<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="societymanagement.Event, societymanagement.EventDAO, societymanagement.HibernateUtil" %>
<%
    EventDAO eventDAO = new EventDAO(HibernateUtil.getSessionFactory());
    List<Event> upcomingEvents = eventDAO.getUpcomingEvents();
    List<Event> pastEvents = eventDAO.getPastEvents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Event Listings</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #121212; color: #fff; font-family: 'Arial', sans-serif; }
        .container { margin-top: 30px; }
        
        /* Card Styling */
        .card {
            background-color: #1A1A2E;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 166, 251, 0.3);
            padding: 20px;
        }

        /* Table Styling */
        .table th { 
            background-color: #00A6FB;
            color: white;
            text-align: center;
            font-size: 16px;
        }
        .table td { 
            color: #ddd; 
            text-align: center; 
            font-size: 14px;
        }
        .table tbody tr:hover { 
            background-color: rgba(0, 166, 251, 0.2); 
            transition: 0.3s; 
        }

        /* Section Headings */
        h2 {
            color: #00A6FB;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
            text-transform: uppercase;
        }

        /* Glow Effect */
        .table-hover tbody tr:hover {
            box-shadow: 0 0 10px rgba(0, 166, 251, 0.5);
        }

    </style>
</head>
<body>

    <div class="container">
        <h2>Upcoming Events</h2>
        <div class="card mb-4">
            <div class="table-responsive">
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th>Event Name</th>
                            <th>Event Date</th>
                            <th>Event Time</th>
                            <th>Organizer</th>
                            <th>Place</th>
                            <th>Description</th>
                            <th>Category</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Event event : upcomingEvents) { %>
                            <tr>
                                <td><%= event.getEventName() %></td>
                                <td><%= event.getEventDate() %></td>
                                <td><%= event.getEventTime() %></td>
                                <td><%= event.getEventOrganizer() %></td>
                                <td><%= event.getEventPlace() %></td>
                                <td><%= event.getEventDescription() %></td>
                                <td><%= event.getEventCategory() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <h2>Past Events</h2>
        <div class="card">
            <div class="table-responsive">
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th>Event Name</th>
                            <th>Event Date</th>
                            <th>Event Time</th>
                            <th>Organizer</th>
                            <th>Place</th>
                            <th>Description</th>
                            <th>Category</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Event event : pastEvents) { %>
                            <tr>
                                <td><%= event.getEventName() %></td>
                                <td><%= event.getEventDate() %></td>
                                <td><%= event.getEventTime() %></td>
                                <td><%= event.getEventOrganizer() %></td>
                                <td><%= event.getEventPlace() %></td>
                                <td><%= event.getEventDescription() %></td>
                                <td><%= event.getEventCategory() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
