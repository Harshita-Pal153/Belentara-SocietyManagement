<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="societymanagement.Member" %>
<%@ page import="societymanagement.HibernateUtil" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String email = "";
    try {
        SessionFactory factory = HibernateUtil.getSessionFactory();
        Session hibernateSession = factory.openSession();
        HttpSession httpSession = request.getSession();
        Integer userId = (Integer) httpSession.getAttribute("userId"); 

        if (userId != null) {
            Query<Member> query = hibernateSession.createQuery("FROM Member WHERE id = :id", Member.class);
            query.setParameter("id", userId);
            Member member = query.uniqueResult();
            if (member != null) {
                email = member.getEmail();
            }
        }
        hibernateSession.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error fetching user details. Please try again.</p>");
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resident Profile</title>
<style>
@import url('https://fonts.googleapis.com/css?family=Montserrat');

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  background-color: #141432;
  font-family: Montserrat, sans-serif;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
}

.card-container {
  background: linear-gradient(145deg, #23233a, #1c1c32);
  border-radius: 12px;
  box-shadow: 5px 5px 15px #0e0e22, -5px -5px 15px #22223a;
  color: #b3b8cd;
  padding: 30px;
  text-align: center;
  width: 350px;
  position: relative;
  transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

.card-container:hover {
  transform: translateY(-10px);
  box-shadow: 0px 10px 30px rgba(3, 191, 203, 0.8);
}

.avatar-container {
  position: relative;
  display: inline-block;
}

.avatar-container img {
  border-radius: 50%;
  width: 100px;
  height: 100px;
  border: 4px solid #03bfcb;
  transition: transform 0.3s ease-in-out;
}

.avatar-container img:hover {
  transform: scale(1.1);
}

.avatar-container::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 120px;
  height: 120px;
  border-radius: 50%;
  background: rgba(3, 191, 203, 0.3);
  box-shadow: 0px 0px 15px rgba(3, 191, 203, 0.6);
  transform: translate(-50%, -50%);
  z-index: -1;
  animation: glow 1.5s infinite alternate;
}

@keyframes glow {
  0% { box-shadow: 0px 0px 10px rgba(3, 191, 203, 0.5); }
  100% { box-shadow: 0px 0px 20px rgba(3, 191, 203, 0.9); }
}

h3 {
  margin: 10px 0;
  font-size: 22px;
  font-weight: bold;
}

h6 {
  text-transform: uppercase;
  margin-bottom: 10px;
  font-size: 14px;
  letter-spacing: 1px;
}

.email-container {
  background: rgba(255, 255, 255, 0.1);
  padding: 8px;
  border-radius: 5px;
  margin-top: 10px;
  color: #03bfcb;
  font-size: 14px;
}

p {
  font-size: 14px;
  color: #d1d1e3;
}

button.primary {
  background: linear-gradient(145deg, #03bfcb, #02899c);
  border: none;
  border-radius: 5px;
  color: #fff;
  font-size: 16px;
  padding: 10px 20px;
  cursor: pointer;
  transition: transform 0.3s, background 0.3s;
  margin-top: 15px;
}

button.primary:hover {
  background: linear-gradient(145deg, #02899c, #03bfcb);
  transform: scale(1.05);
}

.links {
  background: rgba(255, 255, 255, 0.1);
  padding: 15px;
  margin-top: 20px;
  border-radius: 5px;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
}

.links a {
  color: #03bfcb;
  text-decoration: none;
  font-size: 14px;
  padding: 5px 10px;
  border-radius: 3px;
  transition: background 0.3s, transform 0.3s;
}

.links a:hover {
  background: #03bfcb;
  color: #231e39;
  transform: scale(1.1);
}
</style>
</head>
<body>
<div class="card-container">
  <div class="avatar-container">
    <img src="https://i.postimg.cc/JzBWVhW4/my-avatar.png" alt="avatar">
  </div>
  <h6>Resident</h6>

  <!-- Email Section -->
  <div class="email-container">
      <p>Welcome to Belentara Society <strong><%= email %></strong></p>
  </div>
  <br>
  <p>Experience community living with Joy<br>
  Belentara Phase 1,Panvel
  </p>
<button class="primary" onclick="window.location.href='createprofile.jsp'">Create Profile</button>

  <div class="links">
    <a href="gallery.jsp">Gallery</a>
    <a href="event.jsp">Events</a>
    <a href="notice.jsp">Notice Board</a>
    <a href="Manual_payment.jsp">Maintenance</a>
    <a href="message.jsp">Messages</a>
  </div>
</div>
</body>
</html>
