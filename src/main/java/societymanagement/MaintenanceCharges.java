package societymanagement;

import javax.persistence.*;
import java.util.Date;
import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "MaintenanceCharges")
public class MaintenanceCharges {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "flatSize", nullable = false)
    private String flatSize;

    @Column(name = "amount", nullable = false)
    private int amount;

    @Column(name = "dateAdded", nullable = false)
    private Date dateAdded;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFlatSize() {
        return flatSize;
    }

    public void setFlatSize(String flatSize) {
        this.flatSize = flatSize;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Date dateAdded) {
        this.dateAdded = dateAdded;
    }
}
