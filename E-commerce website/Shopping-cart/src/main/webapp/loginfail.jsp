<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Failed</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background: linear-gradient(135deg, #e0eafc, #cfdef3);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .container {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        text-align: center;
        max-width: 400px;
        width: 100%;
        transition: transform 0.3s;
    }
    .container:hover {
        transform: translateY(-5px);
    }
    h1 {
        color: #e74c3c;
        font-size: 2rem;
        margin-bottom: 15px;
        text-transform: uppercase;
    }
    p {
        color: #555;
        margin-bottom: 20px;
        font-size: 1rem;
    }
    .button {
        display: inline-block;
        margin-top: 20px;
        padding: 12px 25px;
        font-size: 18px;
        color: #ffffff;
        background-color: #3498db;
        border: none;
        border-radius: 6px;
        text-decoration: none;
        transition: background-color 0.3s, transform 0.2s;
    }
    .button:hover {
        background-color: #2980b9;
        transform: scale(1.05);
    }
</style></head>
<body>
    <div class="container">
        <h1>Login Failed</h1>
        <p>Please check your email and password.</p>
        <a href="userrole.jsp" class="button">Try Again</a>
    </div>
</body>
</html>
