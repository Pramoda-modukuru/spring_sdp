<%!
//variables
int a=20,b=30;
//method
public int add(int x,int y)
{
	return x+y;
}
%>
<%
System.out.println("Output="+add(a,b)); // console
out.println("Output="+add(a,b)); // implicit object - browser
%>
<b>Output:<%=a%></b>


