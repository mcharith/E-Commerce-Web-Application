<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product Success</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/styles/userStyles/user-product.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h1 class="text-center mb-4"><b>Available <span id="red">Products</span></b></h1>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>