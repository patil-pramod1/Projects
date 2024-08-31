package com.shoppingcart.servlet;

import com.shoppingcart.dao.ProductDAO;
import com.shoppingcart.usermodel.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int itemsPerPage = 12;
        int currentPage = 1;
        int totalPages = 0;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int offset = (currentPage - 1) * itemsPerPage;

        try {
            int totalItems = productDAO.getTotalProductCount();
            System.out.println("Total items: " + totalItems);
            
            if (totalItems > 0) {
                totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
                List<Product> products = productDAO.getProducts(itemsPerPage, offset);
                System.out.println("Products size: " + products.size());

                request.setAttribute("products", products);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);
            } else {
                System.out.println("No products found.");
                request.setAttribute("products", null);
            }

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load products.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
