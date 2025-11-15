package societymanagement;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class EventDAO {

    private SessionFactory sessionFactory;

    public EventDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    // Create or Update Event
    public void saveOrUpdateEvent(Event event) {
        try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction();
            session.saveOrUpdate(event);
            transaction.commit();
        }
    }

    // Get Upcoming Events
    public List<Event> getUpcomingEvents() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM Event WHERE eventDate >= CURRENT_DATE ORDER BY eventDate ASC", Event.class).list();
        }
    }

    // Get Past Events
    public List<Event> getPastEvents() {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM Event WHERE eventDate < CURRENT_DATE ORDER BY eventDate DESC", Event.class).list();
        }
    }

    // Delete Event
    public void deleteEvent(Long eventId) {
        try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction();
            Event event = session.load(Event.class, eventId);
            session.delete(event);
            transaction.commit();
        }
    }
}
