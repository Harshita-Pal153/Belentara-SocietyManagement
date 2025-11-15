package societymanagement;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import org.hibernate.Session;
import org.hibernate.query.Query;

@WebServlet("/FetchPaymentsServlet")
public class FetchPaymentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Query<UserPayment> query = session.createQuery("FROM UserPayment ORDER BY paymentDate DESC", UserPayment.class);
            List<UserPayment> payments = query.list();
            
            request.setAttribute("payments", payments);
            RequestDispatcher dispatcher = request.getRequestDispatcher("view_payments.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}
