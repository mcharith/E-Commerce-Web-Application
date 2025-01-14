<%--
  Created by IntelliJ IDEA.
  User: charithsiriwardana
  Date: 2025-01-13
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Homepage</title>
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
  </style>
</head>
<body>
<%--Nav bar--%>
<nav class="navbar navbar-expand-lg navbar-light">
  <div class="container-fluid">
    <!-- Liberty Text on the Left -->
    <a class="navbar-brand" href="#">Lib<span id="red">er</span>ty Store Admin Page</a>

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
    </div>
  </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
