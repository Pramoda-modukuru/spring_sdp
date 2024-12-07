<%@ page import="java.sql.*"%>
<%
String role = (String)session.getAttribute("role");
if(role == null || !role.equals("admin")) {
    response.sendRedirect("sessionexpiry.html");
    return;
}

int id = Integer.parseInt(request.getParameter("id"));
String status = "";
String subject = "";
String description = "";

if (request.getMethod().equalsIgnoreCase("POST")) {
    status = request.getParameter("status");
    subject = request.getParameter("subject");
    description = request.getParameter("description");

    try {
        Connection con = null;
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

        PreparedStatement pstmt = con.prepareStatement("UPDATE grievances SET status=?, subject=?, description=? WHERE id=?");
        pstmt.setString(1, status);
        pstmt.setString(2, subject);
        pstmt.setString(3, description);
        pstmt.setInt(4, id);
        pstmt.executeUpdate();
        con.close();

        response.sendRedirect("adminhome.jsp");
    } catch(Exception e) {
        out.println(e);
    }
} else {
    try {
        Connection con = null;
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

        PreparedStatement pstmt = con.prepareStatement("SELECT * FROM grievances WHERE id=?");
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();

        if(rs.next()) {
            status = rs.getString("status");
            subject = rs.getString("subject");
            description = rs.getString("description");
        }
        con.close();
    } catch(Exception e) {
        out.println(e);
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Update Grievance</title>
 <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body bgcolor="lightgrey">
<h1 align="center">Update Grievance</h1>
<hr color="black"><hr color="black"><br>
<a href="adminhome.jsp">Home</a>&nbsp;&nbsp;&nbsp;
<a href="userlogout.jsp">Logout</a>&nbsp;&nbsp;&nbsp;
<br>
<form method="post" action="updategrievance.jsp?id=<%= id %>">
<table align="center">
    <tr>
        <td>ID</td>
        <td><%= id %></td>
    </tr>
    <tr>
        <td>Status</td>
        <td>
            <select name="status" required>
                <option value="Pending" <%= status.equals("Pending") ? "selected" : "" %>>Pending</option>
                <option value="Resolved" <%= status.equals("Resolved") ? "selected" : "" %>>Resolved</option>
                <option value="Rejected" <%= status.equals("Rejected") ? "selected" : "" %>>Rejected</option>
            </select>
        </td>
    </tr>
    <tr>
        <td>Subject</td>
        <td><input type="text" name="subject" value="<%= subject %>" required></td>
    </tr>
    <tr>
        <td>Description</td>
        <td><textarea name="description" required><%= description %></textarea></td>
    </tr>
    <tr>
        <td colspan="2" align="center"><input type="submit" value="Update"></td>
    </tr>
</table>
</form>
</body>
</html>
