package com.shoppingcart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.shoppingcart.UserModel;

public class Userdao {
    private Connection connection;
    private String query;
    private PreparedStatement pst;

    public Userdao(Connection connection) {
        this.connection = connection;
    }
    public UserModel userlogin(String email, String password) {
        UserModel user = null;
        try {
            query = "SELECT * FROM revshop.buyeraccount WHERE email = ? AND password = ?";
            pst = this.connection.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new UserModel();
                user.setId(rs.getInt("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    public boolean emailExists(String email) {
        boolean exists = false;
        try {
            query = "SELECT COUNT(*) FROM revshop.buyeraccount WHERE email = ?";
            pst = this.connection.prepareStatement(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    exists = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }
    
    public boolean createAccount(UserModel newUser) {
        boolean success = false;
        try {
            // SQL query to insert a new record into the buyeraccount table
            query = "INSERT INTO revshop.buyeraccount (email, password, first_name, last_name, phone_number, address, city, state, zip_code) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pst = this.connection.prepareStatement(query);
            pst.setString(1, newUser.getEmail());
            pst.setString(2, newUser.getPassword());
            pst.setString(3, newUser.getFirstName());
            pst.setString(4, newUser.getLastName());
            pst.setString(5, newUser.getPhoneNumber());
            pst.setString(6, newUser.getAddress());
                       
            int rowsAffected = pst.executeUpdate();
            
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
}
