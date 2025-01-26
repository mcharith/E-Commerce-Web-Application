package lk.ijse.ecommercewebapplication;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import jakarta.annotation.Resource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect("user-loginpage.jsp?error=Please log in to place an order.");
            return;
        }

        Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("cart.jsp?error=Your cart is empty.");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            connection.setAutoCommit(false);

            // Insert into orders table
            String orderSQL = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'pending')";
            PreparedStatement orderStmt = connection.prepareStatement(orderSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            double totalAmount = cart.values().stream()
                    .mapToDouble(product -> (double) product.get("price") * (int) product.get("quantity"))
                    .sum();
            orderStmt.setInt(1, userId);
            orderStmt.setDouble(2, totalAmount);
            orderStmt.executeUpdate();

            ResultSet orderKeys = orderStmt.getGeneratedKeys();
            if (!orderKeys.next()) {
                connection.rollback();
                throw new SQLException("Failed to retrieve order ID.");
            }
            int orderId = orderKeys.getInt(1);

            // Insert into order_details table
            String orderDetailsSQL = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement orderDetailsStmt = connection.prepareStatement(orderDetailsSQL);

            for (Map.Entry<Integer, Map<String, Object>> entry : cart.entrySet()) {
                int productId = entry.getKey();
                Map<String, Object> productDetails = entry.getValue();
                int quantity = (int) productDetails.get("quantity");
                double price = (double) productDetails.get("price");

                orderDetailsStmt.setInt(1, orderId);
                orderDetailsStmt.setInt(2, productId);
                orderDetailsStmt.setInt(3, quantity);
                orderDetailsStmt.setDouble(4, price);
                orderDetailsStmt.addBatch();
            }
            orderDetailsStmt.executeBatch();

            connection.commit();

            // Clear the cart
            session.removeAttribute("cart");

            resp.sendRedirect("order-confirmation.jsp?success=Order placed successfully.");
        } catch (SQLException e) {
            throw new ServletException("Order placement failed", e);
        }
    }
}