package com.ecom.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import com.ecom.model.Cart;
import com.ecom.model.Product;
import com.ecom.model.UserDtls;
import com.ecom.repository.CartRepository;
import com.ecom.repository.ProductRepository;
import com.ecom.repository.UserRepository;
import com.ecom.service.impl.CartServiceImpl;

public class CartServiceImplTest {

	@Mock
	private CartRepository cartRepository;

	@Mock
	private UserRepository userRepository;

	@Mock
	private ProductRepository productRepository;

	@InjectMocks
	private CartServiceImpl cartService;

	@BeforeEach
	public void setup() {
		MockitoAnnotations.openMocks(this);
	}

	@Test
	public void testSaveCart_Success() {
		// Arrange
		UserDtls user = new UserDtls();
		user.setId(1);
		Product product = new Product();
		product.setId(1);
		product.setDiscountPrice(100.0);
		Cart cart = new Cart();

		when(userRepository.findById(1)).thenReturn(Optional.of(user));
		when(productRepository.findById(1)).thenReturn(Optional.of(product));
		when(cartRepository.findByProductIdAndUserId(1, 1)).thenReturn(null);
		when(cartRepository.save(any(Cart.class))).thenReturn(cart);

		// Act
		Cart savedCart = cartService.saveCart(1, 1);

		// Assert
		assertNotNull(savedCart);
		verify(cartRepository, times(1)).save(any(Cart.class));
	}

	@Test
	public void testSaveCart_UserNotFound() {
		// Arrange
		when(userRepository.findById(1)).thenReturn(Optional.empty());

		// Act & Assert
		assertThrows(IllegalArgumentException.class, () -> {
			cartService.saveCart(1, 1);
		});
	}

	@Test
	public void testUpdateQuantity_Success() {
		// Arrange
		Cart cart = new Cart();
		cart.setId(1);
		Product product = new Product();
		product.setDiscountPrice(100.0);
		cart.setProduct(product);
		cart.setQuantity(2);

		when(cartRepository.findById(1)).thenReturn(Optional.of(cart));

		// Act
		cartService.updateQuantity(1, 3);

		// Assert
		assertEquals(3, cart.getQuantity());
		assertEquals(300.0, cart.getTotalPrice());
		verify(cartRepository, times(1)).save(cart);
	}

	@Test
	public void testUpdateQuantity_CartNotFound() {
		// Arrange
		when(cartRepository.findById(1)).thenReturn(Optional.empty());

		// Act & Assert
		assertThrows(IllegalArgumentException.class, () -> {
			cartService.updateQuantity(1, 2);
		});
	}

	@Test
	public void testRemoveFromCart_Success() {
		// Arrange
		Cart cart = new Cart();
		when(cartRepository.findById(1)).thenReturn(Optional.of(cart));

		// Act
		cartService.removeFromCart(1);

		// Assert
		verify(cartRepository, times(1)).delete(cart);
	}

	@Test
	public void testRemoveFromCart_CartNotFound() {
		// Arrange
		when(cartRepository.findById(1)).thenReturn(Optional.empty());

		// Act & Assert
		assertThrows(IllegalArgumentException.class, () -> {
			cartService.removeFromCart(1);
		});
	}

	@Test
	public void testSaveCartWithoutQuantity_Success() {
		// Arrange
		UserDtls user = new UserDtls();
		Product product = new Product();
		product.setDiscountPrice(100.0);
		Cart cart = new Cart();

		when(userRepository.findById(1)).thenReturn(Optional.of(user));
		when(productRepository.findById(1)).thenReturn(Optional.of(product));
		when(cartRepository.findByProductIdAndUserId(1, 1)).thenReturn(null);
		when(cartRepository.save(any(Cart.class))).thenReturn(cart);

		// Act
		Cart savedCart = cartService.saveCart(1, 1);

		// Assert
		assertNotNull(savedCart);
		verify(cartRepository, times(1)).save(any(Cart.class));
	}

	@Test
	public void testGetCartsByUser_Success() {
		// Arrange
		Product product = new Product();
		product.setDiscountPrice(100.0);
		Cart cart = new Cart();
		cart.setProduct(product);
		cart.setQuantity(2);
		List<Cart> carts = List.of(cart);

		when(cartRepository.findByUserId(1)).thenReturn(carts);

		// Act
		List<Cart> result = cartService.getCartsByUser(1);

		// Assert
		assertEquals(200.0, result.get(0).getTotalPrice());
	}

	@Test
	public void testGetCartsByUser_EmptyCarts() {
		// Arrange
		when(cartRepository.findByUserId(1)).thenReturn(new ArrayList<>());

		// Act
		List<Cart> result = cartService.getCartsByUser(1);

		// Assert
		assertTrue(result.isEmpty());
	}

	@Test
	public void testGetCountCart_Success() {
		// Arrange
		when(cartRepository.countByUserId(1)).thenReturn(3);

		// Act
		Integer count = cartService.getCountCart(1);

		// Assert
		assertEquals(3, count);
	}

	@Test
	public void testGetCountCart_NoItemsFound() {
		// Arrange
		when(cartRepository.countByUserId(1)).thenReturn(0);

		// Act
		Integer count = cartService.getCountCart(1);

		// Assert
		assertEquals(0, count);
	}

	@Test
	public void testUpdateQuantityByOperation_Success() {
		// Arrange
		Cart cart = new Cart();
		cart.setQuantity(2);

		when(cartRepository.findById(1)).thenReturn(Optional.of(cart));

		// Act
		cartService.updateQuantity("in", 1);

		// Assert
		assertEquals(3, cart.getQuantity());
		verify(cartRepository, times(1)).save(cart);
	}

}
