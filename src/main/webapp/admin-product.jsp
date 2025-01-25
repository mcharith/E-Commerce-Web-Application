<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Admin Product</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .custom-table th, .custom-table td {
      vertical-align: middle;
    }
    .cat {
      color: red;
    }
    .section {
      margin-top: 50px;
    }
    tr:hover {
      cursor: pointer;
      background-color: #f2f2f2;
    }
  </style>
</head>
<body>

<%
  String message = request.getParameter("message");
  String error = request.getParameter("error");
%>

<% if (message != null) { %>
<div class="alert alert-success" role="alert"><%= message %></div>
<% } %>
<% if (error != null) { %>
<div class="alert alert-danger" role="alert"><%= error %></div>
<% } %>

<div class="container mt-5">
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
      <input type="number" id="categoryId" class="form-control" placeholder="Enter category ID" name="categoryId" required>
    </div>
    <div class="d-flex justify-content-between">
      <button type="submit" class="btn btn-outline-secondary w-50 me-2" name="action" value="add">Add Product</button>
      <button type="submit" class="btn btn-outline-danger w-50" name="action" value="update">Update Product</button>
    </div>
  </form>
</div>

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
      Connection connection = null;
      PreparedStatement ps = null;
      ResultSet rs = null;

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "1234");

        String sql = "SELECT id, name, description, price, quantity, category_id FROM products";
        ps = connection.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
          int id = rs.getInt("id");
          String name = rs.getString("name");
          double price = rs.getDouble("price");
          int quantity = rs.getInt("quantity");
          int categoryId = rs.getInt("category_id");
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
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (connection != null) connection.close();
      }
    %>
    </tbody>
  </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", () => {
    const rows = document.querySelectorAll("#productTableBody tr");
    const productNameField = document.getElementById("productName");
    const productPriceField = document.getElementById("productPrice");
    const productQtyField = document.getElementById("productQty");
    const categoryIdField = document.getElementById("categoryId");
    const productIdField = document.getElementById("productId");
    const fileNameDisplay = document.getElementById("fileNameDisplay");
    const fileInput = document.getElementById("description");

    rows.forEach(row => {
      row.addEventListener("click", () => {
        const id = row.getAttribute("data-id");
        const name = row.getAttribute("data-name");
        const price = row.getAttribute("data-price");
        const quantity = row.getAttribute("data-quantity");
        const categoryId = row.getAttribute("data-category-id");
        const imageUrl = row.querySelector("img").src;

        // Extract filename from the image URL
        const filename = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

        // Populate form fields with table row data
        productNameField.value = name;
        productPriceField.value = price;
        productQtyField.value = quantity;
        categoryIdField.value = categoryId;
        productIdField.value = id;

        // Set the filename in the display field
        fileNameDisplay.value = filename;
      });
    });

    // Update the fileNameDisplay field when a new file is selected
    fileInput.addEventListener("change", event => {
      const file = event.target.files[0];
      if (file) {
        fileNameDisplay.value = file.name;
      } else {
        fileNameDisplay.value = ""; // Clear if no file is selected
      }
    });
  });
</script>
</body>
</html>