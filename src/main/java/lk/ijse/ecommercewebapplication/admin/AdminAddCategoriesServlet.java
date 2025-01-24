package lk.ijse.ecommercewebapplication.admin;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommercewebapplication.dto.categoriesDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AdminAddCategoriesServlet", value = "/admin-categories")
public class AdminAddCategoriesServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("categories_name");
        String description = req.getParameter("categories_description");

        if (name == null || name.isEmpty() || description == null || description.isEmpty()) {
            resp.sendRedirect("admin-categories.jsp?error=Invalid input. Please provide all required fields.");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, description);

                int affectedRows = ps.executeUpdate();
                if (affectedRows > 0) {
                    resp.sendRedirect("admin-categories.jsp?message=Category added successfully.");
                } else {
                    resp.sendRedirect("admin-categories.jsp?error=Failed to add category.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("admin-categories.jsp?error=Database error occurred.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {
        List<categoriesDTO> categoriesDTOList = new ArrayList<>();
        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM categories";
            try (Statement statement = connection.createStatement();
                 ResultSet resultSet = statement.executeQuery(sql)) {

                while (resultSet.next()) {
                    categoriesDTO category = new categoriesDTO(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("description")
                    );
                    categoriesDTOList.add(category);
                }
            }

            req.setAttribute("categories", categoriesDTOList);
            RequestDispatcher dispatcher = req.getRequestDispatcher("admin-categories.jsp");
            dispatcher.forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("admin-categories.jsp?error=Failed to fetch categories.");
        }
    }
}