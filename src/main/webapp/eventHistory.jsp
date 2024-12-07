<%@ page import="java.sql.*" %>
<%@ include file="collegenavbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event History</title>
    <link rel="stylesheet" href="style.css">
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
            max-width: 1000px;
            margin: 30px auto;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }

        .main-content h2 {
            font-size: 2.5em;
            color: #fc5c7d;
            margin-bottom: 20px;
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
            <h2>Event History</h2>

            <table>
                <tr>
                    <th>Event Name</th>
                    <th>Event Date</th>
                    <th>Participation</th>
                </tr>

                <% 
                    try {
                        // Set up connection and query
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/collegeDB", "root", "password");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT event_name, event_date, participation FROM event_history WHERE college_id = ?");

                        // Loop through the results and display them
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getString("event_name") %></td>
                        <td><%= rs.getDate("event_date") %></td>
                        <td><%= rs.getString("participation") %></td>
                    </tr>
                <% 
                        }
                        // Close connection and result set
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
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
