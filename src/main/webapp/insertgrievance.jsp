<%@ page import="java.sql.*"%>
<%

String fullname = (String)session.getAttribute("fullname");
String email = (String)session.getAttribute("email");
String subject = request.getParameter("subject");
String description = request.getParameter("description");

try {
    Connection con = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
    
    String qry = "INSERT INTO grievances (fullname, email, subject, description) VALUES (?, ?, ?, ?)";
    PreparedStatement pstmt = con.prepareStatement(qry);
    pstmt.setString(1, fullname);
    pstmt.setString(2, email);
    pstmt.setString(3, subject);
    pstmt.setString(4, description);
    pstmt.executeUpdate();
    
    con.close();
    response.sendRedirect("userhome.jsp");
} catch(Exception e) {
    out.println(e);
}
%>
