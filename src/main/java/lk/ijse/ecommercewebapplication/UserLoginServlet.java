package lk.ijse.ecommercewebapplication;

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
import java.sql.ResultSet;

@WebServlet(name = "UserLoginServlet", value = "/user-loginpage")
public class UserLoginServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("user_email");
        String password = req.getParameter("user_password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            resp.sendRedirect("user-loginpage.jsp?error=Email or password cannot be empty");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet resultSet = ps.executeQuery();
            if (resultSet.next()) {
                String dbPassword = resultSet.getString("password");
                if (BCrypt.checkpw(password, dbPassword)) {
                    // Store user info in session
                    req.getSession().setAttribute("user", resultSet.getString("username")); // Assume "name" is a column in the "users" table
                    req.getSession().setAttribute("email", email);

                    // Redirect to user detail page
                    resp.sendRedirect("index.jsp");
                } else {
                    resp.sendRedirect("user-loginpage.jsp?error=Invalid email or password");
                }
            } else {
                resp.sendRedirect("user-loginpage.jsp?error=Invalid email or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("user-loginpage.jsp?error=An error occurred while processing your request");
        }
    }
}
