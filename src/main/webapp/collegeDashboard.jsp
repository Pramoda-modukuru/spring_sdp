<%@ page import="java.sql.*" %>
<%@ include file="collegenavbar.jsp" %>
<%
    // Placeholder values for demonstration purposes
    String adminName = "Admin";
    int totalColleges = 15; // Fetch from database
    int totalStudents = 1200; // Fetch from database
    int totalFaculty = 200; // Fetch from database
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* College Dashboard Specific Styles */
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #141414;
            color: #fff;
        }

        .header {
            background: linear-gradient(135deg, #42a5f5, #7b1fa2);
            padding: 20px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 2.5em;
        }

        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            padding: 20px;
        }

        .card {
            background-color: #1f1f2e;
            color: #fff;
            width: 30%;
            margin: 15px;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .card h2 {
            font-size: 1.8em;
            margin-bottom: 15px;
        }

        .card p {
            font-size: 1.2em;
        }

        .data-table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #1f1f2e;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
        }

        .data-table th, .data-table td {
            padding: 15px;
            text-align: left;
            color: #000; /* Changed text color inside the table to black */
        }

        .data-table th {
            background: linear-gradient(135deg, #42a5f5, #7b1fa2);
            color: #fff; /* Header text color white for contrast */
            font-weight: bold;
        }

        .data-table tr:nth-child(odd) {
            background-color: #2f2f3e;
        }

        .data-table tr:nth-child(even) {
            background-color: #37374d;
        }

        .data-table tr:hover {
            background-color: #44445b;
        }

        .footer {
            text-align: center;
            padding: 10px;
            font-size: 0.9em;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <header class="header">
        <h1>Welcome to the College Dashboard, <%= adminName %>!</h1>
    </header>

    <main class="dashboard-container">
        <!-- Cards Section -->
        <div class="card">
            <h2>Total Colleges</h2>
            <p><%= totalColleges %></p>
        </div>
        <div class="card">
            <h2>Total Students</h2>
            <p><%= totalStudents %></p>
        </div>
        <div class="card">
            <h2>Total Faculty</h2>
            <p><%= totalFaculty %></p>
        </div>
    </main>

    <!-- Data Table -->
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>College Name</th>
                <th>City</th>
                <th>State</th>
                <th>Number of Students</th>
                <th>Number of Faculty</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Fetch data from the database
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

                    String query = "SELECT id, name, city, state, students, faculty FROM colleges";
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String city = rs.getString("city");
                        String state = rs.getString("state");
                        int students = rs.getInt("students");
                        int faculty = rs.getInt("faculty");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= city %></td>
                <td><%= state %></td>
                <td><%= students %></td>
                <td><%= faculty %></td>
            </tr>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
        </tbody>
    </table>

    <footer class="footer">
        &copy; 2024 College Management System. All Rights Reserved.
    </footer>

</body>
</html>
