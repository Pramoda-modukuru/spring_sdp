<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ include file="navbar.jsp" %>

<%
    // Fetch student details from session
    String fullname = (String) session.getAttribute("fullname");
    String email = (String) session.getAttribute("email");
    if (fullname == null || email == null) {
        response.sendRedirect("sessionexpiry.html");
    }
    
    // Retrieve activity ID from request parameters
    int id = Integer.parseInt(request.getParameter("id"));
    String achievement_title = "";
    String date = "";
    String status = "";
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Handle form submission to update data
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String updatedTitle = request.getParameter("achievement_title");
        String updatedDate = request.getParameter("date");
        String updatedStatus = request.getParameter("status");

        try {
            // Update the activity in the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

            String updateQuery = "UPDATE std_ach SET achievement_title = ?, date = ?, status = ? WHERE id = ?";
            PreparedStatement updateStmt = con.prepareStatement(updateQuery);
            updateStmt.setString(1, updatedTitle);
            updateStmt.setString(2, updatedDate);
            updateStmt.setString(3, updatedStatus);
            updateStmt.setInt(4, id);

            int rowsUpdated = updateStmt.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("<p>Activity updated successfully!</p>");
            } else {
                out.println("<p>Error updating the activity.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else {
        // Fetch current activity details from the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
            String query = "SELECT * FROM std_ach WHERE id = ?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                achievement_title = rs.getString("achievement_title");
                date = rs.getString("date");
                status = rs.getString("status");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Activity - Extracurricular Management</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="main-content">
        <h2>Update Achievement</h2>
        <!-- Form to update the achievement -->
        <form method="post" action="updateactivity.jsp">
            <input type="hidden" name="id" value="<%= id %>">
            
            <label for="achievement_title">Title:</label>
            <input type="text" id="achievement_title" name="achievement_title" value="<%= achievement_title %>" required><br><br>

            <label for="date">Date:</label>
            <input type="date" id="date" name="date" value="<%= date %>" required><br><br>

            <label for="status">Status:</label>
            <select id="status" name="status">
                <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Active</option>
                <option value="inactive" <%= "inactive".equals(status) ? "selected" : "" %>>Inactive</option>
            </select><br><br>

            <input type="submit" value="Update">
        </form>
    </div>
</body>
</html>
