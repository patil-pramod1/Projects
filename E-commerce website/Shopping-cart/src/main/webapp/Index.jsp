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
    background-color: linear-gradient(to right, #e0c3fc, #8ec5fc); /* Light gray background for a clean look */
    font-family: 'Arial', sans-serif; /* Modern font */
    color: #333; /* Darker text color for better contrast */
}
       .product-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 5 columns of equal width */
    gap: 20px;
    margin: 0 auto; /* Center the grid */
    padding: 0 15px; /* Add padding to prevent overflow */
    max-width: 100%; /* Ensure the grid doesn't exceed the viewport */
    box-sizing: border-box; /* Include padding and border in the element's total width and height */
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
    box-sizing: border-box; /* Ensure padding is included in the width and height */
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
    font-size: 1.2em; /* Slightly reduce font size to fit better */
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
    font-size: 1.1em; /* Slightly reduce font size to fit better */
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
    padding: 10px 12px; /* Slightly reduce padding to fit better */
    border-radius: 5px;
    cursor: pointer;
    font-size: 0.8em; /* Reduce font size to fit better */
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
    <a href="ProductDetailsServlet?productId=<%= productId %>">
    <img src="<%= productImage %>" alt="<%= productName %>" style="width: 195px; height: 200px;">
</a>

    
    <h3><%= productName %></h3>
    <p><%= productDescription %></p>
    <div class="price-quantity-row">
        <p class="price">Rs.<%= productPrice %></p>
        <input type="number" name="quantity" value="1" min="1" max="<%= stock %>" required class="quantity-input" />
    </div>
    <form action="AddToCartServlet" method="post">
        <input type="hidden" name="productId" value="<%= productId %>" />
        <div class="button-group">
            <input type="submit" value="Add to Cart" class="add-to-cart-btn" />
            <input type="submit" value="Buy" class="add-to-cart-btn buy-btn"/>
        </div>
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
    

    <!-- Customer Care Section -->
 	 <%@ include file="includes/footer.jsp" %>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
