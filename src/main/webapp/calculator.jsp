<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String v1=request.getParameter("v1");
int a=Integer.parseInt(v1);
String v2=request.getParameter("v2");
int b=Integer.parseInt(v2);

String op=request.getParameter("op");
if(op.equals("add"))
{
	out.println("Output="+(a+b));
}
if(op.equals("sub"))
{
	out.println("Output="+(a-b));
}

%>