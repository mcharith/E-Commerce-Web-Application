<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
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
        ResultSet rs = null;

        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "1234");

          String query = "SELECT * FROM orders";
          stmt = conn.prepareStatement(query);
          rs = stmt.executeQuery();

          while (rs.next()) {
            int orderId = rs.getInt("id");
            int userId = rs.getInt("user_id");
            double totalAmount = rs.getDouble("total_amount");
            String status = rs.getString("status");
            Timestamp orderDate = rs.getTimestamp("order_date");
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
          if (rs != null) rs.close();
          if (stmt != null) stmt.close();
          if (conn != null) conn.close();
        }
      %>
      </tbody>
    </table>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>