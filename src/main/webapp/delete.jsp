<%-- 
    Document   : delete
    Created on : Jul 1, 2026, 3:00:12 PM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%-- khai bao ket noi--%>
<%@page import="java.sql.*"%>
<%
    // doc cac du lieu duoc nhap vao
    String id=request.getParameter("id");
    // Khai bao ket noi va chuan bi mau syntax de add du lieu vao database
    Connection con;
    PreparedStatement pst;
    // Tao ket noi va add du lieu vao data base
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost/schooll?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC","root","");
    pst=con.prepareStatement("delete from records where id = ?");
    pst.setString(1, id);
    // Update database
    pst.executeUpdate();
    pst.close();
    con.close();
%>
<%-- Tao thong bao khi xoa thanh cong --%>
<script>
    alert("Delete Successful!");
    window.location.href = "index.jsp";
</script>