package com.ecom.controller;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ecom.model.Category;
import com.ecom.model.Product;
import com.ecom.model.ReviewModel;
import com.ecom.model.UserDtls;
import com.ecom.service.CartService;
import com.ecom.service.CategoryService;
import com.ecom.service.UserService;

import com.ecom.util.CommonUtil;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.ecom.service.ProductService;
import com.ecom.service.ReviewService;

public class HomeControllerTest {

    @Mock
    private CategoryService categoryService;

    @Mock
    private ProductService productService;

    @Mock
    private UserService userService;
    
    @Mock
    private CommonUtil commonUtil;

    @Mock
    private ReviewService reviewService;

    @Mock
    private HttpSession redirectAttributes;

    @Mock
    private CartService cartService;

    

    @Mock
    private Model model;
    
    @Mock
    private HttpServletRequest request;

    @InjectMocks
    private HomeController homeController;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetUserDetails_Success() {
        // Mocking Principal object
        Principal principal = mock(Principal.class);
        when(principal.getName()).thenReturn("test@example.com");

        // Mocking User Service
        UserDtls user = new UserDtls();
        user.setId((int) 1L);
        user.setEmail("test@example.com");
        when(userService.getUserByEmail("test@example.com")).thenReturn(user);

        // Mocking Cart Service
        when(cartService.getCountCart((int) 1L)).thenReturn(5);

        // Mocking Category Service
        List<Category> categories = Arrays.asList(new Category());
        when(categoryService.getAllActiveCategory()).thenReturn(categories);

        // Call the method
        homeController.getUserDetails(principal, model);

        // Verify interactions
        verify(userService, times(1)).getUserByEmail("test@example.com");
        verify(cartService, times(1)).getCountCart((int) 1L);
        verify(categoryService, times(1)).getAllActiveCategory();
        verify(model, times(1)).addAttribute("user", user);
        verify(model, times(1)).addAttribute("countCart", 5);
        verify(model, times(1)).addAttribute("categories", categories);
    }

    @Test
    public void testGetUserDetails_Failure() {
        // Mocking Principal as null
        Principal principal = null;

        // Mocking Category Service
        List<Category> categories = Arrays.asList(new Category());
        when(categoryService.getAllActiveCategory()).thenReturn(categories);

        // Call the method
        homeController.getUserDetails(principal, model);

        // Verify that user-related methods were not called
        verify(userService, times(0)).getUserByEmail(anyString());
        verify(cartService, times(0)).getCountCart((int) anyLong());

        // Verify that categories were added to the model
        verify(categoryService, times(1)).getAllActiveCategory();
        verify(model, times(1)).addAttribute("categories", categories);
    }
    
    @Test
    public void testIndex_Success() {
        // Mock Category List
        List<Category> mockCategories = new ArrayList<>();
        Category category1 = new Category();
        category1.setId(2);  // Using setters to assign values
        mockCategories.add(category1);

        Category category2 = new Category();
        category2.setId(1);  // Using setters to assign values
        mockCategories.add(category2);

        when(categoryService.getAllActiveCategory()).thenReturn(mockCategories);

        // Mock Product List
        List<Product> mockProducts = new ArrayList<>();
        Product product1 = new Product();
        product1.setId(5);  // Using setters to assign values
        mockProducts.add(product1);

        Product product2 = new Product();
        product2.setId(3);  // Using setters to assign values
        mockProducts.add(product2);

        when(productService.getAllActiveProducts("")).thenReturn(mockProducts);

        // Call the controller method
        String viewName = homeController.index(model);

        // Assertions
        assertEquals("index", viewName); // Ensure it returns "index" view

        // Verify model attributes
        verify(model).addAttribute(eq("category"), anyList());
        verify(model).addAttribute(eq("products"), anyList());
    }


    @Test
    public void testIndex_Failure_EmptyCategoriesAndProducts() {
        // Mocking empty lists for categories and products
        when(categoryService.getAllActiveCategory()).thenReturn(new ArrayList<>());
        when(productService.getAllActiveProducts("")).thenReturn(new ArrayList<>());

        // Call the method
        String viewName = homeController.index(model);

        // Verify the services were called
        verify(categoryService, times(1)).getAllActiveCategory();
        verify(productService, times(1)).getAllActiveProducts("");

        // Verify that empty lists were added to the model
        verify(model, times(1)).addAttribute("category", new ArrayList<>());
        verify(model, times(1)).addAttribute("products", new ArrayList<>());

        // Assert that the view name is still "index"
        assertEquals("index", viewName);
    }
    
