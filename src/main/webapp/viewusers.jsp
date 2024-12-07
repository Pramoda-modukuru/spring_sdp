<%@ page import="java.sql.*"%>
<%@ include file="adminnavbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Registered Users</title>
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
        <section class="user-table">
            <h3><u>View Registered Users</u></h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Gender</th>
                        <th>Date of Birth</th>
                        <th>Marital Status</th>
                        <th>Email ID</th>
                        <th>Contact No</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Connection con = null;
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

                        PreparedStatement pstmt = con.prepareStatement("select * from user WHERE role != 'admin'");
                        ResultSet rs = pstmt.executeQuery();

                        while(rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("fullname") %></td>
                        <td><%= rs.getString("gender") %></td>
                        <td><%= rs.getString("dob") %></td>
                        <td><%= rs.getString("maritalstatus") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("contactno") %></td>
                    </tr>
                    <%
                        }
                        con.close();
                    } catch(Exception e) {
                        out.println(e);
                    }
                    %>
                </tbody>
            </table>
        </section>
    </main>
</body>
</html>
