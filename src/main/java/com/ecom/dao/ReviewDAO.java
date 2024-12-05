package com.ecom.dao;

import com.ecom.model.ReviewModel;

import java.util.List;

public interface ReviewDAO {
    void addReview(ReviewModel review);
    List<ReviewModel> getReviewsByProductId(int productId);
}
