package societymanagement;

import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class NoticeDAO {

	public void saveNotice(Notice notice) {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			Transaction tx = session.beginTransaction();
			session.saveOrUpdate(notice);
			tx.commit();
		}
	}

	public List<Notice> getAllNotices() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		List<Notice> notices = session.createQuery("FROM Notice", Notice.class).list();
		session.close();
		return notices;
	}

	public void deleteNotice(int id) {
		try (Session session = HibernateUtil.getSessionFactory().openSession()) {
			Transaction tx = session.beginTransaction();
			Notice notice = session.get(Notice.class, id);
			if (notice != null) {
				session.delete(notice);
			}
			tx.commit();
		}
	}
}
