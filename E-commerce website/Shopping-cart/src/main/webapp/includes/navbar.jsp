<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

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

    /* Active Link Style */
    .navbar .nav-link.active {
        color: #ffd700; /* Gold color for active link */
        font-weight: bold;
    }
</style>
</head>
<body>
<%if (session.getAttribute("auth") == null) {
    response.sendRedirect("login_buyer.jsp");
    return;
} %>

<nav class="navbar navbar-expand-lg navbar-light fixed-top">
    <div class="container-fluid">
        <!-- Left Section: Home Icon and RevShop -->
        <a href="Index.jsp" class="home-icon"><i class="fas fa-home"></i></a> <!-- Home Icon -->
        <a class="navbar-brand" href="Index.jsp">RevShop</a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#responsiveNavbar" aria-controls="responsiveNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <!-- Center Section: Search Bar and Right Section: Links -->
        <div class="collapse navbar-collapse" id="responsiveNavbar">
            <form class="form-inline my-2 my-lg-0" action="SearchServlet" method="get">
                <input class="form-control mr-sm-2" type="search" name="keyword" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
            
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="category.jsp" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Category
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="category.jsp?category=Electronics">Electronic and Accessories</a>
                        <a class="dropdown-item" href="category.jsp?category=Clothing">Clothing and Accessories</a>
                        <a class="dropdown-item" href="category.jsp?category=Home">Home and Kitchen</a>
                        <a class="dropdown-item" href="category.jsp?category=Grocery">Grocery</a>
                    </div>
                </li>

                <li class="nav-item <% if(request.getRequestURI().contains("wishlist.jsp")) { %> active <% } %>">
                    <a class="nav-link" href="wishlist.jsp"><i class="fas fa-heart"></i> Wishlist</a>
                </li>

                <li class="nav-item <% if(request.getRequestURI().contains("cart.jsp")) { %> active <% } %>">
                    <a class="nav-link" href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
                </li>
                <% if (session.getAttribute("auth") != null) { %>
                    <!-- User is logged in -->
                    <li class="nav-item <% if(request.getRequestURI().contains("orders")) { %> active <% } %>">
                        <a class="nav-link" href="orders"><i class="fas fa-box"></i> Orders</a>
                    </li>
                    <li class="nav-item <% if(request.getRequestURI().contains("logout.jsp")) { %> active <% } %>">
                        <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </li>
                <% } else { %>
                    <!-- User is not logged in -->
                    <li class="nav-item <% if(request.getRequestURI().contains("userrole.jsp")) { %> active <% } %>">
                        <a class="nav-link" href="userrole.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                    </li>
                    <li class="nav-item <% if(request.getRequestURI().contains("signin.jsp")) { %> active <% } %>">
                        <a class="nav-link" href="signin.jsp"><i class="fas fa-user-plus"></i> SignUp</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<br>
<br>
<br>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
