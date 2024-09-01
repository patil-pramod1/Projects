package com.shoppingcart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.shoppingcart.connection.DBconnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ForgotPasswordServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String newPassword = request.getParameter("newPassword");

        if (email == null || phone == null || newPassword == null) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        try (Connection connection = DBconnection.getConnection()) {
            // Check if the email and phone number match
            String sql = "SELECT * FROM buyeraccount WHERE email = ? AND phone_number = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email);
                statement.setString(2, phone);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    // Update the password if phone number matches
                    String updateSql = "UPDATE buyeraccount SET password = ? WHERE email = ?";
                    try (PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {
                        updateStatement.setString(1, newPassword);
                        updateStatement.setString(2, email);
                        int rowsUpdated = updateStatement.executeUpdate();

                        if (rowsUpdated > 0) {
                            request.setAttribute("successMessage", "Password updated successfully.");
                            request.getRequestDispatcher("login_buyer.jsp").forward(request, response);
                        } else {
                            request.setAttribute("errorMessage", "Failed to update password.");
                            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                        }
                    }
                } else {
                    request.setAttribute("errorMessage", "Email and phone number do not match.");
                    request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again later.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }
}
