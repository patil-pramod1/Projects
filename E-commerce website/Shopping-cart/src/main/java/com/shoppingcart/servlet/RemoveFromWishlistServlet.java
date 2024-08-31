package com.shoppingcart.servlet;

import com.shoppingcart.dao.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Set;

@WebServlet("/RemoveFromWishlistServlet")
public class RemoveFromWishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String productId = request.getParameter("productId");

        if (email != null) {
            // User is logged in, remove the item from the database
            WishlistDAO wishlistDAO = new WishlistDAO();
            try {
                wishlistDAO.removeFromWishlist(email, productId);
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
                return;  // Stop further execution after error
            }
        } else {
            // User is not logged in, remove the item from the session-stored wishlist
            Set<String> wishlist = (Set<String>) session.getAttribute("wishlist");
            if (wishlist != null) {
                wishlist.remove(productId);
                session.setAttribute("wishlist", wishlist);
            }
        }

        // Redirect back to the wishlist page
        response.sendRedirect("wishlist.jsp");  // Change this to the correct wishlist page if needed
    }
}
