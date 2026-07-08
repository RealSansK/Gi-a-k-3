<%-- 
    Document   : logout
    Created on : Jul 4, 2026
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Đăng xuất người dùng
    session.invalidate();
    
    // Về trang đăng nhập
    response.sendRedirect("login.jsp");
%>