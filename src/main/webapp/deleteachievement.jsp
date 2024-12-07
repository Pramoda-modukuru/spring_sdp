<%@ page import="java.sql.*" %>
<%@ include file="adminnavbar.jsp" %>
<%
String id = request.getParameter("id");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    String query = "DELETE FROM achievements WHERE id = ?";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setInt(1, Integer.parseInt(id));
    int rowCount = pstmt.executeUpdate();

    if (rowCount > 0) {
        response.sendRedirect("adminhome.jsp");
    } 
    else
    {
        out.println("Failed to delete achievement.");
    }

    pstmt.close();
    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
