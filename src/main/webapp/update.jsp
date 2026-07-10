<%-- 
    Document   : update
    Created on : Jul 1, 2026, 3:00:31 PM
    Author     : Admin
--%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    request.setCharacterEncoding("UTF-8");
    if(request.getParameter("submit")!=null){
        String id=request.getParameter("id");
        String name = request.getParameter("sname");
        String course= request.getParameter("course");
        String fee= request.getParameter("fee");
        Connection con;
        PreparedStatement pst;
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection("jdbc:mysql://localhost/schooll?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC","root","");
        pst=con.prepareStatement("update records set strname = ?, course = ?, fee = ? where id = ?");
        pst.setString(1, name);
        pst.setString(2, course);
        pst.setString(3, fee);
        pst.setString(4, id);
        pst.executeUpdate();
        pst.close();
        con.close();
    %>
    <script>
        alert("Update Successful!");
    </script>
    <%
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="row">
            <div class="col-sm-4">
                <form method="post" action="#">
                    <%
                        Connection con2;
                        PreparedStatement pst2;
                        ResultSet rs;
                        Class.forName("com.mysql.jdbc.Driver");
                        con2=DriverManager.getConnection("jdbc:mysql://localhost/schooll?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC","root","");
                        String id=request.getParameter("id");
                        pst2=con2.prepareStatement("select * from records where id = ?");
                        pst2.setString(1,id);
                        rs=pst2.executeQuery();
                        while(rs.next()){
                    %>
                    <div align="left">
                        <label class="form-label">Student name</label>
                        <input type="text" class="form-control" placeholder="Student name"
                            value="<%=rs.getString("strname")%>"   name="sname" id="sname" required>
                    </div>
                    <div align="left">
                        <label class="form-label">Course</label>
                        <input type="text" class="form-control" placeholder="Course"
                            value="<%=rs.getString("course")%>"   name="course" id="course" required>
                    </div>
                    
                    <div align="left">
                        <label class="form-label">Fee</label>
                        <input type="number" class="form-control" placeholder="Fee"
                            value="<%=rs.getInt("fee")%>"   name="fee" id="fee" required>
                    </div>
                    <br>
                    <div align="right">
                        <input type="submit" id="submit" value="submit" name="submit" class="btn btn-info">
                        
                        <input type="reset" id="reset" value="reset" name="reset" class="btn btn-warning">
                    </div>
                    <%
                            }
                            rs.close();
                            pst2.close();
                            con2.close();
                    %>
                    <div align="right">
                        <p><a href="index.jsp">Back home</a></p>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
