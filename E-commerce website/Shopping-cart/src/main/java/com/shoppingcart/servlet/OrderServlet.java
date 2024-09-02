package com.shoppingcart.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.shoppingcart.service.OrderService;
import com.shoppingcart.service.impl.OrderServiceIMPL;
import com.shoppingcart.usermodel.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        if (userEmail == null || userEmail.isEmpty()) {
            response.sendRedirect("login_buyer.jsp");
            return;
        }

        OrderService orderService=new OrderServiceIMPL();
        List<Order> orders = null;

        try {
            orders = orderService.getAllOders(userEmail);

            
            // Pass the orders list to the JSP page
            request.setAttribute("orders", orders);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching orders. Please try again later.");
        }

        // Forward the request to the JSP page
        request.getRequestDispatcher("order.jsp").forward(request, response);
    }
}
