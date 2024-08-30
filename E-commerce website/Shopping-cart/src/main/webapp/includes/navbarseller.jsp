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
       
        body {
            background: linear-gradient(to right, #e0c3fc, #8ec5fc);
            font-family: 'Arial', sans-serif;
            color: #333;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            margin: 0 auto;
            padding: 0 15px;
            max-width: 100%;
            box-sizing: border-box;
        }
        .product-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            transition: transform 0.3s;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 15px;
            height: 100%;
            box-sizing: border-box;
            min-height: 350px;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }
        .product-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .product-card h3 {
            font-size: 1.2em;
            margin-bottom: 10px;
            color: #333;
        }
        .product-card p {
            flex-grow: 1;
            margin-bottom: 10px;
        }
        .price-quantity-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .price {
            color: #ff5722;
            font-size: 1.1em;
            margin: 0;
        }
        .quantity-input {
            display: inline-block;
            width: 60px;
            border-radius: 5px;
            text-align: center;
            border: 1px solid #ddd;
            padding: 5px;
            font-size: 1em;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        .add-to-cart-btn, .buy-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.8em;
            transition: background-color 0.3s, transform 0.2s;
            width: 48%;
        }
        .add-to-cart-btn:hover, .buy-btn:hover {
            transform: translateY(-2px);
        }
        .buy-btn {
            background-color: #007bff;
        }
        .buy-btn:hover {
            background-color: #0056b3;
        }
        @media (max-width: 1200px) {
            .product-grid {
                grid-template-columns: repeat(4, 1fr);
            }
        }
        @media (max-width: 992px) {
            .product-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 576px) {
            .product-grid {
                grid-template-columns: 1fr;
            }
        }
        .pagination-container {
            text-align: center;
            margin: 20px 0;
        }
        .product-container {
            margin-top: 0.5cm; /* Set a 0.5cm gap between navbar and product grid */
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
