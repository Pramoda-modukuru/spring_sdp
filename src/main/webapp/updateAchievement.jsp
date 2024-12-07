<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<%
String email = (String) session.getAttribute("email");
if (email == null) {
    response.sendRedirect("login.jsp");
}

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

    String query = "SELECT id, achievement_title FROM achievements " +
                   "WHERE id IN (SELECT id FROM user WHERE email = ?)";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, email);
    rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Achievement</title>
    <link rel="stylesheet" href="style.css">
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
            margin: 50px auto;
            padding: 40px;
            background: linear-gradient(135deg, #1f1f2e, #3a3a5a);
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            color: #fff;
            text-align: center;
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
            gap: 15px;
        }

        label {
            font-size: 1.1em;
            color: #fff;
            text-align: left;
        }

        select, textarea, input[type="date"] {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
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
    <h2>Update Achievement</h2>
    <form method="POST" action="updateAchievementHandler.jsp">
        <label for="id">Select Achievement:</label>
        <select id="id" name="id" required>
            <% 
            boolean hasAchievements = false;
            while (rs.next()) { 
                hasAchievements = true;
            %>
                <option value="<%= rs.getInt("id") %>"><%= rs.getString("achievement_title") %></option>
            <% } %>
            <% if (!hasAchievements) { %>
                <option disabled>No achievements available</option>
            <% } %>
        </select>

        <label for="description">New Description:</label>
        <textarea id="description" name="description" rows="5" placeholder="Enter a new description..." required></textarea>

        <label for="date">New Date:</label>
        <input type="date" id="date" name="date" required>

        <button type="submit">Update Achievement</button>
    </form>
</main>
<%
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
</body>
</html>
