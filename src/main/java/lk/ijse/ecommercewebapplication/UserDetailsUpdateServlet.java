package lk.ijse.ecommercewebapplication;

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
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "UserDetailsUpdateServlet", value = "/user-detail-update")
public class UserDetailsUpdateServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String newName = req.getParameter("newName");
        String newPassword = req.getParameter("newPassword");
        String userEmail = (String) req.getSession().getAttribute("email");

        if (newName == null || newPassword == null || userEmail == null || newName.isEmpty() || newPassword.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input data.");
            return;
        }

        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        try (Connection connection = dataSource.getConnection()) {
            String sql = "UPDATE users SET username = ?, password = ? WHERE email = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, newName);
                preparedStatement.setString(2, hashedPassword);
                preparedStatement.setString(3, userEmail);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    req.getSession().setAttribute("user", newName);
                    resp.sendRedirect("user-details.jsp?success=Details updated successfully!");
                } else {
                    resp.sendRedirect("user-details.jsp?error=Failed to update details. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating details.");
        }
    }
}