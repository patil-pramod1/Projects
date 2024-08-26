<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.shoppingcart.usermodel.Order" %>
<%@ page import="com.shoppingcart.dao.OrderDAO" %>
<%@ include file="includes/navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Orders</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .order-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-table th, .order-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .order-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }

        .order-table td {
            vertical-align: middle;
        }

        .no-orders-message {
            text-align: center;
            font-size: 1.2em;
            margin: 50px 0;
        }
    </style>
</head>
<body>
    <div class="container order-container">
        <h2>Your Orders</h2>
        <%
            if (session.getAttribute("auth") == null) {
                response.sendRedirect("login_buyer.jsp");
                return;
            }

            String userEmail = (String) session.getAttribute("email");

            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = null;

            try {
                orders = orderDAO.getOrdersByUser(userEmail);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }

            if (orders == null || orders.isEmpty()) {
        %>
            <p class="no-orders-message">You have not placed any orders yet.</p>
        <%
            } else {
        %>
            <table class="order-table table table-hover">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Order Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%	int i=1;
                        for (Order order : orders) {
                        	
                    %>
                    <tr>
                        <td><%= i %></td>
                        <td><%= order.getProductName() %></td>
                        <td><%= order.getQuantity() %></td>
                        <td>Rs.<%= order.getPrice() %></td>
                        <td><%= order.getOrderDate() %></td>
                    </tr>
                    <%
                      		i++;  }
                    %>
                </tbody>
            </table>
        <%
            }
        %>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
