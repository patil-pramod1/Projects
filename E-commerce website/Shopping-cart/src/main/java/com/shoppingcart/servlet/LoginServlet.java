package com.shoppingcart.servlet;

import java.io.IOException;
import java.sql.SQLException;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.dao.Userdao;
import com.shoppingcart.usermodel.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String LOGIN_JSP_BUYER = "login_buyer.jsp";
    private static final String LOGIN_JSP_SELLER = "login_seller.jsp";
    private static final String INDEX_JSP = "Index.jsp";
    private static final String LOGIN_EMAIL_PARAM = "Login-Email";
    private static final String LOGIN_PASSWORD_PARAM = "Login-Password";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");

        String email = request.getParameter(LOGIN_EMAIL_PARAM);
        String password = request.getParameter(LOGIN_PASSWORD_PARAM);

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.sendRedirect("loginfail.jsp");
            return;
        }

        try {
            // Initialize UserDao with a database connection
            Userdao userDao = new Userdao(DBconnection.getConnection());

            // Attempt to authenticate the user
            UserModel user = userDao.userLogin(email, password);

            if (user != null) {
                // Set both the user object and the email in the session
                HttpSession session = request.getSession();
                session.setAttribute("auth", user);
                session.setAttribute("email", user.getEmail());

                // Optionally log session details to the console
                System.out.println("Session ID: " + session.getId());
                System.out.println("User Email in session: " + session.getAttribute("email"));
                System.out.println("User Auth Object in session: " + session.getAttribute("auth"));

                // Redirect to Index.jsp on successful login
                response.sendRedirect(INDEX_JSP);
            } else {
                // If authentication fails, set the response status and redirect to the failure page
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.sendRedirect("loginfail.jsp");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.sendRedirect("error.jsp");
        }
    }
}
