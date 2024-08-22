<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Seller Account - RevShop</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
body {
    background-color: #f8f9fa; /* Light gray background for a clean look */
    font-family: 'Arial', sans-serif; /* Modern font */
    color: #333; /* Darker text color for better contrast */
}

.container {
    margin-top: 30px; /* Space above the container */
}

.form-container {
    background: #ffffff; /* White background for the form */
    padding: 40px; /* Increased padding for better spacing */
    border-radius: 12px; /* Slightly more rounded corners */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Softer shadow for depth */
    transition: transform 0.3s; /* Smooth scaling effect on hover */
}

.form-container:hover {
    transform: translateY(-2px); /* Slightly lift the form on hover */
}

.btn-custom {
    background-color: #007bff; /* Primary button color */
    color: #ffffff; /* White text for contrast */
    border: none; /* Remove default border */
    border-radius: 8px; /* Rounded corners for buttons */
    padding: 10px 20px; /* Padding for better click area */
    font-size: 16px; /* Larger font size for readability */
    transition: background-color 0.3s, transform 0.3s; /* Smooth transition for hover effects */
}

.btn-custom:hover {
    background-color: #0056b3; /* Darker blue on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}

.form-group label {
    font-weight: bold; /* Make labels bold for better visibility */
    margin-bottom: 5px; /* Space between label and input */
}

.form-control {
    border-radius: 8px; /* Rounded corners for input fields */
    border: 1px solid #ced4da; /* Default border color */
    transition: border-color 0.3s; /* Smooth transition for border color */
}

.form-control:focus {
    border-color: #007bff; /* Change border color on focus */
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Subtle shadow effect */
}

/* Responsive Design */
@media (max-width: 768px) {
    .form-container {
        padding: 20px; /* Less padding on smaller screens */
    }
    .btn-custom {
        font-size: 14px; /* Slightly smaller button text */
        padding: 8px 16px; /* Adjust padding for smaller buttons */
    }
}
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 form-container">
                <h2 class="text-center mb-4">Create Seller Account</h2>
                <form action="CreateSellerAccountServlet" method="post">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                    </div>
                    <div class="form-group">
                        <label for="first_name">First Name</label>
                        <input type="text" class="form-control" id="first_name" name="first_name" placeholder="Enter your first name" required>
                    </div>
                    <div class="form-group">
                        <label for="last_name">Last Name</label>
                        <input type="text" class="form-control" id="last_name" name="last_name" placeholder="Enter your last name" required>
                    </div>
                    <div class="form-group">
                        <label for="phone_number">Phone Number</label>
                        <input type="text" class="form-control" id="phone_number" name="phone_number" placeholder="Enter your phone number" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <textarea class="form-control" id="address" name="address" rows="3" placeholder="Enter your address" required></textarea>
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
                    <div class="form-group">
                        <label for="store_name">Store Name</label>
                        <input type="text" class="form-control" id="store_name" name="store_name" placeholder="Enter your store name" required>
                    </div>
                    <div class="form-group">
                        <label for="store_description">Store Description</label>
                        <textarea class="form-control" id="store_description" name="store_description" rows="3" placeholder="Enter a brief description of your store"></textarea>
                    </div>
                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-custom btn-lg">Create Account</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
