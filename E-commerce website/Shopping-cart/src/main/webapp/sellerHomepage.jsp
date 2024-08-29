<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shoppingcart.usermodel.Product" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.*" %>
<%@ page import="com.shoppingcart.connection.DBconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - RevShop</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> <!-- Font Awesome CDN -->
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
<%@ include file="includes/navbarseller.jsp" %>

      <div class="container product-container">
      <h2>Products</h2>
    <div class="product-grid">
        <%
            // Check if the seller is logged in
            if (session.getAttribute("auth") == null) {
                response.sendRedirect("login_seller.jsp");
                return;
            }

            // Retrieve the seller's email from the session
            String sellerEmail = (String) session.getAttribute("auth");

            try (Connection conn = DBconnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM revshop.product WHERE email = ?")) {

                // Set the seller's email in the query
                ps.setString(1, sellerEmail);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.isBeforeFirst()) { // Check if result set is empty
        %>
                        <p class="empty-product-message">You have not added any products yet.</p>
        <%
                    } else {
                        while (rs.next()) {
                            String productId = rs.getString("productId");
                            String productName = rs.getString("productName");
                            String productImage = rs.getString("imageUrl");
                            String productPrice = rs.getString("price");
                            String productDescription = rs.getString("description");
                            int stock = rs.getInt("stockQuantity");
        %>
            <div class="product-card">
                <img src="<%= productImage %>" alt="<%= productName %>" style="width: 200px; height: 100px;">

                <h3><%= productName %></h3>
                <p><%= productDescription %></p>
                <p class="price">Rs.<%= productPrice %></p>
                <p>Stock: <%= stock %></p>
                
                <!-- Edit and Remove buttons -->
<!-- Edit and Remove buttons -->
<form action="editproduct.jsp" method="get" style="display: inline;">
    <input type="hidden" name="productId" value="<%= productId %>" />
    <button type="submit" class="btn btn-warning">Edit</button>
</form>

<form action="RemoveProductServlet" method="post" style="display: inline;">
    <input type="hidden" name="productId" value="<%= productId %>" />
    <button type="submit" class="btn btn-danger">Remove</button>
</form>

            </div>
        <%
                        } // end while
                    } // end if-else
                } // end try with ResultSet
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger' role='alert'>Failed to connect to the database.</div>");
            }
        %>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Include jQuery first -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Then include Bootstrap's JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
