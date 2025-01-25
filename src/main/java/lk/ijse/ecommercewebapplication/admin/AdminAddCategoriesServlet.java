package lk.ijse.ecommercewebapplication.admin;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AdminAddCategoriesServlet", value = "/admin-categories")
public class AdminAddCategoriesServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            addCategory(req, resp);
        } else if ("delete".equals(action)) {
            deleteCategory(req, resp);
        } else if ("update".equals(action)) {
            updateCategory(req, resp);
        }
    }

    private void addCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("categories_name");
        String description = req.getParameter("categories_description");

        String insertSql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(insertSql)) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.executeUpdate();
            resp.sendRedirect("admin-categories.jsp?message=Category added successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("admin-categories.jsp?error=Error adding category");
        }
    }

    private void deleteCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));

        String deleteSql = "DELETE FROM categories WHERE id = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(deleteSql)) {
            ps.setInt(1, categoryId);
            ps.executeUpdate();
            resp.sendRedirect("admin-categories.jsp?message=Category deleted successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("admin-categories.jsp?error=Error deleting category");
        }
    }

    private void updateCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        String name = req.getParameter("categories_name");
        String description = req.getParameter("categories_description");

        String updateSql = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(updateSql)) {
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, categoryId);
            ps.executeUpdate();
            resp.sendRedirect("admin-categories.jsp?message=Category updated successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("admin-categories.jsp?error=Error updating category");
        }
    }
}