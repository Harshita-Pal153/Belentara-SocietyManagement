package societymanagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.query.Query;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            response.getWriter().write("Error: Email and password cannot be empty.");
            return;
        }

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Member WHERE email = :email";
            Query<Member> query = session.createQuery(hql, Member.class);
            query.setParameter("email", email);
            Member member = query.uniqueResult();

            if (member == null || !member.getPassword().equals(password)) {
                response.getWriter().write("Error: Invalid email or password.");
                return;
            }

            // **✅ Store user details in session**
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("userId", member.getId());
            httpSession.setAttribute("userEmail", member.getEmail());

            // **Redirect based on role**
            if (email.equals("admin123@gmail.com") && password.equals("234")) {
                response.sendRedirect("admindashboard.jsp");
            } else if (email.equals("gatekeeper123@gmail.com") && password.equals("789")) {
                response.sendRedirect("gatekeeper.jsp");
            } else {
                response.sendRedirect("memberdashboard.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: Unable to verify member data.");
        }
    }
}
