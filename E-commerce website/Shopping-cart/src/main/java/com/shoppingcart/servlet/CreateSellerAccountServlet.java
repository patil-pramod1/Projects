package com.shoppingcart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.shoppingcart.connection.DBconnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateSellerAccountServlet")
public class CreateSellerAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String phoneNumber = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zip_code");
        String storeName = request.getParameter("store_name");
        String storeDescription = request.getParameter("store_description");

        // Establish a database connection
        try (Connection connection = DBconnection.getConnection()) {
            // Insert data into the selleraccount table
            String query = "INSERT INTO revshop.selleraccount (email, password, first_name, last_name, phone_number, address, city, state, zip_code, store_name, store_description) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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

                // Execute the insert statement
                int rowsAffected = pst.executeUpdate();
                if (rowsAffected > 0) {
                    // Redirect to a success page or login page
                    response.sendRedirect("login_seller.jsp");
                } else {
                    // Handle failure (e.g., redirect to an error page)
                    response.sendRedirect("error.jsp");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
