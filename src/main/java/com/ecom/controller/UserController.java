package com.ecom.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ecom.model.Cart;
import com.ecom.model.Category;
import com.ecom.model.OrderRequest;
import com.ecom.model.Product;
import com.ecom.model.ProductOrder;
import com.ecom.model.UserDtls;
import com.ecom.model.Wishlist;
import com.ecom.repository.UserRepository;
import com.ecom.service.CartService;
import com.ecom.service.CategoryService;
import com.ecom.service.OrderService;
import com.ecom.service.ProductService;
import com.ecom.service.UserService;
import com.ecom.service.WishlistService;
import com.ecom.util.CommonUtil;
import com.ecom.util.OrderStatus;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private CategoryService categoryService;

	@Autowired
	private CartService cartService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private CommonUtil commonUtil;

	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private ProductService productService;


	@GetMapping("/")
	public String home() {
		return "user/home";
	}

	@Autowired
	private WishlistService wishlistService;

	// Add to wishlist
	@GetMapping("/addWishlist")
	public String addToWishlist(@RequestParam Integer productId, Principal p, HttpSession session) {
	    UserDtls user = getLoggedInUserDetails(p);
	    Wishlist wishlist = wishlistService.addToWishlist(user, productId);
	    
	  
	    // Clear the message after redirect
	    return "redirect:/product/" + productId;
	}

	// Remove from wishlist
	@GetMapping("/removeWishlist")
	public String removeFromWishlist(@RequestParam Integer productId, Principal p, HttpSession session) {
	    UserDtls user = getLoggedInUserDetails(p);
	    wishlistService.removeFromWishlist(user, productId);
	    session.setAttribute("succMsg", "Product removed from wishlist");
	    
	    // Clear the message after redirect
	    return "redirect:/user/wishlist";
	}

	@GetMapping("/wishlist")
	public String viewWishlist(Principal p, Model m) {
	    // Retrieve the logged-in user's details
	    UserDtls user = getLoggedInUserDetails(p);
	    
	    // Fetch the wishlist for the logged-in user
	    List<Wishlist> wishlist = wishlistService.getWishlistByUser(user);
	    m.addAttribute("wishlist", wishlist);

	    // Safely get the session and remove any success or error messages
	    ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
	    if (attr != null) {
	        HttpSession session = attr.getRequest().getSession(false); // Use false to avoid creating a new session
	        if (session != null) {
	            session.removeAttribute("succMsg");
	            session.removeAttribute("errorMsg");
	        }
	    }
	    
	    return "user/wishlist";
	}

	
	
	
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
		m.addAttribute("categorys", allActiveCategory);
	}

	@GetMapping("/addCart")
	public String addToCart(@RequestParam Integer pid, @RequestParam Integer uid, HttpSession session) {
		Cart saveCart = cartService.saveCart(pid, uid);

		if (ObjectUtils.isEmpty(saveCart)) {
			session.setAttribute("errorMsg", "Product add to cart failed");
		} else {
			session.setAttribute("succMsg", "Product added to cart");
		}
		return "redirect:/product/" + pid;
	}

	@GetMapping("/cart")
	public String loadCartPage(Principal p, Model m) {

		UserDtls user = getLoggedInUserDetails(p);
		List<Cart> carts = cartService.getCartsByUser(user.getId());
		m.addAttribute("carts", carts);
		if (carts.size() > 0) {
			Double totalOrderPrice = carts.get(carts.size() - 1).getTotalOrderPrice();
			m.addAttribute("totalOrderPrice", totalOrderPrice);
		}
		return "user/cart";
	}
	@GetMapping("/orderNow")
    public String orderNow(@RequestParam Integer pid, Principal p, Model m, RedirectAttributes redirectAttributes) {
        if (p == null) {
            return "redirect:/signin";
        }

        Product product = productService.getProductById(pid);

        if (product == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Invalid product");
            return "redirect:/product/" + pid;
        }

        double deliveryFee = 50;
        double tax = 10;
        double totalPrice = product.getDiscountPrice();
        double totalOrderPrice = totalPrice + deliveryFee + tax;

        m.addAttribute("orderPrice", totalPrice);
        m.addAttribute("totalOrderPrice", totalOrderPrice);
        m.addAttribute("product", product);

        return "user/order";
    }

	@GetMapping("/cartQuantityUpdate")
	public String updateCartQuantity(@RequestParam String sy, @RequestParam Integer cid) {
		cartService.updateQuantity(sy, cid);
		return "redirect:/user/cart";
	}

	private UserDtls getLoggedInUserDetails(Principal p) {
		String email = p.getName();
		UserDtls userDtls = userService.getUserByEmail(email);
		return userDtls;
	}

	@GetMapping("/orders")
	public String orderPage(Principal p, Model m) {
		UserDtls user = getLoggedInUserDetails(p);
		List<Cart> carts = cartService.getCartsByUser(user.getId());
		m.addAttribute("carts", carts);
		if (carts.size() > 0) {
			Double orderPrice = carts.get(carts.size() - 1).getTotalOrderPrice();
			Double totalOrderPrice = carts.get(carts.size() - 1).getTotalOrderPrice() + 50 + 10;
			m.addAttribute("orderPrice", orderPrice);
			m.addAttribute("totalOrderPrice", totalOrderPrice);
		}
		return "user/order";
	}

	@PostMapping("/save-order")
	public String saveOrder(@ModelAttribute OrderRequest request, Principal p) throws Exception {
		// System.out.println(request);
		UserDtls user = getLoggedInUserDetails(p);
		orderService.saveOrder(user.getId(), request);
		cartService.clearCartByUser(user.getId());
		return "redirect:/user/success";
	}

	@GetMapping("/success")
	public String loadSuccess() {
		return "user/success";
	}

	@GetMapping("/user-orders")
	public String myOrder(Model m, Principal p) {
		UserDtls loginUser = getLoggedInUserDetails(p);
		List<ProductOrder> orders = orderService.getOrdersByUser(loginUser.getId());
		m.addAttribute("orders", orders);
		return "user/my_orders";
	}

	@GetMapping("/update-status")
	public String updateOrderStatus(@RequestParam Integer id, @RequestParam Integer st, HttpSession session) {

		OrderStatus[] values = OrderStatus.values();
		String status = null;

		for (OrderStatus orderSt : values) {
			if (orderSt.getId().equals(st)) {
				status = orderSt.getName();
			}
		}

		ProductOrder updateOrder = orderService.updateOrderStatus(id, status);
		
		try {
			commonUtil.sendMailForProductOrder(updateOrder, status);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (!ObjectUtils.isEmpty(updateOrder)) {
			session.setAttribute("succMsg", "Status Updated");
		} else {
			session.setAttribute("errorMsg", "status not updated");
		}
		return "redirect:/user/user-orders";
	}

	@GetMapping("/profile")
	public String profile() {
		return "user/profile";
	}

	@PostMapping("/update-profile")
	public String updateProfile(@ModelAttribute UserDtls user, @RequestParam MultipartFile img, HttpSession session) {
		UserDtls updateUserProfile = userService.updateUserProfile(user, img);
		if (ObjectUtils.isEmpty(updateUserProfile)) {
			session.setAttribute("errorMsg", "Profile not updated");
		} else {
			session.setAttribute("succMsg", "Profile Updated");
		}
		return "redirect:/user/profile";
	}

	@PostMapping("/change-password")
	public String changePassword(@RequestParam String newPassword, @RequestParam String currentPassword, Principal p,
			HttpSession session) {
		UserDtls loggedInUserDetails = getLoggedInUserDetails(p);

		boolean matches = passwordEncoder.matches(currentPassword, loggedInUserDetails.getPassword());

		if (matches) {
			String encodePassword = passwordEncoder.encode(newPassword);
			loggedInUserDetails.setPassword(encodePassword);
			UserDtls updateUser = userService.updateUser(loggedInUserDetails);
			if (ObjectUtils.isEmpty(updateUser)) {
				session.setAttribute("errorMsg", "Password not updated !! Error in server");
			} else {
				session.setAttribute("succMsg", "Password Updated sucessfully");
			}
		} else {
			session.setAttribute("errorMsg", "Current Password incorrect");
		}

		return "redirect:/user/profile";
	}
	
	@GetMapping("/cartRemoveItem")
	public String removeCartItem(@RequestParam Integer cid, HttpSession session) {
	    boolean isRemoved = cartService.removeCartItem(cid);
	    
	    if (isRemoved) {
	        session.setAttribute("succMsg", "Product removed from cart successfully");
	    } else {
	        session.setAttribute("errorMsg", "Failed to remove product from cart");
	    }
	    
	    return "redirect:/user/cart";
	}

}
