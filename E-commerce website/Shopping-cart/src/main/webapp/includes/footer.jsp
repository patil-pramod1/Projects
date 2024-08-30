<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Online Store</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .footer-top {
            background: linear-gradient(90deg, #6a11cb, #2575fc); /* Same gradient as the navbar */
            color: #ffffff;
            padding: 40px 0;
        }
        
        .footer-heading {
            color: #ffffff; /* White text for headings */
            font-size: 1rem;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .footer-links {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        
        .footer-links li {
            margin-bottom: 10px;
        }
        
        .footer-links a {
            color: #ffffff; /* White link text */
            text-decoration: none;
            transition: color 0.3s ease, transform 0.3s ease; /* Same transition as the navbar */
        }
        
        .footer-links a:hover {
            color: #ffd700; /* Gold color on hover */
            text-decoration: underline;
            transform: scale(1.05); /* Slightly enlarge link on hover */
        }
        
        .social-icons {
            font-size: 1.5rem;
        }
        
        .social-icons a {
            color: #ffffff;
            margin-right: 15px;
            transition: color 0.3s ease, transform 0.3s ease; /* Same transition as the navbar */
        }
        
        .social-icons a:hover {
            color: #ffd700; /* Gold color on hover */
            transform: scale(1.1); /* Slightly enlarge icon on hover */
        }
        
        .footer-bottom {
            background-color: #232f3e; /* Dark background for the footer bottom */
            color: #999999; /* Light grey text */
            padding: 20px 0;
            font-size: 0.8rem;
        }
        
        .footer-bottom a {
            color: #999999; /* Light grey link text */
            text-decoration: none;
        }
        
        .footer-bottom a:hover {
            color: #ffffff; /* White color on hover */
        }
        
        .back-to-top {
            background-color: #6a11cb; /* Use the same gradient color */
            color: #ffffff;
            text-align: center;
            padding: 15px 0;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        .back-to-top:hover {
            background-color: #2575fc; /* Transition to the other gradient color */
        }
        .footer-bottom {
    background: linear-gradient(90deg, #6a11cb, #2575fc); /* Same gradient as other divs */
    color: #ffffff; /* White text color */
    padding: 20px 0;
    font-size: 0.9rem;
}

.footer-link {
    color: #ffffff; /* White link text */
    text-decoration: none;
    transition: color 0.3s ease, transform 0.3s ease; /* Smooth transition for hover effects */
}

.footer-link:hover {
    color: #ffd700; /* Gold color on hover */
    transform: scale(1.05); /* Slightly enlarge link on hover */
}

.footer-bottom p {
    margin: 0;
    color: #ffffff; /* White text */
}
        
    </style>
</head>
<body>
    <footer>
        <div class="back-to-top" onclick="scrollToTop()">
            Back to top
        </div>
        <!-- Rest of your footer content -->
    

    <script>
    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }
    </script>
        <div class="footer-top">
            <div class="container">
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <h5 class="footer-heading">Get to Know Us</h5>
                        <ul class="footer-links">
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">Press Releases</a></li>
                            <li><a href="#">Your Online Store Science</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <h5 class="footer-heading">Make Money with Us</h5>
                        <ul class="footer-links">
                            <li><a href="#">Sell products on Your Online Store</a></li>
                            <li><a href="#">Sell on Your Online Store Business</a></li>
                            <li><a href="#">Become an Affiliate</a></li>
                            <li><a href="#">Advertise Your Products</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <h5 class="footer-heading">Your Online Store Payment Products</h5>
                        <ul class="footer-links">
                            <li><a href="#">Your Online Store Business Card</a></li>
                            <li><a href="#">Shop with Points</a></li>
                            <li><a href="#">Reload Your Balance</a></li>
                            <li><a href="#">Currency Converter</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <h5 class="footer-heading">Let Us Help You</h5>
                        <ul class="footer-links">
                            <li><a href="#">Your Account</a></li>
                            <li><a href="#">Your Orders</a></li>
                            <li><a href="#">Shipping Rates & Policies</a></li>
                            <li><a href="#">Returns & Replacements</a></li>
                            <li><a href="#">Help</a></li>
                        </ul>
                    </div>
                </div>
                <hr style="border-color: #3a4553;">
                <div class="row">
    <div class="col-md-12 text-center">
        <a class="navbar-brand" style="color: #ffffff;">RevShop</a>
        <div class="social-icons">
            <a href="#"><i class="fab fa-facebook"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
        </div>
    </div>
</div>

  <div class="footer-bottom">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <p>&copy; 2024 RevShop. All rights reserved.</p>
                <p>
                    <a href="#" class="footer-link mr-2">Conditions of Use</a>
                    <a href="#" class="footer-link mr-2">Privacy Notice</a>
                    <a href="#" class="footer-link">Interest-Based Ads</a>
                </p>
            </div>
        </div>
    </div>
</div>


    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
</body>
</html>
