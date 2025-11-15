package societymanagement;
import org.hibernate.Session;
import org.hibernate.Transaction;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
@WebServlet("/ResidentProfileServlet")
public class ResidentProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get data from the form
        String residentIdStr = request.getParameter("resident-id");
        int residentId = 0; // Default value, change if needed

        // Check if resident-id is not empty or null before parsing
        if (residentIdStr != null && !residentIdStr.trim().isEmpty()) {
            try {
                residentId = Integer.parseInt(residentIdStr);
            } catch (NumberFormatException e) {
                // Handle the case when resident-id is not a valid integer
                e.printStackTrace();
                // You can redirect to an error page or set residentId to a default value
            }
        }

        // Other form data
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String altPhone = request.getParameter("alt-phone");
        String flatNo = request.getParameter("flat-no");
        String blockNo = request.getParameter("block-no");
        String staffName = request.getParameter("staff-name");
        String staffNumber = request.getParameter("staff-number");
        String staffRole = request.getParameter("staff-role");

        // Create ResidentProfile object
        ResidentProfile residentProfile = new ResidentProfile();
        residentProfile.setResidentId(residentId);
        residentProfile.setFirstName(firstName);
        residentProfile.setLastName(lastName);
        residentProfile.setEmail(email);
        residentProfile.setPhone(phone);
        residentProfile.setAltPhone(altPhone);
        residentProfile.setFlatNo(flatNo);
        residentProfile.setBlockNo(blockNo);
        residentProfile.setStaffName(staffName);
        residentProfile.setStaffNumber(staffNumber);
        residentProfile.setStaffRole(staffRole);

        // Get Hibernate Session
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;

        try {
            // Begin a transaction
            transaction = session.beginTransaction();

            // Save the resident profile object
            session.save(residentProfile);

            // Commit the transaction
            transaction.commit();

            // Redirect to success page
            response.sendRedirect("memberdashboard.jsp");
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback(); // Rollback in case of error
            }
            e.printStackTrace();
            // Redirect to error page
            response.sendRedirect("error.jsp");
        } finally {
            session.close(); // Close the session
        }
    }
}
