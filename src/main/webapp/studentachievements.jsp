<%@ include file="collegenavbar.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Achievements</title>
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
        header h1 {
            margin: 0;
            font-size: 2.5em;
            color: #fff;
            letter-spacing: 2px;
            text-transform: uppercase;
        }
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
        ul {
            list-style-type: none;
            padding: 0;
        }
        ul li {
            margin: 20px 0;
            background-color: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        ul li span {
            font-size: 1.1em;
            color: #fc5c7d;
        }
    </style>
</head>
<body>

    <div class="main-content">
        <h2>Student Achievements</h2>

        <% 
            // Ensure session variable 'college_id' is set
            Integer collegeId = (Integer) session.getAttribute("college_id");
            if (collegeId == null) {
                out.println("<p style='color:red;'>Error: College ID not found in session. Please log in again.</p>");
            } else {
                // Connect to the database and fetch achievements
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
                    PreparedStatement stmt = con.prepareStatement("SELECT student_id, achievement, achievement_date FROM std_ach WHERE college_id = ?");
                    stmt.setInt(1, collegeId);
                    ResultSet rs = stmt.executeQuery();
                    
                    // Check if there are any results
                    if (!rs.isBeforeFirst()) {
                        out.println("<p>No achievements found for this college.</p>");
                    } else {
                        // Display achievements
                        out.println("<ul>");
                        while (rs.next()) {
                            out.println("<li>");
                            out.println("<span><strong>Student ID:</strong> " + rs.getString("student_id") + " | <strong>Achievement:</strong> " + rs.getString("achievement") + " | <strong>Date:</strong> " + rs.getString("achievement_date") + "</span>");
                            out.println("</li>");
                        }
                        out.println("</ul>");
                    }
                } catch (SQLException e) {
                    out.println("<p style='color:red;'>SQL Error: " + e.getMessage() + "</p>");
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>

    </div>

</body>
</html>
