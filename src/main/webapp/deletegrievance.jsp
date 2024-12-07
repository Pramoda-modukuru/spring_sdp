<%@ page import="java.sql.*"%>
<%
String role = (String)session.getAttribute("role");
if(role == null || !role.equals("admin")) {
    response.sendRedirect("sessionexpiry.html");
    return;
}

int id = Integer.parseInt(request.getParameter("id"));

try {
    Connection con = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    PreparedStatement pstmt = con.prepareStatement("DELETE FROM grievances WHERE id=?");
    pstmt.setInt(1, id);
    pstmt.executeUpdate();
    con.close();

    response.sendRedirect("adminhome.jsp");
} catch(Exception e) {
    out.println(e);
}
%>
