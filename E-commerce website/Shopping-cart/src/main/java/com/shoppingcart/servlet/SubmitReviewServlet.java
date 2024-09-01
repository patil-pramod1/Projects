package com.shoppingcart.servlet;

import com.shoppingcart.dao.ProductDAO;
import com.shoppingcart.usermodel.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/SubmitReviewServlet")
public class SubmitReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String reviewerName = request.getParameter("reviewerName");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email"); // Get email from session

        ProductDAO productDao = new ProductDAO();
        Product product=null;
		try {
			product = productDao.getProductById(productId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // Assuming you have this method to get the product details
 catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (product != null) {
            String sellerEmail = product.getSellerEmail(); // Get sellerEmail from the product

            try {
                productDao.addReview(productId, reviewerName, rating, comment, email, sellerEmail);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }

            response.sendRedirect("ProductDetailsServlet?productId=" + productId);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
        }
    }
}