    @Test
    public void testProducts_Success() {
        // Mock Category List
        List<Category> mockCategories = new ArrayList<>();
        Category category1 = new Category();
        category1.setId(1);
        mockCategories.add(category1);

        when(categoryService.getAllActiveCategory()).thenReturn(mockCategories);

        // Mock Product List and Page
        List<Product> mockProducts = new ArrayList<>();
        Product product1 = new Product();
        product1.setId(1);
        mockProducts.add(product1);

        Page<Product> mockPage = new PageImpl<>(mockProducts, PageRequest.of(0, 12), mockProducts.size());
        when(productService.getAllActiveProductPagination(0, 12, "")).thenReturn(mockPage);

        // Call the controller method
        String viewName = homeController.products(model, "", 0, 12, "", null);

        // Assertions
        assertEquals("product", viewName); // Ensure it returns "product" view

        // Verify Model Attributes
        verify(model).addAttribute("paramValue", "");
        verify(model).addAttribute("categories", mockCategories);
        verify(model).addAttribute("products", mockProducts);
        verify(model).addAttribute("productsSize", mockProducts.size());
        verify(model).addAttribute("pageNo", mockPage.getNumber());
        verify(model).addAttribute("pageSize", 12);
        verify(model).addAttribute("totalElements", mockPage.getTotalElements());
        verify(model).addAttribute("totalPages", mockPage.getTotalPages());
        verify(model).addAttribute("isFirst", mockPage.isFirst());
        verify(model).addAttribute("isLast", mockPage.isLast());
    }

    @Test
    public void testProducts_SearchSuccess() {
        // Mock Category List
        List<Category> mockCategories = new ArrayList<>();
        Category category1 = new Category();
        category1.setId(1);
        mockCategories.add(category1);

        when(categoryService.getAllActiveCategory()).thenReturn(mockCategories);

        // Mock Product List and Page
        List<Product> mockProducts = new ArrayList<>();
        Product product1 = new Product();
        product1.setId(1);
        mockProducts.add(product1);

        Page<Product> mockPage = new PageImpl<>(mockProducts, PageRequest.of(0, 12), mockProducts.size());
        when(productService.searchActiveProductPagination(0, 12, "", "searchQuery")).thenReturn(mockPage);

        // Call the controller method with search query
        String viewName = homeController.products(model, "", 0, 12, "searchQuery", null);

        // Assertions
        assertEquals("product", viewName); // Ensure it returns "product" view

        // Verify Model Attributes
        verify(model).addAttribute("paramValue", "");
        verify(model).addAttribute("categories", mockCategories);
        verify(model).addAttribute("products", mockProducts);
        verify(model).addAttribute("productsSize", mockProducts.size());
        verify(model).addAttribute("pageNo", mockPage.getNumber());
        verify(model).addAttribute("pageSize", 12);
        verify(model).addAttribute("totalElements", mockPage.getTotalElements());
        verify(model).addAttribute("totalPages", mockPage.getTotalPages());
        verify(model).addAttribute("isFirst", mockPage.isFirst());
        verify(model).addAttribute("isLast", mockPage.isLast());
    }

    @Test
    public void testProducts_Failure() {
        // Mock empty Category List
        List<Category> mockCategories = new ArrayList<>();
        when(categoryService.getAllActiveCategory()).thenReturn(mockCategories);

        // Mock empty Product List and Page
        Page<Product> mockPage = new PageImpl<>(new ArrayList<>(), PageRequest.of(0, 12), 0);
        when(productService.getAllActiveProductPagination(0, 12, "")).thenReturn(mockPage);

        // Call the controller method
        String viewName = homeController.products(model, "", 0, 12, "", null);

        // Assertions
        assertEquals("product", viewName); // Ensure it returns "product" view

        // Verify Model Attributes with empty lists
        verify(model).addAttribute("paramValue", "");
        verify(model).addAttribute("categories", mockCategories);
        verify(model).addAttribute("products", mockPage.getContent());
        verify(model).addAttribute("productsSize", 0);
        verify(model).addAttribute("pageNo", mockPage.getNumber());
        verify(model).addAttribute("pageSize", 12);
        verify(model).addAttribute("totalElements", mockPage.getTotalElements());
        verify(model).addAttribute("totalPages", mockPage.getTotalPages());
        verify(model).addAttribute("isFirst", mockPage.isFirst());
        verify(model).addAttribute("isLast", mockPage.isLast());
    }
    
