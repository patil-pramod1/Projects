<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SignIn</title>
    <style>
    body {
        font-family: 'Helvetica Neue', Arial, sans-serif;
        background: linear-gradient(135deg, #f7f7f7 0%, #e1e1e1 100%);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        text-align: center;
        max-width: 450px;
        width: 100%;
        transition: transform 0.3s;
    }
    .container:hover {
        transform: translateY(-5px);
    }
    h1 {
        color: #2c3e50;
        margin-bottom: 30px;
        font-size: 24px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
    }
    .button {
        display: block;
        width: 100%;
        padding: 12px;
        font-size: 18px;
        color: #ffffff;
        background: linear-gradient(45deg, #3498db, #2980b9);
        border: none;
        border-radius: 6px;
        margin: 15px 0;
        cursor: pointer;
        transition: background 0.3s, transform 0.2s;
        font-weight: bold;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    .button:hover {
        background: linear-gradient(45deg, #2980b9, #3498db);
        transform: scale(1.05);
    }
</style>
</head>
<body>
    <div class="container">
        <h1>Create Account</h1>
        <form action="SignInServlet" method="post">
            <button type="submit" name="role" value="buyer" class="button">Buyer</button>
            <button type="submit" name="role" value="seller" class="button">Seller</button>
        </form>
    </div>
</body>
</html>
