package com.shoppingcart.servlet;

import com.shoppingcart.dao.ProductDAO;
import com.shoppingcart.usermodel.CartItem;
import com.shoppingcart.usermodel.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login_buyer.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        // Retrieve additional information from session or request
        String fullName = (String) session.getAttribute("fullName");
        if (fullName == null || fullName.trim().isEmpty()) {
            fullName = request.getParameter("fullName");
        }
        if (fullName == null || fullName.trim().isEmpty()) {
            fullName = "Default Name";
        }

        String address = request.getParameter("address");
        if (address == null || address.trim().isEmpty()) {
            address = "Default Address";
        }

        String city = request.getParameter("city");
        if (city == null || city.trim().isEmpty()) {
            city = "Default City";
        }

        String state = request.getParameter("state");
        if (state == null || state.trim().isEmpty()) {
            state = "Default State";
        }

        String zipCode = request.getParameter("zipCode");
        if (zipCode == null || zipCode.trim().isEmpty()) {
            zipCode = "00000"; // Use a generic default ZIP code
        }

        String phone = request.getParameter("phone");
        if (phone == null || phone.trim().isEmpty()) {
            phone = "0000000000"; // Use a generic default phone number
        }

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "Default Payment Method"; // Default value for payment method
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product != null && quantity <= product.getStock()) {
                CartItem cartItem = new CartItem();
                cartItem.setEmail(email);
                cartItem.setProductId(productId);
                cartItem.setProductName(product.getProductName());
                cartItem.setQuantity(quantity);
                cartItem.setPrice(product.getPrice());

                // Set the additional fields with default checks
                cartItem.setFullName(fullName);
                cartItem.setAddress(address);
                cartItem.setCity(city);
                cartItem.setState(state);
                cartItem.setZipCode(zipCode);
                cartItem.setPhone(phone);
                cartItem.setPaymentMethod(paymentMethod);
                cartItem.setSellerEmail(product.getSellerEmail()); // Set the seller email

                productDAO.addToCart(email, cartItem);
                response.sendRedirect("cart.jsp");
            } else {
                request.setAttribute("errorMessage", "Product is out of stock or invalid.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid product ID or quantity format.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}