    @Test
    public void testSaveReview_Success() {
        // Mock data for product and user
        Product product = new Product();
        product.setId(1);

        UserDtls user = new UserDtls();
        user.setId(1);

        when(productService.getProductById(1)).thenReturn(product);
        when(userService.getUserById(1)).thenReturn(user);

        // Call the controller method
        String viewName = homeController.saveReview(1, 1, 5, "Great product!", (RedirectAttributes) redirectAttributes);

        // Verifications
        verify(reviewService, times(1)).saveReview(any(ReviewModel.class));
        verify(redirectAttributes).setAttribute("succMsg", "Review submitted successfully");

        // Assertions
        assertEquals("redirect:/product/1", viewName);
    }

    @Test
    public void testSaveReview_Failure_ProductOrUserNotFound() {
        // Mock product as null
        when(productService.getProductById(1)).thenReturn(null);
        when(userService.getUserById(1)).thenReturn(null);

        // Call the controller method
        String viewName = homeController.saveReview(1, 1, 5, "Great product!", (RedirectAttributes) redirectAttributes);

        // Verifications
        verify(reviewService, never()).saveReview(any(ReviewModel.class)); // No review should be saved
        verify(redirectAttributes).setAttribute("errorMsg", "Invalid product or user");

        // Assertions
        assertEquals("redirect:/product/1", viewName);
    }
    

    @Test
    public void testSaveUser_Success() throws IOException {
        // Mock user data
        UserDtls user = new UserDtls();
        user.setEmail("test@example.com");

        // Mock file upload
        MockMultipartFile file = new MockMultipartFile("img", "test.jpg", "image/jpeg", "test data".getBytes());

        when(userService.existsEmail("test@example.com")).thenReturn(false);
        when(userService.saveUser(user)).thenReturn(user);

        // Call the controller method
        String viewName = homeController.saveUser(user, file, redirectAttributes);

        // Verifications
        verify(userService, times(1)).saveUser(any(UserDtls.class));
        verify(redirectAttributes).setAttribute("succMsg", "Registered successfully");

        // Assertions
        assertEquals("redirect:/register", viewName);
    }

    @Test
    public void testSaveUser_Failure_EmailAlreadyExists() throws IOException {
        // Mock user data
        UserDtls user = new UserDtls();
        user.setEmail("test@example.com");

        // Mock file upload
        MockMultipartFile file = new MockMultipartFile("img", "test.jpg", "image/jpeg", "test data".getBytes());

        // Mock email already exists
        when(userService.existsEmail("test@example.com")).thenReturn(true);

        // Call the controller method
        String viewName = homeController.saveUser(user, file, redirectAttributes);

        // Verifications
        verify(userService, never()).saveUser(any(UserDtls.class)); // No user should be saved
        verify(redirectAttributes).setAttribute("errorMsg", "Email already exists");

        // Assertions
        assertEquals("redirect:/register", viewName);
    }
    
    @Test
    public void testProcessForgotPassword_Success() throws UnsupportedEncodingException, MessagingException {
        String email = "test@example.com";
        UserDtls user = new UserDtls();
        user.setEmail(email);
        
        // Mock user service to return a valid user for the email
        when(userService.getUserByEmail(email)).thenReturn(user);
        
        // Mock commonUtil.sendMail() to return true (email sent successfully)
        when(commonUtil.sendMail(anyString(), eq(email))).thenReturn(true);
        
        // Mock the request URL
        when(request.getRequestURL()).thenReturn(new StringBuffer("http://localhost:8080"));
        when(request.getServletPath()).thenReturn("/forgot-password");
        
        String result = homeController.processForgotPassword(email, (RedirectAttributes) redirectAttributes, request);

        // Verify that the success message is added to redirect attributes
        verify(redirectAttributes).setAttribute("succMsg", "Password Reset link sent to your email");
        
        // Assert the redirection
        assertEquals("redirect:/forgot-password", result);
    }
    
    @Test
    public void testProcessForgotPassword_InvalidEmail() throws UnsupportedEncodingException, MessagingException {
        String email = "invalid@example.com";
        
        // Mock user service to return null (no user found)
        when(userService.getUserByEmail(email)).thenReturn(null);

        String result = homeController.processForgotPassword(email, (RedirectAttributes) redirectAttributes, request);

        // Verify that the error message is added to redirect attributes
        verify(redirectAttributes).setAttribute("errorMsg", "Invalid email");
        
        // Assert the redirection
        assertEquals("redirect:/forgot-password", result);
    }
}

