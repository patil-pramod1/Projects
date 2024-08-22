<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Home Page</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f4f4f4, #eaeaea); /* Soft gradient background */
        }

        .product-card {
            background-color: white;
            border-radius: 10px; /* Increased border radius for a softer look */
            padding: 20px; /* Increased padding */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Deeper shadow for more depth */
            text-align: center;
            transition: transform 0.3s; /* Smooth scaling effect */
        }

        .product-card:hover {
            transform: translateY(-5px); /* Lift effect on hover */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3); /* Darker shadow on hover */
        }

        .product-card img {
            width: 100%; /* Ensures image takes full width of the card */
            height: 200px; /* Fixed height for all images */
            object-fit: cover; /* Crops and scales the image to fit within the fixed dimensions */
            border-radius: 10px; /* Rounded corners for images */
            margin-bottom: 15px;
        }

        .product-card h3 {
            font-size: 1.5em; /* Increased font size for better visibility */
            margin-bottom: 10px;
            color: #333; /* Darker color for better contrast */
        }

        .price {
            color: #ff5722; /* Vibrant color for price */
            font-size: 1.3em; /* Increased font size for emphasis */
            margin-bottom: 15px;
        }

        .add-to-cart-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 20px; /* Consistent padding for both buttons */
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em; /* Consistent font size for both buttons */
            width: 200px; /* Fixed width for both buttons */
            height: 50px; /* Fixed height for both buttons */
            transition: background-color 0.3s, transform 0.2s; /* Smooth transition effects */
            display: inline-block; /* Ensures buttons are inline-block for better alignment */
            margin-bottom: 10px; /* Space between buttons */
        }

        .add-to-cart-btn:hover {
            background-color: #218838; /* Darker green on hover */
            transform: translateY(-2px); /* Slight lift effect on hover */
        }

        /* Additional styling for 'Buy' button */
        .buy-btn {
            background-color: #007bff; /* Different color for the 'Buy' button */
        }

        .buy-btn:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        @media (max-width: 768px) {
            .product-card {
                width: 100%;
                margin-bottom: 20px; /* Adjust spacing on smaller screens */
            }
        }
    </style>
</head>
<body>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.Statement" %>
    <%@ page import="java.sql.ResultSet" %>
    <%@ page import="com.shoppingcart.connection.DBconnection" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <!-- Navbar -->
    <%@ include file="includes/navbar.jsp" %>

    <!-- Main content: Product Grid -->
    <div class="container">
        <div class="row">
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBconnection.getConnection();
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM revshop.product"; // Adjust your SQL query based on your database schema
                    rs = stmt.executeQuery(sql);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger' role='alert'>Failed to connect to the database.</div>");
                }
                while (rs != null && rs.next()) {
                    String productName = rs.getString("name");
                    String productImage = rs.getString("image_url");
                    String productPrice = rs.getString("price");
            %>
            <div class="col-md-4 mb-4">
                <div class="product-card">
                    <img src="<%= productImage %>" alt="<%= productName %>">
                    <h3><%= productName %></h3>
                    <p class="price">Rs.<%= productPrice %></p>
                    <button class="add-to-cart-btn buy-btn">Buy</button>
                    <button class="add-to-cart-btn">Add to Cart</button>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="includes/footer.jsp" %><br>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        document.querySelectorAll('.add-to-cart-btn').forEach(button => {
            button.addEventListener('click', () => {
                alert('Item added to cart!');
                // Implement add-to-cart logic here
            });
        });
    </script>
</body>
</html>
