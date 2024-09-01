<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
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
            String userEmail = (String) session.getAttribute("email");
            if (userEmail == null || userEmail.isEmpty()) {
                response.sendRedirect("login_buyer.jsp");
                return;
            }

            List<Order> orders = null;

            try {
                OrderDAO orderDAO = new OrderDAO();
                orders = orderDAO.getOrdersByUser(userEmail);

                // Update order status based on payment success or failure
                if (orders != null) {
                    for (Order order : orders) {
                        String paymentStatus = order.getPaymentStatus();
                        if (paymentStatus != null && paymentStatus.equals("SUCCESS")) {
                            order.setOrderStatus("Order Placed");
                        } else {
                            order.setOrderStatus("Order Placed");
                        }
                        //orderDAO.updateOrderStatus(order); // Assuming this method exists in OrderDAO
                    }
                }

                if (orders != null && !orders.isEmpty()) {
        %>
        <table class="order-table table table-hover">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Order Date</th>
                    <th>Shipping Address</th>
                    <th>Payment Method</th>
                    <th>Order Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Order order : orders) {
                %>
                <tr>
                    <td><%= order.getProductName() %></td>
                    <td><%= order.getQuantity() %></td>
                    <td>Rs.<%= order.getPrice().multiply(new BigDecimal(order.getQuantity())) %></td>
                    <td><%= new java.text.SimpleDateFormat("dd-MM-yyyy").format(order.getOrderDate()) %></td>
                    <td><%= order.getAddress() %>, <%= order.getCity() %>, <%= order.getState() %>, <%= order.getZipCode() %></td>
                    <td><%= order.getPaymentMethod() %></td>
                    <td><%= order.getOrderStatus() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <p class="no-orders-message">No orders found.</p>
        <%
            }
        %>
        <%
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace(); // Log the exception using a logging framework
                out.println("<p class='text-danger'>An error occurred while fetching orders. Please try again later.</p>");
            }
        %>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
