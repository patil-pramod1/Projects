<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <!-- Left Section: RevShop and Home -->
        <a class="navbar-brand" href="Index.jsp">RevShop</a>
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="Index.jsp">Home</a>
            </li>
        </ul>

        <!-- Center Section: Search Bar -->
        <div class="mx-auto order-0">
            <form class="form-inline my-2 my-lg-0 d-flex">
                <input class="form-control" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success ml-2" type="submit">Search</button>
            </form>
        </div>

        <!-- Right Section: Category, Cart, Orders, Login/Logout -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#responsiveNavbar" aria-controls="responsiveNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse order-3" id="responsiveNavbar">
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
                    <a class="nav-link" href="cart.jsp">Cart</a>
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
                <% } %>
            </ul>
        </div>
    </div>
</nav>
