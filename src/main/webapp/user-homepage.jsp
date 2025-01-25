<%--
  Created by IntelliJ IDEA.
  User: charithsiriwardana
  Date: 2025-01-24
  Time: 18:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Watch E-Commerce</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: url('https://images.unsplash.com/photo-1519588489750-451385f7448a') no-repeat center center fixed;
      background-size: cover;
      color: white;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .overlay {
      background-color: rgba(0, 0, 0, 0.7);
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -1;
    }
    .content {
      text-align: center;
    }
    .content h1 {
      font-size: 3rem;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .content p {
      font-size: 1.5rem;
      margin-bottom: 30px;
    }
    .btn {
      padding: 15px 30px;
      font-size: 1.2rem;
      border-radius: 50px;
      transition: all 0.3s ease;
    }
    .btn-primary {
      background-color: #007bff;
      border: none;
    }
    .btn-primary:hover {
      background-color: #0056b3;
    }
    .btn-outline-light {
      border-color: white;
      color: white;
    }
    .btn-outline-light:hover {
      background-color: white;
      color: black;
    }
  </style>
</head>
<body>
<div class="overlay"></div>
<div class="content">
  <h1>Welcome to Watch Haven</h1>
  <p>Explore timeless elegance with our premium collection of watches.</p>
  <div class="d-flex justify-content-center gap-3">
    <a href="login.jsp" class="btn btn-primary">Log In</a>
    <a href="products.jsp" class="btn btn-outline-light">See Products</a>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>