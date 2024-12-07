<%@ page import="java.sql.*" %>
<%
String adminname = (String) session.getAttribute("adminname");
if (adminname == null) {
    response.sendRedirect("sessionexpiry.html");
}

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM users");
%>
<html>
<head>
<title>Manage Users</title>
</head>
<body bgcolor="lightgrey">
<h1 align="center">Manage Users</h1>
<hr color="black"><hr color="black"><br>
<a href="adminhome.jsp">Home</a>&nbsp;&nbsp;&nbsp;
<a href="adminlogout.jsp">Logout</a>&nbsp;&nbsp;&nbsp;
<br>
<table border="1" align="center">
    <tr>
        <th>Username</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Contact</th>
        <th>Role</th>
        <th>Action</th>
    </tr>
    <%
    while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("fullname") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("contact") %></td>
        <td><%= rs.getString("role") %></td>
        <td><a href="edituser.jsp?username=<%= rs.getString("username") %>">Edit</a> | <a href="deleteuser.jsp?username=<%= rs.getString("username") %>">Delete</a></td>
    </tr>
    <%
    }
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
</table>
</body>
</html>
