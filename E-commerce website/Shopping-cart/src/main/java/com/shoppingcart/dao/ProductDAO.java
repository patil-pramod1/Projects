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
    public Product getProductById(int productId) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM revshop.product WHERE productId = ?";
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("productId"));
                product.setProductName(resultSet.getString("productName"));
                product.setPrice(resultSet.getBigDecimal("price"));
                product.setStock(resultSet.getInt("stockQuantity"));
                product.setSellerEmail(resultSet.getString("sellerEmail"));
                return product;
            } else {
                return null;
            }
        }
    }


    // Method to add a cart item to the database
    public void addToCart(String email, CartItem cartItem) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO cart (email, productId, productName, quantity, price, fullName, address, city, state, zipCode, phone, paymentMethod, sellerEmail) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = getConnection();
             PreparedStatement pst = connection.prepareStatement(query)) {
            
            pst.setString(1, cartItem.getEmail());
            pst.setInt(2, cartItem.getProductId());
            pst.setString(3, cartItem.getProductName());
            pst.setInt(4, cartItem.getQuantity());
            pst.setBigDecimal(5, cartItem.getPrice());
            pst.setString(6, cartItem.getFullName());
            pst.setString(7, cartItem.getAddress());
            pst.setString(8, cartItem.getCity());
            pst.setString(9, cartItem.getState());
            pst.setString(10, cartItem.getZipCode());
            pst.setString(11, cartItem.getPhone());
            pst.setString(12, cartItem.getPaymentMethod());
            pst.setString(13, cartItem.getSellerEmail()); // Include sellerEmail

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
                    item.setSellerEmail(rs.getString("sellerEmail")); // Retrieve sellerEmail
                    cartItems.add(item);
                }
            }
        }
        return cartItems;
    }

    // Method to add a review to the database
    public void addReview(int productId, String reviewerName, int rating, String comment) throws ClassNotFoundException {
        try (Connection connection = getConnection()) {
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

    // Method to retrieve reviews for a specific product
    public List<Review> getProductReviews(int productId) throws ClassNotFoundException {
        List<Review> reviews = new ArrayList<>();
        try (Connection connection = getConnection()) {
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

    // Method to search products by a keyword
    public List<Product> searchProducts(String keyword) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM product WHERE productName LIKE ? OR description LIKE ?";
        List<Product> productList = new ArrayList<>();
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("productId"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stockQuantity"));
                product.setImageUrl(rs.getString("imageUrl"));
                product.setDescription(rs.getString("description"));
                product.setCategory(rs.getString("category"));
                productList.add(product);
            }
        }
        
        return productList;
    }

    // Method to retrieve products by category
    public List<Product> getProductsByCategory(String category) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM product WHERE category = ?";
        List<Product> productList = new ArrayList<>();
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("productId"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStock(rs.getInt("stockQuantity"));
                product.setImageUrl(rs.getString("imageUrl"));
                product.setDescription(rs.getString("description"));
                product.setCategory(rs.getString("category"));
                productList.add(product);
            }
        }
        
        return productList;
    }

    public List<Product> getProducts(int itemsPerPage, int offset) throws SQLException, ClassNotFoundException {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM revshop.product LIMIT ? OFFSET ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, itemsPerPage);
            pstmt.setInt(2, offset);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("productId"));
                    product.setProductName(rs.getString("productName"));
                    product.setImageUrl(rs.getString("imageUrl"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setStock(rs.getInt("stockQuantity"));
                    products.add(product);
                }
            }
        }
        return products;
    }

    public int getTotalProductCount() throws SQLException, ClassNotFoundException {
        String query = "SELECT COUNT(*) AS total FROM revshop.product";
        int totalItems = 0;

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                totalItems = rs.getInt("total");
            }
        }
        return totalItems;
    }
    public void addReview(int productId, String reviewerName, int rating, String comment, String email, String sellerEmail) throws ClassNotFoundException {
        String query = "INSERT INTO revshop.reviews (productId, reviewerName, rating, comment, reviewDate, email, sellerEmail) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, productId);
            stmt.setString(2, reviewerName);
            stmt.setInt(3, rating);
            stmt.setString(4, comment);
            stmt.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis())); // current timestamp
            stmt.setString(6, email);
            stmt.setString(7, sellerEmail);
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<Review> getReviewsBySellerEmail(String sellerEmail) throws SQLException, ClassNotFoundException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM revshop.reviews WHERE sellerEmail = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, sellerEmail);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("reviewId"));
                    review.setProductId(rs.getInt("productId"));
                    review.setReviewerName(rs.getString("reviewerName"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setReviewDate(rs.getTimestamp("reviewDate"));
                    review.setEmail(rs.getString("email"));
                    review.setSellerEmail(rs.getString("sellerEmail"));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }
    public void checkAndHandleLowStock(int productId) throws SQLException, ClassNotFoundException {
        String checkStockSql = "SELECT productName, stockQuantity FROM revshop.product WHERE productId = ?";
        String deleteProductSql = "DELETE FROM revshop.product WHERE productId = ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement checkStockStmt = connection.prepareStatement(checkStockSql);
             PreparedStatement deleteProductStmt = connection.prepareStatement(deleteProductSql)) {
            
            checkStockStmt.setInt(1, productId);
            try (ResultSet rs = checkStockStmt.executeQuery()) {
                if (rs.next()) {
                    int stockQuantity = rs.getInt("stockQuantity");
                    String productName = rs.getString("productName");

                    if (stockQuantity < 5 && stockQuantity > 0) {
                        throw new SQLException("Warning: Stock for product '" + productName + "' is low (" + stockQuantity + " items left).");
                    } else if (stockQuantity == 0) {
                        deleteProductStmt.setInt(1, productId);
                        deleteProductStmt.executeUpdate();
                        throw new SQLException("Product '" + productName + "' is out of stock and has been removed from the inventory.");
                    }
                }
            }
        }
    }
    
    public void reduceStockQuantity(int productId, int quantity) throws SQLException, ClassNotFoundException {
        String updateStockSql = "UPDATE revshop.product SET stockQuantity = stockQuantity - ? WHERE productId = ?";
        
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement updateStockStmt = connection.prepareStatement(updateStockSql)) {
            
            updateStockStmt.setInt(1, quantity);
            updateStockStmt.setInt(2, productId);
            updateStockStmt.executeUpdate();
            
            // Check stock quantity after reduction
            checkAndHandleLowStock(productId);
        }
    }
    public List<Product> getLowStockProducts(String sellerEmail) throws SQLException, ClassNotFoundException {
        List<Product> lowStockProducts = new ArrayList<>();
        String sql = "SELECT productId, productName, stockQuantity FROM revshop.product WHERE sellerEmail = ? AND stockQuantity < 5";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, sellerEmail);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("productId"));
                    product.setProductName(rs.getString("productName"));
                    product.setStock(rs.getInt("stockQuantity"));
                    lowStockProducts.add(product);
                }
            }
        }
        return lowStockProducts;
    }
}