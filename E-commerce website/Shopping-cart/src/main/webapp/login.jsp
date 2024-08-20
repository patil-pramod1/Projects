<%@ page import="com.shoppingcart.UserModel" %>
<%@ page import="com.shoppingcart.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Login Page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f7f9fc; /* Light background for a clean look */
        }
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Center the login form vertically */
        }
        .login-card {
            width: 100%;
            max-width: 400px; /* Restrict the width for better design */
            border-radius: 15px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
            background-color: #ffffff; /* White background for the card */
        }
        .card-header {
            background-color: #007bff; /* Blue header background */
            color: #fff; /* White text in the header */
            font-size: 1.5rem; /* Larger font for the title */
            padding: 15px; /* Padding inside the header */
            border-top-left-radius: 15px; /* Rounded corners */
            border-top-right-radius: 15px;
        }
        .form-control {
            border-radius: 10px; /* Rounded input fields */
            height: 45px; /* Taller input fields */
            font-size: 1rem; /* Larger text */
        }
        .btn-primary {
            background-color: #007bff; /* Primary blue color */
            border-color: #007bff;
            border-radius: 10px; /* Rounded button */
            height: 45px; /* Taller button */
            font-size: 1rem; /* Larger text */
            transition: background-color 0.3s ease; /* Smooth hover transition */
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Darker blue on hover */
            border-color: #0056b3;
        }
        .text-center {
            margin-top: 20px; /* Space above the button */
        }
        .forgot-password {
            color: #007bff; /* Blue text for the link */
            text-decoration: none; /* Remove underline */
            font-size: 0.9rem; /* Slightly smaller font */
        }
        .forgot-password:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>

<%@ include file="includes/navbar.jsp" %>

<div class="login-container">
    <div class="card login-card">
        <div class="card-header text-center">
            User Login
        </div>
        <div class="card-body">
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" class="form-control" id="email" name="Login-Email" placeholder="Enter Your Email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="Login-Password" placeholder="********" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary btn-block">Login</button>
                </div>
                <div class="text-center mt-3">
                    <a href="#" class="forgot-password">Forgot Password?</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>

</body>
</html>
