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
<style>
body {
    background: linear-gradient(to right, #e0c3fc, #8ec5fc); /* Soft gradient background */
    font-family: 'Arial', sans-serif; /* Modern font for better readability */
    color: #333; /* Darker text for better contrast */
}

.navbar {
    background-color: #232F3E; /* Amazon's dark blue color */
    padding: 10px;
}

.navbar-brand, .navbar-nav .nav-link {
    color: #ffffff;
    font-weight: bold;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 3 columns per row */
    gap: 20px;
    margin: 20px auto;
    padding: 0 15px;
    max-width: 1200px;
}

.product-card {
    position: relative; /* Ensure positioning context for favorite icon */
    background-color: white;
    border: 1px solid #ddd; /* Light gray border */
    border-radius: 4px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    text-align: center;
    padding: 15px;
    transition: box-shadow 0.3s;
}

.product-card:hover {
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
    /* Slightly stronger shadow on hover */
}

.product-card img {
    width: 100%;
    height: 250px; /* Increase the image height */
    object-fit: contain;
    /* Contain the image within the specified height */
    margin-bottom: 15px;
}

.product-card h3 {
    font-size: 1.1em;
    color: #007185; /* Amazon's link color */
    margin-bottom: 10px;
}

.price-quantity-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.price {
    color: #B12704; /* Amazon's price color */
    font-size: 1.2em;
    font-weight: bold;
}

.quantity-input {
    width: 60px;
    border-radius: 4px;
    border: 1px solid #ddd;
    padding: 5px;
    text-align: center;
}
.button-group {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
    align-items: stretch; /* Ensure buttons have equal height */
}

.add-to-cart-btn, .buy-btn {
    background-color: #28a745;
    color: white;
    border: none;
    padding: 10px 12px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 0.9em;
    transition: background-color 0.3s, transform 0.2s;
    width: 48%;
    display: flex;
    align-items: center;
    justify-content: center;
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

.favorite-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    color: #ffffff; /* White color for the heart icon */
    font-size: 1.5em;
    cursor: pointer;
    background: none;
    border: none;
    outline: none;
    padding: 0;
    transition: color 0.3s ease;
}

.favorite-btn i {
    -webkit-text-stroke: 1px #000000; /* Thin black outline around the heart icon */
}

.favorite-btn.active {
    color: #ff0000; /* Red color when active */
    -webkit-text-stroke: 0px; /* Remove outline when active */
}

.pagination-container {
    margin-top: 20px;
}

.pagination .page-link {
    color: #007185;
}

.pagination .page-item.active .page-link {
    background-color: #007bff;
    
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
                            try (Statement wishlistStmt = conn.createStatement()) {
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
                        <p class="stock">Stock: <%= stock %></p>
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
