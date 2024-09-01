<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.shoppingcart.dao.CartDAO" %>
<%@ page import="com.shoppingcart.usermodel.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ include file="includes/navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .cart-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cart-table th, .cart-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .cart-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }

        .cart-table td {
            vertical-align: middle;
        }

        .cart-total {
            text-align: right;
            padding: 15px;
            font-size: 1.2em;
            font-weight: bold;
        }

        .empty-cart-message {
            text-align: center;
            font-size: 1.2em;
            margin: 50px 0;
        }
       
        /* Additional styles for favorite button */
        .favorite-btn {
            color: white;
            font-size: 1.5em;
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            transition: color 0.3s ease;
            background: none;
            border: none;
            outline: none;
            padding: 0;
            text-shadow: 
                -1px -1px 0 #000,  
                 1px -1px 0 #000,
                -1px  1px 0 #000,
                 1px  1px 0 #000;
        }

        .favorite-btn.active {
            color: red;
        }

        @keyframes spark {
            0% {
                box-shadow: 0 0 0 0 rgba(255, 0, 0, 0.7);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(255, 0, 0, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(255, 0, 0, 0);
            }
        }

        .favorite-btn:active {
            animation: spark 0.3s ease-out;
        }
        
        /* Other styles... */
        .product-card {
            position: relative; /* Added to position favorite button */
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
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }
        .product-card img {
    width: 100%;
    height: 150px;
    object-fit: contain; /* Change from cover to contain */
    border-radius: 10px;
    margin-bottom: 15px;
    background-color: #f8f8f8; /* Optional: Add background color to fill space if the image doesn't cover entire area */
} 
        .product-card h3 {
            font-size: 1.2em;
            margin-bottom: 10px;
            color: #333;
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
    </style>
 
</head>
<body>
    <div class="container cart-container">
        <%
            if (session.getAttribute("auth") == null) {
                response.sendRedirect("login_buyer.jsp");
                return;
            }

            String userEmail = (String) session.getAttribute("email");

            CartDAO cartDAO = new CartDAO();
            List<CartItem> cartItems = null;

            try {
                cartItems = cartDAO.getCartItemsByUser(userEmail);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }

            if (cartItems == null || cartItems.isEmpty()) {
        %>
            <p class="empty-cart-message">Your cart is empty.</p>
        <%
            } else {
                BigDecimal total = new BigDecimal("0");
        %>
            <table class="cart-table table table-hover">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (CartItem item : cartItems) {
                            BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));
                            total = total.add(itemTotal);
                    %>
                    <tr>
                        <td><%= item.getProductName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>Rs.<%= item.getPrice() %></td>
                        <td>Rs.<%= String.format("%.2f", itemTotal) %></td>
                        <td>
                            <!-- Form for the Buy button -->
                            <form action="ConfirmOrderServlet" method="post" style="display: inline;">
                                <input type="hidden" name="cartId" value="<%= item.getCartId() %>" />
                                <button type="submit" class="btn btn-success">Buy</button>
                            </form>

                            <!-- Form for the Remove button -->
                            <form action="RemoveCartServlet" method="post" style="display: inline;">
                                <input type="hidden" name="cartId" value="<%= item.getCartId() %>" />
                                <button type="submit" class="btn btn-danger">Remove</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                        BigDecimal totalRounded = total.setScale(2, BigDecimal.ROUND_HALF_UP);
                    %>
                    <tr>
                        <td colspan="3" class="cart-total">Total</td>
                        <td colspan="2" class="cart-total">Rs.<%= String.format("%.2f", totalRounded) %></td>
                    </tr>
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