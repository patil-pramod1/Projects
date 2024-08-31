package com.shoppingcart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.usermodel.CartItem;

public class CartDAO {

    // Method to establish a connection to the database
    private Connection getConnection() throws SQLException {
        try {
            return DBconnection.getConnection();
        } catch (ClassNotFoundException e) {
            throw new SQLException("Unable to load database driver.", e);
        }
    }

    // Method to check if a cart item already exists for a user
    public boolean itemExistsInCart(String email, int productId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM revshop.cart WHERE email = ? AND productId = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.setInt(2, productId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;  // Returns true if the item exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return false;
    }

    // Method to add a CartItem to the database
    // If the item already exists, update its quantity
    public void addToCart(String email, int productId, int quantity, double price) throws SQLException {
        if (itemExistsInCart(email, productId)) {
            // If the item exists, update the quantity
            String sql = "UPDATE revshop.cart SET quantity = quantity + ? WHERE email = ? AND productId = ?";
            try (Connection connection = getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql)) {

                statement.setInt(1, quantity);
                statement.setString(2, email);
                statement.setInt(3, productId);
                statement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                throw e;
            }
        } else {
            // If the item does not exist, insert a new one
            String sql = "INSERT INTO revshop.cart (email, productId, quantity, price) VALUES (?, ?, ?, ?)";
            try (Connection connection = getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql)) {

                statement.setString(1, email);
                statement.setInt(2, productId);
                statement.setInt(3, quantity);
                statement.setDouble(4, price);
                statement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                throw e;
            }
        }
    }

    // Method to retrieve all CartItems for a specific user
    public List<CartItem> getCartItemsByUser(String userEmail) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM revshop.cart WHERE email = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, userEmail);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartId(rs.getInt("cartId"));
                item.setProductId(rs.getInt("productId"));
                item.setProductName(rs.getString("productName"));  // Assuming productName is stored in the cart table
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setFullName(rs.getString("fullName"));
                item.setAddress(rs.getString("address"));
                item.setCity(rs.getString("city"));
                item.setState(rs.getString("state"));
                item.setZipCode(rs.getString("zipCode"));
                item.setPhone(rs.getString("phone"));
                item.setPaymentMethod(rs.getString("paymentMethod"));
                cartItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return cartItems;
    }

    // Method to update the quantity of an item in the cart
    public void updateCartItemQuantity(int cartId, int quantity) throws SQLException {
        String sql = "UPDATE revshop.cart SET quantity = ? WHERE cartId = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, cartId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    // Method to remove an item from the cart
    public void removeFromCart(int cartId) throws SQLException {
        System.out.println("Removing cart item with cartId: " + cartId);
        
        String sql = "DELETE FROM revshop.cart WHERE cartId = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Set the cartId parameter
            statement.setInt(1, cartId);

            // Execute the deletion
            int rowsAffected = statement.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Cart item with cartId " + cartId + " removed successfully."+rowsAffected);
            } else {
                System.out.println("Cart item with cartId " + cartId + " not found.");
            }
        } catch (SQLException e) {
            System.err.println("Error removing cart item with cartId: " + cartId);
            e.printStackTrace();
            throw e;  // Re-throw the exception to handle it further up the stack
        }
    }


    // Method to retrieve a CartItem by its cartId
    public CartItem getCartItemById(int cartId) throws SQLException {
        String sql = "SELECT * FROM revshop.cart WHERE cartId = ?";
        CartItem item = null;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                item = new CartItem();
                item.setCartId(rs.getInt("cartId"));
                item.setProductId(rs.getInt("productId"));
                item.setProductName(rs.getString("productName"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setFullName(rs.getString("fullName"));
                item.setAddress(rs.getString("address"));
                item.setCity(rs.getString("city"));
                item.setState(rs.getString("state"));
                item.setZipCode(rs.getString("zipCode"));
                item.setPhone(rs.getString("phone"));
                item.setPaymentMethod(rs.getString("paymentMethod"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return item;
    }

    // Method to clear the cart for a specific user
    public void clearCart(String email) throws SQLException {
        String sql = "DELETE FROM revshop.cart WHERE email = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
}