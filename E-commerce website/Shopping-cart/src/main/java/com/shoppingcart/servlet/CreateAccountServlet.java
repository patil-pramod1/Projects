package com.shoppingcart.servlet;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.dao.Userdao;
import com.shoppingcart.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/CreateAccountServlet")
public class CreateAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CreateAccountServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String phoneNumber = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zip_code");

        Connection connection = null;

        try {
            connection = DBconnection.getConnection();
            Userdao userDao = new Userdao(connection);

            // Check if the email already exists
            boolean emailExists = userDao.emailExists(email);

            if (emailExists) {
                // Redirect to account exists page
                response.sendRedirect("accountexist.jsp");
            } else {
                // Create new account
                UserModel newUser = new UserModel();
                newUser.setEmail(email);
                newUser.setPassword(password);
                newUser.setFirstName(firstName);
                newUser.setLastName(lastName);
                newUser.setPhoneNumber(phoneNumber);
                newUser.setAddress(address);
                newUser.setCity(city);
                newUser.setState(state);
                newUser.setZip_code(zipCode);

                

                boolean accountCreated = userDao.createAccount(newUser);

                if (accountCreated) {
                    response.sendRedirect("userrole.jsp"); // Change to your success page
                } else {
                    response.sendRedirect("error.jsp"); // Change to your error page
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Change to your error page
        } finally {
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
