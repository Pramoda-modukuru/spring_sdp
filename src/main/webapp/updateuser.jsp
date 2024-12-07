<%@ page import="java.sql.*" %>
<%@ include file="adminnavbar.jsp" %>
<%
    // Retrieve parameters from the request
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String pwd = request.getParameter("pwd");

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        System.out.println("Driver Class Loaded");

        // Establish a connection to the database
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
        System.out.println("Connection Established");

        String sql = "UPDATE user SET fullname = ?, email = ?, password = ? WHERE id = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, pwd);
        pstmt.setInt(4, id);

        int rowsUpdated = pstmt.executeUpdate();

        if (rowsUpdated > 0) {
            response.sendRedirect("updateSuccess.html");
        } else {
            out.println("User not found or no update needed.");
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
