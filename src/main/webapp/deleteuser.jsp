<%@ page import="java.sql.*"%>
<%@ include file="adminnavbar.jsp" %>
<%
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    pstmt = con.prepareStatement("select * from user WHERE role != 'admin'");
    rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete User</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
        <style>
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
    z-index: 1;
}

header::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.3);
    z-index: -1;
}

header h1 {
    margin: 0;
    font-size: 2.5em;
    color: #fff;
    letter-spacing: 2px;
    text-transform: uppercase;
}

nav {
    margin-top: 10px;
}

nav a {
    color: #fff;
    text-decoration: none;
    font-size: 1.1em;
    margin: 0 15px;
    padding: 8px 15px;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

nav a:hover {
    background-color: rgba(255, 255, 255, 0.3);
    transform: scale(1.1);
}

.main-content {
    text-align: center;
    padding: 40px;
    background: linear-gradient(135deg, #1f1f2e, #3a3a5a);
    border-radius: 15px;
    max-width: 1000px;
    margin: 30px auto;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
}

.main-content h2 {
    font-size: 2.5em;
    color: #fc5c7d;
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    background-color: #fc5c7d; /* Updated to solid pink color */
    border-radius: 10px;
    overflow: hidden;
}

th, td {
    padding: 10px;
    text-align: center;
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    color:#000;
}

th {
    background-color: #fc5c7d; /* Updated to solid pink color */
    color: #000;
    font-size: 1.1em;
}

td {
    color: #000;
}

tr:hover {
    background-color: rgba(255, 255, 255, 0.1);
}

footer {
    text-align: center;
    padding: 20px;
    background-color: #0d0d0d;
    color: #fff;
    margin-top: 50px;
}

footer p {
    font-size: 1.1em;
}
    </style>
</head>
<body>
    <main>
        <section class="delete-user">
            <h3><u>Delete User</u></h3>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Gender</th>
                    <th>Date of Birth</th>
                    <th>Marital Status</th>
                    <th>Email ID</th>
                    <th>Contact No</th>
                    <th>Action</th>
                </tr>
                <%
                while(rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt(1) %></td>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getString(4) %></td>
                    <td><%= rs.getString(5) %></td>
                    <td><%= rs.getString(6) %></td>
                    <td><%= rs.getString(8) %></td>
                    <td><a href="userdeletion.jsp?id=<%= rs.getInt(1) %>">Delete</a></td>
                </tr>
                <%
                }
                %>
            </table>
        </section>
    </main>
</body>
</html>
<%
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    try {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    } catch(SQLException e) {
        out.println("Error closing resources: " + e.getMessage());
    }
}
%>
