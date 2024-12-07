<%@ page import="java.sql.*"%>
<%
String role = (String)session.getAttribute("role");
if(role == null || !role.equals("admin")) {
    response.sendRedirect("sessionexpiry.html");
    return;
}

int id = Integer.parseInt(request.getParameter("id"));
%>
<!DOCTYPE html>
<html>
<head>
<title>View Grievance</title>
 <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body bgcolor="lightgrey">
<h1 align="center">Grievance Details</h1>
<hr color="black"><hr color="black"><br>
<a href="adminhome.jsp">Home</a>&nbsp;&nbsp;&nbsp;
<a href="userlogout.jsp">Logout</a>&nbsp;&nbsp;&nbsp;
<br>
<%
try {
    Connection con = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    PreparedStatement pstmt = con.prepareStatement("SELECT * FROM grievances WHERE id=?");
    pstmt.setInt(1, id);
    ResultSet rs = pstmt.executeQuery();

    if(rs.next()) {
%>
<table align="center" border="1">
    <tr><td>ID</td><td><%= rs.getInt("id") %></td></tr>
    <tr><td>Full Name</td><td><%= rs.getString("fullname") %></td></tr>
    <tr><td>Email</td><td><%= rs.getString("email") %></td></tr>
    <tr><td>Subject</td><td><%= rs.getString("subject") %></td></tr>
    <tr><td>Description</td><td><%= rs.getString("description") %></td></tr>
    <tr><td>Status</td><td><%= rs.getString("status") %></td></tr>
</table>
<%
    } else {
%>
<p>No grievance found with ID <%= id %></p>
<%
    }
    con.close();
} catch(Exception e) {
    out.println(e);
}
%>
</body>
</html>
