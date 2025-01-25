<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Details</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .border-blue {
      border: 2px solid blue !important;
    }
    .border-red {
      border: 2px solid red !important;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center">User Details</h2>
  <div class="card mt-4">
    <div class="card-body">
      <h5>Welcome, <%= session.getAttribute("user") %>!</h5>
      <p>Email: <%= session.getAttribute("email") %></p>
      <form action="user-detail-update" method="post">
        <div class="mb-3">
          <label for="newName" class="form-label">Update Name:</label>
          <input type="text" id="newName" name="newName" class="form-control" placeholder="Enter new name">
        </div>
        <div class="mb-3">
          <label for="newPassword" class="form-label">Update Password:</label>
          <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Enter new password" oninput="checkPasswordMatch()">
        </div>
        <div class="mb-3">
          <label for="reEnterPassword" class="form-label">Re-type Password:</label>
          <input type="password" id="reEnterPassword" name="reEnterPassword" class="form-control" placeholder="Re-type password" oninput="checkPasswordMatch()">
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
      </form>
      <a href="logout.jsp" class="btn btn-danger mt-3">Logout</a>
    </div>
  </div>
</div>
<script>
  function checkPasswordMatch() {
    const password = document.getElementById('newPassword');
    const retypePassword = document.getElementById('reEnterPassword');

    if (retypePassword.value === password.value && retypePassword.value !== "") {
      password.classList.remove('border-red');
      retypePassword.classList.remove('border-red');
      password.classList.add('border-blue');
      retypePassword.classList.add('border-blue');
    } else {
      password.classList.remove('border-blue');
      retypePassword.classList.remove('border-blue');
      password.classList.add('border-red');
      retypePassword.classList.add('border-red');
    }
  }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>