<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.sql.DataSource" %>
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
    <link href="assets/styles/userStyles/user-homepage.css" rel="stylesheet">
    <link href="assets/styles/userStyles/user-search.css" rel="stylesheet">
    <link href="assets/styles/userStyles/user-cart.css" rel="stylesheet">
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

<div id="customer_home_section">
<!-- Banner -->
<div class="banner">
    <div><h1>These are our coming soon Products...<br>
        Log in before Buy your Product.
    </h1></div>
    <img src="assets/image/111848_apple-watch-series8.png">
</div>
<!-- Product Grid Section -->
<div class="container product-grid">
    <div class="product-card">
        <img src="assets/image/111848_apple-watch-series8.png" alt="Apple Watch Serious 8">
        <div class="product-info">
            <div class="product-title">Apple Watch Serious 8</div>
            <div class="product-description">Water resistant, Blood oxygen sensor, Electrical heart sensor, High-g accelerometer, Display: 45mm, 41mm, Always-On Retina LTPO OLED display.</div>
            <div class="product-price">Rs:184900.00</div>
        </div>
    </div>
    <div class="product-card">
        <img src="assets/image/MXL33ref_FV99_VW_34FR+watch-case-46-aluminum-jetblack-nc-s10_VW_34FR+watch-face-46-aluminum-jetblack-s10_VW_34FR.jpeg" alt="Apple Watch Series 10">
        <div class="product-info">
            <div class="product-title">Apple Watch Series 10</div>
            <div class="product-description">46mm. Height: 46mm. Width: 39mm. Depth: 9.7mm. 416 by 496 pixels. 1220 sq mm display area. Weight (aluminum, GPS): 36.4 grams.</div>
            <div class="product-price">Rs:199900.00</div>
        </div>
    </div>
    <div class="product-card">
        <img src="assets/image/imageGshok.avif" alt="Product 3">
        <div class="product-info">
            <div class="product-title">G-Shock</div>
            <div class="product-description">Tough Solar: Casio watches are powered by solar energy, making them more reliable and durable than watches that use batteries.</div>
            <div class="product-price">Rs:15900.00</div>
        </div>
    </div>
    <!-- Add more products as needed -->
</div>
</div>

<%--Product Section--%>
<div id="customer_product_section" class="container mt-5">
    <h1 class="text-center mb-4"><b><span id="av1">Available</span> <span id="red1">Products</span></b></h1>
    <div class="row">
        <%
            Connection connection = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "1234");

                String sql = "SELECT id, name, price FROM products";
                ps = connection.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
        %>
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm">
                <img src="image?id=<%= id %>" class="card-img-top" alt="<%= name %>">
                <div class="card-body text-center">
                    <h5 class="card-title"><%= name %></h5>
                    <p class="card-text">Price: Rs:<%= String.format("%.2f", price) %></p>
                    <form action="add-to-cart" method="post">
                        <input type="hidden" name="productId" value="<%= id %>">
                        <input type="hidden" name="productName" value="<%= name %>">
                        <input type="hidden" name="productPrice" value="<%= price %>">
                        <button type="submit" class="btn btn-add-to-cart w-100 mb-2">Add to Cart</button>
                    </form>
                    <button class="btn btn-buy-now w-100">Buy Now</button>
                </div>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            }
        %>
    </div>
</div>

<%--Cart Section--%>
<div id="customer_cart_section" class="container my-5">
    <h2 class="text-center"><span id="checkout">Checkout</span></h2>
    <div class="table-responsive">
        <table class="table">
            <thead class="table-dark">
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <%
                Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) session.getAttribute("cart");
                double total = 0.0;

                if (cart != null && !cart.isEmpty()) {
                    for (Map.Entry<Integer, Map<String, Object>> entry : cart.entrySet()) {
                        Map<String, Object> productDetails = entry.getValue();
                        String productName = (String) productDetails.get("name");
                        double productPrice = (double) productDetails.get("price");
                        int quantity = (int) productDetails.get("quantity");
                        double subtotal = productPrice * quantity;
                        total += subtotal;
            %>
            <tr>
                <td><%= productName %></td>
                <td>$<%= String.format("%.2f", productPrice) %></td>
                <td><%= quantity %></td>
                <td>$<%= String.format("%.2f", subtotal) %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" class="text-center">Your cart is empty.</td>
            </tr>
            <%
                }
            %>
            </tbody>
            <tfoot>
            <tr class="table-secondary">
                <td colspan="3" class="text-end">Total</td>
                <td>$<%= String.format("%.2f", total) %></td>
            </tr>
            </tfoot>
        </table>
    </div>
    <form action="checkout" method="post">
        <button type="submit" class="btn btn-success w-100">Place Order</button>
    </form>
</div>

<%--Search Section--%>
<div id="customer_search_section" class="container mt-5">
    <div class="filter-bar-container">
        <select id="category-select" class="form-select" style="width: 200px;">
            <option value="all">All Categories</option>
        </select>

        <form id="search-form" class="d-flex">
            <input id="search-input" class="form-control me-2" type="search" placeholder="Search products" aria-label="Search">
            <button class="btn btn-outline-danger" type="submit">Search</button>
        </form>

        <select id="sort-select" class="form-select" style="width: 200px;">
            <option value="none">Sort By</option>
            <option value="asc">Price: Low to High</option>
            <option value="desc">Price: High to Low</option>
        </select>
    </div>

    <h2 class="text-center mb-4"><span id="available">Available Products</span></h2>
    <div class="row" id="product-list">
        <%
            try (Connection connection1 = ((DataSource) getServletContext().getAttribute("jdbc/pool")).getConnection()) {
                String query = "SELECT id, name, price FROM products";
                try (PreparedStatement pst = connection1.prepareStatement(query);
                     ResultSet rst = pst.executeQuery()) {
                    while (rst.next()) {
                        int id = rst.getInt("id");
                        String name = rst.getString("name");
                        double price = rst.getDouble("price");
        %>
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm">
                <img src="image?id=<%= id %>" class="card-img-top" alt="<%= name %>">
                <div class="card-body">
                    <h5 class="card-title"><%= name %></h5>
                    <p class="card-text">Price: Rs:<%= price %></p>
                    <button class="btn btn-primary w-100">Add to Cart</button>
                </div>
            </div>
        </div>
        <%
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
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
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="js/user/user-search.js"></script>
<script src="js/user/user-dashboard.js"></script>
</body>
</html>