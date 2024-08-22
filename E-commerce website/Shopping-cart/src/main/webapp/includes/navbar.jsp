<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Colorful Navbar</title>
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

        .navbar .dropdown-menu {
            background-color: #ffffff; /* White background for dropdown */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); /* Shadow for dropdown */
        }

        .navbar .dropdown-item {
            color: #333; /* Dark color for dropdown items */
            transition: background-color 0.3s ease; /* Smooth transition for dropdown items */
        }

        .navbar .dropdown-item:hover {
            background-color: #6a11cb; /* Change background color on hover */
            color: #ffffff; /* Change text color to white on hover */
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
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <!-- Left Section: Home Icon and RevShop -->
        <a href="Index.jsp" class="home-icon"><i class="fas fa-home"></i></a> <!-- Home Icon -->
        <a class="navbar-brand" href="Index.jsp">RevShop</a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#responsiveNavbar" aria-controls="responsiveNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <!-- Center Section: Search Bar -->
        <div class="collapse navbar-collapse mx-auto order-0" id="responsiveNavbar">
            <form class="form-inline my-2 my-lg-0 d-flex justify-content-center">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>

        <!-- Right Section: Category, Cart, Orders, Login/Logout -->
        <div class="collapse navbar-collapse" id="responsiveNavbar">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown active">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Category
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Electronic and Accessories</a>
                        <a class="dropdown-item" href="#">Clothing and Accessories</a>
                        <a class="dropdown-item" href="#">Home and Kitchen</a>
                        <a class="dropdown-item" href="#">Grocery</a>
                    </div>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
                </li>

                <% if (session.getAttribute("auth") != null) { %>
                    <!-- User is logged in -->
                    <li class="nav-item active">
                        <a class="nav-link" href="orders.jsp"><i class="fas fa-box"></i> Orders</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </li>
                <% } else { %>
                    <!-- User is not logged in -->
                    <li class="nav-item active">
                        <a class="nav-link" href="userrole.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="signin.jsp"><i class="fas fa-user-plus"></i> SignUp</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
