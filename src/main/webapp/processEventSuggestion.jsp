<%@ page import="java.sql.*" %>
<%
    String eventName = request.getParameter("event_name");
    String eventDate = request.getParameter("event_date");
    
    // Debugging output to see what values are being passed
    out.print("Event Name: " + eventName);  // Print event name to check if it's coming through
    out.print("Event Date: " + eventDate);  // Print event date to check if it's coming through

    // Validate form inputs
    if (eventName == null || eventName.trim().isEmpty()) {
        out.print("Error: Event name is required.");
        return;
    }
    if (eventDate == null || eventDate.trim().isEmpty()) {
        out.print("Error: Event date is required.");
        return;
    }
    
    // Get the session variable for college_id
    Integer collegeId = (Integer) session.getAttribute("college_id");
    if (collegeId == null) {
        out.print("Error: College ID not found in session.");
        return;
    }
    
    try {
        // Database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp14", "root", "root");
        
        // Insert event details into the database
        String query = "INSERT INTO suggested_events (college_id, event_name, event_date) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, collegeId);  // Use session variable
        ps.setString(2, eventName);
        ps.setDate(3, Date.valueOf(eventDate));  // Ensure date is in the correct format
        ps.executeUpdate();
        
        // Redirect back to the events page after successful insertion
        response.sendRedirect("collegeEvents.jsp");
        
    } catch (Exception e) {
        out.print("Database Error: " + e.getMessage());
        e.printStackTrace();  // This will show the complete stack trace for debugging.
    }
%>
