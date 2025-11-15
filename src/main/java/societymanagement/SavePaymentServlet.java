package societymanagement;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.Transaction;
import societymanagement.HibernateUtil;
import societymanagement.UserPayment;
@WebServlet("/SavePaymentServlet")

@MultipartConfig
public class SavePaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String flatSize = request.getParameter("flatSize");
        int amount = Integer.parseInt(request.getParameter("amount"));

        Part filePart = request.getPart("paymentScreenshot");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        
        filePart.write(uploadPath + File.separator + fileName);
        
        String filePath = "uploads/" + fileName;

        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();

        UserPayment payment = new UserPayment(name, email, phone, flatSize, amount, filePath, new Date());
        session.save(payment);
        HttpSession userSession = request.getSession();
        userSession.setAttribute("userEmail", email); // Store email in session

        tx.commit();
        session.close();

        response.sendRedirect("TransactionHistory.jsp");
    }
}
