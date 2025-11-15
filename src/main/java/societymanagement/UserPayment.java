package societymanagement;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "user_payments")
public class UserPayment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private String email;
    private String phone;
    private String flatSize;
    private int amount;
    private String paymentScreenshot; // Store image path in DB

    @Temporal(TemporalType.TIMESTAMP) // Ensures proper date format
    @Column(name = "payment_date", nullable = false, updatable = false)
    private Date paymentDate;

    public UserPayment() {}

    public UserPayment(String name, String email, String phone, String flatSize, int amount, String paymentScreenshot, Date paymentDate) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.flatSize = flatSize;
        this.amount = amount;
        this.paymentScreenshot = paymentScreenshot;
        this.paymentDate = paymentDate;
    }

    // Getters and Setters
    public int getId() { return id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getFlatSize() { return flatSize; }
    public void setFlatSize(String flatSize) { this.flatSize = flatSize; }

    public int getAmount() { return amount; }
    public void setAmount(int amount) { this.amount = amount; }

    public String getPaymentScreenshot() { return paymentScreenshot; }
    public void setPaymentScreenshot(String paymentScreenshot) { this.paymentScreenshot = paymentScreenshot; }

    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }

	public void setId(int i) {
		// TODO Auto-generated method stub
		
	}
}
