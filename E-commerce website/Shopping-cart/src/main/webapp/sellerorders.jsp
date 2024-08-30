<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shoppingcart.dao.OrderDAO" %>
<%@ page import="com.shoppingcart.usermodel.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders Received</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
        body {
            background: linear-gradient(to right, #e0c3fc, #8ec5fc);
            font-family: 'Arial', sans-serif;
            color: #333;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            margin: 0 auto;
            padding: 0 15px;
            max-width: 100%;
            box-sizing: border-box;
        }
        .product-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            transition: transform 0.3s;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 15px;
            height: 100%;
            box-sizing: border-box;
            min-height: 350px;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }
        .product-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .product-card h3 {
            font-size: 1.2em;
            margin-bottom: 10px;
            color: #333;
        }
        .product-card p {
            flex-grow: 1;
            margin-bottom: 10px;
        }
        .price-quantity-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .price {
            color: #ff5722;
            font-size: 1.1em;
            margin: 0;
        }
        .quantity-input {
            display: inline-block;
            width: 60px;
            border-radius: 5px;
            text-align: center;
            border: 1px solid #ddd;
            padding: 5px;
            font-size: 1em;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        .add-to-cart-btn, .buy-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.8em;
            transition: background-color 0.3s, transform 0.2s;
            width: 48%;
        }
        .add-to-cart-btn:hover, .buy-btn:hover {
            transform: translateY(-2px);
        }
        .buy-btn {
            background-color: #007bff;
        }
        .buy-btn:hover {
            background-color: #0056b3;
        }
        @media (max-width: 1200px) {
            .product-grid {
                grid-template-columns: repeat(4, 1fr);
            }
        }
        @media (max-width: 992px) {
            .product-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 576px) {
            .product-grid {
                grid-template-columns: 1fr;
            }
        }
        .pagination-container {
            text-align: center;
            margin: 20px 0;
        }
        .product-container {
            margin-top: 0.5cm; /* Set a 0.5cm gap between navbar and product grid */
        }
    </style>
</head>
<body>
<%@ include file="includes/navbarseller.jsp" %>
    <div class="container">
        <h2>Orders Received</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Order Date</th>
                    <th>Buyer Email</th>
                    <th>Buyer Name</th>
                    <th>Shipping Address</th>
                    <th>Payment Method</th>
                    <th>Order Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String sellerEmail = (String) session.getAttribute("auth"); // Retrieve the seller's email from session
                    
                    // Debugging: Print the seller email to verify
                    System.out.println("Seller email from session: " + sellerEmail);

                    if (sellerEmail != null && !sellerEmail.isEmpty()) {
                        List<Order> ordersList = null;
                        try {
                            OrderDAO orderDAO = new OrderDAO();
                            ordersList = orderDAO.getOrdersBySellerEmail(sellerEmail); // Fetch orders by seller's email
                        } catch (SQLException | ClassNotFoundException e) {
                            e.printStackTrace();
                        }

                        if (ordersList != null && !ordersList.isEmpty()) {
                            for (Order order : ordersList) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getProductId() %></td>
                    <td><%= order.getProductName() %></td>
                    <td><%= order.getQuantity() %></td>
                    <td><%= order.getPrice() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td><%= order.getEmail() %></td>
                    <td><%= order.getFullName() %></td>
                    <td><%= order.getAddress() %>, <%= order.getCity() %>, <%= order.getState() %>, <%= order.getZipCode() %></td>
                    <td><%= order.getPaymentMethod() %></td>
                    <td>
                        <form action="UpdateOrderStatusServlet" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <select name="orderStatus" class="form-control" onchange="this.form.submit()">
                                <option value="Order Received" <%= "Order Received".equals(order.getOrderStatus()) ? "selected" : "" %>>Order Received</option>
                                <option value="Processing" <%= "Processing".equals(order.getOrderStatus()) ? "selected" : "" %>>Processing</option>
                                <option value="Shipped" <%= "Shipped".equals(order.getOrderStatus()) ? "selected" : "" %>>Shipped</option>
                                <option value="Delivered" <%= "Delivered".equals(order.getOrderStatus()) ? "selected" : "" %>>Delivered</option>
                                <option value="Cancelled" <%= "Cancelled".equals(order.getOrderStatus()) ? "selected" : "" %>>Cancelled</option>
                                <option value="Returned" <%= "Returned".equals(order.getOrderStatus()) ? "selected" : "" %>>Returned</option>
                            </select>
                        </form>
                    </td>
                </tr>
                <%
                            }
                        } else {
                %>
                <tr>
                    <td colspan="11" class="text-center">No orders received.</td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="11" class="text-center">Seller email not found in session. Please <a href="login_seller.jsp">login</a>.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<%@ include file="includes/footer.jsp" %>
</html>
