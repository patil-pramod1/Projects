<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.shoppingcart.connection.DBconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%@ include file="includes/navbarseller.jsp" %>

<div class="container">
    <h2>Edit Product</h2>
    <%
        String productId = request.getParameter("productId");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBconnection.getConnection();
            ps = conn.prepareStatement("SELECT * FROM revshop.product WHERE productId = ?");
            ps.setString(1, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
    %>
                <form action="EditProductServlet" method="post">
                    <input type="hidden" name="productId" value="<%= productId %>">

                    <div class="form-group">
                        <label for="productName">Product Name</label>
                        <input type="text" class="form-control" id="productName" name="productName" value="<%= rs.getString("productName") %>" required>
                    </div>

                    <div class="form-group">
                        <label for="productDescription">Product Description</label>
                        <textarea class="form-control" id="productDescription" name="productDescription" required><%= rs.getString("description") %></textarea>
                    </div>

                    <div class="form-group">
                        <label for="productPrice">Price</label>
                        <input type="text" class="form-control" id="productPrice" name="productPrice" value="<%= rs.getString("price") %>" min="1" required>
                    </div>

                    <div class="form-group">
                        <label for="stockQuantity">Stock Quantity</label>
                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" value="<%= rs.getInt("stockQuantity") %>" min="1" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>
    <%
            } else {
                out.println("<div class='alert alert-danger' role='alert'>Product not found.</div>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger' role='alert'>Error retrieving product details.</div>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
</div>
</body>
</html>
