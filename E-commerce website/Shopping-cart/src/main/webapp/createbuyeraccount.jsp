<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Buyer Account</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
body {
    background: #f8f9fa;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px; /* Added padding for better spacing on smaller screens */
}

.card {
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    overflow: hidden; /* Ensures children do not overflow the card */
}

.card-header {
    background-color: #6c757d;
    border-radius: 15px 15px 0 0;
    color: white;
    text-align: center;
    font-size: 1.5rem;
    font-weight: 600;
    padding: 15px; /* Added padding for better spacing */
}

.form-group label {
    font-weight: bold; /* Makes labels bold for better visibility */
}

.form-control {
    border-radius: 10px; /* Rounded corners for input fields */
    transition: border-color 0.3s ease; /* Smooth transition for border color */
}

.form-control:focus {
    border-color: #4B79A1; /* Change border color on focus */
    box-shadow: 0 0 5px rgba(75, 121, 161, 0.5); /* Subtle shadow effect */
}

.btn-primary {
    background-color: #4B79A1;
    border: none;
    border-radius: 10px; /* Rounded corners for the button */
    transition: background-color 0.3s ease;
}

.btn-primary:hover {
    background-color: #283E51;
}

/* Responsive Design */
@media (max-width: 768px) {
    .card {
        width: 100%; /* Full width for smaller screens */
        margin: 0; /* Remove margin */
    }
    .card-header {
        font-size: 1.25rem; /* Smaller font size for card header on mobile */
    }
    .btn-primary {
        font-size: 1.1rem; /* Slightly larger button on mobile */
    }
}
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">Create Buyer Account</div>
                    <div class="card-body">
                        <form action="CreateAccountServlet" method="post">
                            <div class="form-group">
                                <label for="first_name">First Name</label>
                                <input type="text" class="form-control" id="first_name" name="first_name" placeholder="Enter your first name" required>
                            </div>
                            <div class="form-group">
                                <label for="last_name">Last Name</label>
                                <input type="text" class="form-control" id="last_name" name="last_name" placeholder="Enter your last name" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter a strong password" required>
                            </div>
                            <div class="form-group">
                                <label for="phone_number">Phone Number</label>
                                <input type="tel" class="form-control" id="phone_number" name="phone_number" placeholder="Enter your phone number" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" name="address" placeholder="Enter your address" required>
                            </div>
                            <div class="form-group">
                                <label for="city">City</label>
                                <input type="text" class="form-control" id="city" name="city" placeholder="Enter your city" required>
                            </div>
                            <div class="form-group">
                                <label for="state">State</label>
                                <input type="text" class="form-control" id="state" name="state" placeholder="Enter your state" required>
                            </div>
                            <div class="form-group">
                                <label for="zip_code">ZIP Code</label>
                                <input type="text" class="form-control" id="zip_code" name="zip_code" placeholder="Enter your ZIP code" required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-block mt-4">Create Account</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
