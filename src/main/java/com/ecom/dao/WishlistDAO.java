package com.ecom.dao;

import com.ecom.model.Wishlist;
import com.ecom.model.Product;

import java.util.List;

public interface WishlistDAO {
    void add(Wishlist wishlist);
    void remove(Long wishlistId); // Change to Long
    Wishlist findByUserAndProductId(Integer userId, Integer productId);
    List<Wishlist> findAllByUserId(Integer userId);
    List<Product> findProductsByUserId(Integer userId);
}
