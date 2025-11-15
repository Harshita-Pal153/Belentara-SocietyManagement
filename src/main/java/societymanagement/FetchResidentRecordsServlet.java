package societymanagement;

import com.google.gson.Gson;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/FetchResidentRecordsServlet")
public class FetchResidentRecordsServlet extends HttpServlet {
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionFactory factory = HibernateUtil.getSessionFactory();
        Session session = factory.openSession();
        
        try {
            String hql = "SELECT r.firstName, r.lastName, r.email, r.flatNo, r.blockNo, r.staffName, r.staffRole FROM ResidentProfile r";
            Query<Object[]> query = session.createQuery(hql, Object[].class);
            List<Object[]> records = query.list();

            request.setAttribute("records", records);
            request.getRequestDispatcher("memberRecords.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }
}
