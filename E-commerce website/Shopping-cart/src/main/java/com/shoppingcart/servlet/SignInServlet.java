package com.shoppingcart.servlet;


import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
	
	
@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String BUYER = "createbuyeraccount.jsp";
    private static final String SELLER = "createselleraccount.jsp";
    private static final String ROLE_PARAM = "role";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String role = request.getParameter(ROLE_PARAM);

        if (role != null) {
            if (role.equals("buyer")) {
                response.sendRedirect(BUYER);
            } else if (role.equals("seller")) {
                response.sendRedirect(SELLER);
            } else {
                response.sendRedirect("signin.jsp"); // Redirect back if role is invalid
            }
        } else {
            response.sendRedirect("signin.jsp"); // Redirect back if no role is selected
        }
    }
}
