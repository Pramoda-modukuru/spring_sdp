<%@ page import="java.sql.*" %>
<%
    String requestTitle = request.getParameter("requestTitle");
    String description = request.getParameter("description");

    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
        String query = "INSERT INTO portal_requests (college_id, title, description) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, (Integer) session.getAttribute("college_id")); // Replace with session variable
        ps.setString(2, requestTitle);
        ps.setString(3, description);
        ps.executeUpdate();
        response.sendRedirect("collegeHome.jsp");
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
