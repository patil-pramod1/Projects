package com.shoppingcart.servlet;

import java.io.IOException;
import java.sql.SQLException;

import com.shoppingcart.dao.CartDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RemoveCartServlet")
public class RemoveCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve the cartId from the request
        String cartIdStr = request.getParameter("cartId");
        int cartId;

        try {
            cartId = Integer.parseInt(cartIdStr);
        } catch (NumberFormatException e) {
            // Handle the case where cartId is not a valid number
            response.sendRedirect("error.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();

        try {
            cartDAO.removeFromCart(cartId);
            response.sendRedirect("cart.jsp");  // Redirect back to the cart page after removal
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page on failure
        }
    }
}
