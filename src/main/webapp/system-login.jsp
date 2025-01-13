<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #e4bf9b;
            font-family: 'Arial', sans-serif;
        }

        .login-container {
            max-width: 900px;
            width: 100%;
            background: #fff;
            border-radius: 15px;
            box-shadow: 1px 5px 15px rgb(80, 51, 22);
            overflow: hidden;
        }

        .login-image {
            background: url('assets/image/img_2.png') no-repeat center center;
            background-size: cover;
            height: auto;
        }

        .login-form {
            padding: 2rem;
        }

        .login-form h2 {
            font-weight: bold;
            color: #343a40;
            margin-bottom: 1.5rem;
        }

        .form-control {
            border-radius: 10px;
        }

        .btn-primary {
            border-radius: 10px;
            padding: 0.5rem 1rem;
            font-size: 1rem;
        }

        .card-footer {
            margin-top: 1rem;
        }

        @media (max-width: 768px) {
            .login-image {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="login-container d-flex">
    <!-- Left Side Image -->
    <div class="login-image col-6 d-none d-md-block"></div>

    <!-- Right Side Login Form -->
    <div class="col-12 col-md-6 login-form">
        <h2 class="text-center">Welcome Back!</h2>
        <p class="text-center text-muted mb-4">Login to continue to your account</p>
        <form>
            <!-- Email Field -->
            <div class="mb-3">
                <label for="email" class="form-label">Email Address :</label>
                <input type="email" class="form-control" id="email" placeholder="Enter your email" required>
            </div>

            <!-- Password Field -->
            <div class="mb-3">
                <label for="password" class="form-label">Password :</label>
                <input type="password" class="form-control" id="password" placeholder="Enter your password" required>
            </div>

            <!-- Login Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Login</button>
            </div>

            <!-- Register Link -->
            <div class="card-footer text-center mt-3">
                <small class="text-muted">Don’t have an account?
                    <a href="user-save.jsp" class="text-primary">Sign up</a>
                </small>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>