package com.shoppingcart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.dao.CartDAO;
import com.shoppingcart.usermodel.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = (String) request.getSession().getAttribute("email");
        String cartIdStr = request.getParameter("cartId");

        if (cartIdStr == null || email == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        int cartId = Integer.parseInt(cartIdStr);
        CartDAO cartDAO = new CartDAO();

        try {
            // Fetch the cart item using the cartId
            CartItem cartItem = cartDAO.getCartItemById(cartId);

            if (cartItem != null) {
                // Save the order for the single item
                saveOrder(cartItem, email);

                // Remove only the item corresponding to the cartId from the cart
                cartDAO.removeFromCart(cartId);

                // Redirect to a success page after the order is confirmed
                response.sendRedirect("orderConfirmation.jsp");
            } else {
                // Handle case where cartItem is not found
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void saveOrder(CartItem cartItem, String email) throws SQLException {
        String sql = "INSERT INTO revshop.orders (email, product_id, product_name, quantity, price, order_date) VALUES (?, ?, ?, ?, ?, NOW())";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.setInt(2, cartItem.getProductId());
            statement.setString(3, cartItem.getProductName());
            statement.setInt(4, cartItem.getQuantity());
            statement.setBigDecimal(5, cartItem.getPrice());

            statement.executeUpdate();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
