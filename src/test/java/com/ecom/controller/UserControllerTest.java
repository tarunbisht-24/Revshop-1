package com.ecom.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

import java.security.Principal;
import java.util.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import com.ecom.model.*;
import com.ecom.service.*;
import com.ecom.util.CommonUtil;
import com.ecom.util.OrderStatus;

import jakarta.servlet.http.HttpSession;


public class UserControllerTest {

    @InjectMocks
    private UserController userController;

    @Mock
    private UserService userService;

    @Mock
    private CategoryService categoryService;

    @Mock
    private CartService cartService;

    @Mock
    private OrderService orderService;

    @Mock
    private CommonUtil commonUtil;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private ProductService productService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }
    
    HttpSession session = mock(HttpSession.class);

    @Test
    public void testAddToCartSuccess() {
        Principal principal = () -> "testUser@example.com";
        UserDtls user = new UserDtls();
        user.setId(1);
        when(userService.getUserByEmail(principal.getName())).thenReturn(user);
        when(cartService.saveCart(1, 1)).thenReturn(new Cart());

        RedirectAttributes redirectAttributes = new RedirectAttributesModelMap();
        String viewName = userController.addToCart(1, 2, session);
        assertEquals("redirect:/product/1", viewName);
        assertEquals("Product added to cart", redirectAttributes.getFlashAttributes().get("succMsg"));
    }

    @Test
    public void testAddToCartFailure() {
        Principal principal = () -> "testUser@example.com";
        UserDtls user = new UserDtls();
        user.setId(1);
        when(userService.getUserByEmail(principal.getName())).thenReturn(user);
        when(cartService.saveCart(1, 1)).thenReturn(null);

        RedirectAttributes redirectAttributes = new RedirectAttributesModelMap();
        String viewName = userController.addToCart(1, 2, session);

        assertEquals("redirect:/product/1", viewName);
        assertEquals("Product added to cart failed", redirectAttributes.getFlashAttributes().get("errorMsg"));
    }
    
    @Test
    public void testSaveOrder() throws Exception {
        Principal principal = () -> "testUser@example.com";
        UserDtls user = new UserDtls();
        user.setId(1);
        when(userService.getUserByEmail(principal.getName())).thenReturn(user);

        OrderRequest orderRequest = new OrderRequest();

        RedirectAttributes redirectAttributes = new RedirectAttributesModelMap();
        String viewName = userController.saveOrder(orderRequest, principal);

        verify(orderService, times(1)).saveOrder(1, orderRequest);
        assertEquals("redirect:/user/success", viewName);
    }
    
    @Test
    public void testOrderNow() {
        Principal principal = () -> "testUser@example.com";
        Product product = new Product();
        product.setDiscountPrice(1000.0);
        when(productService.getProductById(1)).thenReturn(product);

        Model model = new ExtendedModelMap();
        RedirectAttributes redirectAttributes = new RedirectAttributesModelMap();
        String viewName = userController.orderNow(1, principal, model, redirectAttributes);

        assertEquals("user/order", viewName);
        assertEquals(product, model.getAttribute("product"));
        assertEquals(1000.0, model.getAttribute("orderPrice"));
        assertEquals(1350.0, model.getAttribute("totalOrderPrice"));
    }
}
