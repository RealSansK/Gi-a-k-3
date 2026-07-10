package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.PasswordUtil;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String error = null;

        // ===== Kiểm tra tính đúng đắn của dữ liệu (validate phía server) =====
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            error = "Vui lòng nhập đầy đủ tài khoản và mật khẩu!";
        } else if (username.trim().length() < 3) {
            error = "Tài khoản phải có ít nhất 3 ký tự!";
        } else if (password.length() < 6) {
            error = "Mật khẩu phải có ít nhất 6 ký tự!";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        // ======================================================================

        username = username.trim();
        String hashedPassword = PasswordUtil.hash(password);

        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost/schooll?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC",
                    "root", "")) {
                String sql = "select * from users where username=? and password=?";
                try (PreparedStatement pst = con.prepareStatement(sql)) {
                    pst.setString(1, username);
                    pst.setString(2, hashedPassword);
                    try (ResultSet rs = pst.executeQuery()) {
                        if (rs.next()) {
                            HttpSession session = request.getSession();
                            session.setAttribute("username", username);
                            response.sendRedirect("index.jsp");
                            return;
                        } else {
                            error = "Sai tài khoản hoặc mật khẩu!";
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            error = "Lỗi hệ thống: " + e.getMessage();
        }

        request.setAttribute("error", error);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
