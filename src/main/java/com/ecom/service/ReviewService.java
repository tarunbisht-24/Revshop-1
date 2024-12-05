package com.ecom.service;

import  com.ecom.model.*;
import com.ecom.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public List<ReviewModel> getReviewsByProductId(int productId) {
        return reviewRepository.findByProductId(productId);
    }

    public void saveReview(ReviewModel review) {
        reviewRepository.save(review);
    }
}
