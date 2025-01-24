<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Homepage</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<%--  <style>--%>
<%--    .navbar {--%>
<%--      background-color: #d0cece;--%>
<%--    }--%>

<%--    .navbar-brand {--%>
<%--      font-weight: bold;--%>
<%--      font-size: 1.5rem;--%>
<%--      color: white !important;--%>
<%--    }--%>

<%--    #red {--%>
<%--      color: red;--%>
<%--    }--%>

<%--    .nav-link {--%>
<%--      color: white !important;--%>
<%--      position: relative;--%>
<%--      text-decoration: none;--%>
<%--    }--%>

<%--    .nav-link:hover::after {--%>
<%--      content: '';--%>
<%--      display: block;--%>
<%--      width: 100%;--%>
<%--      height: 2px;--%>
<%--      background-color: red;--%>
<%--      color: black;--%>
<%--      position: absolute;--%>
<%--      bottom: -3px;--%>
<%--      left: 0;--%>
<%--    }--%>

<%--    .form-control {--%>
<%--      border-radius: 5px;--%>
<%--    }--%>

<%--    .btn-outline-success {--%>
<%--      border-radius: 5px;--%>
<%--    }--%>
<%--  </style>--%>
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
      /*font-weight:bold;*/
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

    .form-control {
      border-radius: 5px;
    }

    .btn-outline-success {
      border-radius: 5px;
    }
  </style>
</head>
<body>
<!-- Navbar -->
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
          <a class="nav-link active" href="admin-product.jsp">Product</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="admin-customer-details.jsp">Customers</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="#">Order Details</a>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-danger" type="submit">Search</button>
      </form>
      <!-- Logout Button with Margin Start -->
      <button type="submit" class="btn btn-danger logout-button ms-3">
        <a href="admin-loginpage.jsp"></a>
        Logout</button>
    </div>
  </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>