package com.shoppingcart.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.dao.CartDAO;
import com.shoppingcart.dao.ProductDAO;
import com.shoppingcart.usermodel.CartItem;
import com.shoppingcart.usermodel.Order;
import com.shoppingcart.usermodel.Product;

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
        ProductDAO productDAO = new ProductDAO();

        try {
            List<CartItem> cartItems = cartDAO.getCartItemsByUser(email);
            if (cartItems == null || cartItems.isEmpty()) {
                System.out.println("Cart is empty. Cannot proceed with order.");
                request.setAttribute("errorMessage", "Your cart is empty. Please add items to the cart before proceeding.");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            // Fetch and validate form parameters
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zipCode = request.getParameter("zipCode");
            String phone = request.getParameter("phone");
            String paymentMethod = request.getParameter("paymentMethod");

            // Log the paymentMethod to ensure it is being captured correctly
            System.out.println("Payment Method: " + paymentMethod);

            // Validate paymentMethod
            if (paymentMethod == null || paymentMethod.isEmpty()) {
                System.out.println("Payment method is null or empty, redirecting to error page.");
                request.setAttribute("errorMessage", "Payment method is required.");
                request.getRequestDispatcher("orderfail.jsp").forward(request, response);
                return;
            }

            BigDecimal totalAmount = BigDecimal.ZERO;

            for (CartItem cartItem : cartItems) {
                Product product = productDAO.getProductById(cartItem.getProductId());
                if (product != null) {
                    cartItem.setFullName(fullName);
                    cartItem.setAddress(address);
                    cartItem.setCity(city);
                    cartItem.setState(state);
                    cartItem.setZipCode(zipCode);
                    cartItem.setPhone(phone);
                    cartItem.setPaymentMethod(paymentMethod);

                    totalAmount = totalAmount.add(processSingleCartItem(cartDAO, cartItem, product, email));
                } else {
                    System.out.println("Product not found for productId: " + cartItem.getProductId());
                    response.sendRedirect("error.jsp");
                    return;
                }
            }

            if (totalAmount.compareTo(BigDecimal.ZERO) <= 0) {
                System.out.println("Total amount is zero or less, cannot proceed with order.");
                request.setAttribute("errorMessage", "Cannot proceed with an empty cart.");
                request.getRequestDispatcher("orderfail.jsp").forward(request, response);
                return;
            }

            updateProductEmail(cartItems, email); // Update the email in the product table

            request.setAttribute("successMessage", "Order placed successfully!");
            request.getRequestDispatcher("orderSuccess.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private BigDecimal processSingleCartItem(CartDAO cartDAO, CartItem cartItem, Product product, String email) throws SQLException, ClassNotFoundException {
        int userOrderNumber = getNextUserOrderNumber(email);

        // Reduce the product stock by the quantity ordered
        boolean stockUpdated = updateProductStock(product.getProductId(), cartItem.getQuantity());

        if (!stockUpdated) {
            throw new SQLException("Failed to update stock for product ID: " + product.getProductId());
        }

        saveOrder(createOrder(cartItem, product, email, userOrderNumber));

        return cartItem.getPrice().multiply(new BigDecimal(cartItem.getQuantity()));
    }

    private boolean updateProductStock(int productId, int quantity) throws SQLException, ClassNotFoundException {
        // Updated column name to match the database
        String updateStockSql = "UPDATE revshop.product SET stockQuantity = stockQuantity - ? WHERE productId = ? AND stockQuantity >= ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateStockSql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, productId);
            statement.setInt(3, quantity); // Ensure stock doesn't go negative

            int rowsAffected = statement.executeUpdate();

            // If no rows were updated, it means there wasn't enough stock
            return rowsAffected > 0;
        }
    }


    private void updateProductEmail(List<CartItem> cartItems, String buyerEmail) throws SQLException, ClassNotFoundException {
        String updateSql = "UPDATE revshop.product SET email = ? WHERE productId = ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateSql)) {

            for (CartItem cartItem : cartItems) {
                statement.setString(1, buyerEmail);
                statement.setInt(2, cartItem.getProductId());
                statement.executeUpdate();
            }
        }
    }

    private BigDecimal calculateTotalAmount(String email) throws SQLException, ClassNotFoundException {
        CartDAO cartDAO = new CartDAO();
        List<CartItem> cartItems = cartDAO.getCartItemsByUser(email);
        BigDecimal totalAmount = BigDecimal.ZERO;

        if (cartItems != null) {
            for (CartItem item : cartItems) {
                BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                totalAmount = totalAmount.add(itemTotal);
            }
        }

        return totalAmount;
    }

    private void saveOrder(Order order) throws SQLException {
        String sql = "INSERT INTO revshop.receivedorders (orderId, cartId, fullName, address, city, state, zipCode, phone, paymentMethod, orderDate, email, productId, productName, quantity, price, userOrderNumber, sellerEmail, orderStatus) "
                + "VALUES (DEFAULT, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            // Set all parameters using the Order object
            statement.setInt(1, order.getCartId());
            statement.setString(2, order.getFullName());
            statement.setString(3, order.getAddress());
            statement.setString(4, order.getCity());
            statement.setString(5, order.getState());
            statement.setString(6, order.getZipCode());
            statement.setString(7, order.getPhone());
            statement.setString(8, order.getPaymentMethod());
            statement.setTimestamp(9, order.getOrderDate()); // Assuming orderDate is a Timestamp
            statement.setString(10, order.getEmail());
            statement.setInt(11, order.getProductId());
            statement.setString(12, order.getProductName());
            statement.setInt(13, order.getQuantity());
            statement.setBigDecimal(14, order.getPrice());
            statement.setString(15, order.getUserOrderNumber());
            statement.setString(16, order.getSellerEmail());
            statement.setString(17, order.getOrderStatus());

            statement.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new SQLException("Failed to save order for seller", e);
        }
    }

    private Order createOrder(CartItem cartItem, Product product, String email, int userOrderNumber) throws SQLException {
        // Ensure the product object is not null and contains the seller's email
        String sellerEmail = product.getSellerEmail();
        if (sellerEmail == null || sellerEmail.isEmpty()) {
            throw new SQLException("Seller email is missing for product ID: " + product.getProductId());
        }

        Order order = new Order();
        order.setCartId(cartItem.getCartId());
        order.setFullName(cartItem.getFullName());
        order.setAddress(cartItem.getAddress());
        order.setCity(cartItem.getCity());
        order.setState(cartItem.getState());
        order.setZipCode(cartItem.getZipCode());
        order.setPhone(cartItem.getPhone());
        order.setPaymentMethod(cartItem.getPaymentMethod());
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setEmail(email);
        order.setProductId(cartItem.getProductId());
        order.setProductName(cartItem.getProductName());
        order.setQuantity(cartItem.getQuantity());
        order.setPrice(cartItem.getPrice());
        order.setUserOrderNumber(String.valueOf(userOrderNumber));
        order.setSellerEmail(sellerEmail);  // Ensure this is set correctly
        order.setOrderStatus("Order Placed");

        return order;
    }

    private int getNextUserOrderNumber(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT MAX(CAST(userOrderNumber AS UNSIGNED)) FROM revshop.receivedorders WHERE email = ?";

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
}