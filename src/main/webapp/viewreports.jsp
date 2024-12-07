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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - View Reports</title>
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
        }
        form input, form select {
            padding: 10px;
            font-size: 1em;
            border: none;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            width: 250px;
        }
        form button {
            padding: 10px 20px;
            font-size: 1em;
            background-color: #fc5c7d;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        form button:hover {
            background-color: #ff4770;
        }

        /* Table Styles */
        table {
            width: 95%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fc5c7d;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            background-color: #fff;
            color: #0d0d0d;
        }

        th {
            background-color: #fc5c7d;
            color: #fff;
            font-size: 1.2em;
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.1);
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

        /* Badge Styling */
        .badge {
            padding: 8px 12px;
            border-radius: 5px;
            font-weight: bold;
        }
        .gold {
            background-color: #FFD700;
            color: #fff;
        }
        .silver {
            background-color: #C0C0C0;
            color: #fff;
        }
        .bronze {
            background-color: #CD7F32;
            color: #fff;
        }

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
            <h2>Student Achievement Report</h2>

            <!-- Search Form to enter student email -->
            <form method="GET" action="viewreports.jsp">
                <input type="text" name="studentEmail" placeholder="Enter student email" required>
                <button type="submit">Search</button>
            </form>

            <%
            // Get the search email from the form (if any)
            String studentEmail = request.getParameter("studentEmail");

            // Initialize the student report list
            List<Map<String, Object>> studentReport = new ArrayList<>();

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

                // Query to fetch students and their achievement count
                String query = "";
                if (studentEmail != null && !studentEmail.trim().isEmpty()) {
                    query = "SELECT u.email, "
                          + "SUM(CASE WHEN a.status = 'active' THEN 1 ELSE 0 END) AS active_count, "
                          + "SUM(CASE WHEN a.status = 'pending' THEN 1 ELSE 0 END) AS pending_count "
                          + "FROM user u LEFT JOIN std_ach a ON u.email = a.student_email "
                          + "WHERE u.email LIKE ? AND u.role != 'admin' "
                          + "GROUP BY u.email";
                } else {
                    query = "SELECT u.email, "
                          + "SUM(CASE WHEN a.status = 'active' THEN 1 ELSE 0 END) AS active_count, "
                          + "SUM(CASE WHEN a.status = 'pending' THEN 1 ELSE 0 END) AS pending_count "
                          + "FROM user u LEFT JOIN std_ach a ON u.email = a.student_email "
                          + "WHERE u.role != 'admin' "
                          + "GROUP BY u.email";
                }

                PreparedStatement stmt = con.prepareStatement(query);

                // If email is provided, use it to filter the results
                if (studentEmail != null && !studentEmail.trim().isEmpty()) {
                    stmt.setString(1, "%" + studentEmail + "%");
                }

                ResultSet rs = stmt.executeQuery();

                // Process results and store in studentReport list
                while (rs.next()) {
                    Map<String, Object> studentData = new HashMap<>();
                    studentData.put("email", rs.getString("email"));
                    studentData.put("active_count", rs.getInt("active_count"));
                    studentData.put("pending_count", rs.getInt("pending_count"));
                    studentReport.add(studentData);
                }

                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>

            <!-- Displaying the report of students -->
            <div class="report-summary">
                <h3>All Student's Achievement Reports</h3>

                <table>
                    <thead>
                        <tr>
                            <th>Student Email</th>
                            <th>Active Achievements</th>
                            <th>Pending Achievements</th>
                            <th>Badge</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, Object> student : studentReport) { 
                            String emailData = (String) student.get("email");
                            int activeCount = (int) student.get("active_count");
                            int pendingCount = (int) student.get("pending_count");

                            String badge = "None"; 
                            if (activeCount >= 5) {
                                badge = "Gold";
                            } else if (activeCount >= 3) {
                                badge = "Silver";
                            } else if (activeCount >= 1) {
                                badge = "Bronze";
                            }

                            %>
                        <tr>
                            <td><%= emailData %></td>
                            <td><%= activeCount %></td>
                            <td><%= pendingCount %></td>
                            <td>
                                <span class="badge <%= badge.toLowerCase() %>">
                                    <%= badge %>
                                </span>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <footer>
        <p>&copy; 2024 Admin Dashboard | All Rights Reserved</p>
    </footer>
</body>
</html>
