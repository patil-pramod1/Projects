package com.shoppingcart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.usermodel.CartItem;
import com.shoppingcart.usermodel.Product;
import com.shoppingcart.usermodel.Review;

public class ProductDAO {

    // Method to get a database connection
    private Connection getConnection() throws SQLException {
        try {
            return DBconnection.getConnection();
        } catch (ClassNotFoundException e) {
            throw new SQLException("Unable to load database driver.", e);
        }
    }

    // Method to retrieve a product by its ID
    public Product getProductById(int productId) throws SQLException {
        String sql = "SELECT * FROM revshop.product WHERE productId = ?";
        
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
             
            statement.setInt(1, productId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Product product = new Product();
                    product.setProductId(resultSet.getInt("productId"));
                    product.setProductName(resultSet.getString("productName"));
                    product.setDescription(resultSet.getString("description"));
                    product.setPrice(resultSet.getBigDecimal("price"));
                    product.setImageUrl(resultSet.getString("imageUrl"));
                    product.setCategory(resultSet.getString("category"));
                    product.setStock(resultSet.getInt("stockQuantity"));
                    return product;
                }
            }
        }
        return null; // Product not found
    }

    // Method to add a cart item to the databas

        public void addToCart(String email, CartItem cartItem) throws SQLException, ClassNotFoundException {
            String query = "INSERT INTO cart (email, productId, productName, quantity, price) VALUES (?, ?, ?, ?, ?)";
            
            try (Connection connection = DBconnection.getConnection();
                 PreparedStatement pst = connection.prepareStatement(query)) {
                
                pst.setString(1, email);
                pst.setInt(2, cartItem.getProductId());
                pst.setString(3, cartItem.getProductName());
                pst.setInt(4, cartItem.getQuantity());
                pst.setBigDecimal(5, cartItem.getPrice());

                pst.executeUpdate();
            }
        }
    


    // Method to retrieve all cart items for a specific user by email
    public List<CartItem> getCartItemsByUser(String userEmail) throws SQLException, ClassNotFoundException {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM revshop.cart WHERE email = ?";
        
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
             
            stmt.setString(1, userEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartId(rs.getInt("cartId"));
                    item.setProductId(rs.getInt("productId"));
                    item.setProductName(rs.getString("productName"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    cartItems.add(item);
                }
            }
        }
        return cartItems;
    }
    public void addReview(int productId, String reviewerName, int rating, String comment) throws ClassNotFoundException {
        try (Connection connection = DBconnection.getConnection()) {
            String query = "INSERT INTO revshop.reviews (productId, reviewerName, rating, comment) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);
            stmt.setString(2, reviewerName);
            stmt.setInt(3, rating);
            stmt.setString(4, comment);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<Review> getProductReviews(int productId) throws ClassNotFoundException {
        List<Review> reviews = new ArrayList<>();
        try (Connection connection = DBconnection.getConnection()) {
            String query = "SELECT * FROM reviews WHERE productId = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("reviewId"));
                review.setProductId(rs.getInt("productId"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewerName(rs.getString("reviewerName"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

}
