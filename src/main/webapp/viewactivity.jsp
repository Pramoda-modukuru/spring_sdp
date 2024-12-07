<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<%
String email = (String) session.getAttribute("email");
if (email == null) {
    response.sendRedirect("login.jsp");
}

int activityId = Integer.parseInt(request.getParameter("id"));
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Activity</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        /* CSS Styles */
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #141414;
            color: #fff;
        }

        header {
            background: linear-gradient(135deg, #ff6f61, #af69ef);
            padding: 30px 0;
            text-align: center;
        }

        header h1 {
            font-size: 3em;
            color: #fff;
        }

        nav a {
            color: #fff;
            text-decoration: none;
            font-size: 1.3em;
            margin: 0 20px;
            padding: 10px 20px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
        }

        nav a:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        main {
            padding: 40px 0;
            text-align: center;
        }

        main h2 {
            font-size: 2.5em;
            color: #af69ef;
        }

        .user-info {
            max-width: 600px;
            margin: 0 auto;
            background-color: #1f1f2e;
            padding: 30px;
            border-radius: 15px;
        }

        .user-info h3 {
            color: #ff6f61;
            font-size: 1.8em;
        }

        .user-info p {
            font-size: 1.2em;
            line-height: 1.8;
        }

        .actions a {
            color: #fff;
            text-decoration: none;
            padding: 12px 25px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            margin: 0 10px;
        }

        .actions a:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }
    </style>
</head>
<body>
    <main>
        <div class="main-content">
            <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

                String query = "SELECT * FROM achievements WHERE id = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setInt(1, activityId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
            %>
            <p><strong>ID:</strong> <%= rs.getInt("id") %></p>
            <p><strong>Title:</strong> <%= rs.getString("achievement_title") %></p>
            <p><strong>Description:</strong> <%= rs.getString("description") %></p>
            <p><strong>Date:</strong> <%= rs.getDate("date") %></p>
            <p><strong>Status:</strong> <%= rs.getString("status") %></p>
            <%
                } else {
                    out.println("<p>Activity not found.</p>");
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            }
            %>
        </div>
    </main>
</body>
</html>
