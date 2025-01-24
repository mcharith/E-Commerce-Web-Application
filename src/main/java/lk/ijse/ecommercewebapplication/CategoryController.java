package lk.ijse.ecommercewebapplication;

import com.google.gson.Gson;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.json.Json;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CategoryController", value = "/CategoryController")
public class CategoryController extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement("SELECT id, name FROM categories")) {

            ResultSet rs = ps.executeQuery();
            List<Map<String, Object>> categories = new ArrayList<>();
            while (rs.next()) {
                Map<String, Object> category = new HashMap<>();
                category.put("id", rs.getInt("id"));
                category.put("name", rs.getString("name"));
                categories.add(category);
            }
            resp.setContentType("application/json");
            resp.getWriter().write(new Gson().toJson(categories));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
