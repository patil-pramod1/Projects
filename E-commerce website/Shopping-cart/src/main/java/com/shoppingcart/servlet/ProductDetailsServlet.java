package com.shoppingcart.servlet;

import com.shoppingcart.dao.*;
import com.shoppingcart.usermodel.Product;
import com.shoppingcart.usermodel.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ProductDetailsServlet")
public class ProductDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");

        if (productId != null && !productId.isEmpty()) {
            ProductDAO productDao = new ProductDAO();
            Product product = null;
			try {
				product = productDao.getProductById(Integer.parseInt(productId));
			} catch (NumberFormatException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            if (product != null) {
            	// Instantiate the ReviewDao
            	ReviewDao reviewDao = new ReviewDao();

            	// Use the instantiated ReviewDao object to get the reviews
            	List<Review> reviews = null;
				try {
					reviews = reviewDao.getReviewsByProductId(Integer.parseInt(productId));
				} catch (NumberFormatException | ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

                request.setAttribute("product", product);
                request.setAttribute("reviews", reviews);
                request.getRequestDispatcher("productDetails.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp"); // Redirect to error page if product is not found
            }
        } else {
            response.sendRedirect("error.jsp"); // Redirect to error page if productId is missing
        }
    }
}
