<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shoppingcart.dao.OrderDAO" %>
<%@ page import="com.shoppingcart.usermodel.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders Received</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%@ include file="includes/navbarseller.jsp" %>
    <div class="container">
        <h2>Orders Received</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Order Date</th>
                    <th>Buyer Email</th>
                    <th>Buyer Name</th>
                    <th>Shipping Address</th>
                    <th>Payment Method</th>
                    <th>Order Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String sellerEmail = (String) session.getAttribute("auth"); // Retrieve the seller's email from session
                    
                    // Debugging: Print the seller email to verify
                    System.out.println("Seller email from session: " + sellerEmail);

                    if (sellerEmail != null && !sellerEmail.isEmpty()) {
                        List<Order> ordersList = null;
                        try {
                            OrderDAO orderDAO = new OrderDAO();
                            ordersList = orderDAO.getOrdersBySellerEmail(sellerEmail); // Fetch orders by seller's email
                        } catch (SQLException | ClassNotFoundException e) {
                            e.printStackTrace();
                        }

                        if (ordersList != null && !ordersList.isEmpty()) {
                            for (Order order : ordersList) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getProductId() %></td>
                    <td><%= order.getProductName() %></td>
                    <td><%= order.getQuantity() %></td>
                    <td><%= order.getPrice() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td><%= order.getEmail() %></td>
                    <td><%= order.getFullName() %></td>
                    <td><%= order.getAddress() %>, <%= order.getCity() %>, <%= order.getState() %>, <%= order.getZipCode() %></td>
                    <td><%= order.getPaymentMethod() %></td>
                    <td>
                        <form action="UpdateOrderStatusServlet" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <select name="orderStatus" class="form-control" onchange="this.form.submit()">
                                <option value="Order Received" <%= "Order Received".equals(order.getOrderStatus()) ? "selected" : "" %>>Order Received</option>
                                <option value="Processing" <%= "Processing".equals(order.getOrderStatus()) ? "selected" : "" %>>Processing</option>
                                <option value="Shipped" <%= "Shipped".equals(order.getOrderStatus()) ? "selected" : "" %>>Shipped</option>
                                <option value="Delivered" <%= "Delivered".equals(order.getOrderStatus()) ? "selected" : "" %>>Delivered</option>
                                <option value="Cancelled" <%= "Cancelled".equals(order.getOrderStatus()) ? "selected" : "" %>>Cancelled</option>
                                <option value="Returned" <%= "Returned".equals(order.getOrderStatus()) ? "selected" : "" %>>Returned</option>
                            </select>
                        </form>
                    </td>
                </tr>
                <%
                            }
                        } else {
                %>
                <tr>
                    <td colspan="11" class="text-center">No orders received.</td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="11" class="text-center">Seller email not found in session. Please <a href="login_seller.jsp">login</a>.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
<%@ include file="includes/footer.jsp" %>
</html>
