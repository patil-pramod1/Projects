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

@WebServlet("/RemoveProductServlet")
public class RemoveProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM revshop.product WHERE productId = ?")) {

            ps.setString(1, productId);
            ps.executeUpdate();
            response.sendRedirect("sellerHomepage.jsp"); // Redirect to seller's home page
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().print("<div class='alert alert-danger' role='alert'>Error removing product.</div>");
        } catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }
}
