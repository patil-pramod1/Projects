package com.shoppingcart.servlet;

import com.shoppingcart.dao.SellerDao;
import com.shoppingcart.connection.DBconnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/SellerLoginServlet")
public class SellerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Debugging: Log the received email and password
        System.out.println("Received email: " + email);

        // Establish a connection to the database
        try (Connection connection = DBconnection.getConnection()) {
            // Validate seller credentials
            boolean isValidSeller = validateSellerCredentials(connection, email, password);

            if (isValidSeller) {
                // Create a new session for the seller
                HttpSession session = request.getSession();
                session.setAttribute("auth", email); // Store email as "auth"

                // Debugging: Log that the seller was authenticated and session was set
                System.out.println("Seller authenticated. Session email set to: " + email);

                // Redirect to the seller's homepage
                response.sendRedirect("sellerHomepage.jsp");
            } else {
                // Invalid login, redirect back to the login page with an error message
                request.setAttribute("errorMessage", "Invalid email or password. Please try again.");
                request.getRequestDispatcher("login_seller.jsp").forward(request, response);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        }
    }

    // Method to validate seller credentials
    private boolean validateSellerCredentials(Connection connection, String email, String password) throws SQLException {
        String query = "SELECT * FROM revshop.selleraccount WHERE email = ? AND password = ?";
        try (PreparedStatement pst = connection.prepareStatement(query)) {
            pst.setString(1, email);
            pst.setString(2, password);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next(); // Returns true if a record is found
            }
        }
    }
}
