<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<%
String email = (String) session.getAttribute("email");
if (email == null) {
    response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Achievement - Student Extracurricular Management System</title>
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #0d0d0d;
            color: #fff;
            overflow-x: hidden;
        }

        .main-content {
            max-width: 600px;
            margin: 30px auto;
            padding: 40px;
            background: linear-gradient(135deg, #1f1f2e, #3a3a5a);
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            color: #fff;
        }

        .main-content h2 {
            font-size: 2.5em;
            color: #fc5c7d;
            margin-bottom: 20px;
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

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-size: 1.1em;
        }

        input[type="text"],
        textarea,
        input[type="date"] {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #f0f0f0;
            color: #333;
        }

        button {
            padding: 12px;
            font-size: 1.1em;
            font-weight: bold;
            color: #fff;
            background: #fc5c7d;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #e04e6a;
        }
    </style>
</head>
<body>
    <main class="main-content">
        <section>
            <h2>Post a New Achievement</h2>
            <form action="postAchievementHandler.jsp" method="post">
                <label for="title">Achievement Title:</label>
                <input type="text" id="title" name="title" required>

                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="5" required></textarea>

                <label for="date">Date:</label>
                <input type="date" id="date" name="date" required>

                <button type="submit">Post Achievement</button>
            </form>
        </section>
    </main>
</body>
</html>
