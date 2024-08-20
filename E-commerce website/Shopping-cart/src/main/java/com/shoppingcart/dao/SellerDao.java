package com.shoppingcart.dao;


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
}

