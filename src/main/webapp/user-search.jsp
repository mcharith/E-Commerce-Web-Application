<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product Browsing</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card {
      transition: transform 0.3s ease;
    }

    .card:hover {
      transform: scale(1.05);
    }

    .card img {
      height: 200px;
      object-fit: cover;
    }

    .btn-add-to-cart {
      background-color: #b0b0b0; /* Ash color */
      color: #000;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-add-to-cart:hover {
      background-color: #000; /* Black color */
      color: #fff;
    }

    .btn-buy-now {
      background-color: #000; /* Black color */
      color: #fff;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-buy-now:hover {
      background-color: #de4c4c; /* Ash color */
      color: white;
    }

    .filter-bar-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }

    #search-input {
      width: 250px;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<div class="container mt-5">
  <!-- Filter and Search Bar -->
  <div class="filter-bar-container">
    <!-- Category Dropdown -->
    <select id="category-select" class="form-select" style="width: 200px;">
      <option value="all">All Categories</option>
      <!-- Categories will be dynamically loaded -->
    </select>

    <!-- Search Bar -->
    <form id="search-form" class="d-flex">
      <input id="search-input" class="form-control me-2" type="search" placeholder="Search products" aria-label="Search">
      <button class="btn btn-outline-danger" type="submit">Search</button>
    </form>

    <!-- Sort Dropdown -->
    <select id="sort-select" class="form-select" style="width: 200px;">
      <option value="none">Sort By</option>
      <option value="asc">Price: Low to High</option>
      <option value="desc">Price: High to Low</option>
    </select>
  </div>

  <h1 class="text-center mb-4">Available Products</h1>
  <div class="row" id="product-list">
    <%
      try (Connection connection = ((DataSource) getServletContext().getAttribute("jdbc/pool")).getConnection()) {
        String query = "SELECT id, name, price FROM products";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
          while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            double price = rs.getDouble("price");
    %>
    <div class="col-md-4 mb-4">
      <div class="card shadow-sm">
        <img src="image?id=<%= id %>" class="card-img-top" alt="<%= name %>">
        <div class="card-body">
          <h5 class="card-title"><%= name %></h5>
          <p class="card-text">Price: $<%= price %></p>
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

<script>
  function loadProducts(search = '', category = 'all', sort = 'none') {
    $.ajax({
      url: 'ProductController',
      method: 'GET',
      data: { search, category, sort },
      success: function (response) {
        $('#product-list').html(response);
      },
      error: function (xhr, status, error) {
        console.error('Error loading products:', error);
      }
    });
  }

  function loadCategories() {
    $.ajax({
      url: 'CategoryController',
      method: 'GET',
      success: function (response) {
        const categories = JSON.parse(response);
        categories.forEach(category => {
          $('#category-select').append(`<option value="${category.id}">${category.name}</option>`);
        });
      },
      error: function (xhr, status, error) {
        console.error('Error loading categories:', error);
      }
    });
  }

  $(document).ready(function () {
    loadCategories();
    loadProducts();

    // Filter by category
    $('#category-select').on('change', function () {
      const category = $(this).val();
      const search = $('#search-input').val();
      const sort = $('#sort-select').val();
      loadProducts(search, category, sort);
    });

    // Sort products
    $('#sort-select').on('change', function () {
      const sort = $(this).val();
      const search = $('#search-input').val();
      const category = $('#category-select').val();
      loadProducts(search, category, sort);
    });

    // Search functionality
    $('#search-form').on('submit', function (e) {
      e.preventDefault();
      const search = $('#search-input').val();
      const category = $('#category-select').val();
      const sort = $('#sort-select').val();
      loadProducts(search, category, sort);
    });
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>