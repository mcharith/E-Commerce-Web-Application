package lk.ijse.ecommercewebapplication;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import jakarta.annotation.Resource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AddToCartServlet", value = "/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            session.setAttribute("redirectAfterLogin", "add-to-cart");
            resp.sendRedirect("user-loginpage.jsp?error=Please log in to add items to the cart.");
            return;
        }

        int productId = Integer.parseInt(req.getParameter("productId"));
        String productName = req.getParameter("productName");
        double productPrice = Double.parseDouble(req.getParameter("productPrice"));
        int quantity = 1;

        Map<Integer, Map<String, Object>> cart = (Map<Integer, Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        Map<String, Object> productDetails = cart.get(productId);
        if (productDetails != null) {
            int existingQuantity = (int) productDetails.get("quantity");
            productDetails.put("quantity", existingQuantity + 1);
        } else {
            productDetails = new HashMap<>();
            productDetails.put("name", productName);
            productDetails.put("price", productPrice);
            productDetails.put("quantity", quantity);
            cart.put(productId, productDetails);
        }

        session.setAttribute("cart", cart);

        resp.sendRedirect("user-product.jsp?success=Product added to cart successfully.");
    }
}