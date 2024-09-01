package com.shoppingcart.dao;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.usermodel.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Method to save an order to the revshop.orders table
    public void saveOrder(Order order) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO revshop.orders (cart_id, full_name, address, city, state, zip_code, phone, payment_method, order_date, email, product_id, product_name, quantity, price, user_order_number, seller_email) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, order.getCartId());
            statement.setString(2, order.getFullName());
            statement.setString(3, order.getAddress());
            statement.setString(4, order.getCity());
            statement.setString(5, order.getState());
            statement.setString(6, order.getZipCode());
            statement.setString(7, order.getPhone());
            statement.setString(8, order.getPaymentMethod());
            statement.setTimestamp(9, order.getOrderDate());
            statement.setString(10, order.getEmail());
            statement.setInt(11, order.getProductId());
            statement.setString(12, order.getProductName());
            statement.setInt(13, order.getQuantity());
            statement.setBigDecimal(14, order.getPrice());
            statement.setString(15, order.getUserOrderNumber());
            statement.setString(16, order.getSellerEmail());

            statement.executeUpdate();
        }
    }

    // Method to retrieve orders by user email
    public List<Order> getOrdersByUser(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM revshop.orders WHERE email = ?";
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
        }

        return orders;
    }

    // Method to retrieve orders by seller email
    public List<Order> getOrdersBySellerEmail(String sellerEmail) throws SQLException, ClassNotFoundException {
        List<Order> ordersList = new ArrayList<>();

        String sql = "SELECT * FROM revshop.orders WHERE seller_email = ?";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, sellerEmail);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setCartId(rs.getInt("cart_id"));
                    order.setFullName(rs.getString("full_name"));
                    order.setAddress(rs.getString("address"));
                    order.setCity(rs.getString("city"));
                    order.setState(rs.getString("state"));
                    order.setZipCode(rs.getString("zip_code"));
                    order.setPhone(rs.getString("phone"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setEmail(rs.getString("email"));
                    order.setProductId(rs.getInt("product_id"));
                    order.setProductName(rs.getString("product_name"));
                    order.setQuantity(rs.getInt("quantity"));
                    order.setPrice(rs.getBigDecimal("price"));
                    order.setUserOrderNumber(rs.getString("user_order_number"));
                    order.setSellerEmail(rs.getString("seller_email"));
                    order.setOrderStatus(rs.getString("order_status"));
                    ordersList.add(order);
                }
            }
        }
        return ordersList;
    }

    // Utility method to map ResultSet to Order object
    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setProductId(rs.getInt("product_id"));
        order.setProductName(rs.getString("product_name"));
        order.setQuantity(rs.getInt("quantity"));
        order.setPrice(rs.getBigDecimal("price"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setEmail(rs.getString("email"));
        order.setFullName(rs.getString("full_name"));
        order.setAddress(rs.getString("address"));
        order.setCity(rs.getString("city"));
        order.setState(rs.getString("state"));
        order.setZipCode(rs.getString("zip_code"));
        order.setPhone(rs.getString("phone"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setOrderStatus(rs.getString("order_status"));
        return order;
    }
    public void updateOrderStatus(Order order) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE revshop.orders SET order_status = ? ";

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, order.getOrderStatus());
            
            statement.executeUpdate();
        }
    }
}