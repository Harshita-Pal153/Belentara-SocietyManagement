package societymanagement;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EventManagementServlet")
public class EventManagementServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		EventDAO eventDAO = new EventDAO(HibernateUtil.getSessionFactory());

		try {
			// Retrieve events
			List<Event> upcomingEvents = eventDAO.getUpcomingEvents();
			List<Event> pastEvents = eventDAO.getPastEvents();

			// Debugging: Log retrieved events
			System.out.println("Upcoming Events Count: " + upcomingEvents.size());
			System.out.println("Past Events Count: " + pastEvents.size());

			request.setAttribute("upcomingEvents", upcomingEvents);
			request.setAttribute("pastEvents", pastEvents);
			request.getRequestDispatcher("admindashboard.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error fetching events.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		EventDAO eventDAO = new EventDAO(HibernateUtil.getSessionFactory());

		// Retrieve parameters
		String eventName = request.getParameter("eventName");
		String eventDate = request.getParameter("eventDate");
		String eventTime = request.getParameter("eventTime");
		String eventOrganizer = request.getParameter("eventOrganizer");
		String eventPlace = request.getParameter("eventPlace");
		String eventDescription = request.getParameter("eventDescription");
		String eventCategory = request.getParameter("eventCategory");
		String eventIdStr = request.getParameter("eventId");

		try {
			Event event = new Event();
			if (eventIdStr != null && !eventIdStr.isEmpty()) {
				event.setId(Long.parseLong(eventIdStr));
			}

			// Validate event date
			if (eventDate != null && !eventDate.isEmpty()) {
				event.setEventDate(Date.valueOf(eventDate));
			} else {
				throw new IllegalArgumentException("Event date cannot be empty.");
			}

			// Validate event time
			if (eventTime != null && !eventTime.isEmpty()) {
				if (!eventTime.matches("\\d{2}:\\d{2}")) {
					throw new IllegalArgumentException("Invalid time format. Use HH:mm.");
				}
				eventTime = eventTime + ":00"; // Append seconds
				event.setEventTime(Time.valueOf(eventTime));
			} else {
				throw new IllegalArgumentException("Event time cannot be empty.");
			}

			// Set event details
			event.setEventName(eventName);
			event.setEventOrganizer(eventOrganizer);
			event.setEventPlace(eventPlace);
			event.setEventDescription(eventDescription);
			event.setEventCategory(eventCategory);

			// Save or update event
			eventDAO.saveOrUpdateEvent(event);

			// Redirect to event management page
			response.sendRedirect("EventManagementServlet");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error saving event: " + e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
