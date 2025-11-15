package societymanagement;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

@WebServlet("/MaintenanceServlet")
public class MaintenanceServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    List<MaintenanceCharges> chargesList = null;

	    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
	        Query<MaintenanceCharges> query = session.createQuery("FROM MaintenanceCharges", MaintenanceCharges.class);
	        chargesList = query.list();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    request.setAttribute("chargesList", chargesList);
	    RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
	    dispatcher.forward(request, response);
	}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String flatSize = request.getParameter("flatSize");
        String amountStr = request.getParameter("amount");
        String dateAddedStr = request.getParameter("dateAdded");
        String idStr = request.getParameter("id");

        int amount = (amountStr != null && !amountStr.trim().isEmpty()) ? Integer.parseInt(amountStr) : 0;
        int id = (idStr != null && !idStr.trim().isEmpty()) ? Integer.parseInt(idStr) : 0;

        Date dateAdded = null;
        try {
            if (dateAddedStr != null && !dateAddedStr.trim().isEmpty()) {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                dateAdded = formatter.parse(dateAddedStr);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Transaction transaction = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            if ("add".equals(action)) {
                MaintenanceCharges newCharge = new MaintenanceCharges();
                newCharge.setFlatSize(flatSize);
                newCharge.setAmount(amount);
                newCharge.setDateAdded(dateAdded);

                session.save(newCharge);
            } 

            else if ("delete".equals(action) && id > 0) {
                MaintenanceCharges chargeToDelete = session.get(MaintenanceCharges.class, id);
                if (chargeToDelete != null) {
                    session.delete(chargeToDelete);
                }
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback(); // Rollback in case of error
            }
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/MaintenanceServlet");
    }
}