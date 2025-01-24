<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liberty</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
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
                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="admin-categories.jsp">Categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="user-product.jsp">Product</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#">Cart</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <!-- Search Button -->
                <a class="btn btn-search" href="user-search.jsp"><i class="bi bi-search"></i>
                </a>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>