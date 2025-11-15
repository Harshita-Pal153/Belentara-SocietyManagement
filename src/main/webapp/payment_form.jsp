<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="societymanagement.HibernateUtil" %>
<%@ page import="societymanagement.MaintenanceCharges" %>


<!DOCTYPE html>
<html>
<head>
    <title>Maintenance Payment</title>
<style>
    /* Dark Mode Styling with Full-Page Background Image */
    body {
        font-family: Arial, sans-serif;
        background: url('image.png') no-repeat center center fixed; 
        background-size: cover;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        color: #ffffff;
    }

    .container {
        width: 35%; /* Reduced size */
        background: rgba(20, 20, 20, 0.85); /* Semi-transparent dark background */
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.4);
        text-align: center;
        transition: transform 0.3s ease-in-out;
    }

    .container:hover {
        transform: scale(1.02);
    }

    img {
        width: 120px; /* Slightly smaller */
        margin-bottom: 15px;
        border-radius: 10px;
        border: 2px solid #fff;
    }

    h2 {
        color: #f8f9fa;
        font-size: 20px;
        margin-bottom: 10px;
    }

    label {
        font-weight: bold;
        display: block;
        margin-top: 12px;
        text-align: left;
        color: #ddd;
    }

    input, select, textarea, button {
        width: 100%;
        margin-top: 6px;
        border: 1px solid #444;
        border-radius: 6px;
        font-size: 14px;
        background: #222;
        color: #fff;
        transition: 0.3s;
    }

    input:focus, select:focus, textarea:focus {
        border-color: #007bff;
        outline: none;
        box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5);
    }

    select {
        cursor: pointer;
    }

    textarea {
        height: 80px; /* Ensuring proper spacing */
        resize: vertical; /* Allow resizing but maintain spacing */
    }

    input[readonly] {
        background-color: #333;
    }

    button {
        background: #007bff;
        color: white;
        border: none;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        transition: background 0.3s;
        margin-top: 15px;
    }

    button:hover {
        background: #0056b3;
    }
</style>

</head>
<body>
    <div class="container">
        <img src="gpay_qr.jpg" alt="Scan QR Code">
        <h2>Pay Maintenance Charges</h2>

        <%
            // Fetching data from Hibernate
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Query<MaintenanceCharges> query = hibernateSession.createQuery("FROM MaintenanceCharges", MaintenanceCharges.class);
            List<MaintenanceCharges> flatSizes = query.list();
            hibernateSession.close();
        %>

        <form action="SavePaymentServlet" method="post" enctype="multipart/form-data">
            <input type="text" name="name" placeholder="Enter Name" required><br>
            <input type="email" name="email" placeholder="Enter Email" required><br>
            <input type="tel" name="phone" placeholder="Enter Phone Number" required><br>

            <!-- Flat Size Selection -->
            <label for="flatSize">Select Flat Size:</label>
            <select name="flatSize" id="flatSize" onchange="updateAmount()" required>
                <option value="">Select Flat Size</option>
                <%
                    for (MaintenanceCharges charge : flatSizes) {
                        out.print("<option value='" + charge.getFlatSize() + "'>" + charge.getFlatSize() + "</option>");
                    }
                %>
            </select><br>

            <!-- Amount Field (Automatically Updated) -->
            <label for="amount">Amount(In thousands):</label>
            <input type="text" name="amount" id="amount" placeholder="Amount" readonly><br>

            <!-- Payment Screenshot Upload -->
            <label for="paymentScreenshot">Upload Payment Screenshot:</label>
            <input type="file" name="paymentScreenshot" accept="image/*" required><br>

            <button type="submit">Submit Payment</button>
        </form>
    </div>

    <script>
        function updateAmount() {
            var flatSize = document.getElementById("flatSize").value;
            var amountField = document.getElementById("amount");

            var amounts = {
                <% 
                    for (MaintenanceCharges charge : flatSizes) {
                        out.print("'" + charge.getFlatSize() + "': " + charge.getAmount() + ",");
                    }
                %>
            };

            amountField.value = amounts[flatSize] || 0;
        }
    </script>

</body>
</html>
