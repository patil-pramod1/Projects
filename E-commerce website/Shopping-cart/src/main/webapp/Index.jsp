<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.shoppingcart.connection.DBconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Home Page</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f4f4f4, #eaeaea);
        }

        .header {
            background-color: #007bff;
            color: white;
            padding: 10px 0;
            text-align: center;
        }

        .container {
            margin-top: 20px;
            max-width: 1200px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
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
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .product-card img {
            width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }

        .product-card h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #333;
        }

        .price {
            color: #ff5722;
            font-size: 1.3em;
            margin-bottom: 15px;
        }

        .add-to-cart-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            width: 100%;
            height: 50px;
            transition: background-color 0.3s, transform 0.2s;
            display: inline-block;
        }

        .add-to-cart-btn:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .buy-btn {
            background-color: #007bff;
            margin-top: 10px;
        }

        .buy-btn:hover {
            background-color: #0056b3;
        }

        .footer {
            background-color: #f8f9fa;
            text-align: center;
            padding: 10px 0;
            margin-top: 20px;
        }

        .customer-care {
            margin-top: 20px;
            text-align: center;
        }

        .navbar-nav .nav-link.active {
            color: white !important;
            background-color: #007bff !important;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <!-- Navbar inclusion -->
    <%@ include file="includes/navbar.jsp" %>

    <!-- Main content: Product Grid -->
    <div class="container">
        <div class="product-grid">
            <%
                try (Connection conn = DBconnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM revshop.product")) {

                    while (rs.next()) {
                        String productId = rs.getString("productId");
                        String productName = rs.getString("productName");
                        String productImage = rs.getString("imageUrl");
                        String productPrice = rs.getString("price");
                        String productDescription = rs.getString("description");
                        int stock = rs.getInt("stockQuantity");
            %>
            <div class="product-card">
                <img src="<%= productImage %>" alt="<%= productName %>">
                <h3><%= productName %></h3>
                <p><%= productDescription %></p>
                <p class="price">Rs.<%= productPrice %></p>
                <form action="AddToCartServlet" method="post">
                    <input type="hidden" name="productId" value="<%= productId %>" />
                    <input type="number" name="quantity" value="1" min="1" max="<%= stock %>" required />
                    <input type="submit" value="Add to Cart" class="add-to-cart-btn" />
                    <input type="submit" value=" Buy " class="add-to-cart-btn buy-btn"/>
                </form>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger' role='alert'>Failed to connect to the database.</div>");
                }
            %>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2023 Your Online Store. All rights reserved.</p>
    </div>

    <!-- Customer Care Section -->
    <div class="container customer-care">
        <h4>Customer Care</h4>
        <p><i class="fas fa-phone"></i> Call us: 1800-123-456</p>
        <p><i class="fas fa-envelope"></i> Email: support@example.com</p>
        <p><i class="fas fa-comments"></i> Live Chat: Available 24/7</p>
        <h4>Feedback</h4>
        <p>Your feedback is important to us! <a href="#">Click here</a> to provide your feedback.</p>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
