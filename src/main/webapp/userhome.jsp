 <%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<%
    // Initialize variables
    String fullname = "";
    String email = (String)session.getAttribute("email");
    String gender = "";
    String dob = "";
    String maritalstatus = "";
    String contactno = "";
    String role = "";
    String badge = "";
    int activeRecords = 0;
    int pendingRecords = 0;
    String newBadge = "";

    if (email == null) {
        response.sendRedirect("sessionexpiry.html"); // Redirect if session has expired
    } else {
        try {
            // Database connection setup
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

            // Query to fetch user details from users table
            String query = "SELECT * FROM user WHERE email = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            // Populate user details if record is found
            if (rs.next()) {
                fullname = rs.getString("fullname");
                gender = rs.getString("gender");
                dob = rs.getString("dob");
                maritalstatus = rs.getString("maritalstatus");
                contactno = rs.getString("contactno");
                role = rs.getString("role");
                badge = rs.getString("badge"); // Get current badge
            }

            // Query to get active and pending achievements for the user
            String achievementQuery = "SELECT status FROM std_ach WHERE student_email = ?";
            PreparedStatement pstmt2 = con.prepareStatement(achievementQuery);
            pstmt2.setString(1, email);
            ResultSet rs2 = pstmt2.executeQuery();

            while (rs2.next()) {
                String status = rs2.getString("status");
                if ("active".equalsIgnoreCase(status)) {
                    activeRecords++;
                } else if ("pending".equalsIgnoreCase(status)) {
                    pendingRecords++;
                }
            }

            // Logic to determine the badge based on active and pending records
            if (activeRecords >= 5) {
                newBadge = "Gold";  // More than 5 active records = Gold Badge
            } else if (activeRecords >= 2) {
                newBadge = "Silver";  // More than 2 active records = Silver Badge
            } else if (activeRecords >= 1) {
                newBadge = "Bronze";  // More than 1 active record = Bronze Badge
            } else {
                newBadge = "No Badge";  // Default badge if none of the conditions match
            }

            // Update the badge in the database if it's changed
            if (!badge.equals(newBadge)) {
                String updateBadgeQuery = "UPDATE user SET badge = ? WHERE email = ?";
                PreparedStatement pstmt3 = con.prepareStatement(updateBadgeQuery);
                pstmt3.setString(1, newBadge);
                pstmt3.setString(2, email);
                pstmt3.executeUpdate(); // Execute the update
            }

            con.close(); // Close the connection
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Home - Student Extracurricular Management System</title>
    <link rel="stylesheet" href="styles.css">
    <!-- Google Fonts for better typography -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&family=Poppins:wght@300;400&display=swap" rel="stylesheet">
    <style>
        /* CSS Styles */
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #141414;
            color: #fff;
            background-image: url('https://unsplash.com/photos/a-blue-and-purple-background-with-swirls-C4iq8xKzY3Q'); /* Background Image */
            background-size: cover;
            background-position: center;
        }

        header {
            background: linear-gradient(135deg, #ff6f61, #af69ef);
            text-align: center;
            padding: 20px 0;
        }

        header h1 {
            font-size: 3em;
            color: #fff;
        }

        main {
            text-align: center;
            padding: 30px;
        }

        main h2 {
            font-size: 2.5em;
            color: #af69ef;
            margin-bottom: 20px;
        }

        .user-info {
            max-width: 600px;
            margin: 0 auto;
            background-color: rgba(31, 31, 46, 0.8);
            padding: 30px;
            border-radius: 15px;
            position: relative;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        }

        .user-info h3 {
            color: #ff6f61;
            font-size: 1.8em;
            margin-bottom: 15px;
        }

        .user-info p {
            font-size: 1.2em;
            line-height: 1.8;
        }

        .badge-img {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 150px;
            height: 100px;
            border-radius: 10px;
        }

        .actions a {
            color: #fff;
            text-decoration: none;
            padding: 12px 25px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            margin: 0 10px;
            transition: background-color 0.3s ease;
        }

        .actions a:hover {
            background-color: rgba(255, 255, 0, 0.3);
        }

        .profile-picture {
            width: 120px;
            height: 120px;
            margin: 20px auto;
            border-radius: 50%;
            overflow: hidden;
        }

        .profile-picture img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body>

<main>
    <h2>Hello, <%= fullname %>!</h2>
    <section class="user-info">
        <!-- Profile Picture Section -->
        <div class="profile-picture">
            <img src="images/user-placeholder.jpg" alt="User Profile Picture" />
        </div>

        <!-- Badge displayed at top right -->
        <img src="<%= newBadge.equals("Gold") ? "images/gbb.jpg" : newBadge.equals("Silver") ? "images/sbb.jpg" : newBadge.equals("Bronze") ? "images/bbb.jpg" : "images/default.jpg" %>" alt="<%= newBadge %> Badge" class="badge-img">

        <h3>Your Profile Information:</h3>
        <p><strong>Name:</strong> <%= fullname %></p>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Gender:</strong> <%= gender %></p>
        <p><strong>Date of Birth:</strong> <%= dob %></p>
        <p><strong>Marital Status:</strong> <%= maritalstatus %></p>
        <p><strong>Contact No:</strong> <%= contactno %></p>
        <p><strong>Role:</strong> <%= role %></p>
        <p><strong>Badge:</strong> <%= newBadge %></p> <!-- Display badge -->
    </section>

    <div class="actions">
        <a href="updateprofile.jsp"><i class="fa fa-edit"></i> Update Profile</a>
        <a href="viewachievements.jsp"><i class="fa fa-trophy"></i> View Achievements</a>
    </div>
</main>

</body>
</html> 