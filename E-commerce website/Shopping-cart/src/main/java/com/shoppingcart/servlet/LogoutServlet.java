package com.shoppingcart.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            if (request.getSession().getAttribute("auth") != null) {
                request.getSession().invalidate();  // Invalidates the session, removing all attributes
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("Index.jsp");
            }
        } catch (Exception e) {
        	System.out.println("cannot stating logout");
            e.printStackTrace(); // Log the exception
            // Redirect to an error page if needed
        }
        
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response); // Handle GET requests by redirecting to doPost
    }
}
