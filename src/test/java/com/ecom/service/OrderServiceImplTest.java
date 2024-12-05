package com.ecom.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.ecom.model.Cart;
import com.ecom.model.OrderAddress;
import com.ecom.model.OrderRequest;
import com.ecom.model.Product;
import com.ecom.model.ProductOrder;
import com.ecom.repository.CartRepository;
import com.ecom.repository.ProductOrderRepository;
import com.ecom.service.impl.OrderServiceImpl;
import com.ecom.util.CommonUtil;
import com.ecom.util.OrderStatus;

public class OrderServiceImplTest {

	@Mock
	private ProductOrderRepository orderRepository;

	@Mock
	private CartRepository cartRepository;

	@Mock
	private CommonUtil commonUtil;

	@InjectMocks
	private OrderServiceImpl orderService;

	@BeforeEach
	public void setup() {
		MockitoAnnotations.openMocks(this);
	}

	@Test
	public void testSaveOrder_Success() throws Exception {
		// Arrange
		Integer userId = 1;
		OrderRequest orderRequest = new OrderRequest();
		List<Cart> carts = new ArrayList<>();
		Cart cart = new Cart();
		cart.setProduct(new Product()); // Mock a Product with discountPrice
		cart.setQuantity(2);
		carts.add(cart);

		when(cartRepository.findByUserId(userId)).thenReturn(carts);
		when(orderRepository.save(any(ProductOrder.class))).thenReturn(new ProductOrder());

		// Act
		orderService.saveOrder(userId, orderRequest);

		// Assert
		verify(orderRepository, times(1)).save(any(ProductOrder.class));
		verify(commonUtil, times(1)).sendMailForProductOrder(any(ProductOrder.class), eq("success"));
	}

	@Test
	public void testGetOrdersByUser_Success() {
		// Arrange
		Integer userId = 1;
		List<ProductOrder> orders = new ArrayList<>();
		orders.add(new ProductOrder());
		when(orderRepository.findByUserId(userId)).thenReturn(orders);

		// Act
		List<ProductOrder> result = orderService.getOrdersByUser(userId);

		// Assert
		assertEquals(1, result.size());
		verify(orderRepository, times(1)).findByUserId(userId);
	}

	@Test
	public void testGetOrdersByUser_Failure_NoOrdersFound() {
		// Arrange
		Integer userId = 1;
		when(orderRepository.findByUserId(userId)).thenReturn(new ArrayList<>());

		// Act
		List<ProductOrder> result = orderService.getOrdersByUser(userId);

		// Assert
		assertTrue(result.isEmpty());
	}

	@Test
	public void testUpdateOrderStatus_Success() {
		// Arrange
		Integer orderId = 1;
		ProductOrder order = new ProductOrder();
		when(orderRepository.findById(orderId)).thenReturn(Optional.of(order));
		when(orderRepository.save(order)).thenReturn(order);

		// Act
		ProductOrder result = orderService.updateOrderStatus(orderId, null);

		// Assert
		assertNotNull(result);
		assertEquals(null, order.getStatus());
		verify(orderRepository, times(1)).save(order);
	}

	@Test
	public void testUpdateOrderStatus_Failure_OrderNotFound() {
		// Arrange
		Integer orderId = 1;
		when(orderRepository.findById(orderId)).thenReturn(Optional.empty());

		// Act
		ProductOrder result = orderService.updateOrderStatus(orderId, null);

		// Assert
		assertNull(result);
		verify(orderRepository, never()).save(any(ProductOrder.class));
	}

	@Test
	public void testGetAllOrders_Success() {
		// Arrange
		List<ProductOrder> orders = new ArrayList<>();
		orders.add(new ProductOrder());
		when(orderRepository.findAll()).thenReturn(orders);

		// Act
		List<ProductOrder> result = orderService.getAllOrders();

		// Assert
		assertEquals(1, result.size());
		verify(orderRepository, times(1)).findAll();
	}

	@Test
	public void testGetAllOrders_Failure_NoOrders() {
		// Arrange
		when(orderRepository.findAll()).thenReturn(new ArrayList<>());

		// Act
		List<ProductOrder> result = orderService.getAllOrders();

		// Assert
		assertTrue(result.isEmpty());
	}

	@Test
	public void testGetAllOrdersPagination_Success() {
		// Arrange
		Pageable pageable = PageRequest.of(0, 10);
		List<ProductOrder> orders = new ArrayList<>();
		orders.add(new ProductOrder());
		Page<ProductOrder> orderPage = new PageImpl<>(orders);
		when(orderRepository.findAll(pageable)).thenReturn(orderPage);

		// Act
		Page<ProductOrder> result = orderService.getAllOrdersPagination(0, 10);

		// Assert
		assertEquals(1, result.getContent().size());
		verify(orderRepository, times(1)).findAll(pageable);
	}

	@Test
	public void testGetAllOrdersPagination_Failure_EmptyPage() {
		// Arrange
		Pageable pageable = PageRequest.of(0, 10);
		when(orderRepository.findAll(pageable)).thenReturn(Page.empty());

		// Act
		Page<ProductOrder> result = orderService.getAllOrdersPagination(0, 10);

		// Assert
		assertTrue(result.isEmpty());
	}

	@Test
	public void testGetOrdersByOrderId_Success() {
		// Arrange
		String orderId = UUID.randomUUID().toString();
		ProductOrder order = new ProductOrder();
		when(orderRepository.findByOrderId(orderId)).thenReturn(order);

		// Act
		ProductOrder result = orderService.getOrdersByOrderId(orderId);

		// Assert
		assertNotNull(result);
		verify(orderRepository, times(1)).findByOrderId(orderId);
	}

	@Test
	public void testGetOrdersByOrderId_Failure_OrderNotFound() {
		// Arrange
		String orderId = UUID.randomUUID().toString();
		when(orderRepository.findByOrderId(orderId)).thenReturn(null);

		// Act
		ProductOrder result = orderService.getOrdersByOrderId(orderId);

		// Assert
		assertNull(result);
	}

}
