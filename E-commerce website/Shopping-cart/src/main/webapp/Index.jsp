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
            box-sizing: border-box;
            min-height: 350px;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }
        .product-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .product-card h3 {
            font-size: 1.2em;
            margin-bottom: 10px;
            color: #333;
        }
        .product-card p {
            flex-grow: 1;
            margin-bottom: 10px;
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
                grid-template-columns: repeat(4, 1fr);
            }
        }
        @media (max-width: 992px) {
            .product-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 576px) {
            .product-grid {
                grid-template-columns: 1fr;
            }
        }
        .pagination-container {
            text-align: center;
            margin: 20px 0;
        }
        .product-container {
            margin-top: 0.5cm; /* Set a 0.5cm gap between navbar and product grid */
        }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>

    <div class="container product-container"> <!-- Added class for margin-top -->
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

                try (Connection conn = DBconnection.getConnection();
                     Statement stmt = conn.createStatement()) {

                    ResultSet countRs = stmt.executeQuery("SELECT COUNT(*) AS total FROM revshop.product");
                    if (countRs.next()) {
                        int totalItems = countRs.getInt("total");
                        totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
                    }

                    String query = "SELECT * FROM revshop.product LIMIT " + itemsPerPage + " OFFSET " + offset;
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String productId = rs.getString("productId");
                        String productName = rs.getString("productName");
                        String productImage = rs.getString("imageUrl");
                        String productPrice = rs.getString("price");
                        int stock = rs.getInt("stockQuantity");
            %>
            <div class="product-card">
                <a href="ProductDetailsServlet?productId=<%= productId %>">
                    <img src="<%= productImage %>" alt="<%= productName %>" />
                </a>
                <h3><%= productName %></h3>
                <form action="AddToCartServlet" method="post">
                    <input type="hidden" name="productId" value="<%= productId %>" />
                    <div class="price-quantity-row">
                        <p class="price">Rs.<%= productPrice %></p>
                        <div class="quantity-control">
                            <input type="number" name="quantity" value="1" min="1" max="<%= stock %>" required class="quantity-input" />
                        </div>
                    </div>
                    <div class="button-group">
                        <input type="submit" value="Add to Cart" class="add-to-cart-btn" />
                        <input type="submit" value="Buy" class="buy-btn"/>
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