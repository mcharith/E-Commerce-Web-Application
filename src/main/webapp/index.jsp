<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liberty - Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/styles/userStyles/user-product.css" rel="stylesheet">
    <style>
        /* Global Background Gradient */
        body {
            background: linear-gradient(45deg, #a3a3c2, #150303);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #c9c9c9;
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
            color: white !important;
        }

        #red {
            color: red;
        }

        .nav-link {
            color: white !important;
            position: relative;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: black !important;
        }

        .nav-link:hover::after {
            content: '';
            display: block;
            width: 100%;
            height: 2px;
            background-color: red;
            position: absolute;
            bottom: -5px;
            left: 0;
        }

        .btn-search {
            color: black;
            background-color: transparent;
            border: none;
            display: flex;
            align-items: center;
            font-size: 1.1rem;
            position: relative;
        }

        .btn-search i {
            margin-left: 5px;
            font-size: 1.2rem;
        }

        .btn-search:hover {
            color: red;
        }

        .btn-search:hover::after {
            content: '';
            display: block;
            width: 100%;
            height: 2px;
            background-color: white;
            position: absolute;
            bottom: -3px;
            left: 0;
        }

        /* Banner Section */
        .banner {
            background-image: url('https://via.placeholder.com/1920x600?text=Shop+Our+Latest+Products');
            background-size: cover;
            background-position: center;
            height: 400px;
            color: white;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 2rem;
            font-weight: bold;
            background: linear-gradient(45deg, rgb(241, 86, 86), rgba(255, 255, 255, 0.8)), url('https://via.placeholder.com/1920x600?text=Shop+Our+Latest+Products');
            background-size: cover;
            background-position: center;
        }

        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            padding: 30px 0;
        }

        .product-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-10px);
        }

        .product-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-info {
            padding: 20px;
        }

        .product-title {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .product-description {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }

        .product-price {
            color: #dc3545;
            font-size: 1.2rem;
            font-weight: bold;
        }

        /* Footer Section */
        .footer {
            background-color: #f8f9fa;
            padding: 40px 0;
            text-align: center;
            background: linear-gradient(45deg, #343333, #9b9999);
        }

        .footer .footer-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .footer .footer-links a {
            color: #6c757d;
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s;
        }

        .footer .footer-links a:hover {
            color: #dc3545;
        }

    </style>
</head>
<body>
<%--Nav Bar--%>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Lib<span id="red">er</span>ty</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" id="user_home_nav" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" id="user_product_nav" href="user-product.jsp">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" id="user_cart_nav" href="user-cart.jsp">Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" id="user_news_nav" href="#">News</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <a class="btn btn-search" id="user_search_nav" href="user-search.jsp"><i class="bi bi-search"></i></a>
            </div>

            <%-- Check if the user is logged in --%>
            <% if (session.getAttribute("user") != null) { %>
            <!-- Logged-in state -->
            <a href="user-details.jsp" class="btn btn-secondary ms-3">
                <i class="bi bi-gear"></i> Settings
            </a>
            <a href="logout.jsp" class="btn btn-danger ms-2">Logout</a>
            <% } else { %>
            <!-- Guest state -->
            <a href="user-loginpage.jsp" class="btn btn-danger ms-3">Log In</a>
            <% } %>
        </div>
    </div>
</nav>

<!-- Banner -->
<div class="banner">
    <div><h1>These are our coming soon Products...<br>
        Log in before Buy your Product.
    </h1></div>
</div>

<!-- Product Grid Section -->
<div class="container product-grid">
    <div class="product-card">
        <img src="assets/image/111848_apple-watch-series8.png" alt="Apple Watch Serious 8">
        <div class="product-info">
            <div class="product-title">Apple Watch Serious 8</div>
            <div class="product-description">Water resistant, Blood oxygen sensor, Electrical heart sensor, High-g accelerometer, Display: 45mm, 41mm, Always-On Retina LTPO OLED display.</div>
            <div class="product-price">$49.99</div>
        </div>
    </div>
    <div class="product-card">
        <img src="assets/image/MXL33ref_FV99_VW_34FR+watch-case-46-aluminum-jetblack-nc-s10_VW_34FR+watch-face-46-aluminum-jetblack-s10_VW_34FR.jpeg" alt="Apple Watch Series 10">
        <div class="product-info">
            <div class="product-title">Apple Watch Series 10</div>
            <div class="product-description">46mm. Height: 46mm. Width: 39mm. Depth: 9.7mm. 416 by 496 pixels. 1220 sq mm display area. Weight (aluminum, GPS): 36.4 grams.</div>
            <div class="product-price">$59.99</div>
        </div>
    </div>
    <div class="product-card">
        <img src="assets/image/imageGshok.avif" alt="Product 3">
        <div class="product-info">
            <div class="product-title">G-Shock</div>
            <div class="product-description">Tough Solar: Casio watches are powered by solar energy, making them more reliable and durable than watches that use batteries.</div>
            <div class="product-price">$39.99</div>
        </div>
    </div>
    <!-- Add more products as needed -->
</div>


<!-- Footer Section -->
<div class="footer">
    <div class="footer-title">Stay Connected</div>
    <div class="footer-links">
        <a href="#">Facebook</a>
        <a href="#">Instagram</a>
        <a href="#">Twitter</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>