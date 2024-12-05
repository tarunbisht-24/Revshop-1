package com.ecom.dao.serviceImpl;

import com.ecom.dao.ReviewDAO;
import com.ecom.model.ReviewModel;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addReview(ReviewModel review) {
        Session session = sessionFactory.getCurrentSession();
        session.save(review);
    }

    @Override
    public List<ReviewModel> getReviewsByProductId(int productId) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM ReviewModel WHERE product.id = :productId", ReviewModel.class)
                      .setParameter("productId", productId)
                      .list();
    }
}
