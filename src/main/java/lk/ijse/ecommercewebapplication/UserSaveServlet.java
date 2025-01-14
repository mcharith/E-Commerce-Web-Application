package lk.ijse.ecommercewebapplication;



import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.json.JsonReader;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "UserSaveServlet", value = "/user-save")
public class UserSaveServlet extends HttpServlet {
    String DB_URL = "jdbc:mysql://localhost:3306/ecommerce";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//            String username = req.getParameter("user_name");
//            String email = req.getParameter("user_email");
//            String password = req.getParameter("user_password");
//            String role = req.getParameter("user_role");
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
//
//            String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
//            PreparedStatement pstm = connection.prepareStatement(sql);
//            pstm.setString(1, username);
//            pstm.setString(2, email);
//            pstm.setString(3, password);
//            pstm.setString(4, role);
//
//            int effectedRowCount = pstm.executeUpdate();
//
//            if (effectedRowCount > 0) {
//                resp.sendRedirect("user-save.jsp?message= User Saved Successfully!");
//            }else {
//                resp.sendRedirect("user-save.jsp?error= User Save Failed!");
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            resp.sendRedirect("user-save.jsp?message= User Save Failed!");
//        }
//    }


    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;
//
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection connection = dataSource.getConnection()) {
//            JsonReader jsonReader = Json.createReader(req.getReader());
//            JsonObject jsonObject = jsonReader.readObject();
//
//            if (!jsonObject.containsKey("user_name") || !jsonObject.containsKey("user_email") ||
//                    !jsonObject.containsKey("user_password") || !jsonObject.containsKey("user_role")) {
//                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//                sendErrorResponse(resp, "Invalid input data.");
//                return;
//            }

            String username = req. getParameter ("user_name");
            String email = req. getParameter ("user_email");
            String password = req. getParameter ("user_password") ;
            String role = req. getParameter ("user_role");


            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
            try (PreparedStatement pst = connection.prepareStatement(sql)) {
                pst.setString(1, username);
                pst.setString(2, email);
                pst.setString(3, hashedPassword);
                pst.setString(4, role);

                int affectedRows = pst.executeUpdate();
//                resp.setContentType("application/json");
//                resp.setStatus(HttpServletResponse.SC_CREATED);
//
//                JsonObjectBuilder responseBuilder = Json.createObjectBuilder();
//                responseBuilder.add("status", "success");
//                responseBuilder.add("message", "User saved successfully.");
//                resp.getWriter().write(responseBuilder.build().toString());

                if (affectedRows > 0) {
                    resp.sendRedirect("user-save.jsp?message= User Saved Successfully!");
                }else {
                    resp.sendRedirect("user-save.jsp?error= User Save Failed!");
                }
            } catch (Exception e) {
                e.printStackTrace();
//                sendErrorResponse(resp, "Database error: " + e.getMessage());
                resp.sendRedirect("user-save.jsp?message= User Save Failed!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
//            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//            sendErrorResponse(resp, "Failed to establish database connection.");
        }
    }

    private void sendErrorResponse(HttpServletResponse resp, String message) throws IOException {
        JsonObjectBuilder responseBuilder = Json.createObjectBuilder();
        responseBuilder.add("status", "error");
        responseBuilder.add("message", message);

        resp.setContentType("application/json");
        resp.getWriter().write(responseBuilder.build().toString());
    }
}
