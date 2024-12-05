package com.ecom.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ecom.exception.EmailSendingException;
import com.ecom.model.*;
import com.ecom.service.impl.*;
import com.ecom.service.*;
import com.ecom.util.*;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private ReviewService reviewService;  // Add ReviewService

    @Autowired
    private CommonUtil commonUtil;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private CartService cartService;

    @ModelAttribute
    public void getUserDetails(Principal p, Model m) {
        if (p != null) {
            String email = p.getName();
            UserDtls userDtls = userService.getUserByEmail(email);
            m.addAttribute("user", userDtls);
            Integer countCart = cartService.getCountCart(userDtls.getId());
            m.addAttribute("countCart", countCart);
        }

        List<Category> allActiveCategory = categoryService.getAllActiveCategory();
        m.addAttribute("categories", allActiveCategory);
    }

    @GetMapping("/")
    public String index(Model m) {
        List<Category> allActiveCategory = categoryService.getAllActiveCategory().stream()
            .sorted((c1, c2) -> c2.getId().compareTo(c1.getId()))
            .limit(6).toList();
        List<Product> allActiveProducts = productService.getAllActiveProducts("").stream()
            .sorted((p1, p2) -> p2.getId().compareTo(p1.getId()))
            .limit(8).toList();
        m.addAttribute("category", allActiveCategory);
        m.addAttribute("products", allActiveProducts);
        return "index";
    }

    @GetMapping("/signin")
    public String login() {
        return "login"; 
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @GetMapping("/products")
    public String products(Model m, @RequestParam(value = "category", defaultValue = "") String category,
            @RequestParam(name = "pageNo", defaultValue = "0") Integer pageNo,
            @RequestParam(name = "pageSize", defaultValue = "12") Integer pageSize,
            @RequestParam(defaultValue = "") String ch, Principal principal) {

        List<Category> categories = categoryService.getAllActiveCategory();
        m.addAttribute("paramValue", category);
        m.addAttribute("categories", categories);

        Page<Product> page = StringUtils.isEmpty(ch)
            ? productService.getAllActiveProductPagination(pageNo, pageSize, category)
            : productService.searchActiveProductPagination(pageNo, pageSize, category, ch);

        List<Product> products = page.getContent();
        m.addAttribute("products", products);
        m.addAttribute("productsSize", products.size());

        m.addAttribute("pageNo", page.getNumber());
        m.addAttribute("pageSize", pageSize);
        m.addAttribute("totalElements", page.getTotalElements());
        m.addAttribute("totalPages", page.getTotalPages());
        m.addAttribute("isFirst", page.isFirst());
        m.addAttribute("isLast", page.isLast());
        if (principal != null) {
	        UserDtls user = userService.getUserByEmail(principal.getName());
	        m.addAttribute("userRole", user.getRole()); // Add user role to model
	    } else {
	        m.addAttribute("userRole", "ROLE_GUEST"); // Default role if not logged in
	    }

        return "product";
    }

    @GetMapping("/product/{id}")
    public String product(@PathVariable int id, Model m) {
        Product productById = productService.getProductById(id);
        List<ReviewModel> reviews = reviewService.getReviewsByProductId(id); // Fetch reviews

        m.addAttribute("product", productById);
        m.addAttribute("reviews", reviews); // Add reviews to the model
        return "view_product";
    }

    @PostMapping("/saveReview")
    public String saveReview(
        @RequestParam("productId") int productId,
        @RequestParam("userId") int userId,
        @RequestParam("rating") int rating,
        @RequestParam("comment") String comment,
        RedirectAttributes redirectAttributes) {

        // Set current date and time
        LocalDateTime reviewDate = LocalDateTime.now();

        // Assuming you have methods to fetch Product and User by their IDs
        Optional<Product> productOpt = Optional.ofNullable(productService.getProductById(productId));
        Optional<UserDtls> userOpt = Optional.ofNullable(userService.getUserById(userId));

        if (!productOpt.isPresent() || !userOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMsg", "Invalid product or user");
            return "redirect:/product/" + productId;
        }

        Product product = productOpt.get();
        UserDtls user = userOpt.get();

        ReviewModel review = new ReviewModel();
        review.setProduct(product);
        review.setUser(user);
        review.setRating(rating);
        review.setComment(comment);
        review.setDate(reviewDate);

        // Save review
        reviewService.saveReview(review);

        redirectAttributes.addFlashAttribute("succMsg", "Review submitted successfully");
        return "redirect:/product/" + productId;
    }


	
    @PostMapping("/saveUser")
    public String saveUser(@ModelAttribute UserDtls user, 
                           @RequestParam("img") MultipartFile file, 
                           HttpSession session) throws IOException {

        Boolean existsEmail = userService.existsEmail(user.getEmail());

        if (existsEmail) {
            session.setAttribute("errorMsg", "Email already exists, You can login.");
            return "redirect:/signin";
        }

        if ("buyer".equals(user.getRole())) {
            user.setRole("ROLE_USER");
        } else if ("seller".equals(user.getRole())) {
            user.setRole("ROLE_ADMIN");
        }

        String otp = CommonUtil.generateOtp();
        session.setAttribute("otp", otp);
        session.setAttribute("tempUser", user);
        session.setAttribute("imgFile", file);

        try {
            commonUtil.sendOtpMail(otp, user.getEmail());
        } catch (EmailSendingException e) {
            session.setAttribute("errorMsg", "Failed to send OTP. Try again.");
            return "redirect:/register";
        }

        session.setAttribute("succMsg", "Registered successfully. Please verify your OTP.");
        return "redirect:/verify-otp";  
    }

    @GetMapping("/forgot-password")
    public String showForgotPassword() {
        return "forgot_password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam String email, RedirectAttributes redirectAttributes, HttpServletRequest request) throws UnsupportedEncodingException, MessagingException {
        UserDtls userByEmail = userService.getUserByEmail(email);

        if (ObjectUtils.isEmpty(userByEmail)) {
            redirectAttributes.addFlashAttribute("errorMsg", "Invalid email");
        } else {
            String resetToken = UUID.randomUUID().toString();
            userService.updateUserResetToken(email, resetToken);
            String url = CommonUtil.generateUrl(request) + "/reset-password?token=" + resetToken;
            Boolean sendMail = commonUtil.sendMail(url, email);

            if (sendMail) {
                redirectAttributes.addFlashAttribute("succMsg", "Password Reset link sent to your email");
            } else {
                redirectAttributes.addFlashAttribute("errorMsg", "Something went wrong! Email not sent");
            }
        }

        return "redirect:/forgot-password";
    }

    @GetMapping("/reset-password")
    public String showResetPassword(@RequestParam String token, Model m) {
        UserDtls userByToken = userService.getUserByToken(token);

        if (userByToken == null) {
            m.addAttribute("msg", "Your link is invalid or expired!");
            return "message";
        }
        m.addAttribute("token", token);
        return "reset_password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String token, @RequestParam String password, Model m) {
        UserDtls userByToken = userService.getUserByToken(token);
        if (userByToken == null) {
            m.addAttribute("errorMsg", "Your link is invalid or expired!");
            return "message";
        } else {
            userByToken.setPassword(passwordEncoder.encode(password));
            userByToken.setResetToken(null);
            userService.updateUser(userByToken);
            m.addAttribute("msg", "Password changed successfully");
            return "message";
        }
    }

    @GetMapping("/search")
    public String searchProduct(@RequestParam String ch, Model m) {
        List<Product> searchProducts = productService.searchProduct(ch);
        m.addAttribute("products", searchProducts);
        List<Category> categories = categoryService.getAllActiveCategory();
        m.addAttribute("categories", categories);
        return "product";
    }
    @GetMapping("/verify-otp")
    public String verifyOtpPage() {
        return "verify_otp"; 
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam("otp") String enteredOtp, HttpSession session, RedirectAttributes redirectAttributes) throws IOException {
        String generatedOtp = (String) session.getAttribute("otp");

        if (generatedOtp != null && generatedOtp.equals(enteredOtp)) {
            UserDtls user = (UserDtls) session.getAttribute("tempUser");
            MultipartFile file = (MultipartFile) session.getAttribute("imgFile");

            
            UserDtls savedUser = userService.saveUser(user);

            if (!file.isEmpty()) {
               
                File saveFile = new ClassPathResource("static/img/profile_img").getFile();
                Path path = Paths.get(saveFile.getAbsolutePath() + File.separator + file.getOriginalFilename());
                Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            }

            
            session.removeAttribute("otp");
            session.removeAttribute("tempUser");
            session.removeAttribute("imgFile");

            redirectAttributes.addFlashAttribute("succMsg", "Registered successfully");
            return "redirect:/signin";
        }

        redirectAttributes.addFlashAttribute("errorMsg", "Invalid OTP. Please try again.");
        return "redirect:/verify-otp";
    }
}