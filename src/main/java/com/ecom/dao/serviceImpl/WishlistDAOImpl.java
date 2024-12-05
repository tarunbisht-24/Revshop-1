package com.ecom.dao.serviceImpl;

import com.ecom.dao.WishlistDAO;
import com.ecom.model.Wishlist;
import com.ecom.model.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public abstract class WishlistDAOImpl implements WishlistDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("deprecation")
	@Override
    public void add(Wishlist wishlist) {
        Session session = sessionFactory.getCurrentSession();
        session.save(wishlist);
    }

    @Override
    public List<Product> findProductsByUserId(Integer userId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT p FROM Product p WHERE p.id IN (SELECT w.productId FROM Wishlist w WHERE w.userId = :userId)";
        Query<Product> query = session.createQuery(hql, Product.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
}
