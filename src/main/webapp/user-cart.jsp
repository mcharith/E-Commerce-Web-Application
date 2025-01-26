<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <h1 class="text-center">Checkout</h1>
    <div class="table-responsive">
        <table class="table">
            <thead class="table-dark">
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <%
                Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) session.getAttribute("cart");
                double total = 0.0;

                if (cart != null && !cart.isEmpty()) {
                    for (Map.Entry<Integer, Map<String, Object>> entry : cart.entrySet()) {
                        Map<String, Object> productDetails = entry.getValue();
                        String productName = (String) productDetails.get("name");
                        double productPrice = (double) productDetails.get("price");
                        int quantity = (int) productDetails.get("quantity");
                        double subtotal = productPrice * quantity;
                        total += subtotal;
            %>
            <tr>
                <td><%= productName %></td>
                <td>$<%= String.format("%.2f", productPrice) %></td>
                <td><%= quantity %></td>
                <td>$<%= String.format("%.2f", subtotal) %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" class="text-center">Your cart is empty.</td>
            </tr>
            <%
                }
            %>
            </tbody>
            <tfoot>
            <tr class="table-secondary">
                <td colspan="3" class="text-end">Total</td>
                <td>$<%= String.format("%.2f", total) %></td>
            </tr>
            </tfoot>
        </table>
    </div>
    <form action="checkout" method="post">
        <button type="submit" class="btn btn-success w-100">Place Order</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>