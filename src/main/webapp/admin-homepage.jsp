<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Homepage</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/styles/adminStyles/admin-homepage.css">
  <link rel="stylesheet" href="assets/styles/adminStyles/admin-categories.css">
  <link rel="stylesheet" href="assets/styles/adminStyles/admin-product.css">
  <link rel="stylesheet" href="assets/styles/adminStyles/admin-homesection.css">
  <link rel="stylesheet" href="assets/styles/adminStyles/admin-footer.css">
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
          <a class="nav-link active" id="home_nav" aria-current="page" href="admin-homepage.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" id="category_nav" href="#">Categories</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" id="product_nav" href="#">Product</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" id="customer_details_nav" href="#">Customers</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" id="order_details_nav" href="#">Order Details</a>
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

<%--Home page section--%>
<section id="home_section" class="home-section">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="home-content">
          <h1>Welcome to Our Website</h1>
          <p>Discover amazing features, great design, and a seamless experience.</p>
          <a href="#about" class="btn btn-primary home-btn">Learn More</a>
        </div>
      </div>
    </div>
  </div>
</section>


<%--Admin Category Page--%>
<%--<%--%>
<%--  String message = request.getParameter("message");--%>
<%--  String error = request.getParameter("error");--%>
<%--%>--%>

<%--<% if (message != null) { %>--%>
<%--<div class="alert alert-success" role="alert"><%= message %></div>--%>
<%--<% } %>--%>
<%--<% if (error != null) { %>--%>
<%--<div class="alert alert-danger" role="alert"><%= error %></div>--%>
<%--<% } %>--%>
<div id="admin_category_section" class="container mt-5">
  <h1 class="text-center mb-4"><b>Manage <span class="cat">Categories</span></b></h1>
  <form id="categoryForm" class="shadow p-4 rounded bg-light" action="admin-categories" method="POST">
    <input type="hidden" name="categoryId" id="categoryId">
    <div class="mb-3">
      <label for="categoryName" class="form-label">Category Name</label>
      <input type="text" id="categoryName" class="form-control" placeholder="Enter category name" name="categories_name" required>
    </div>
    <div class="mb-3">
      <label for="categoryDescription" class="form-label">Description</label>
      <input type="text" id="categoryDescription" class="form-control" placeholder="Enter category description" name="categories_description" required>
    </div>
    <button type="submit" class="btn btn-outline-secondary w-100" name="action" value="add">Add Category</button>
    <button type="submit" class="btn btn-outline-danger w-100 mt-2" name="action" value="update">Update Category</button>
  </form>

  <h2 class="mt-5">Categories List</h2>
  <table class="table table-hover custom-table mt-3 shadow">
    <thead class="table-secondary">
    <tr>
      <th>ID</th>
      <th>Category Name</th>
      <th>Description</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody id="categoryTableBody">
    <%
      Connection connection = null;
      PreparedStatement ps = null;
      ResultSet rs = null;

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "1234");

        String sql = "SELECT id, name, description FROM categories";
        ps = connection.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
          int id = rs.getInt("id");
          String name = rs.getString("name");
          String description = rs.getString("description");
    %>
    <tr data-id="<%= id %>" data-name="<%= name %>" data-description="<%= description %>">
      <td><%= id %></td>
      <td><%= name %></td>
      <td><%= description %></td>
      <td>
        <!-- Delete button form -->
        <form action="admin-categories" method="POST" style="display:inline;">
          <input type="hidden" name="categoryId" value="<%= id %>">
          <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">
            Delete
          </button>
        </form>
      </td>
    </tr>
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
    </tbody>
  </table>
</div>


<%--Admin Product Page--%>
<%
  String message1 = request.getParameter("message");
  String error1 = request.getParameter("error");
