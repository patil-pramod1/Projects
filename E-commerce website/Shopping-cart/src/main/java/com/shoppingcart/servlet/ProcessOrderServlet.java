package com.shoppingcart.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.dao.CartDAO;
import com.shoppingcart.usermodel.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProcessOrderServlet")
public class ProcessOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = (String) request.getSession().getAttribute("email");
        System.out.println("Processing order for user: " + email);

        if (email == null || email.isEmpty()) {
            System.out.println("User not logged in, redirecting to login page.");
            response.sendRedirect("login_buyer.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();

        try {
            // Ensure only one cart item is processed if cartId is provided
            String cartIdParam = request.getParameter("cartId");
            if (cartIdParam != null && !cartIdParam.isEmpty()) {
                try {
                    int cartId = Integer.parseInt(cartIdParam);
                    CartItem cartItem = cartDAO.getCartItemById(cartId);

                    if (cartItem != null) {
                        processSingleCartItem(cartDAO, cartItem, email);
                    } else {
                        System.out.println("Cart item not found for cartId: " + cartId);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid cartId provided: " + cartIdParam);
                }
            } else {
                System.out.println("No specific cartId provided, skipping single item processing.");
            }

            // Redirect to a success page or handle appropriately
            response.sendRedirect("orderSuccess.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void processSingleCartItem(CartDAO cartDAO, CartItem cartItem, String email) throws SQLException, ClassNotFoundException {
        int userOrderNumber = getNextUserOrderNumber(email);
        System.out.println("Processing single cart item: " + cartItem.getProductName() + " (Cart ID: " + cartItem.getCartId() + "), User Order Number: " + userOrderNumber);

        saveOrder(cartItem, email, userOrderNumber);
        cartDAO.removeFromCart(cartItem.getCartId());
        System.out.println("Removed specific cart item: " + cartItem.getCartId());
    }

    private int getNextUserOrderNumber(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT MAX(user_order_number) FROM orders WHERE email = ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int lastOrderNumber = resultSet.getInt(1);
                return lastOrderNumber + 1;
            } else {
                return 1; // First order for this user
            }
        }
    }

    private void saveOrder(CartItem cartItem, String email, int userOrderNumber) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO orders (cart_id, email, product_id, product_name, quantity, price, order_date, user_order_number) " +
                     "VALUES (?, ?, ?, ?, ?, ?, NOW(), ?)";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, cartItem.getCartId());
            statement.setString(2, email);
            statement.setInt(3, cartItem.getProductId());
            statement.setString(4, cartItem.getProductName());
            statement.setInt(5, cartItem.getQuantity());
            statement.setBigDecimal(6, cartItem.getPrice());
            statement.setInt(7, userOrderNumber);

            int rowsAffected = statement.executeUpdate();
            System.out.println("Order saved to database with user order number " + userOrderNumber + ". Rows affected: " + rowsAffected);
        }
    }
}

