<%--
  Created by IntelliJ IDEA.
  User: charithsiriwardana
  Date: 2025-01-12
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<%
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>

<%
    if (message!= null){
%>
<div style="color: green">
    <%=message%>
</div>
<%
    }
%>

<%
    if (error!= null){
%>
<div style="color: red">
    <%=error%>
</div>
<%
    }
%>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white text-center">
                    <h3>Register for Your Account</h3>
                </div>
                <div class="card-body">
                    <form action="user-save" method="POST">
                        <!-- Username -->
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="user_name" placeholder="Enter your username" required>
                        </div>
                        <!-- Email -->
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="user_email" placeholder="Enter your email" required>
                        </div>
                        <!-- Password -->
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="user_password" placeholder="Enter a secure password" required>
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i class="bi bi-eye-slash" id="toggleIcon"></i>
                                </button>
                            </div>
                        </div>
                        <!-- Role -->
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="user_role" id="roleCustomer" value="customer" required>
                                    <label class="form-check-label" for="roleCustomer">Customer</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="user_role" id="roleAdmin" value="admin">
                                    <label class="form-check-label" for="roleAdmin">Admin</label>
                                </div>
                            </div>
                        </div>
                        <!-- Submit Button -->
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary btn-block w-100">Register</button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center">
                    <small>Already have an account? <a href="user-loginpage.jsp" class="text-primary">Login here</a></small>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/user-register.js"></script>
</body>
</html>
