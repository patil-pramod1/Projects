package com.shoppingcart.dao;

import com.shoppingcart.usermodel.Review;
import com.shoppingcart.connection.DBconnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDao {

    public boolean addReview(Review review) throws ClassNotFoundException {
        boolean isSuccess = false;
        String query = "INSERT INTO reviews (productId, reviewerName, rating, comment) VALUES (?, ?, ?, ?)";
        
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, review.getProductId());
            stmt.setString(2, review.getReviewerName());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getComment());

            int rowsAffected = stmt.executeUpdate();
            isSuccess = rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    public List<Review> getReviewsByProductId(int productId) throws ClassNotFoundException {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews WHERE productId = ? ORDER BY reviewDate DESC";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("reviewId"));
                review.setProductId(rs.getInt("productId"));
                review.setReviewerName(rs.getString("reviewerName"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewDate(rs.getTimestamp("reviewDate"));
                reviews.add(review);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }
}
