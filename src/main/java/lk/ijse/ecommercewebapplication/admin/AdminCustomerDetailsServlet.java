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

@WebServlet(name = "AdminCustomerDetailsServlet", value = "/admin-customer-details")
public class AdminCustomerDetailsServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if (action == null || id == null) {
            resp.sendRedirect("admin-customer-details.jsp");
            return;
        }

        boolean activate = action.equals("activate");
        try (Connection connection = dataSource.getConnection()) {
            String query = "UPDATE users SET status = ? WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setBoolean(1, activate);
                statement.setInt(2, Integer.parseInt(id));
                statement.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("admin-customer-details.jsp");
    }
}