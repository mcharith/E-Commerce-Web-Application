package lk.ijse.ecommercewebapplication.admin;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "AdminProductServlet", value = "/admin-product")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class AdminProductServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            addProduct(req, resp);
        } else if ("delete".equals(action)) {
            deleteProduct(req, resp);
        } else if ("update".equals(action)) {
            updateProduct(req, resp);
        }
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Part filePart = req.getPart("description");

        try (Connection connection = dataSource.getConnection()) {
            String sql = "INSERT INTO products (name, description, price, quantity, category_id) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, name);

                InputStream inputStream = filePart.getInputStream();
                ps.setBlob(2, inputStream);

                ps.setDouble(3, price);
                ps.setInt(4, quantity);
                ps.setInt(5, categoryId);

                ps.executeUpdate();
                resp.sendRedirect("admin-homepage.jsp?message=Product added successfully");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("admin-homepage.jsp?error=Failed to add product");
        }
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("productId");

        if (productId == null || productId.isEmpty()) {
            resp.sendRedirect("admin-homepage.jsp?error=Product ID is required to delete");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "DELETE FROM products WHERE id = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(productId));
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    resp.sendRedirect("admin-homepage.jsp?message=Product deleted successfully");
                } else {
                    resp.sendRedirect("admin-homepage.jsp?error=Product not found");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("admin-homepage.jsp?error=Failed to delete product");
        }
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("productId");
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Part filePart = req.getPart("description");

        if (productId == null || productId.isEmpty()) {
            resp.sendRedirect("admin-homepage.jsp?error=Product ID is required to update");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = filePart != null && filePart.getSize() > 0
                    ? "UPDATE products SET name = ?, description = ?, price = ?, quantity = ?, category_id = ? WHERE id = ?"
                    : "UPDATE products SET name = ?, price = ?, quantity = ?, category_id = ? WHERE id = ?";

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, name);

                if (filePart != null && filePart.getSize() > 0) {
                    InputStream inputStream = filePart.getInputStream();
                    ps.setBlob(2, inputStream);
                    ps.setDouble(3, price);
                    ps.setInt(4, quantity);
                    ps.setInt(5, categoryId);
                    ps.setInt(6, Integer.parseInt(productId));
                } else {
                    ps.setDouble(2, price);
                    ps.setInt(3, quantity);
                    ps.setInt(4, categoryId);
                    ps.setInt(5, Integer.parseInt(productId));
                }

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    resp.sendRedirect("admin-homepage.jsp?message=Product updated successfully");
                } else {
                    resp.sendRedirect("admin-homepage.jsp?error=Failed to update product");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("admin-homepage.jsp?error=Failed to update product");
        }
    }
}