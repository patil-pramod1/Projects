package com.shoppingcart.servlet;

import com.shoppingcart.dao.SellerDao;
import com.shoppingcart.connection.DBconnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");
        String category = request.getParameter("category");
        String stockQuantityStr = request.getParameter("stockQuantity");
        System.out.println("Product Name: " + productName);
        System.out.println("Description: " + description);
        System.out.println("Price: " + priceStr);
        System.out.println("Image URL: " + imageUrl);
        System.out.println("Category: " + category);
        System.out.println("Stock Quantity: " + stockQuantityStr);

        // Validate input
        if (productName == null || productName.trim().isEmpty() ||
            description == null || description.trim().isEmpty() ||
            priceStr == null || priceStr.trim().isEmpty() ||
            imageUrl == null || imageUrl.trim().isEmpty() ||
            category == null || category.trim().isEmpty() ||
            stockQuantityStr == null || stockQuantityStr.trim().isEmpty()) {

            response.sendRedirect("sellerHomepage.jsp?error=1");
            return;
        }

        double price;
        int stockQuantity;

        try {
            price = Double.parseDouble(priceStr.trim());
            stockQuantity = Integer.parseInt(stockQuantityStr.trim());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("sellerHomepage.jsp?error=1");
            return;
        }

        // Get vendorId from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("auth");

        if (email == null) {
            response.sendRedirect("login_seller.jsp");
            return;
        }



        // Current date and time
        String dateAdded = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String lastUpdated = dateAdded;

        // Database connection and insertion
        try (Connection connection = DBconnection.getConnection()) {
            SellerDao sellerDao = new SellerDao(connection);
            boolean isProductAdded = sellerDao.addProduct(productName, description, price, imageUrl, category, stockQuantity, dateAdded, lastUpdated, email);

            if (isProductAdded) {
                response.sendRedirect("sellerHomepage.jsp?success=1");
            } else {
                System.out.println("Failed to insert product: No rows affected.");
                response.sendRedirect("sellerHomepage.jsp?error=1");
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("sellerHomepage.jsp?error=1");
        } catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }

}
