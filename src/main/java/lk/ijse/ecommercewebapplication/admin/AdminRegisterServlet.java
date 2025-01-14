package lk.ijse.ecommercewebapplication.admin;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "AdminRegisterServlet", value = "/admin-register")
public class AdminRegisterServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = dataSource.getConnection()) {
            String username = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");
            String role = request.getParameter("user_role");

            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
            try (PreparedStatement pstm = connection.prepareStatement(sql)) {
                pstm.setString(1, username);
                pstm.setString(2, email);
                pstm.setString(3, hashedPassword);
                pstm.setString(4, role);

                int affectedRows = pstm.executeUpdate();
                if (affectedRows > 0) {
                    response.sendRedirect("admin-register.jsp?message=Administrator Registration Successful");
                } else {
                    response.sendRedirect("admin-register.jsp?error=Administrator Registration Failed");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("admin-register.jsp?error=Error occurred during registration");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin-register.jsp?error=Database connection error");
        }
    }
}