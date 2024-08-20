package com.shoppingcart.servlet;


import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RoleSelectionServlet")
public class RoleSelectionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String LOGIN_JSP_BUYER = "login_buyer.jsp";
    private static final String LOGIN_JSP_SELLER = "login_seller.jsp";
    private static final String USER_ROLE_PARAM = "role";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String role = request.getParameter(USER_ROLE_PARAM);

        if (role != null) {
            if (role.equals("buyer")) {
                response.sendRedirect(LOGIN_JSP_BUYER);
            } else if (role.equals("seller")) {
                response.sendRedirect(LOGIN_JSP_SELLER);
            } else {
                response.sendRedirect("userrole.jsp"); // Redirect back if role is invalid
            }
        } else {
            response.sendRedirect("userrole.jsp"); // Redirect back if no role is selected
        }
    }
}
