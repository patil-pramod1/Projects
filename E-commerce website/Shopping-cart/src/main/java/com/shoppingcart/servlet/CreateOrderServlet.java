package com.shoppingcart.servlet;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import org.json.JSONObject;

@WebServlet("/CreateOrderServlet")
public class CreateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("CreateOrderServlet: Started processing request.");

        try {
            // Initialize Razorpay client
            System.out.println("CreateOrderServlet: Initializing Razorpay client.");
            RazorpayClient razorpayClient = new RazorpayClient("rzp_test_dChgnE1vVIlVnK", "8bcAvJizBjTNYEUDhCTFW4xD");

            // Create an order on Razorpay
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", 50000); // amount in the smallest currency unit (e.g., paise for INR)
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "order_rcptid_11");
            orderRequest.put("payment_capture", 1); // auto capture

            System.out.println("CreateOrderServlet: Creating order with Razorpay.");
            Order order = razorpayClient.orders.create(orderRequest);

            // Log the generated order ID
            System.out.println("CreateOrderServlet: Generated Razorpay Order ID: " + order.get("id"));

            // Set the order ID in the request attribute to pass it to the JSP
            request.setAttribute("razorpayOrderId", order.get("id"));
            System.out.println("CreateOrderServlet: Set Razorpay Order ID in request attribute.");

            // Forward to the JSP page (orderConfirmation.jsp)
            RequestDispatcher dispatcher = request.getRequestDispatcher("orderConfirmation.jsp");
            dispatcher.forward(request, response);
            System.out.println("CreateOrderServlet: Forwarded to orderConfirmation.jsp.");

        } catch (RazorpayException e) {
            System.err.println("CreateOrderServlet: RazorpayException occurred.");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create Razorpay order");
        } catch (Exception e) {
            System.err.println("CreateOrderServlet: Exception occurred.");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
        }
    }
}
