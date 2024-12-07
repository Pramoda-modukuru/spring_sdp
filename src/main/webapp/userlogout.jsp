<%
session.removeAttribute("fullname");
session.removeAttribute("contact");
session.removeAttribute("email");
//session.invalidate(); removes all session attributes
response.sendRedirect("userlogin.html");
%>