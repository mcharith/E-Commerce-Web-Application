<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liberty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar {
            background-color: #f8f9fa;
        }

        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }

        .navbar-center {
            flex-grow: 1;
            display: flex;
            justify-content: center;
        }

        .navbar-right {
            display: flex;
            align-items: center;
        }

        .navbar-right img {
            max-height: 40px;
        }
        #red{
            color: red;
        }
        .circle{
            width: 150px;
            height: 150px;
            border-radius: 100px;
            background-image: url("assets/image/img_2.png");
        }
    </style>
</head>
<body>
<%--Nav Bar--%>
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <!-- Liberty Text on the Left -->
        <a class="navbar-brand" href="#">Lib<span id="red">er</span>ty</a>

        <!-- Navbar Toggler -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Collapsible Navbar Content -->
        <div class="collapse navbar-collapse" id="navbarContent">
            <!-- Search Bar Centered -->
            <div class="navbar-center">
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>

            <!-- Logo on the Right -->
            <div class="navbar-right">
                <a href="system-login.jsp">
                    <img src="assets/icons/img.png">
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Links -->
<div class="container mt-3">
    <a href="user-save.jsp">Register</a><br>
    <a href="system-login.jsp">Login</a><br>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>