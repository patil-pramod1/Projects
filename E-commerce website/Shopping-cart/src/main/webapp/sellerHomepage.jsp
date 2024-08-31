<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shoppingcart.usermodel.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="com.shoppingcart.connection.DBconnection"%>
<%@ page import="com.shoppingcart.dao.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - RevShop</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

    <div class="container mt-4">
        <h2>Products</h2>

        <!-- Low stock warning section -->
        <%
            String sellerEmail = (String) session.getAttribute("auth");
            if (sellerEmail == null) {
                response.sendRedirect("login_seller.jsp");
                return;
            }

            ProductDAO productDAO = new ProductDAO();
            try {
                List<Product> lowStockProducts = productDAO.getLowStockProducts(sellerEmail);
                if (!lowStockProducts.isEmpty()) {
                    out.println("<div class='alert alert-warning' role='alert'>");
                    out.println("<h4>Low Stock Warning</h4>");
                    out.println("<ul>");
                    for (Product product : lowStockProducts) {
                        out.println("<li>" + product.getProductName() + " - Only " + product.getStock() + " left in stock!</li>");
                    }
                    out.println("</ul>");
                    out.println("</div>");
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger' role='alert'>Failed to retrieve low stock products.</div>");
            }
        %>

        <div class="product-grid">
            <!-- Existing code to display products -->
            <%
                try (Connection conn = DBconnection.getConnection();
                     PreparedStatement ps = conn.prepareStatement("SELECT * FROM revshop.product WHERE sellerEmail = ?")) {
                    
                    ps.setString(1, sellerEmail);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.isBeforeFirst()) {
            %>
            <p class="empty-product-message">You have not added any products yet.</p>
            <%
                        } else {
                            while (rs.next()) {
                                String productId = rs.getString("productId");
                                String productName = rs.getString("productName");
                                String productImage = rs.getString("imageUrl");
                                String productPrice = rs.getString("price");
                                int stockQuantity = rs.getInt("stockQuantity");
            %>
            <div class="product-card" data-product-id="<%= productId %>">
                <img id="img" src="<%= productImage %>" alt="<%= productName %>">
                <h3><%= productName %></h3>
                <p class="price">Rs.<%= productPrice %></p>
                <p>Stock: <%= stockQuantity %></p>
                
                <!-- Edit and Remove buttons -->
                <form action="editproduct.jsp" method="get" style="display: inline;">
                    <input type="hidden" name="productId" value="<%= productId %>" />
                    <button type="submit" class="btn btn-warning">Edit</button>
                </form>
                <br>
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
    <%@ include file="includes/footer.jsp"%>
</body>

</html>
