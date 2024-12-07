<%@ page import="java.sql.*" %>
<%
String email = request.getParameter("email");
String description = request.getParameter("description");
String dateAchieved = request.getParameter("date_achieved");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    String query = "INSERT INTO achievements (student_id, description, date_achieved) " +
                   "VALUES ((SELECT id FROM students WHERE email = ?), ?, ?)";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1, email);
    pstmt.setString(2, description);
    pstmt.setString(3, dateAchieved);

    int rowCount = pstmt.executeUpdate();
    if (rowCount > 0) {
        response.sendRedirect("adminhome.jsp");
    } else {
        out.println("Failed to add achievement. Student email not found.");
    }

    pstmt.close();
    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
