<%@ page import="java.sql.*" %>
<%
String email = (String) session.getAttribute("email");
if (email == null) {
    response.sendRedirect("login.jsp");
}

int activityId = Integer.parseInt(request.getParameter("id"));
Connection con = null;
PreparedStatement pstmt = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    String deleteQuery = "DELETE FROM achievements WHERE id = ?";
    pstmt = con.prepareStatement(deleteQuery);
    pstmt.setInt(1, activityId);
    int rowsDeleted = pstmt.executeUpdate();

    if (rowsDeleted > 0) {
        out.println("<p>Activity deleted successfully.</p>");
    } else {
        out.println("<p>Error: Activity not found or could not be deleted.</p>");
    }
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if (pstmt != null) pstmt.close();
    if (con != null) con.close();
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Activity</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <header>
        <h1>Delete Activity</h1>
    </header>
    <main>
        <p><a href="adminhome.jsp">Return to Dashboard</a></p>
    </main>
</body>
</html>
