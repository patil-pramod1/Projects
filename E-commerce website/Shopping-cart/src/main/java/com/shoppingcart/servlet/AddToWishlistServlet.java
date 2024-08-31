package com.shoppingcart.servlet;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.usermodel.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

@WebServlet("/AddToWishlistServlet")
public class AddToWishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Correctly retrieve the UserModel from the session
        UserModel user = (UserModel) session.getAttribute("auth");
        String email = null;
        if (user != null) {
            email = user.getEmail();  // Extract email from UserModel
        }
        
        String productId = request.getParameter("productId");

        if (email == null) {
            // User is not logged in, store the wishlist item in the session
            Set<String> wishlist = (Set<String>) session.getAttribute("wishlist");
            if (wishlist == null) {
                wishlist = new HashSet<>();
            }
            wishlist.add(productId);
            session.setAttribute("wishlist", wishlist);
        } else {
            // User is logged in, store the wishlist item in the database
            try (Connection conn = DBconnection.getConnection()) {
                String query = "INSERT INTO revshop.wishlist (email, productId) VALUES (?, ?)";
                try (PreparedStatement pst = conn.prepareStatement(query)) {
                    pst.setString(1, email);
                    pst.setString(2, productId);
                    pst.executeUpdate();
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding to the wishlist.");
                return;
            }
        }

        response.sendRedirect("Index.jsp"); // Redirect back to the homepage or the product page
    }
}
