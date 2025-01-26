<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const rows = document.querySelectorAll("#categoryTableBody tr");
        const categoryNameField = document.getElementById("categoryName");
        const categoryDescriptionField = document.getElementById("categoryDescription");
        const categoryIdField = document.getElementById("categoryId");

        rows.forEach(row => {
            row.addEventListener("click", () => {
                const id = row.getAttribute("data-id");
                const name = row.getAttribute("data-name");
                const description = row.getAttribute("data-description");

                // Populate form fields
                categoryIdField.value = id;
                categoryNameField.value = name;
                categoryDescriptionField.value = description;
            });
        });
    });
</script>
</body>
</html>