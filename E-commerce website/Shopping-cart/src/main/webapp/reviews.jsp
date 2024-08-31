<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.shoppingcart.dao.ProductDAO" %>
<%@ page import="com.shoppingcart.usermodel.Review" %>

<%

String sellerEmail = (String) session.getAttribute("auth"); // Get the seller's email from the session
if (sellerEmail == null || session.getAttribute("auth") == null) {
    // If the seller is not logged in, redirect to the login page
    response.sendRedirect("login_seller.jsp");
    return;
}

    ProductDAO productDao = new ProductDAO();
    List<Review> reviews = null;
    try {
        reviews = productDao.getReviewsBySellerEmail(sellerEmail);
    } catch (Exception e) {
        e.printStackTrace();
        reviews = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

        .product-container {
            margin-top: 0.5cm;
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

        #img {
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
    <%@ include file="includes/navbarseller.jsp"%>

<div class="container mt-5">
    <h1>Product Reviews</h1>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Reviewer Name</th>
                <th>Rating</th>
                <th>Comment</th>
                <th>Review Date</th>
            </tr>
        </thead>
        <tbody>
            <% if (reviews.isEmpty()) { %>
                <tr>
                    <td colspan="5" class="text-center">No reviews found for your products.</td>
                </tr>
            <% } else { 
                for (Review review : reviews) { %>
                    <tr>
                        <td><%= review.getProductId() %></td>
                        <td><%= review.getReviewerName() %></td>
                        <td><%= review.getRating() %></td>
                        <td><%= review.getComment() %></td>
                        <td><%= review.getReviewDate() %></td>
                    </tr>
                <% } 
            } %>
        </tbody>
    </table>
</div>

</body>
</html>
