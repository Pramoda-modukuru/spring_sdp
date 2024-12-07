<%@ include file="collegenavbar.jsp" %>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Suggestions</title>
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

        /* Form Styles */
        form {
            margin: 20px 0;
            display: flex;
            flex-direction: column;
            gap: 15px;
            background-color: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
        }
        form input, form button {
            padding: 10px;
            font-size: 1em;
            border: none;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            transition: transform 0.3s ease;
        }
        form input:focus, form button:focus {
            transform: scale(1.05);
        }
        form button {
            background-color: #fc5c7d;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        form button:hover {
            background-color: #ff4770;
            transform: scale(1.1);
        }

        /* Event List Styles */
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
        ul li img {
            width: 100px;
            height: 100px;
            border-radius: 5px;
            object-fit: cover;
        }
        ul li span {
            font-size: 1.1em;
            color: #fc5c7d;
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

    <div class="main-content">
        <h2>Submit an Event Suggestion</h2>
        <form action="processEventSuggestion.jsp" method="post" enctype="multipart/form-data">
            <label for="event_name">Event Name:</label>
            <input type="text" name="event_name" required placeholder="Enter event name"><br><br>
            
            <label for="event_date">Event Date:</label>
            <input type="date" name="event_date" required><br><br>


            <button type="submit">Submit Event</button>
        </form>

        <h2>All Suggested Events</h2>
        <ul>
            <% 
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
                    PreparedStatement stmt = con.prepareStatement("SELECT event_name, event_date FROM suggested_events WHERE college_id = ?");
                    stmt.setInt(1, (Integer) session.getAttribute("college_id"));
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
            %>
            <% 
                }
            } catch (Exception e) {
                out.print("Error: " + e.getMessage());
            }
            %>
        </ul>
    </div>

    <footer>
        <p>&copy; 2024 Event Suggestions</p>
    </footer>

</body>
</html>
