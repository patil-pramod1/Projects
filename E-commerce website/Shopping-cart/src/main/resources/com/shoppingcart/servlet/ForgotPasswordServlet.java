package com.shoppingcart.servlet;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("forgotpassword.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String resetToken = generateResetToken();
        
        try {
            // Update the reset token in the database for the user
            if (updateResetToken(email, resetToken)) {
                // Send reset email with the token
                sendResetEmail(email, resetToken);
                request.setAttribute("message", "A password reset link has been sent to your email.");
            } else {
                request.setAttribute("error", "No account found with this email address.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again later.");
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("forgotpassword.jsp");
        dispatcher.forward(request, response);
    }

    private String generateResetToken() {
        return java.util.UUID.randomUUID().toString(); // A simple way to generate a token
    }

    private boolean updateResetToken(String email, String resetToken) throws SQLException {
        Connection conn = DBConnection.initializeDatabase();
        String query = "UPDATE buyeraccount SET reset_token = ? WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, resetToken);
        stmt.setString(2, email);
        
        int rowsUpdated = stmt.executeUpdate();
        stmt.close();
        conn.close();
        
        return rowsUpdated > 0;
    }

    private void sendResetEmail(String email, String resetToken) {
        // Implement email sending logic here, e.g., using JavaMail API
        String resetLink = "http://yourwebsite.com/reset-password?token=" + resetToken;
        String message = "Click the following link to reset your password: " + resetLink;

        // Send the email
//        EmailUtility.sendEmail(email, "Password Reset Request", message);
    }
}
