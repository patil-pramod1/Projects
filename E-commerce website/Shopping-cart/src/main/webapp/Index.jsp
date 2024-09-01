<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.*" %>
<%@ page import="com.shoppingcart.connection.DBconnection" %>
<%@ page import="com.shoppingcart.usermodel.*" %>
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

    <div class="container product-container">
        <div class="product-grid">
            <%
                int itemsPerPage = 12;
                int currentPage = 1;

                String pageParam = request.getParameter("page");
                if (pageParam != null) {
                    try {
                        currentPage = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        currentPage = 1;
                    }
                }

                int offset = (currentPage - 1) * itemsPerPage;
                int totalPages = 0;

                UserModel user = (UserModel) session.getAttribute("auth");
                String email = (user != null) ? user.getEmail() : null;

                try (Connection conn = DBconnection.getConnection();
                     Statement stmt = conn.createStatement()) {

                    ResultSet countRs = stmt.executeQuery("SELECT COUNT(*) AS total FROM revshop.product");
                    if (countRs.next()) {
                        int totalItems = countRs.getInt("total");
                        totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
                    }
                    countRs.close(); // Close the first ResultSet

                    String query = "SELECT * FROM revshop.product LIMIT " + itemsPerPage + " OFFSET " + offset;
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String productId = rs.getString("productId");
                        String productName = rs.getString("productName");
                        String productImage = rs.getString("imageUrl");
                        String productPrice = rs.getString("price");
                        int stock = rs.getInt("stockQuantity");

                        // Check if the product is in the user's wishlist
                        boolean isFavorite = false;
                        if (email != null) {
                            try (Statement wishlistStmt = conn.createStatement()) { // Use a new Statement for the wishlist query
                                String wishlistQuery = "SELECT * FROM revshop.wishlist WHERE email = '" + email + "' AND productId = '" + productId + "'";
                                try (ResultSet wishlistRs = wishlistStmt.executeQuery(wishlistQuery)) {
                                    if (wishlistRs.next()) {
                                        isFavorite = true;
                                    }
                                }
                            }
                        }
            %>
            <div class="product-card">
                <%
                    if (email != null) {
                %>
                <form action="<%= isFavorite ? "RemoveFromWishlistServlet" : "AddToWishlistServlet" %>" method="post" class="favorite-form">
                    <input type="hidden" name="productId" value="<%= productId %>" />
                    <button type="submit" class="favorite-btn <%= isFavorite ? "active" : "" %>"><i class="fas fa-heart"></i></button>
                </form>
                <%
                    } else {
                %>
                <button class="favorite-btn" onclick="location.href='login_buyer.jsp'"><i class="fas fa-heart"></i></button>
                <%
                    }
                %>
                <a href="ProductDetailsServlet?productId=<%= productId %>">
                    <img src="<%= productImage %>" alt="<%= productName %>" />
                </a>
                <h3><%= productName %></h3>
                <form action="<%= email != null ? "AddToCartServlet" : "login_buyer.jsp" %>" method="post">
                    <input type="hidden" name="productId" value="<%= productId %>" />
                    <div class="price-quantity-row">
                        <p class="price">Rs.<%= productPrice %></p>
    					
                        <div class="quantity-control">
                            <input type="number" name="quantity" value="1" min="1" max="<%= stock %>" required class="quantity-input" />
                        </div>
                        <p class="price">Stock.<%= stock %></p>
                    </div>
                    <div class="button-group">
                        <input type="submit" value="Add to Cart" class="add-to-cart-btn" />
                        <input type="submit" value="Buy" class="buy-btn"/>
                    </div>
                </form>
            </div>
            <%
                    }
                    rs.close(); // Close the second ResultSet
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger' role='alert'>Failed to connect to the database.</div>");
                }
            %>
        </div>

        <!-- Pagination Controls -->
        <div class="pagination-container">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <%
                        if (currentPage > 1) {
                            int previousPage = currentPage - 1;
                    %>
                        <li class="page-item">
                            <a class="page-link" href="Index.jsp?page=<%= previousPage %>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    <%
                        }
                        for (int i = 1; i <= totalPages; i++) {
                            boolean isActive = (i == currentPage);
                    %>
                        <li class="page-item <%= isActive ? "active" : "" %>">
                            <a class="page-link" href="Index.jsp?page=<%= i %>"><%= i %></a>
                        </li>
                    <%
                        }
                        if (currentPage < totalPages) {
                            int nextPage = currentPage + 1;
                    %>
                        <li class="page-item">
                            <a class="page-link" href="Index.jsp?page=<%= nextPage %>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    <%
                        }
                    %>
                </ul>
            </nav>
        </div>
    </div>

    <%@ include file="includes/footer.jsp" %>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
