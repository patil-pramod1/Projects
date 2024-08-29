package com.shoppingcart.servlet;

import com.shoppingcart.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/SubmitReviewServlet")
public class SubmitReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String reviewerName = request.getParameter("reviewerName");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        ProductDAO productDao = new ProductDAO();
        try {
			productDao.addReview(productId, reviewerName, rating, comment);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        response.sendRedirect("ProductDetailsServlet?productId=" + productId);
    }
}
