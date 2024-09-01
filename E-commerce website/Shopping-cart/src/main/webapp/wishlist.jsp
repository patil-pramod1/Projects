<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.shoppingcart.connection.DBconnection" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.stream.Collectors" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Wishlist</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
      
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
   

@media (max-width: 1200px) {
    .product-grid {
        grid-template-columns: repeat(4, 1fr); /* 4 products per row for medium screens */
    }
}

@media (max-width: 992px) {
    .product-grid {
        grid-template-columns: repeat(3, 1fr); /* 3 products per row for tablets */
    }
}

@media (max-width: 768px) {
    .product-grid {
        grid-template-columns: repeat(2, 1fr); /* 2 products per row for small screens */
    }
}

@media (max-width: 576px) {
    .product-grid {
        grid-template-columns: 1fr; /* 1 product per row for extra small screens */
    }
}


    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>

    <div class="container mt-5">
        <h1>Your Wishlist</h1>
        <div class="row">
            <%
                String email = (String) session.getAttribute("email");
                Set<String> wishlist = (Set<String>) session.getAttribute("wishlist");

                if (email == null && (wishlist == null || wishlist.isEmpty())) {
                    out.println("<p>Your wishlist is empty. Please add some products.</p>");
                    return;
                }

                try (Connection conn = DBconnection.getConnection();
                     Statement stmt = conn.createStatement()) {

                    String query;
                    if (email != null) {
                        // Query for logged-in users, getting items from the database
                        query = "SELECT p.productId, p.productName, p.imageUrl, p.price " +
                                "FROM revshop.product p " +
                                "JOIN revshop.wishlist w ON p.productId = w.productId " +
                                "WHERE w.email = '" + email + "'";
                    } else {
                        // Query for non-logged-in users, getting items from session-stored wishlist
                        if (wishlist != null && !wishlist.isEmpty()) {
                            String productIds = wishlist.stream()
                                                        .map(id -> "'" + id + "'")
                                                        .collect(Collectors.joining(","));
                            query = "SELECT productId, productName, imageUrl, price FROM revshop.product WHERE productId IN (" + productIds + ")";
                        } else {
                            query = ""; // No need to query if wishlist is empty
                        }
                    }

                    if (!query.isEmpty()) {
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            String productId = rs.getString("productId");
                            String productName = rs.getString("productName");
                            String productImage = rs.getString("imageUrl");
                            String productPrice = rs.getString("price");
                            boolean isInWishlist = wishlist != null && wishlist.contains(productId);
            %>
            <div class="col-md-4">
                <div class="card mb-4">
                    <img src="<%= productImage %>" class="card-img-top" alt="<%= productName %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= productName %></h5>
                        <p class="card-text">Rs.<%= productPrice %></p>
                        <form class="favorite-form" method="post" action="<%= isInWishlist ? "RemoveFromWishlistServlet" : "AddToWishlistServlet" %>">
                            <input type="hidden" name="productId" value="<%= productId %>" />
                            <button type="submit" class="favorite-btn <%= isInWishlist ? "active" : "" %>">
                                <i class="fas fa-heart"></i>
                            </button>
                        </form>
                        <div class="d-flex justify-content-between mt-3">
                            <form action="AddToCartServlet" method="post" style="flex-grow: 1; margin-right: 5px;">
                                <input type="hidden" name="productId" value="<%= productId %>" />
                                <button type="submit" class="btn btn-success btn-block">Buy Now</button>
                            </form>
                            <form action="RemoveFromWishlistServlet" method="post" style="flex-grow: 1; margin-left: 5px;">
                                <input type="hidden" name="productId" value="<%= productId %>" />
                                <button type="submit" class="btn btn-danger btn-block">Remove</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                        }
                    } else {
                        out.println("<p>Your wishlist is empty. Please add some products.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger' role='alert'>Failed to load wishlist items.</div>");
                }
            %>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
