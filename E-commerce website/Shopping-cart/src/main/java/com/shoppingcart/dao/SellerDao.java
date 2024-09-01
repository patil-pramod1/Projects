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

    /**
     * Creates a new seller account in the selleraccount table.
     *
     * @param email The email address of the seller.
     * @param password The password for the seller's account.
     * @param firstName The first name of the seller.
     * @param lastName The last name of the seller.
     * @param phoneNumber The phone number of the seller.
     * @param address The address of the seller.
     * @param city The city of the seller.
     * @param state The state of the seller.
     * @param zipCode The ZIP code of the seller.
     * @param storeName The name of the seller's store.
     * @param storeDescription A description of the seller's store.
     * @return true if the account was successfully created, false otherwise.
     */
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

    /**
     * Adds a new product to the product table, linked to the seller via their email.
     *
     * @param productName The name of the product.
     * @param description A description of the product.
     * @param price The price of the product.
     * @param imageUrl The URL of the product's image.
     * @param category The category of the product.
     * @param stockQuantity The quantity of the product in stock.
     * @param dateAdded The date the product was added.
     * @param lastUpdated The date the product was last updated.
     * @param email The email of the seller.
     * @return true if the product was successfully added, false otherwise.
     */
    public boolean addProduct(String productName, String description, double price, String imageUrl, String category, int stockQuantity, String dateAdded, String lastUpdated, String email) {
        String query = "INSERT INTO product (productName, description, price, imageUrl, category, stockQuantity, dateAdded, lastUpdated, vendorId) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, (SELECT vendorId FROM revshop.selleraccount WHERE email = ?))";
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

    /**
     * Adds a new product to the product table, with the vendorId directly provided.
     *
     * @param productName The name of the product.
     * @param description A description of the product.
     * @param price The price of the product.
     * @param imageUrl The URL of the product's image.
     * @param category The category of the product.
     * @param stockQuantity The quantity of the product in stock.
     * @param dateAdded The date the product was added.
     * @param lastUpdated The date the product was last updated.
     * @param vendorId The ID of the vendor adding the product.
     * @param email The email of the seller.
     * @return true if the product was successfully added, false otherwise.
     */
    public boolean addProductseller(String productName, String description, double price, String imageUrl, String category, int stockQuantity, String dateAdded, String lastUpdated, int vendorId, String buyerEmail, String sellerEmail) throws SQLException {
        String query = "INSERT INTO product (productId, productName, description, price, imageUrl, category, stockQuantity, dateAdded, lastUpdated, vendorId, email, sellerEmail) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, productName);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, imageUrl);
            ps.setString(5, category);
            ps.setInt(6, stockQuantity);
            ps.setString(7, dateAdded);
            ps.setString(8, lastUpdated);
            ps.setInt(9, vendorId);
            ps.setString(10, buyerEmail); // Initially set as an empty string
            ps.setString(11, sellerEmail);

            int result = ps.executeUpdate();
            return result > 0;
        }
    }


}