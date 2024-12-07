<%@ page import="java.sql.*" %>
<%
String email = (String) session.getAttribute("email");
if (email == null) {
    response.sendRedirect("login.jsp");
    return;
}

Connection con = null;
PreparedStatement pstmt = null;

try {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Connect to the database
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    // Insert the achievement
    String query = "INSERT INTO std_ach (student_email, achievement_title, description, date, status) VALUES (?, ?, ?, ?, ?)";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, email); // Logged-in user's email
    pstmt.setString(2, request.getParameter("title")); // Achievement title
    pstmt.setString(3, request.getParameter("description")); // Achievement description
    pstmt.setString(4, request.getParameter("date")); // Achievement date
    pstmt.setString(5, "Pending"); // Default status as "Pending"

    int rows = pstmt.executeUpdate();

    if (rows > 0) {
        response.sendRedirect("viewachievements.jsp"); // Redirect to view page
    } else {
        out.println("Error: Could not post achievement.");
    }
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    // Close resources
    if (pstmt != null) {
        try {
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    if (con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>
