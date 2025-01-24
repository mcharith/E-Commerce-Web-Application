package lk.ijse.ecommercewebapplication.admin;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "ImageServlet", value = "/image")
public class ImageServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("id");

        if (productId == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing.");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT description FROM products WHERE id = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(productId));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        byte[] imageBytes = rs.getBytes("description");
                        resp.setContentType("image/jpeg");
                        OutputStream out = resp.getOutputStream();
                        out.write(imageBytes);
                        out.close();
                    } else {
                        resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found for product ID: " + productId);
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error retrieving image", e);
        }
    }
}