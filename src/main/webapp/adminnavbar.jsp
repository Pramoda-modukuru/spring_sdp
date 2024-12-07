<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Navbar</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        /* Admin Navbar Styles */
        .admin-navbar {
            background: linear-gradient(135deg, #ff6f61, #AF69EF); /* Pink to orange gradient */
            padding: 15px 0;
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .admin-navbar h1 {
            font-size: 2em;
            color: #ffffff; /* White text */
            letter-spacing: 1px;
            margin-bottom: 0;
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
            background-color: rgba(255, 255, 255, 0.1); /* Subtle transparent background */
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        nav a:hover {
            background-color: rgba(255, 255, 255, 0.3); /* Highlight effect */
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <!-- Admin Navbar -->
    <div class="admin-navbar">
        <h1>Admin Dashboard</h1>
        <nav>
            <a href="adminhome.jsp">Home</a>
            <a href="viewusers.jsp">View Students</a>
            <a href="updateuserform.html">Update Students</a>
            <a href="deleteuser.jsp">Delete Students</a>
            <a href="viewreports.jsp">View Reports</a>
            <a href="userlogout.jsp">Logout</a>
        </nav>
    </div>
</body>
</html>
