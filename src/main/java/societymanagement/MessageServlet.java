package societymanagement;
import societymanagement.Message;
import societymanagement.HibernateUtil;

import org.hibernate.Session;
import org.hibernate.Transaction;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MessageServlet") 
public class MessageServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("user_name");
        String userEmail = request.getParameter("user_email");
        String subject = request.getParameter("subject");
        String messageText = request.getParameter("message");

        Message message = new Message();
        message.setUserName(userName);
        message.setUserEmail(userEmail);
        message.setSubject(subject);
        message.setMessage(messageText);

        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(message);
            transaction.commit();
            response.sendRedirect("message.jsp"); // Redirect to a success page
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
    }
}
