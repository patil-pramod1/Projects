package com.shoppingcart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.usermodel.Order;

public class OrderDAO {

    public List<Order> getOrdersByUser(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM orders WHERE email = ?";
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setProductId(rs.getInt("product_id"));
                order.setProductName(rs.getString("product_name"));
                order.setQuantity(rs.getInt("quantity"));
                order.setPrice(rs.getDouble("price"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                orders.add(order);
            }
        }
        return orders;
    }
}
