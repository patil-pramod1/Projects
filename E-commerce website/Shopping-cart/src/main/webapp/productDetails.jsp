<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shoppingcart.usermodel.Product" %>
<%@ page import="com.shoppingcart.usermodel.Review" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Product product = (Product) request.getAttribute("product");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getProductName() %> - Product Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background: linear-gradient(to right, #e0c3fc, #8ec5fc); /* Soft gradient background */
            font-family: 'Arial', sans-serif; /* Modern font for better readability */
            color: #333; /* Darker text for better contrast */
        }

        .product-image {
            width: 100%;
            max-width: 380px; /* Adjusted max-width */
            height: auto;
            border-radius: 20px; /* More pronounced rounded corners */
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3); /* Deeper shadow for more depth */
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition for transform and shadow */
        }

        .product-image:hover {
            transform: scale(1.05); /* Slightly enlarges image on hover */
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4); /* Enhanced shadow on hover */
        }

        .rating {
            display: flex;
            align-items: center;
            margin: 10px 0; /* Added margin for spacing */
        }

        .rating-star {
            color: gold;
            font-size: 1.5em; /* Adjusted size for balance */
            margin-right: 5px;
            transition: transform 0.3s, color 0.3s; /* Smooth transition for transform and color */
        }

        .rating-star:hover {
            transform: scale(1.2); /* Slightly enlarges star on hover */
            color: orange; /* Changes color on hover */
        }

        .review-form {
            background: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
            border-radius: 15px; /* Rounded corners for the form */
            padding: 20px; /* Padding for better layout */
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2); /* Soft shadow for form */
            margin-top: 20px; /* Space above the form */
        }

        .review-form textarea {
            width: 100%;
            min-height: 120px; /* Slightly taller textarea */
            margin-bottom: 15px; /* More space below the textarea */
            border-radius: 10px; /* Rounded corners */
            border: 1px solid #ccc; /* Light border */
            padding: 15px; /* Padding for better text positioning */
            font-size: 1em; /* Set font size */
            font-family: 'Arial', sans-serif; /* Consistent font */
            transition: border-color 0.3s, box-shadow 0.3s; /* Transition for border and shadow */
        }

        .review-form textarea:focus {
            border-color: gold; /* Highlight border on focus */
            outline: none; /* Remove default outline */
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.5); /* Enhanced shadow on focus */
        }

        .review-form button {
            background: linear-gradient(to right, #ff7e5f, #feb47b); /* Gradient background for button */
            color: white; /* Text color */
            border: none; /* Remove default border */
            border-radius: 10px; /* Rounded corners */
            padding: 12px 25px; /* Padding for better button appearance */
            font-size: 1em; /* Set font size */
            cursor: pointer; /* Pointer cursor on hover */
            transition: background 0.3s, transform 0.3s; /* Smooth transition for background and transform */
            width: 100%; /* Full-width button */
        }

        .review-form button:hover {
            background: linear-gradient(to right, #feb47b, #ff7e5f); /* Reverse gradient on hover */
            transform: translateY(-2px); /* Slight lift effect on hover */
        }

        .review-form button:active {
            transform: translateY(0); /* Reset lift effect on click */
        }

        .review-item {
            background: rgba(255, 255, 255, 0.9); /* Background for review item */
            border-radius: 10px; /* Rounded corners */
            padding: 15px; /* Padding for better layout */
            margin-bottom: 15px; /* Space between reviews */
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); /* Soft shadow for review */
        }

        h1, h3, h4 {
            color: #333; /* Darker color for headings */
        }

        .text-success {
            color: #28a745; /* Bootstrap success color */
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px; /* Space above the button group */
        }

        .add-to-cart-btn, .buy-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 12px; /* Slightly reduce padding to fit better */
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9em; /* Reduce font size to fit better */
            transition: background-color 0.3s, transform 0.2s;
            width: 48%; /* Make the buttons take up equal space */
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
    <%@ include file="includes/navbar.jsp" %>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6 text-center">
                <img src="<%= product.getImageUrl() %>" alt="<%= product.getProductName() %>" class="product-image">
            </div>
            <div class="col-md-6">
                <h1 class="text-center"><%= product.getProductName() %></h1>
                <p><%= product.getDescription() %></p>

                <%
                    // Ensure price and discount are not null
                    BigDecimal price = product.getPrice() != null ? product.getPrice() : BigDecimal.ZERO;
                    

                    // Calculate the discount amount and final price after applying the discount
                   
                %>

                
                <h3 class="text-success">Price: Rs.<%= price %></h3>

                <!-- Add to Cart and Buy Buttons -->
                <form action="AddToCartServlet" method="post">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>" />
                    <input type="hidden" name="quantity" value="1" /> <!-- Default quantity set to 1 -->
                    
                    <div class="button-group">
                        <input type="submit" value="Add to Cart" class="add-to-cart-btn" />
                        <input type="submit" value="Buy" class="buy-btn"/>
                    </div>
                </form>

                <hr>
                <h4>Customer Reviews:</h4>
                <div class="reviews">
                    <%
                        if (reviews != null && !reviews.isEmpty()) {
                            for (Review review : reviews) {
                    %>
                    <div class="review-item">
                        <div class="rating">
                            <% for (int i = 1; i <= review.getRating(); i++) { %>
                            <span class="fas fa-star rating-star"></span>
                            <% } %>
                        </div>
                        <p><%= review.getComment() %></p>
                        <small>- <%= review.getReviewerName() %></small>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <p>No reviews yet. Be the first to review this product!</p>
                    <%
                        }
                    %>
                </div>

                <h4>Leave a Review:</h4>
                <form action="SubmitReviewServlet" method="post" class="review-form">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>" />
                    <div class="form-group">
                        <label for="reviewerName">Your Name:</label>
                        <input type="text" class="form-control" name="reviewerName" id="reviewerName" required>
                    </div>
                    <div class="form-group">
                        <label for="rating">Rating:</label>
                        <select name="rating" id="rating" class="form-control">
                            <option value="5">5 - Excellent</option>
                            <option value="4">4 - Good</option>
                            <option value="3">3 - Average</option>
                            <option value="2">2 - Poor</option>
                            <option value="1">1 - Terrible</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="comment">Your Review:</label>
                        <textarea name="comment" id="comment" class="form-control" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit Review</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
