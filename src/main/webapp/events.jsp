<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="navbar.jsp" %>

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
    <title>Available Events - Extracurricular Management System</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        body {
            margin: 0;
            font-family: 'Arial', sans-serif;
            background-color: #0d0d0d;
            color: #fff;
        }
        .events-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 40px;
        }
        .event-card {
            background-color: #1f1f2e;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
            max-width: 300px;
            text-align: center;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .event-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }
        .event-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .event-card h3 {
            margin: 15px 0;
            color: #fc5c7d;
        }
        .event-card p {
            margin: 10px 20px;
            color: #ccc;
        }
        .event-card span {
            display: block;
            margin-top: 5px;
            font-size: 14px;
            color: #a0a0a0;
        }
        .event-card button {
            background-color: #fc5c7d;
            color: #fff;
            border: none;
            padding: 10px 20px;
            margin: 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .event-card button:hover {
            background-color: #ff4770;
        }
    </style>
</head>
<body>
    <header>
        <h1>Available Extracurricular Events</h1>
    </header>
    <div class="events-container">
        <%
            // Simulate data for events
            List<String[]> events = Arrays.asList(
                new String[]{"Coding Hackathon", "Join us for an exciting coding competition!", "images/coding.jpg", "KL University"},
                new String[]{"Debate Competition", "Express your thoughts and ideas in debates!", "images/debate.jpg", "IIT Hyderabad"},
                new String[]{"Photography Workshop", "Learn photography techniques from experts!", "images/photo.jpg", "JNTU Kakinada"},
                new String[]{"Music Jam Session", "Showcase your musical talents!", "images/jam.jpg", "NIT Warangal"},
                new String[]{"Art Exhibition", "Discover and exhibit beautiful artworks!", "images/art.jpg", "Andhra University"},
                new String[]{"Sports Meet", "Participate in thrilling sports events!", "images/sm.jpg", "BITS Pilani"},
                new String[]{"Dance Workshop", "Learn to dance with professional trainers!", "images/dw.jpg", "VIT Vellore"},
                new String[]{"Drama Club Auditions", "Unleash your inner actor or actress!", "images/dc.jpg", "Osmania University"},
                new String[]{"Community Service", "Make a difference by volunteering!", "images/cs.jpg", "SRM University"},
                new String[]{"Cooking Challenge", "Show off your culinary skills!", "images/cc.jpg", "Amrita University"}
            );

            String registeredEvent = request.getParameter("registerEvent");
            String unregisterEvent = request.getParameter("unregisterEvent");
            session.setAttribute("registeredEvent", registeredEvent != null ? registeredEvent : session.getAttribute("registeredEvent"));

            for (String[] event : events) {
                String eventName = event[0];
                String eventDescription = event[1];
                String eventImage = event[2];
                String collegeName = event[3];
        %>
        <div class="event-card">
            <img src="<%= eventImage %>" alt="<%= eventName %>">
            <h3><%= eventName %></h3>
            <p><%= eventDescription %></p>
            <span>Organized by: <%= collegeName %></span>
            <% if (session.getAttribute("registeredEvent") != null && session.getAttribute("registeredEvent").equals(eventName)) { %>
                <button onclick="location.href='events.jsp?unregisterEvent=<%= eventName %>'">Unregister</button>
            <% } else { %>
                <button onclick="location.href='events.jsp?registerEvent=<%= eventName %>'">Register</button>
            <% } %>
        </div>
        <%
            }
            if (unregisterEvent != null && unregisterEvent.equals(session.getAttribute("registeredEvent"))) {
                session.setAttribute("registeredEvent", null);
            }
        %>
    </div>
</body>
</html>
