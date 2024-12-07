<%@ page import="java.sql.*" %>
<%
    String role = "college";
    String collegename = (String) session.getAttribute("collegename");

    // If not logged in as College, redirect to unauthorized access page
    if (collegename == null || !"college".equals(role)) {
        response.sendRedirect("unauthorizedAccess.jsp");
    }
%>

<html>
<head>
    <title>College Homepage</title>
</head>
<body bgcolor="lightgrey">
    <h1 align="center">Welcome, <%= collegename %>!</h1>
    <h2 align="center">College Dashboard</h2>
    <hr color="black"><hr color="black">
    <ul>
        <li><a href="sendPortalRequest.jsp">Send Portal Request</a></li>
        <li><a href="trackStudentAchievements.jsp">Track Student Achievements</a></li>
        <li><a href="collegeEventHistory.jsp">View Event Participation History</a></li>
        <li><a href="suggestCollegeEvents.jsp">View Event Suggestions</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</body>
</html>
