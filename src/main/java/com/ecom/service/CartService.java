package com.ecom.service;

import java.util.List;

import com.ecom.model.Cart;
import org.springframework.stereotype.Component;


public interface CartService {

	public Cart saveCart(Integer productId, Integer userId);

	public List<Cart> getCartsByUser(Integer userId);
	
	public Integer getCountCart(Integer userId);

	public void updateQuantity(String sy, Integer cid);
	
	public void clearCartByUser(Integer userId);

	public void updateQuantity(int i, int cid);
	
	public void removeFromCart(int cartId);

	public boolean removeCartItem(Integer cid);


}