%>
<% if (message1 != null) { %>
<div class="alert alert-success" role="alert"><%= message1 %></div>
<% } %>
<% if (error1 != null) { %>
<div class="alert alert-danger" role="alert"><%= error1 %></div>
<% } %>
<div id="admin_product_section" class="container mt-5">
  <input type="hidden" name="productId" id="productId">
  <h1 class="text-center mb-4"><b>Manage <span class="cat">Product</span></b></h1>
  <form id="productForm" class="shadow p-4 rounded bg-light" action="admin-product" method="POST" enctype="multipart/form-data">
    <div class="mb-3">
      <label for="productName" class="form-label">Product Name</label>
      <input type="text" id="productName" class="form-control" placeholder="Enter product name" name="name" required>
    </div>
    <div class="mb-3">
      <label for="description" class="form-label">Product Image</label>
      <input type="file" id="description" name="description" class="form-control" accept="image/*" required>
      <!-- Display field for filename -->
      <input type="text" id="fileNameDisplay" class="form-control mt-2" placeholder="Selected image filename" readonly name="productId">
    </div>
    <div class="mb-3">
      <label for="productPrice" class="form-label">Price</label>
      <input type="number" id="productPrice" class="form-control" placeholder="Enter product price" name="price" step="0.01" required>
    </div>
    <div class="mb-3">
      <label for="productQty" class="form-label">Quantity</label>
      <input type="number" id="productQty" class="form-control" placeholder="Enter product quantity" name="quantity" required>
    </div>
    <div class="mb-3">
      <label for="categoryId" class="form-label">Category ID</label>
      <input type="number" id="categoryIds" class="form-control" placeholder="Enter category ID" name="categoryId" required>
    </div>
    <div class="d-flex justify-content-between">
      <button type="submit" class="btn btn-outline-secondary w-50 me-2" name="action" value="add">Add Product</button>
      <button type="submit" class="btn btn-outline-danger w-50" name="action" value="update">Update Product</button>
    </div>
  </form>
<div class="container section">
  <h2 class="text-center mb-4">Product List</h2>
  <table class="table table-hover custom-table shadow">
    <thead class="table-secondary">
    <tr>
      <th>ID</th>
      <th>Product Name</th>
      <th>Image</th>
      <th>Price</th>
      <th>Quantity</th>
      <th>Category ID</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody id="productTableBody">
    <%
      Connection connection1 = null;
      PreparedStatement pst = null;
      ResultSet rst = null;

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "1234");

        String sql = "SELECT id, name, description, price, quantity, category_id FROM products";
        pst = connection1.prepareStatement(sql);
        rst = pst.executeQuery();

        while (rst.next()) {
          int id = rst.getInt("id");
          String name = rst.getString("name");
          double price = rst.getDouble("price");
          int quantity = rst.getInt("quantity");
          int categoryId = rst.getInt("category_id");
          String imageUrl = "image?id=" + id;
    %>
    <tr data-id="<%= id %>" data-name="<%= name %>" data-price="<%= price %>" data-quantity="<%= quantity %>" data-category-id="<%= categoryId %>">
      <td><%= id %></td>
      <td><%= name %></td>
      <td><img src="<%= imageUrl %>" alt="<%= name %>" style="width: 100px; height: auto;"></td>
      <td>$<%= String.format("%.2f", price) %></td>
      <td><%= quantity %></td>
      <td><%= categoryId %></td>
      <td>
        <!-- Delete button form -->
        <form action="admin-product" method="POST" style="display:inline;">
          <input type="hidden" name="productId" value="<%= id %>">
          <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">
            Delete
          </button>
        </form>
      </td>
    </tr>
    <%
        }
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        if (rst != null) rst.close();
        if (pst != null) pst.close();
        if (connection1 != null) connection1.close();
      }
    %>
    </tbody>
  </table>
</div>
</div>


<%--Admin Customer Activate Deactivate--%>
<%
  DataSource dataSource = null;
  try {
    Context initContext = new InitialContext();
    Context envContext = (Context) initContext.lookup("java:comp/env");
    dataSource = (DataSource) envContext.lookup("jdbc/pool");
  } catch (Exception e) {
    System.out.println("Error initializing datasource: " + e.getMessage());
  }

  Connection connection2 = null;
  PreparedStatement statement = null;
  ResultSet resultSet = null;
