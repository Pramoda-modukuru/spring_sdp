<%@page import="java.sql.*" %>
<%
//request is implicit object
String name=request.getParameter("name");
String gender=request.getParameter("gender");
String dob=request.getParameter("dob");
String mstatus=request.getParameter("mstatus");
String email=request.getParameter("email");
String pwd=request.getParameter("pwd");
String contact=request.getParameter("contactno");
String role=request.getParameter("role");
%>

<%
try
{
	  Connection con = null;
	  Class.forName("com.mysql.cj.jdbc.Driver");
      System.out.println("Driver Class Loaded");
      con=DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
      System.out.println("Connection Established"); 
      
      PreparedStatement pstmt = con.prepareStatement("insert into user(fullname,gender,dob,maritalstatus,email,password,contactno,role) values(?,?,?,?,?,?,?,?)");
      pstmt.setString(1, name);
      pstmt.setString(2, gender);
      pstmt.setString(3, dob);
      pstmt.setString(4, mstatus);
      pstmt.setString(5, email);
      pstmt.setString(6, pwd);
      pstmt.setString(7, contact);
      pstmt.setString(8, role);
      pstmt.executeUpdate();
      
      if (role.equalsIgnoreCase("admin")) {
          response.sendRedirect("adminlogin.html");
      } else {
          response.sendRedirect("usersuccess.html");
      } 
}
catch(Exception e)
{
	out.println(e); // out is implicit object
}
%>