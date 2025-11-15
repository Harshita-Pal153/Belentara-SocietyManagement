package societymanagement;

import com.google.gson.Gson;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NoticeServlet")
public class NoticeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        List<Notice> notices = new NoticeDAO().getAllNotices();  // Fetch from DAO
        
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(notices));
        out.flush();
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String posX = request.getParameter("posX");
        String posY = request.getParameter("posY");

        if (title == null || content == null || posX == null || posY == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"error\": \"Missing parameters\"}");
            return;
        }

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Notice notice;

            if (id == null || id.isEmpty()) {
                // Create new notice
                notice = new Notice(title, content, Integer.parseInt(posX), Integer.parseInt(posY));
                session.save(notice);
            } else {
                // Update existing notice
                notice = session.get(Notice.class, Integer.parseInt(id));
                if (notice != null) {
                    notice.setTitle(title);
                    notice.setContent(content);
                    notice.setPosX(Integer.parseInt(posX));
                    notice.setPosY(Integer.parseInt(posY));
                    session.update(notice);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.write("{\"error\": \"Notice not found\"}");
                    return;
                }
            }

            tx.commit();
            out.write(new Gson().toJson(notice));

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\": \"Database error\"}");
        }
    }
}
