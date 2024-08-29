package com.shoppingcart.servlet;

import com.shoppingcart.connection.DBconnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        String productPrice = request.getParameter("productPrice");
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE revshop.product SET productName = ?, description = ?, price = ?, stockQuantity = ? WHERE productId = ?")) {

            ps.setString(1, productName);
            ps.setString(2, productDescription);
            ps.setString(3, productPrice);
            ps.setInt(4, stockQuantity);
            ps.setString(5, productId);

            ps.executeUpdate();
            response.sendRedirect("sellerHomepage.jsp"); // Redirect to seller's home page
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().print("<div class='alert alert-danger' role='alert'>Error updating product.</div>");
        } catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }
}
