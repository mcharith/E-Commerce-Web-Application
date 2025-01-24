<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.ecommercewebapplication.dto.categoriesDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .custom-table th, .custom-table td {
            vertical-align: middle;
        }
        .cat {
            color: red;
        }
    </style>
</head>
<body>
<%
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>

<% if (message != null) { %>
<div class="alert alert-success">
    <%= message %>
</div>
<% } %>

<% if (error != null) { %>
<div class="alert alert-danger">
    <%= error %>
</div>
<% } %>

<div class="container mt-5">
    <h1 class="text-center mb-4"><b>Manage <span class="cat">Categories</span></b></h1>
    <form id="categoryForm" class="shadow p-4 rounded bg-light" action="admin-categories" method="post">
        <div class="mb-3">
            <label for="categoryName" class="form-label">Category Name</label>
            <input type="text" id="categoryName" class="form-control" placeholder="Enter category name" name="categories_name" required>
        </div>
        <div class="mb-3">
            <label for="categoryDescription" class="form-label">Description</label>
            <input type="text" id="categoryDescription" class="form-control" placeholder="Enter category description" name="categories_description" required>
        </div>
        <button type="submit" class="btn btn-outline-secondary w-100">Add Category</button>
    </form>

    <h2 class="mt-5">Categories List</h2>
    <%
        List<categoriesDTO> dataList = (List<categoriesDTO>) request.getAttribute("categories");
        if (dataList != null && !dataList.isEmpty()) {
    %>
    <table class="table table-hover custom-table mt-3 shadow">
        <thead class="table-secondary">
        <tr>
            <th>ID</th>
            <th>Category Name</th>
            <th>Description</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (categoriesDTO categoriesDTO : dataList) {
        %>
        <tr>
            <td><%= categoriesDTO.getId() %></td>
            <td><%= categoriesDTO.getName() %></td>
            <td><%= categoriesDTO.getDescription() %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <% } else { %>
    <p>No categories found.</p>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>