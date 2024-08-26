<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Home - RevShop</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> <!-- Font Awesome CDN -->
    <style>
        /* Navbar Styles */
        .navbar {
            background: linear-gradient(90deg, #6a11cb, #2575fc); /* Gradient background */
            padding: 0.5rem 1rem; /* Add vertical padding for a larger navbar */
        }

        .navbar .navbar-brand, .navbar .home-icon {
            color: #ffffff; /* White text for brand and icon */
            font-weight: bold; /* Bold font for brand and icon */
            font-size: 1.25rem; /* Increased font size for better visibility */
            margin-right: 15px; /* Space between the icon and brand name */
        }

        .navbar .nav-link {
            color: #ffffff; /* White link text */
            transition: color 0.3s ease, transform 0.3s ease; /* Smooth transition for hover effects */
            font-size: 1rem; /* Font size for nav links */
            margin: 0 15px; /* Space between individual nav links */
        }

        .navbar .nav-link:hover {
            color: #ffd700; /* Gold color on hover */
            transform: scale(1.05); /* Slightly enlarge link on hover */
        }

        .btn-outline-success {
            border-color: #ffffff; /* White border for the search button */
            color: #ffffff; /* White text for the button */
            transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transition */
            font-size: 1rem; /* Font size for the button */
            margin-left: 10px; /* Space between search input and button */
        }

        .btn-outline-success:hover {
            background-color: #ffffff; /* White background on hover */
            color: #6a11cb; /* Change text color to the main theme color */
        }

        @media (max-width: 768px) {
            .navbar .navbar-brand {
                font-size: 1rem; /* Smaller brand font size on mobile */
            }

            .navbar .nav-link {
                font-size: 0.875rem; /* Smaller link font size on mobile */
            }

            .btn-outline-success {
                font-size: 0.875rem; /* Smaller button text on mobile */
            }

            .form-control {
                width: 100%; /* Full-width search input on mobile */
            }
        }

        /* Active Link Style */
        .navbar .nav-link.active {
            color: #ffd700; /* Gold color for active link */
            font-weight: bold;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <!-- Left Section: Home Icon and RevShop -->
        <a href="sellerHomepage.jsp" class="home-icon"><i class="fas fa-home"></i></a> <!-- Home Icon -->
        <a class="navbar-brand" href="sellerHomepage.jsp">RevShop</a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#responsiveNavbar" aria-controls="responsiveNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <!-- Right Section: Links -->
        <div class="collapse navbar-collapse" id="responsiveNavbar">
            <ul class="navbar-nav ml-auto">
                <% if (session.getAttribute("auth") != null) { %>
                    <!-- User is logged in -->
                    <li class="nav-item <%= request.getRequestURI().contains("sellerorders.jsp") ? "active" : "" %>">
                        <a class="nav-link" href="sellerorders.jsp"><i class="fas fa-box"></i> Orders</a>
                    </li>
                    <li class="nav-item <%= request.getRequestURI().contains("logout.jsp") ? "active" : "" %>">
                        <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </li>
                <% } else { %>
                    <!-- User is not logged in -->
                    <li class="nav-item <%= request.getRequestURI().contains("login_seller.jsp") ? "active" : "" %>">
                        <a class="nav-link" href="login_seller.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                    </li>
                    <li class="nav-item <%= request.getRequestURI().contains("createselleraccount.jsp") ? "active" : "" %>">
                        <a class="nav-link" href="createselleraccount.jsp"><i class="fas fa-user-plus"></i> Sign Up</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <% if (session.getAttribute("auth") != null) { %>
        <!-- User is logged in -->
        <h2>Add a New Product</h2>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success" role="alert">
                Product added successfully!
            </div>
        <% } else if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger" role="alert">
                Failed to add product. Please try again.
            </div>
        <% } %>

        <form action="AddProductServlet" method="post">
    <div class="form-group">
        <label for="productName">Product Name:</label>
        <input type="text" class="form-control" id="productName" name="productName" required>
    </div>
    <div class="form-group">
        <label for="description">Description:</label>
        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
    </div>
    <div class="form-group">
        <label for="price">Price:</label>
        <input type="number" class="form-control" id="price" name="price" step="0.01" required>
    </div>
    <div class="form-group">
        <label for="imageUrl">Image URL:</label>
        <input type="text" class="form-control" id="imageUrl" name="imageUrl" required>
    </div>
    <div class="form-group">
        <label for="category">Category:</label>
        <input type="text" class="form-control" id="category" name="category" required>
    </div>
    <div class="form-group">
        <label for="stockQuantity">Stock Quantity:</label>
        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" required>
    </div>
   

            
            <button type="submit" class="btn btn-primary">Add Product</button>
        </form>
    <% } else { %>
        <!-- User is not logged in -->
        <div class="alert alert-warning" role="alert">
            Please <a href="login_seller.jsp">login</a> to add products.
        </div>
    <% } %>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Include jQuery first -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Then include Bootstrap's JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
