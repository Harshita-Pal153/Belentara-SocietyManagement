<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="societymanagement.Event"%>
<%@ page import="societymanagement.EventDAO"%>
<%@ page import="societymanagement.MaintenanceCharges"%>
<%@ page import="org.hibernate.Session"%>
<%@ page import="org.hibernate.SessionFactory"%>
<%@ page import="org.hibernate.cfg.Configuration"%>
<%@ page import="java.util.List"%>
<%@ page import="societymanagement.Message"%>
<%@ page isELIgnored="false"%>
<%@ page session="true"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html lang="en" class="dark-theme">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/apexcharts">

document.getElementById("memberRecordsTab").addEventListener("click", function () {
    window.location.href = "http://localhost:7531/Finalyear/FetchResidentRecordsServlet";
});

</script>
<link rel="stylesheet" href="admin.css">
</head>
<body>
	<div id="notification-container"></div>

	<div class="dashboard">
		<nav class="sidebar">
			<div class="logo">
				<a href="login.jsp"> <img src="logo.png" alt="Image" width="230"
					height="100">
				</a>

			</div>
			<ul class="nav-links">
				<li class="active" data-section="dashboard"
					data-content="dashboard-content"><i class="fas fa-home"></i> <span>Dashboard</span>
					<div class="nav-indicator"></div></li>
				<li id="memberRecordsTab"
					onclick="redirectToServlet('FetchResidentRecordsServlet')">
					<i class="fas fa-address-book"></i> <span>Member Records</span>
					<div class="nav-indicator"></div>
				</li>

				<li data-section="projects" data-content="projects-content"><i
					class="far fa-calendar"></i> <span>Event Management</span>
					<div class="nav-indicator"></div></li>
				<li data-section="maintenance" data-content="maintenance-content"><i
					class="fas fa-tools"></i> <span>Maintenance</span>
					<div class="nav-indicator"></div></li>
				<li data-section="service" data-content="service-content"><i
					class="fas fa-concierge-bell"></i> <span>Service</span>
					<div class="nav-indicator"></div></li>
				<li data-section="messages" data-content="messages-content"><i
					class="fas fa-envelope"></i> <span>Messages</span>
					<div class="nav-indicator"></div></li>
				<li data-section="settings" data-content="settings-content"><i
					class="fas fa-file-invoice"></i> <span>Notice Board</span>
					<div class="nav-indicator"></div></li>
			</ul>
		</nav>
		<main class="main-content">

			<div id="dashboard-content" class="content-section active">
				<div class="dashboard-grid">
					<div class="stats-container">
						<div class="stat-card glow">
							<div class="stat-icon">
								<i class="fas fa-users"></i>
							</div>
							<div class="stat-details">
								<h3>Total Residents</h3>
								<p class="counter" data-target="150">0</p>
								<span class="trend positive">+2.5%</span>
							</div>
						</div>
						<div class="stat-card glow">
							<div class="stat-icon">
								<i class="fas fa-hand-holding-usd"></i>
							</div>
							<div class="stat-details">
								<h3>Maintenance Collected</h3>
								<p class="counter" data-target="50000">0</p>
								<span class="trend positive">+5.1%</span>
							</div>
						</div>
						<div class="stat-card glow">
							<div class="stat-icon">
								<i class="fas fa-tools"></i>
							</div>
							<div class="stat-details">
								<h3>Pending Maintenance Requests</h3>
								<p class="counter" data-target="12">0</p>
								<span class="trend negative">-3%</span>
							</div>
						</div>
						<div class="stat-card glow">
							<div class="stat-icon">
								<i class="fas fa-file-invoice"></i>
							</div>
							<div class="stat-details">
								<h3>Total Invoices Generated</h3>
								<p class="counter" data-target="275">0</p>
								<span class="trend positive">+4.3%</span>
							</div>
						</div>
					</div>

					<div class="charts-container">
						<div class="chart-card glow">
							<div class="revenue-header">
								<h2>Maintenance Collection</h2>
								<select class="revenue-filter">
									<option value="1">Last Month</option>
									<option value="7" selected>Last Quarter</option>
									<option value="30">Last 6 Months</option>
									<option value="90">Last 3 Months</option>
									<option value="365">Last Year</option>
								</select>
							</div>
							<div id="revenueChart"></div>
						</div>
						<div class="chart-card glow">
							<div class="chart-header">
								<h3>Service Requests</h3>
								<div class="chart-actions">
									<div class="legend">
										<span class="legend-item"> <span class="dot new"></span>
											Open Requests
										</span> <span class="legend-item"> <span class="dot returning"></span>
											Resolved
										</span>
									</div>
								</div>
							</div>
							<div id="userActivityChart"></div>
						</div>
					</div>
					<div class="activity-card glow">
						<div class="activity-header">
							<h2>Pending Complaints</h2>
						</div>
						<div class="activity-list" id="activityList"></div>
					</div>
				</div>
			</div>

			<div id="analytics-content" class="content-section">
				<div class="section-header">
					<h2>Member Records</h2>
					<p>Track member records</p>
				</div>

				<table>
					<thead>
						<tr>
							<th>Resident Name</th>
							<th>Email</th>
							<th>Flat No</th>
							<th>Block No</th>
							<th>Staff Name</th>
							<th>Staff Role</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Object[]> records = (List<Object[]>) request.getAttribute("records");
						if (records != null) {
							for (Object[] record : records) {
								String residentName = record[0] + " " + record[1];
								String email = (String) record[2];
								String flatNo = (String) record[3];
								String blockNo = (String) record[4];
								String staffName = (String) record[5];
								String staffRole = (String) record[6];

								if (staffName == null)
							staffName = "N/A";
								if (staffRole == null)
							staffRole = "N/A";
						%>
						<tr>
							<td><%=residentName%></td>
							<td><%=email%></td>
							<td><%=flatNo%></td>
							<td><%=blockNo%></td>
							<td><%=staffName%></td>
							<td><%=staffRole%></td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="6">No records found.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>

			<div id="projects-content" class="content-section">
				<div class="section-header">
					<h2>Event Management</h2>
					<p>Track and manage events</p>
				</div>
				<h2>Create or Update Event</h2>
				<form action="EventManagementServlet" method="post"
					onsubmit="return validateEventDate()">
					<input type="hidden" name="eventId" value="${event.id}" />
					<div class="form-group">
						<label for="eventName">Event Name</label> <input type="text"
							class="form-control" id="eventName" name="eventName" required />
					</div>
					<div class="form-group">
						<label for="eventDate">Event Date</label> <input type="date"
							class="form-control" id="eventDate" name="eventDate" required />
					</div>
					<div class="form-group">
						<label for="eventTime">Event Time</label> <input type="time"
							class="form-control" id="eventTime" name="eventTime" required />
					</div>
					<div class="form-group">
						<label for="eventOrganizer">Event Organizer</label> <input
							type="text" class="form-control" id="eventOrganizer"
							name="eventOrganizer" required />
					</div>
					<div class="form-group">
						<label for="eventPlace">Event Place</label> <input type="text"
							class="form-control" id="eventPlace" name="eventPlace" required />
					</div>
					<div class="form-group">
						<label for="eventDescription">Event Description</label>
						<textarea class="form-control" id="eventDescription"
							name="eventDescription"></textarea>
					</div>
					<div class="form-group">
						<label for="eventCategory">Event Category</label> <input
							type="text" class="form-control" id="eventCategory"
							name="eventCategory" required />
					</div>
					<button type="submit" class="btn btn-primary">Save Event</button>
					<button type="reset" class="btn btn-secondary">Clear</button>
				</form>

				<h2 class="my-4">Upcoming Events</h2>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Event Name</th>
							<th>Event Date</th>
							<th>Event Time</th>
							<th>Organizer</th>
							<th>Place</th>
							<th>Description</th>
							<th>Category</th>
							<th>Actions</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="event" items="${upcomingEvents}">
							<tr>
								<form action="EventManagementServlet" method="post">
									<td><input type="text" class="form-control"
										name="eventName" value="${event.eventName}" required /></td>
									<td><input type="date" class="form-control"
										name="eventDate" value="${event.eventDate}" required /></td>
									<td><input type="time" class="form-control"
										name="eventTime" value="${event.eventTime}" required /></td>
									<td><input type="text" class="form-control"
										name="eventOrganizer" value="${event.eventOrganizer}" required /></td>
									<td><input type="text" class="form-control"
										name="eventPlace" value="${event.eventPlace}" required /></td>
									<td><textarea class="form-control" name="eventDescription">${event.eventDescription}</textarea></td>
									<td><input type="text" class="form-control"
										name="eventCategory" value="${event.eventCategory}" required /></td>
									<td><input type="hidden" name="eventId"
										value="${event.id}" /> <input type="hidden" name="action"
										value="update" /> <!-- Added this -->
										<button type="submit" class="btn btn-warning">Update</button>
									</td>
								</form>
								<td>
									<!-- Delete Button -->
									<form action="EventManagementServlet" method="post"
										onsubmit="return confirm('Are you sure you want to delete this event?');">
										<input type="hidden" name="eventId" value="${event.id}" /> <input
											type="hidden" name="action" value="delete" />
										<!-- Added this -->
										<button type="submit" class="btn btn-danger">Delete</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<!-- Display Past Events -->
				<h2 class="my-4">Past Events</h2>
				<table class="table table-bordered">
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
						<c:forEach var="event" items="${pastEvents}">
							<tr>
								<td>${event.eventName}</td>
								<td>${event.eventDate}</td>
								<td>${event.eventTime}</td>
								<td>${event.eventOrganizer}</td>
								<td>${event.eventPlace}</td>
								<td>${event.eventDescription}</td>
								<td>${event.eventCategory}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<%
			// Load Hibernate SessionFactory
			SessionFactory factory = new Configuration().configure().buildSessionFactory();
			Session hibernateSession = null; // ✅ Renamed to avoid conflict
			List<Message> messages = null;

			try {
				hibernateSession = factory.openSession();
				hibernateSession.beginTransaction();

				// Fetch messages from the database
				messages = hibernateSession.createQuery("FROM Message ORDER BY createdAt DESC", Message.class).list();

				hibernateSession.getTransaction().commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (hibernateSession != null)
					hibernateSession.close();
				if (factory != null)
					factory.close();
			}
			%>

			<div id="messages-content" class="content-section">
				<div class="section-header">
					<h2>Messages</h2>
					<p>Your communications hub</p>
				</div>


				<div class="messages-list"
					style="display: flex; flex-direction: column; gap: 15px;">
					<%
					if (messages != null && !messages.isEmpty()) {
						for (Message msg : messages) {
					%>
					<div class="message-card"
						style="background: #222; color: #fff; padding: 15px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); transition: transform 0.2s ease-in-out;">
						<h3 style="color: #ffcc00; font-size: 1.2rem; margin-bottom: 8px;"><%=msg.getSubject()%></h3>
						<p style="margin: 5px 0; line-height: 1.4;">
							<strong>From:</strong>
							<%=msg.getUserName()%>
							(<%=msg.getUserEmail()%>)
						</p>
						<p style="margin: 5px 0; line-height: 1.4;">
							<strong>Message:</strong>
							<%=msg.getMessage()%>
						</p>
						<p class="message-time"
							style="font-size: 12px; color: #bbb; font-style: italic;"><%=msg.getCreatedAt()%></p>
					</div>
					<%
					}
					} else {
					%>
					<p style="color: #bbb; text-align: center;">No messages found.</p>
					<%
					}
					%>
				</div>
			</div>

			<div id="settings-content" class="content-section">
				<div class="section-header">
					<h2>NOTICE BOARD</h2>
					<p>Kindly pay attention</p>
					<div class="board">
						<div class="board-container"></div>
						<button class="add">+ Add Note</button>
					</div>
				</div>
			</div>


			<div id="maintenance-content" class="content-section">
				<!-- Section Header -->
				<div class="section-header">
					<h2>Maintenance Management</h2>
					<p>Manage maintenance requests, charges, and member payments</p>
				</div>
				<!-- Add/Update/Delete Form -->
				<form action="MaintenanceServlet" method="post"
					id="maintenance-form-section"
					style="background-color: #1A1A2E; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 166, 251, 0.3); width: 50%; margin: auto; font-family: Arial, sans-serif; color: white;">

					<label for="flatSize"
						style="display: block; font-weight: bold; margin-bottom: 5px;">Flat
						Size:</label> <input type="text" id="flatSize" name="flatSize"
						placeholder="E.g., 2BHK" required
						style="width: 100%; padding: 10px; margin-bottom: 15px; border-radius: 5px; border: 1px solid #00A6FB; background-color: #121212; color: white;">

					<label for="amount"
						style="display: block; font-weight: bold; margin-bottom: 5px;">Amount
						(in thousands):</label> <input type="number" id="amount" name="amount"
						placeholder="Enter amount" required
						style="width: 100%; padding: 10px; margin-bottom: 15px; border-radius: 5px; border: 1px solid #00A6FB; background-color: #121212; color: white;">

					<label for="dateAdded"
						style="display: block; font-weight: bold; margin-bottom: 5px;">Date:</label>
					<input type="date" id="dateAdded" name="dateAdded" required
						style="width: 100%; padding: 10px; margin-bottom: 15px; border-radius: 5px; border: 1px solid #00A6FB; background-color: #121212; color: white;">

					<input type="hidden" name="id" id="chargeId"> <input
						type="hidden" name="action" id="actionType" value="add">

					<div id="maintenance-button-group"
						style="text-align: center; margin-top: 15px;">
						<button type="button" onclick="submitForm('add')"
							style="background-color: #00A6FB; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; transition: 0.3s;">
							Add</button>
					</div>

				</form>

				<br>

				<!-- Maintenance Charges Cards -->
				<h3 style="text-align: center; color: white;">Maintenance
					Charges</h3>

				<div id="maintenance-card-container"
					style="display: flex; flex-wrap: wrap; justify-content: center; gap: 20px; padding: 20px;">
					<%
					List<MaintenanceCharges> chargesList = (List<MaintenanceCharges>) request.getAttribute("chargesList");
					if (chargesList != null && !chargesList.isEmpty()) {
						for (MaintenanceCharges charge : chargesList) {
					%>
					<div class="maintenance-card"
						style="background-color: #121212; padding: 15px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 166, 251, 0.3); width: 250px; text-align: center; color: white;">

						<h4 style="margin: 5px 0; color: #00A6FB;"><%=charge.getFlatSize()%></h4>
						<p>
							<strong>Amount:</strong> ₹<%=charge.getAmount() * 1000%></p>
						<p>
							<strong>Date Added:</strong>
							<%=charge.getDateAdded()%></p>

						<button type="button"
							onclick="submitForm('delete', <%=charge.getId()%>)"
							style="background-color: #E63946; color: white; padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; transition: 0.3s;">
							Delete</button>
					</div>
					<%
					}
					} else {
					%>
					<p style="color: white; text-align: center;">No maintenance
						charges found.</p>
					<%
					}
					%>
				</div>

				<!-- Redirect to Add/Update/Delete -->
				<div id="maintenance-more-details" style="text-align: center;">
					<a href="http://localhost:7531/Finalyear/FetchPaymentsServlet">More
						Features</a>
				</div>
			</div>

			<div id="service-content" class="content-section">
				<div class="section-header">
					<h2>Service</h2>
					<p>Monitor and provide essential services</p>
				</div>
				<div class="add-task-container">
					<input type="text" maxlength="12" id="taskText"
						placeholder="New Service..."
						onkeydown="if (event.keyCode == 13) document.getElementById('add').click()">
					<button id="add" class="button add-button" onclick="addTask()">Add</button>
				</div>

				<div class="main-container">
					<ul class="columns">

						<li class="column to-do-column">
							<div class="column-header">
								<h4>Service</h4>
							</div>
							<ul class="task-list" id="to-do">
								<li class="task">
									<p>Cleaning</p>
								</li>
								<li class="task">
									<p>Electricity Maintenance</p>
								</li>
								<li class="task">
									<p>Security Maintenance</p>
								</li>
							</ul>
						</li>

						<li class="column doing-column">
							<div class="column-header">
								<h4>Ongoing services</h4>
							</div>
							<ul class="task-list" id="doing">
								<li class="task">
									<p>Water Tank cleaning</p>
								</li>
							</ul>
						</li>

						<li class="column done-column">
							<div class="column-header">
								<h4>Completed</h4>
							</div>
							<ul class="task-list" id="done">
								<li class="task">
									<p>annual meeting</p>
								</li>
							</ul>
						</li>

						<li class="column trash-column">
							<div class="column-header">
								<h4>❌ Trash</h4>
							</div>
							<ul class="task-list" id="trash">
								<li class="task">
									<p>annual report</p>
								</li>
							</ul>
							<div class="column-button">
								<button class="button delete-button" onclick="emptyTrash()">Delete</button>
							</div>
						</li>

					</ul>
				</div>
			</div>
		</main>
	</div>
	<script>
function redirectToServlet(servletUrl) {
    if (!servletUrl) {
        console.error("Error: servletUrl is undefined or empty.");
        return;
    }
    window.location.href = servletUrl;
}
</script>

	<script>
document.addEventListener("DOMContentLoaded", function () {
    
    // Function to update event
    function updateEvent(eventId) {
        let row = document.getElementById("event-" + eventId);
        
        let formData = new FormData();
        formData.append("action", "update");
        formData.append("eventId", eventId);
        formData.append("eventName", row.querySelector(".event-name").textContent);
        formData.append("eventDate", row.querySelector(".event-date").textContent);
        formData.append("eventTime", row.querySelector(".event-time").textContent);
        formData.append("eventOrganizer", row.querySelector(".event-organizer").textContent);
        formData.append("eventPlace", row.querySelector(".event-place").textContent);
        formData.append("eventDescription", row.querySelector(".event-description").textContent);
        formData.append("eventCategory", row.querySelector(".event-category").textContent);

        fetch("EventActionServlet", {
            method: "POST",
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "success") {
                alert("Event updated successfully.");
                row.querySelector(".event-name").textContent = data.eventName;
                row.querySelector(".event-date").textContent = data.eventDate;
                row.querySelector(".event-time").textContent = data.eventTime;
                row.querySelector(".event-organizer").textContent = data.eventOrganizer;
                row.querySelector(".event-place").textContent = data.eventPlace;
                row.querySelector(".event-description").textContent = data.eventDescription;
                row.querySelector(".event-category").textContent = data.eventCategory;
            } else {
                alert("Update failed: " + data.message);
            }
        })
        .catch(error => console.error("Error:", error));
    }

    // Function to delete event
    function deleteEvent(eventId) {
        let formData = new FormData();
        formData.append("action", "delete");
        formData.append("eventId", eventId);

        fetch("EventActionServlet", {
            method: "POST",
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "success") {
                alert("Event deleted successfully.");
                document.getElementById("event-" + eventId).remove(); // Remove from UI
            } else {
                alert("Delete failed: " + data.message);
            }
        })
        .catch(error => console.error("Error:", error));
    }

    // Attach event listeners to update & delete buttons dynamically
    document.querySelectorAll(".update-button").forEach(button => {
        button.addEventListener("click", function () {
            let eventId = this.getAttribute("data-id");
            updateEvent(eventId);
        });
    });

    document.querySelectorAll(".delete-button").forEach(button => {
        button.addEventListener("click", function () {
            let eventId = this.getAttribute("data-id");
            deleteEvent(eventId);
        });
    });

});
</script>


	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/dragula/3.7.3/dragula.min.js"></script>
	<script src="admin.js"></script>

</body>
</html>
