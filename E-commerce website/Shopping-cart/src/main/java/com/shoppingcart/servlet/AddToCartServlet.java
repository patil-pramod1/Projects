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
        
        HttpSession session = request.getSession(false);  // Get the current session without creating a new one
        if (session == null || session.getAttribute("email") == null) {
            // Redirect to login page if session or email attribute is missing
            response.sendRedirect("login_buyer.jsp");
            return;
        }

        // Correctly retrieve the email from the session
        String email = (String) session.getAttribute("email");

        // Rest of your method logic...
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);

            if (product != null && quantity <= product.getStock()) {
                CartItem cartItem = new CartItem();
                cartItem.setProductId(product.getProductId());
                cartItem.setProductName(product.getProductName());
                cartItem.setQuantity(quantity);
                cartItem.setPrice(product.getPrice());

                productDAO.addToCart(email, cartItem);  // This is where the email variable is used
                response.sendRedirect("cart.jsp");
            } else {
                request.setAttribute("errorMessage", "Product is out of stock or invalid.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid product ID or quantity.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
