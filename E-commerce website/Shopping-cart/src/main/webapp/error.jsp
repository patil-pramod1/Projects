<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Something Went Wrong</title>
   <style>
    body {
        font-family: 'Arial', sans-serif;
        background: linear-gradient(135deg, #f2f2f2, #e0e0e0);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        color: #333;
    }
    .container {
        background-color: #ffffff;
        padding: 50px 40px; /* Increased padding for better spacing */
        border-radius: 15px; /* More rounded corners */
        box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3); /* Deeper shadow for depth */
        text-align: center;
        max-width: 500px;
        width: 100%;
        transition: transform 0.3s; /* Smooth scaling effect */
    }
    .container:hover {
        transform: scale(1.02); /* Slight zoom effect on hover */
    }
    h1 {
        color: #e74c3c;
        font-size: 2.5em; /* Increased font size */
        margin-bottom: 15px;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1); /* Soft shadow for text */
    }
    p {
        color: #555;
        font-size: 1.2em; /* Increased font size */
        margin-bottom: 30px;
        line-height: 1.6; /* Improved line height for readability */
    }
    .button {
        display: inline-block;
        padding: 14px 30px; /* Increased padding for a more substantial button */
        font-size: 16px;
        color: #ffffff;
        background-color: #3498db;
        border: none;
        border-radius: 6px; /* Slightly larger border radius */
        text-decoration: none;
        transition: background-color 0.3s ease, transform 0.2s ease; /* Added transform transition */
        cursor: pointer; /* Pointer cursor for better UX */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Soft shadow for button */
    }
    .button:hover {
        background-color: #2980b9;
        transform: translateY(-3px); /* Slight lift effect on hover */
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.25); /* Darker shadow on hover */
    }
    .icon {
        font-size: 4em;
        color: #e74c3c;
        margin-bottom: 20px;
        transition: transform 0.3s; /* Smooth scaling effect */
    }
    .icon:hover {
        transform: scale(1.1); /* Slight zoom effect on hover */
    }
</style>
</head>
<body>
    <div class="container">
        <div class="icon">🚫</div>
        <h1>Oops! Something Went Wrong</h1>
        <p>We encountered an unexpected issue. Please try again later or contact support if the problem persists.</p>
        <a href="userrole.jsp" class="button">Return to Login</a>
    </div>
</body>
</html>
