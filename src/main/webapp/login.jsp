<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <h1>Login User</h1><br>
        <div class="row">
            <div class="col-sm-4">
                <form method="post" action="LoginServlet">
                    <%
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                        <p style="color:red;"><%= error %></p>
                    <%
                        }
                    %>
                    <div align="left">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" placeholder="Username"
                               name="username" id="username" required>
                    </div>
                    <div align="left">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" placeholder="Password"
                               name="password" id="password" required>
                    </div>
                    </br>
                    <div align="right">
                        <input type="submit" id="submit" value="Login" name="submit" class="btn btn-info">
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>