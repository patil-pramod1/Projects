<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.shoppingcart.dao.ProductDAO" %>
<%@ page import="com.shoppingcart.usermodel.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <style>
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Products</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <!-- Navbar inclusion -->
    <%@ include file="includes/navbar.jsp" %>

    <div class="container">
        <h2>Products in <%= request.getParameter("category") %> Category</h2>
        <div class="product-grid">
            <%
                String category = request.getParameter("category");
                List<Product> productList = null;

                try {
                    ProductDAO productDAO = new ProductDAO();
                    productList = productDAO.getProductsByCategory(category);
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }

                if (productList != null && !productList.isEmpty()) {
                    for (Product product : productList) {
            %>
            <div class="product-card">
                <a href="ProductDetailsServlet?productId=<%= product.getProductId() %>">
                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getProductName() %>" style="width: 195px; height: 200px;">
                </a>
                <h3><%= product.getProductName() %></h3>
                <p><%= product.getDescription() %></p>
                <div class="price-quantity-row">
                    <p class="price">Rs.<%= product.getPrice() %></p>
                </div>
                <form action="AddToCartServlet" method="post">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>" />
                    <div class="button-group">
                        <input type="submit" value="Add to Cart" class="add-to-cart-btn" />
                        <input type="submit" value="Buy" class="buy-btn"/>
                    </div>
                </form>
            </div>
            <%
                    }
                } else {
            %>
            <p>No products found in this category.</p>
            <%
                }
            %>
        </div>
    </div>

    <!-- Footer inclusion -->
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
