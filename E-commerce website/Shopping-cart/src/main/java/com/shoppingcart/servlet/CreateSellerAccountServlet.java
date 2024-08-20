package com.shoppingcart.servlet;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.dao.SellerDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/CreateSellerAccountServlet")
public class CreateSellerAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CreateSellerAccountServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String phoneNumber = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zip_code");
        String storeName = request.getParameter("store_name");
        String storeDescription = request.getParameter("store_description");

        Connection connection = null;
        try {
            // Establish database connection
            connection = DBconnection.getConnection();

            // Create an instance of SellerDao
            SellerDao sellerDao = new SellerDao(connection);

            // Create a seller account
            boolean success = sellerDao.createSellerAccount(email, password, firstName, lastName, phoneNumber, address, city, state, zipCode, storeName, storeDescription);

            if (success) {
                // Redirect to a success page or display a success message
                response.sendRedirect("userrole.jsp"); // Change to your actual success page
            } else {
                // Redirect to an error page or display an error message
                response.sendRedirect("error.jsp"); // Change to your actual error page
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Change to your actual error page
        } finally {
            // Clean up resources
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
