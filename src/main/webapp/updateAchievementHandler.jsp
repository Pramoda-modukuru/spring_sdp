<%@ page import="java.sql.*" %>
<%
String email = (String) session.getAttribute("email");
if (email == null) {
    response.sendRedirect("login.jsp");
}

Connection con = null;
PreparedStatement pstmt = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    String query = "UPDATE achievements SET description = ?, date = ? WHERE id = ? AND id IN (SELECT id FROM user WHERE email = ?)";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, request.getParameter("description"));
    pstmt.setString(2, request.getParameter("date"));
    pstmt.setInt(3, Integer.parseInt(request.getParameter("id")));
    pstmt.setString(4, email);

    int rows = pstmt.executeUpdate();
    if (rows > 0) {
        response.sendRedirect("viewAchievements.jsp");
    } else {
        out.println("Error: Could not update achievement.");
    }
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
