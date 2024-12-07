<%@ page import="java.sql.*" %>
<%
    String fullname = (String)session.getAttribute("fullname");
    String email = (String)session.getAttribute("email");
    if(fullname == null || email == null) {
        response.sendRedirect("sessionexpiry.html");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Grievance</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <header>
        <h1>Welcome to MyApp</h1>
        <nav>
            <a href="userhome.jsp">Home</a>	
            <a href="submitgrievance.jsp">Submit Grievance</a>
        </nav>
    </header>
    <main>
        <section class="form-container">
            <h3>Submit your grievance below:</h3>
            <form method="post" action="insertgrievance.jsp">
                <div class="form-group">
                    <label for="subject">Subject:</label>
                    <input type="text" id="subject" name="subject" required>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="5" required></textarea>
                </div>
                <div class="form-actions">
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </div>
            </form>
        </section>
    </main>
</body>
</html>
