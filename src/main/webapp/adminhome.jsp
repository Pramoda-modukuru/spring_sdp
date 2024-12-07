<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="adminnavbar.jsp" %>

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
    <title>Admin Dashboard - Extracurricular Management System</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        /* General Body and Header Styles */
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
        header h1 {
            margin: 0;
            font-size: 2.5em;
            color: #fff;
            letter-spacing: 2px;
            text-transform: uppercase;
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

        /* Main Content Styles */
        .main-content {
            text-align: center;
            padding: 40px;
            background: url('background-image.jpg') center/cover no-repeat, linear-gradient(135deg, #1f1f2e, #3a3a5a);
            border-radius: 15px;
            max-width: 1000px; /* Adjusted width for better readability */
            margin: 30px auto;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }
        .main-content h2 {
            font-size: 2.5em;
            color: #fc5c7d;
            margin-bottom: 20px;
        }

        /* Search and Filter Form */
        form {
            margin: 20px 0;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            background-color: rgba(255, 255, 255, 0.1);
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
        }
        form input, form select {
            padding: 10px;
            font-size: 1em;
            border: none;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            width: 250px;
            transition: transform 0.3s ease;
        }
        form input:focus, form select:focus {
            transform: scale(1.05);
        }
        form button {
            padding: 10px 20px;
            font-size: 1em;
            background-color: #fc5c7d;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        form button:hover {
            background-color: #ff4770;
            transform: scale(1.1);
        }

        /* Table Styles */
        table {
            width: 95%;
            margin: 20px auto;
            border-collapse: collapse;
            background: url('table-background.png') center/cover no-repeat, #fc5c7d;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.5);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            background-color: rgba(255, 255, 255, 0.9);
            color: #0d0d0d;
        }

        th {
            background-color: rgba(252, 92, 125, 0.8);
            color: #fff;
            font-size: 1.2em;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        /* Action Links */
        td a {
            text-decoration: none;
            color: #0d0d0d;
            padding: 5px 15px;
            border-radius: 5px;
            background-color: #fc5c7d;
            transition: background-color 0.3s ease, transform 0.3s ease;
            display: inline-block;
            margin-right: 10px;
        }
        td a:hover {
            background-color: #ff4770;
            transform: scale(1.1);
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 20px;
            background-color: #0d0d0d;
            color: #fff;
            margin-top: 50px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <main>
        <div class="main-content">
            <h2>Manage Extracurricular Activities</h2>
            
            <!-- Search and Filter Form -->
            <form method="GET" action="adminhome.jsp">
                <input type="text" name="search" placeholder="Search by student email or title" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <select name="statusFilter">
                    <option value="">All Statuses</option>
                    <option value="active" <%= "active".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>Active</option>
                    <option value="pending" <%= "pending".equals(request.getParameter("statusFilter")) ? "selected" : "" %>>Pending</option>
                </select>
                <button type="submit">Search</button>
            </form>
            
            <table>
                <tr>
                    <th><a href="adminhome.jsp?sortBy=id">ID</a></th>
                    <th><a href="adminhome.jsp?sortBy=achievement_title">Activity Title</a></th>
                    <th><a href="adminhome.jsp?sortBy=date">Date</a></th>
                    <th>Student Email</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>

                <%
                String searchQuery = request.getParameter("search");
                String statusFilter = request.getParameter("statusFilter");
                String sortBy = request.getParameter("sortBy");

                String sqlQuery = "SELECT id, student_email, achievement_title, date, status FROM std_ach WHERE (achievement_title LIKE ? OR student_email LIKE ?) AND status LIKE ?";
                if (sortBy != null) {
                    sqlQuery += " ORDER BY " + sortBy;
                }
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
                    PreparedStatement stmt = con.prepareStatement(sqlQuery);
                    stmt.setString(1, "%" + (searchQuery != null ? searchQuery : "") + "%");
                    stmt.setString(2, "%" + (searchQuery != null ? searchQuery : "") + "%");
                    stmt.setString(3, "%" + (statusFilter != null ? statusFilter : "") + "%");
                    ResultSet rs = stmt.executeQuery();

                    while(rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("achievement_title") %></td>
                    <td><%= rs.getString("date") %></td>
                    <td><%= rs.getString("student_email") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td>
                        <a href="viewactivity.jsp?id=<%= rs.getInt("id") %>">View</a>
                        <a href="updateactivity.jsp?id=<%= rs.getInt("id") %>">Update</a>
                        <a href="deleteactivity.jsp?id=<%= rs.getInt("id") %>">Delete</a>
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
    </main>
    <footer>
        <p>&copy; 2024 Extracurricular Management System</p>
    </footer>
</body>
</html>
s