%>
<div id="admin_customer_activate_deactivate_section" class="container mt-4">
  <h1 class="mb-4">Customer Details</h1>
  <table class="table table-striped">
    <thead>
    <tr>
      <th>ID</th>
      <th>Username</th>
      <th>Email</th>
      <th>Status</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
      try {
        connection = dataSource.getConnection();
        String query = "SELECT id, username, email, status FROM users WHERE role = 'customer'";
        statement = connection.prepareStatement(query);
        resultSet = statement.executeQuery();

        while (resultSet.next()) {
          int id = resultSet.getInt("id");
          String username = resultSet.getString("username");
          String email = resultSet.getString("email");
          boolean status = resultSet.getBoolean("status");
    %>
    <tr>
      <td><%= id %></td>
      <td><%= username %></td>
      <td><%= email %></td>
      <td>
                <span class="badge <%= status ? "bg-success" : "bg-danger" %>">
                    <%= status ? "Active" : "Inactive" %>
                </span>
      </td>
      <td>
        <form method="post" action="admin-customer-details" style="display:inline-block;">
          <input type="hidden" name="id" value="<%= id %>">
          <input type="hidden" name="action" value="<%= status ? "deactivate" : "activate" %>">
          <button type="submit" class="btn <%= status ? "btn-danger" : "btn-success" %>">
            <%= status ? "Deactivate" : "Activate" %>
          </button>
        </form>
      </td>
    </tr>
    <%
        }
      } catch (SQLException e) {
        System.out.println("<tr><td colspan='5'>Error loading data: " + e.getMessage() + "</td></tr>");
      } finally {
        if (resultSet != null) resultSet.close();
        if (statement != null) statement.close();
        if (connection != null) connection.close();
      }
    %>
    </tbody>
  </table>
</div>

<%--Admin View Order Details Section--%>
<div id="admin_order_details_section" class="container my-5">
  <h1 class="text-center">Order Management</h1>
  <div class="table-responsive">
    <table class="table table-bordered table-hover">
      <thead class="table-dark">
      <tr>
        <th>Order ID</th>
        <th>User ID</th>
        <th>Total Amount</th>
        <th>Status</th>
        <th>Order Date</th>
        <th>Order Details</th>
      </tr>
      </thead>
      <tbody>
      <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rss = null;

        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "1234");

          String query = "SELECT * FROM orders";
          stmt = conn.prepareStatement(query);
          rss = stmt.executeQuery();

          while (rss.next()) {
            int orderId = rss.getInt("id");
            int userId = rss.getInt("user_id");
            double totalAmount = rss.getDouble("total_amount");
            String status = rss.getString("status");
            Timestamp orderDate = rss.getTimestamp("order_date");
      %>
      <tr>
        <td><%= orderId %></td>
        <td><%= userId %></td>
        <td>$<%= String.format("%.2f", totalAmount) %></td>
        <td><%= status %></td>
        <td><%= orderDate %></td>
        <td>
          <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#orderDetailsModal<%= orderId %>">
            View Details
          </button>

          <div class="modal fade" id="orderDetailsModal<%= orderId %>" tabindex="-1" aria-labelledby="orderDetailsLabel<%= orderId %>" aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="orderDetailsLabel<%= orderId %>">Order Details - Order ID: <%= orderId %></h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <table class="table table-bordered">
                    <thead class="table-light">
                    <tr>
                      <th>Product ID</th>
                      <th>Quantity</th>
                      <th>Price</th>
                      <th>Subtotal</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                      PreparedStatement detailsStmt = null;
                      ResultSet detailsRs = null;

                      try {
                        String detailsQuery = "SELECT * FROM order_details WHERE order_id = ?";
                        detailsStmt = conn.prepareStatement(detailsQuery);
                        detailsStmt.setInt(1, orderId);
                        detailsRs = detailsStmt.executeQuery();

                        while (detailsRs.next()) {
                          int productId = detailsRs.getInt("product_id");
                          int quantity = detailsRs.getInt("quantity");
                          double price = detailsRs.getDouble("price");
                          double subtotal = quantity * price;
                    %>
                    <tr>
                      <td><%= productId %></td>
                      <td><%= quantity %></td>
                      <td>$<%= String.format("%.2f", price) %></td>
                      <td>$<%= String.format("%.2f", subtotal) %></td>
                    </tr>
                    <%
                        }
                      } catch (SQLException e) {
                        e.printStackTrace();
                      } finally {
                        if (detailsRs != null) detailsRs.close();
                        if (detailsStmt != null) detailsStmt.close();
                      }
                    %>
                    </tbody>
                  </table>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>
        </td>
      </tr>
      <%
          }
        } catch (Exception e) {
          e.printStackTrace();
        } finally {
          if (rss != null) rss.close();
          if (stmt != null) stmt.close();
          if (conn != null) conn.close();
        }
      %>
      </tbody>
    </table>
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
<script src="js/admin/admin-category.js"></script>
<script src="js/admin/admin-product.js"></script>
<script src="js/admin/admin-dashboard.js"></script>
</body>
</html>