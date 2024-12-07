<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="navbar.jsp" %>

<%
String fullname = (String)session.getAttribute("fullname");
String email = (String)session.getAttribute("email");
if(fullname == null || email == null) {
    response.sendRedirect("sessionexpiry.html");
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - Extracurricular Management</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        /* General Styles */
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #0d0d0d;
            color: #fff;
            overflow-x: hidden;
        }

        header {
            background: linear-gradient(135deg, #6a82fb, #fc5c7d);
            padding: 20px 0;
            text-align: center;
            position: relative;
        }
        header h1 {
            margin: 0;
            font-size: 2.5em;
            color: #fff;
        }

        .main-content {
            text-align: center;
            padding: 40px;
            background-color: #3a3a5a;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            max-width: 900px;
            margin: 50px auto;
        }

        .main-content h2 {
            font-size: 2em;
            color: #fc5c7d;
        }

        table {
            width: 95%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            background-color: rgba(255, 255, 255, 0.8);
            color: #0d0d0d;
        }

        th {
            background-color: #fc5c7d;
            font-size: 1.2em;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }

        td a {
            color: #0d0d0d;
            background-color: #fc5c7d;
            text-decoration: none;
            padding: 5px 15px;
            border-radius: 5px;
        }

        td a:hover {
            background-color: #ff4770;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <h2>Your Achievements</h2>
        <table>
            <tr>
                <th>Activity Title</th>
                <th>Date</th>
                <th>Status</th>
                <th>Certificate</th>
            </tr>

            <%
            try {
                String query = "SELECT * FROM std_ach WHERE student_email = ?";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();

                while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("achievement_title") %></td>
                <td><%= rs.getString("date") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <%
                    if("active".equals(rs.getString("status"))) {
                    %>
                    <a href="downloadCertificate.jsp?id=<%= rs.getInt("id") %>">Download Certificate</a>
                    <%
                    } else {
                    %>
                    <span>Not Active</span>
                    <%
                    }
                    %>
                </td>
            </tr>
            <% 
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            }
            %>
        </table>
    </div>
</body>
</html>
