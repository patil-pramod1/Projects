package com.shoppingcart.dao;


import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SellerDao {
    private Connection connection;

    public SellerDao(Connection connection) {
        this.connection = connection;
    }

    public boolean createSellerAccount(String email, String password, String firstName, String lastName, String phoneNumber, String address, String city, String state, String zipCode, String storeName, String storeDescription) {
        String query = "INSERT INTO revshop.selleraccount (email, password, first_name, last_name, phone_number, address, city, state, zip_code, store_name, store_description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pst = connection.prepareStatement(query)) {
            pst.setString(1, email);
            pst.setString(2, password);
            pst.setString(3, firstName);
            pst.setString(4, lastName);
            pst.setString(5, phoneNumber);
            pst.setString(6, address);
            pst.setString(7, city);
            pst.setString(8, state);
            pst.setString(9, zipCode);
            pst.setString(10, storeName);
            pst.setString(11, storeDescription);

            int result = pst.executeUpdate();
            return result > 0; // Returns true if at least one row is affected
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean addProduct(String productName, String description, double price, String imageUrl, String category, int stockQuantity, String dateAdded, String lastUpdated, String email) {
        String query = "INSERT INTO product (productName, description, price, imageUrl, category, stockQuantity, dateAdded, lastUpdated, vendorId) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, (SELECT vendorId FROM selleraccount WHERE email = ?))";
        try (PreparedStatement pst = connection.prepareStatement(query)) {
            pst.setString(1, productName);
            pst.setString(2, description);
            pst.setBigDecimal(3, new BigDecimal(price).setScale(2));
            pst.setString(4, imageUrl);
            pst.setString(5, category);
            pst.setInt(6, stockQuantity);
            pst.setString(7, dateAdded);
            pst.setString(8, lastUpdated);
            pst.setString(9, email); // Bind email to the query

            int result = pst.executeUpdate();
            return result > 0; // Returns true if at least one row is affected
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    public boolean addProductseller(String productName, String description, double price, String imageUrl, String category, int stockQuantity, String dateAdded, String lastUpdated, int vendorId, String email) {
        String query = "INSERT INTO product (productName, description, price, imageUrl, category, stockQuantity, dateAdded, lastUpdated, vendorId, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, productName);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, imageUrl);
            ps.setString(5, category);
            ps.setInt(6, stockQuantity);
            ps.setString(7, dateAdded);
            ps.setString(8, lastUpdated);
            ps.setInt(9, vendorId);  // Set vendorId as an int
            ps.setString(10, email);  // Set email

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}

