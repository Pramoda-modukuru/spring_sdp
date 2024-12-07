<%@ page import="java.sql.*" %>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");

if (username != null && password != null) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM user WHERE username='" + username + "' AND password='" + password + "' AND role='admin'");
        if (rs.next()) {
            session.setAttribute("adminname", rs.getString("fullname"));
            response.sendRedirect("adminhome.jsp");
        } else {
            out.println("Invalid username or password!");
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>
<html>
<head>
<title>Admin Login</title>
</head>
<body bgcolor="lightgrey">
<h1 align="center">Admin Login</h1>
<hr color="black"><hr color="black"><br>
<form method="post" action="adminlogin.jsp">
    Username: <input type="text" name="username"><br>
    Password: <input type="password" name="password"><br>
    <input type="submit" value="Login">
</form>
</body>
</html>
