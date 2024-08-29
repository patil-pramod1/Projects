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
                    <li class="nav-item <%= request.getRequestURI().contains("addproduct.jsp") ? "active" : "" %>">
                        <a class="nav-link" href="addproduct.jsp"><i class="fas fa-box"></i> Add Products</a>
                    </li>
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
