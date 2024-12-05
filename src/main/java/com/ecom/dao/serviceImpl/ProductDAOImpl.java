package com.ecom.dao.serviceImpl;

import com.ecom.dao.ProductDAO;
import com.ecom.model.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public abstract class ProductDAOImpl implements ProductDAO {

    @Autowired
    private SessionFactory sessionFactory;

//    @Override
    public void addProduct(Product product) {
        Session session = sessionFactory.getCurrentSession();
        session.save(product);
    }

//    @Override
    public Product getProductById(Integer id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Product.class, id);
    }

//    @Override
    public List<Product> getAllProducts() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Product", Product.class).list();
    }

//    @Override
    public void updateProduct(Product product) {
        Session session = sessionFactory.getCurrentSession();
        session.update(product);
    }

//    @Override
    public void deleteProduct(Integer id) {
        Session session = sessionFactory.getCurrentSession();
        Product product = session.get(Product.class, id);
        if (product != null) {
            session.delete(product);
        }
    }

//    @Override
    public List<Product> getActiveProducts(String category) {
        Session session = sessionFactory.getCurrentSession();
        Query<Product> query = session.createQuery("FROM Product WHERE isActive = true", Product.class);
        return query.getResultList();
    }
}
