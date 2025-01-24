package lk.ijse.ecommercewebapplication;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "ProductController", value = "/ProductController")
public class ProductController extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String category = req.getParameter("category");
        String search = req.getParameter("search");
        String sort = req.getParameter("sort");

        String query = "SELECT p.id, p.name, p.description, p.price, c.name AS category_name FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.id WHERE 1=1";

        if (category != null && !"all".equals(category)) {
            query += " AND p.category_id = ?";
        }
        if (search != null && !search.isEmpty()) {
            query += " AND p.name LIKE ?";
        }
        if ("asc".equals(sort)) {
            query += " ORDER BY p.price ASC";
        } else if ("desc".equals(sort)) {
            query += " ORDER BY p.price DESC";
        }

        try (Connection connection = dataSource.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            int paramIndex = 1;
            if (category != null && !"all".equals(category)) {
                ps.setInt(paramIndex++, Integer.parseInt(category));
            }
            if (search != null && !search.isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();
            PrintWriter out = resp.getWriter();

            while (rs.next()) {
                out.println("<div class='col-md-4 mb-3'>");
                out.println("<div class='card shadow-sm'>");
                out.println("<img src='image?id=" + rs.getInt("id") + "' class='card-img-top' alt='" + rs.getString("name") + "'>");
                out.println("<div class='card-body text-center'>");
                out.println("<h5 class='card-title'>" + rs.getString("name") + "</h5>");
                out.println("<p class='card-text'>Price: $" + rs.getBigDecimal("price") + "</p>");
                out.println("<button class='btn btn-add-to-cart w-100 mb-2'>Add to Cart</button>");
                out.println("<button class='btn btn-buy-now w-100'>Buy Now</button>");
                out.println("</div></div></div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}