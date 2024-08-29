package com.shoppingcart.usermodel;

import java.sql.Timestamp;

public class Review {
    private int reviewId;         // The unique ID for each review
    private int productId;        // The ID of the product being reviewed
    private String reviewerName;  // The name of the person who wrote the review
    private int rating;           // The rating given by the reviewer (1 to 5)
    private String comment;       // The review text
    private Timestamp reviewDate; // The date and time when the review was submitted

    // Default constructor
    public Review() {
    }

    // Parameterized constructor
    public Review(int productId, String reviewerName, int rating, String comment) {
        this.productId = productId;
        this.reviewerName = reviewerName;
        this.rating = rating;
        this.comment = comment;
    }

    // Getters and Setters

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getReviewerName() {
        return reviewerName;
    }

    public void setReviewerName(String reviewerName) {
        this.reviewerName = reviewerName;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Timestamp reviewDate) {
        this.reviewDate = reviewDate;
    }

    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", productId=" + productId +
                ", reviewerName='" + reviewerName + '\'' +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", reviewDate=" + reviewDate +
                '}';
    }
}

