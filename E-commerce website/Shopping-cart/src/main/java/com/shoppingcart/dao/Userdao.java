package com.shoppingcart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.shoppingcart.usermodel.UserModel;

public class Userdao {
    private Connection connection;

    public Userdao(Connection connection) {
        this.connection = connection;
    }

    public UserModel userlogin(String email, String password) {
        UserModel user = null;
        String query = "SELECT * FROM revshop.buyeraccount WHERE email = ? AND password = ?";
        try (PreparedStatement pst = this.connection.prepareStatement(query)) {
            pst.setString(1, email);
            pst.setString(2, password);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    user = new UserModel();
                    user.setId(rs.getInt("id"));
                    user.setFirstName(rs.getString("first_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    // Populate other fields as needed
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging the exception
        }
        return user;
    }

    public boolean emailExists(String email) {
        boolean exists = false;
        String query = "SELECT COUNT(*) FROM revshop.buyeraccount WHERE email = ?";
        try (PreparedStatement pst = this.connection.prepareStatement(query)) {
            pst.setString(1, email);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    exists = rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging the exception
        }
        return exists;
    }

    public boolean createAccount(UserModel newUser) {
        boolean success = false;
        String query = "INSERT INTO revshop.buyeraccount (email, password, first_name, last_name, phone_number, address, city, state, zip_code) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pst = this.connection.prepareStatement(query)) {
            pst.setString(1, newUser.getEmail());
            pst.setString(2, newUser.getPassword());
            pst.setString(3, newUser.getFirstName());
            pst.setString(4, newUser.getLastName());
            pst.setString(5, newUser.getPhoneNumber());
            pst.setString(6, newUser.getAddress());
            pst.setString(7, newUser.getCity());
            pst.setString(8, newUser.getState());
            pst.setString(9, newUser.getZip_code());

            int rowsAffected = pst.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging the exception
        }
        return success;
    }
}
