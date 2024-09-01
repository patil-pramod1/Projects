<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header text-center">
                        <h2>Forgot Password</h2>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
                        <% } %>
                        <% if (request.getAttribute("successMessage") != null) { %>
                            <div class="alert alert-success"><%= request.getAttribute("successMessage") %></div>
                        <% } %>
                        <form action="ForgotPasswordServlet" method="post">
                            <div class="form-group">
                                <label for="email">Email Address:</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number:</label>
                                <input type="text" class="form-control" id="phone" name="phone" required>
                            </div>
                            <div class="form-group">
                                <label for="newPassword">New Password:</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">Reset Password</button>
                        </form>
                        <div class="link-container mt-3 text-center">
                            <a href="login.jsp">Back to Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
