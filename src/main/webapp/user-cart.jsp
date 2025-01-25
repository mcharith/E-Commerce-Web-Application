<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: charithsiriwardana
  Date: 2025-01-24
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .cart-header {
            background-color: #f8f9fa;
            padding: 10px;
            border-bottom: 1px solid #dee2e6;
            font-weight: bold;
        }
        .cart-item {
            border-bottom: 1px solid #dee2e6;
            padding: 15px 0;
        }
        .cart-footer {
            background-color: #f8f9fa;
            padding: 15px;
            font-weight: bold;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
<div class="container my-4">
    <h5>Welcome, <%= session.getAttribute("user") %>!</h5>
    <h1 class="text-center">Shopping Cart</h1>
    <div class="row">
        <div class="col-md-12">
            <!-- Cart Table -->
            <div class="table-responsive">
                <table class="table">
                    <thead class="cart-header">
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) session.getAttribute("cart");
                        double total = 0.0;

                        if (cart != null && !cart.isEmpty()) {
                            for (Map.Entry<Integer, Map<String, Object>> entry : cart.entrySet()) {
                                int productId = entry.getKey();
                                Map<String, Object> productDetails = entry.getValue();
                                String productName = (String) productDetails.get("name");
                                double productPrice = (double) productDetails.get("price");
                                int quantity = (int) productDetails.get("quantity");
                                double subtotal = productPrice * quantity;
                                total += subtotal;
                    %>
                    <tr class="cart-item">
                        <td><%= productName %></td>
                        <td>$<%= String.format("%.2f", productPrice) %></td>
                        <td>
                            <input type="number" class="form-control w-50" value="<%= quantity %>" min="1" disabled>
                        </td>
                        <td>$<%= String.format("%.2f", subtotal) %></td>
                        <td>
                            <form action="remove-from-cart" method="post">
                                <input type="hidden" name="productId" value="<%= productId %>">
                                <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center">Your cart is empty.</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                    <tfoot>
                    <tr class="cart-footer">
                        <td colspan="3">Total</td>
                        <td>$<%= String.format("%.2f", total) %></td>
                        <td>
                            <button class="btn btn-success">Checkout</button>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>