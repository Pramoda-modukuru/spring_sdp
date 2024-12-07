<%@ page import="java.sql.*"%>
<%

String email = request.getParameter("email");
String pwd  = request.getParameter("pwd");

try
{
    Connection con = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    System.out.println("Driver Class Loaded");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
    System.out.println("Connection Established");
    
    String qry = "select * from user where email=? and password=? ";
    PreparedStatement pstmt = con.prepareStatement(qry);
    pstmt.setString(1, email);
    pstmt.setString(2, pwd);
    ResultSet rs = pstmt.executeQuery();
    if(rs.next())
    {
        //out.println("login success");
        
        String fullname = rs.getString("fullname");
        String contact = rs.getString("contactno");
        String role = rs.getString("role");
        
        //session variables
        session.setAttribute("fullname", fullname);
        session.setAttribute("contact", contact);
        session.setAttribute("email", email);
        session.setAttribute("role", role);
        
        session.setMaxInactiveInterval(300); // 5 minutes
        
        if(role.equalsIgnoreCase("admin")) {
            response.sendRedirect("adminhome.jsp");
        }
        else if ("college".equalsIgnoreCase(role)) {
            // Define the specific functionality or redirections for the college role
            response.sendRedirect("collegeDashboard.jsp");
        }
        else {
            response.sendRedirect("userhome.jsp");
        }
        
    }
    else
    {
        //out.println("login failed");
        response.sendRedirect("loginfail.html");
    }
}
catch(Exception e)
{
   out.println(e);	
}
%>
