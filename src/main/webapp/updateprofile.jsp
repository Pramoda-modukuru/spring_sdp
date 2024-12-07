<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>
<%
    String fullname = "";
    String gender = "";
    String dob = "";
    String maritalstatus = "";
    String contactno = "";
    String role = "";
    String email = (String) session.getAttribute("email");

    if (email == null) {
        response.sendRedirect("userlogin.jsp");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");

            String query = "SELECT * FROM user WHERE email = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                fullname = rs.getString("fullname");
                gender = rs.getString("gender");
                dob = rs.getString("dob");
                maritalstatus = rs.getString("maritalstatus");
                contactno = rs.getString("contactno");
                role = rs.getString("role");
            }
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - Student Extracurricular Management System</title>
    <link rel="stylesheet" href="style.css">
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
            font-size: 2.5em;
            color: #fff;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin: 0;
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

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-size: 1.1em;
        }

        input[type="text"],
        input[type="date"],
        select {
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
        <h2>Update Your Information</h2>
        <form action="updateprofile.jsp" method="post">
            <label for="fullname">Name:</label>
            <input type="text" id="fullname" name="fullname" value="<%= fullname %>" required>

            <label for="gender">Gender:</label>
            <select id="gender" name="gender">
                <option value="Male" <%= gender.equals("Male") ? "selected" : "" %>>Male</option>
                <option value="Female" <%= gender.equals("Female") ? "selected" : "" %>>Female</option>
                <option value="Other" <%= gender.equals("Other") ? "selected" : "" %>>Other</option>
            </select>

            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" value="<%= dob %>" required>

            <label for="maritalstatus">Marital Status:</label>
            <select id="maritalstatus" name="maritalstatus">
                <option value="Single" <%= maritalstatus.equals("Single") ? "selected" : "" %>>Single</option>
                <option value="Married" <%= maritalstatus.equals("Married") ? "selected" : "" %>>Married</option>
                <option value="Other" <%= maritalstatus.equals("Other") ? "selected" : "" %>>Other</option>
            </select>

            <label for="contactno">Contact No:</label>
            <input type="text" id="contactno" name="contactno" value="<%= contactno %>" required>

            <label for="role">Role:</label>
            <input type="text" id="role" name="role" value="<%= role %>" required>

            <button type="submit">Update Profile</button>
        </form>
    </section>
</main>

</body>
</html>
