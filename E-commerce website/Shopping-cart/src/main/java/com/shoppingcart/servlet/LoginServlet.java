package com.shoppingcart.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.dao.Userdao;
import com.shoppingcart.usermodel.UserModel;

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
            throws IOException {
        response.setContentType("text/html; charset=UTF-8");

        String email = request.getParameter(LOGIN_EMAIL_PARAM);
        String password = request.getParameter(LOGIN_PASSWORD_PARAM);

        try (PrintWriter out = response.getWriter()) {
            Userdao userdao = new Userdao(DBconnection.getConnection());
            UserModel user = userdao.userlogin(email, password);

            if (user != null) {
                // Set both the user object and the email in the session
                request.getSession().setAttribute("auth", user);
                request.getSession().setAttribute("email", user.getEmail());

                // Print session details to console
                HttpSession session = request.getSession();
                System.out.println("Session ID: " + session.getId());
                System.out.println("User Email in session: " + session.getAttribute("email"));
                System.out.println("User Auth Object in session: " + session.getAttribute("auth"));

                response.sendRedirect(INDEX_JSP); // Redirect to Index.jsp on successful login
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("Login failed. Please check your email and password.");
                response.sendRedirect("loginfail.jsp"); // Redirect to a login failure page
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("An error occurred. Please try again later.");
        }
    }

}
