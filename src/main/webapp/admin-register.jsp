<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Register</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
      background-color: #add1f8;
    }
    .form-container {
      max-width: 400px;
      margin: 50px auto;
      background-color: #ffffff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .form-header {
      text-align: center;
      margin-bottom: 20px;
    }
  </style>
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


<div class="form-container">
  <div class="form-header">
    <h3><b>Admin Registration</b></h3>
    <p>Join the Clock Sale platform</p>
  </div>
  <form action="admin-register" method="POST">
    <div class="mb-3">
      <label for="name" class="form-label">Full Name:</label>
      <input type="text" class="form-control" id="name" name="user_name" placeholder="Enter Full Name" required>
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Email Address:</label>
      <input type="email" class="form-control" id="email" name="user_email" placeholder="Enter Email" required>
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">Password:</label>
      <div class="input-group">
        <input type="password" class="form-control" id="password" name="user_password" placeholder="Enter Password" required>
        <button class="btn btn-outline-secondary" type="button" id="toggledPassword">
          <i class="bi bi-eye-slash" id="toggledIcon"></i>
        </button>
      </div>
    </div>
    <div class="mb-3">
      <label for="re-password" class="form-label">Retype Password:</label>
      <input type="password" class="form-control" id="re-password" placeholder="Re-enter Password" required>
    </div>
    <p id="passwordMatchMessage" class="form-text"></p>

    <div class="form-check">
      <input class="form-check-input" type="radio" name="user_role" id="roleAdmin" value="admin" required>
      <label class="form-check-label" for="roleAdmin">Register as Administrator</label>
    </div>

    <div class="d-grid mt-4">
      <button type="submit" class="btn btn-primary">Register</button>
    </div>
  </form>
  <p class="text-center mt-3">
    Already have an account? <a href="admin-loginpage.jsp">Login here</a>
  </p>
</div>
</div>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/password.js"></script>
</body>
</html>