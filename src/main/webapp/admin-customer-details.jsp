<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<%
  DataSource dataSource = null;
  try {
    Context initContext = new InitialContext();
    Context envContext = (Context) initContext.lookup("java:comp/env");
    dataSource = (DataSource) envContext.lookup("jdbc/pool");
  } catch (Exception e) {
    System.out.println("Error initializing datasource: " + e.getMessage());
  }

  Connection connection = null;
  PreparedStatement statement = null;
  ResultSet resultSet = null;
%>
<html>
<head>
  <title>Admin Customer Details</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
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
</body>
</html>