<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        body {
            background: linear-gradient(to right, #e0c3fc, #8ec5fc);
            font-family: 'Arial', sans-serif;
            color: #333;
        }
    </style>
</head>

<body>
    <div class="container order-container">
        <h2>Your Orders</h2>

        <!-- Check for error message -->
        <c:if test="${not empty error}">
            <p class="text-danger">${error}</p>
        </c:if>

        <!-- Check if orders list is not empty -->
        <c:if test="${not empty orders}">
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
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.productName}</td>
                            <td>${order.quantity}</td>
                            <td>Rs. ${order.price.multiply(order.quantity)}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy"/></td>
                            <td>${order.address}, ${order.city}, ${order.state}, ${order.zipCode}</td>
                            <td>${order.paymentMethod}</td>
                            <td>${order.orderStatus}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- If no orders were found -->
        <c:if test="${empty orders}">
            <p class="no-orders-message">No orders found.</p>
        </c:if>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
