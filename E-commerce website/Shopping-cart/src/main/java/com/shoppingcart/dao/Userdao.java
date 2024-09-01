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

    /**
     * Authenticates a user by email and password.
     * 
     * @param email The user's email.
     * @param password The user's password.
     * @return A UserModel object if authentication is successful, null otherwise.
     */
    public UserModel userLogin(String email, String password) {
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
                    user.setLastName(rs.getString("last_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setAddress(rs.getString("address"));
                    user.setCity(rs.getString("city"));
                    user.setState(rs.getString("state"));
                    user.setZipCode(rs.getString("zip_code"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error occurred while trying to log in user with email: " + email);
            e.printStackTrace();
        }

        return user;
    }

    /**
     * Checks if an email already exists in the database.
     * 
     * @param email The email to check.
     * @return True if the email exists, false otherwise.
     */
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
            System.out.println("Error occurred while checking if email exists: " + email);
            e.printStackTrace();
        }

        return exists;
    }

    /**
     * Creates a new user account in the database.
     * 
     * @param newUser The UserModel object containing the new user's details.
     * @return True if the account was successfully created, false otherwise.
     */
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
            pst.setString(9, newUser.getZipCode());

            int rowsAffected = pst.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error occurred while creating account for email: " + newUser.getEmail());
            e.printStackTrace();
        }

        return success;
    }
    public UserModel getUserByEmail(String email) {
        UserModel user = null;
        String query = "SELECT * FROM revshop.buyeraccount WHERE email = ?";

        try (PreparedStatement pst = this.connection.prepareStatement(query)) {
            pst.setString(1, email);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    user = new UserModel();
                    user.setId(rs.getInt("id"));
                    user.setFirstName(rs.getString("first_name"));
                    user.setLastName(rs.getString("last_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.setAddress(rs.getString("address"));
                    user.setCity(rs.getString("city"));
                    user.setState(rs.getString("state"));
                    user.setZipCode(rs.getString("zip_code"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error occurred while trying to retrieve user with email: " + email);
            e.printStackTrace();
        }

        return user;
    }
}