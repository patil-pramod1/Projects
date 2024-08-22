<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="refresh" content="5000;URL='Index.jsp'" />
    <title>Logging Out...</title>
</head>
<body>
    <p>Logging out...</p>
    <%
        // Invalidate the session
        session.invalidate();
        // Redirect to Index.jsp
        response.sendRedirect("Index.jsp");
    %>
</body>
</html>
