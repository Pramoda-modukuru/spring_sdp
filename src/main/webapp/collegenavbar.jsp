<!DOCTYPE html>
<html>
<head>
    <style>
        /* Navbar Styles */
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background: linear-gradient(135deg, #6a82fb, #fc5c7d);
            color: white;
        }

        .nav-logo {
            font-size: 1.8em;
            font-weight: bold;
            color: #fff;
            text-transform: uppercase;
            text-decoration: none;
            letter-spacing: 2px;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            text-decoration: none;
            color: #fff;
            font-size: 1.2em;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.05);
        }

        .logout-button {
            padding: 8px 15px;
            background-color: #e63946;
            border: none;
            color: #fff;
            font-size: 1.1em;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: #b51d30;
        }

        @media (max-width: 768px) {
            .nav-links {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .nav-logo {
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <nav>
        <a href="collegeHome.jsp" class="nav-logo">College Dashboard</a>
        <div class="nav-links">
            <a href="collegeDashboard.jsp">Home</a>
            <a href="sendPortalRequest.jsp">Send Portal Request</a>
            <a href="collegeEvents.jsp">Events Suggestions</a>
            <a href="studentachievements.jsp">Student Achievements</a>
            <a href="eventHistory.jsp">Event History</a>
        </div>
        <form action="logout.jsp" method="post" style="margin: 0;">
            <button class="logout-button">Logout</button>
        </form>
    </nav>
</body>
</html>
