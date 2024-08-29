<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buyer Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
   <style>
    body {
        background: linear-gradient(to right, #e0c3fc, #8ec5fc);
        font-family: 'Arial', sans-serif;
    }
    .login-container {
        max-width: 400px;
        margin: 50px auto;
        padding: 30px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s;
    }
    .login-container:hover {
        transform: translateY(-5px);
    }
    .login-container h2 {
        margin-bottom: 20px;
        text-align: center;
        color: #007bff;
        font-size: 1.5rem;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    .btn-forgot {
        background: none;
        border: none;
        color: #007bff;
        cursor: pointer;
        padding: 0;
        font-size: 0.875rem;
        transition: color 0.3s;
    }
    .btn-forgot:hover {
        text-decoration: underline;
        color: #0056b3;
    }
</style>
</head>
<body>
    <div class="login-container">
        <h2>Buyer Login</h2>
        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="email">Email address</label>
                <input type="email" class="form-control" id="email" name="Login-Email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="Login-Password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Login</button>
            <div class="text-center mt-3">
                <a href="createbuyeraccount.jsp">Create an Account</a><br>
                <button type="button" class="btn-forgot" onclick="window.location.href='forgotpassword.jsp'">Forgot Password?</button>
            </div>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
