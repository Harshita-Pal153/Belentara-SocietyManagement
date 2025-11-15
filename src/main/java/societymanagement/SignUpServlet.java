package societymanagement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (email == null || password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            response.sendRedirect("signup.jsp?error=Passwords do not match or fields are empty");
            return;
        }

        Member member = new Member();
        member.setEmail(email);
        member.setPassword(password);

        SessionFactory factory = HibernateUtil.getSessionFactory(); // Do not close this factory here
        try (Session session = factory.openSession()) {
            Transaction transaction = session.beginTransaction();
            session.save(member);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=Failed to register");
            return;
        }

        // Redirect based on user role for demonstration (simplified logic)
        if ("admin123@gmail.com".equals(email)) {
            response.sendRedirect("admindashboard.jsp");
        } else if ("gatekeeper123@gmail.com".equals(email)) {
            response.sendRedirect("gatekeeper.jsp");
        } else {
            response.sendRedirect("memberdashboard.jsp");
        }
    }
}
