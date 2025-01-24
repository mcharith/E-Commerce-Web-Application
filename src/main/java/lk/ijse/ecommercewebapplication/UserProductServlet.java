package lk.ijse.ecommercewebapplication;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "UserProductServlet", value = "/user-product")
public class UserProductServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT id, name, description, price, image FROM products";
            try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
                PrintWriter out = resp.getWriter();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    double price = rs.getDouble("price");
                    byte[] imageBytes = rs.getBytes("image");

                    String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);

                    out.println("<div class='col-md-4 mb-4'>");
                    out.println("<div class='card shadow-sm'>");
                    out.println("<img src='data:image/jpeg;base64," + base64Image + "' class='card-img-top' alt='" + name + "'>");
                    out.println("<div class='card-body'>");
                    out.println("<h5 class='card-title'>" + name + "</h5>");
                    out.println("<p class='card-text'>" + description + "</p>");
                    out.println("<p class='card-text'>Price: $" + price + "</p>");
                    out.println("<button class='btn btn-primary w-100'>Add to Cart</button>");
                    out.println("</div></div></div>");
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
