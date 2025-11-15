<%@ page import="java.util.List, societymanagement.HibernateUtil, societymanagement.UserPayment, org.hibernate.Session" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Transaction History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #343a40;
        }
        .table {
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }
        .table th {
            background: #007bff;
            color: white;
            text-align: center;
        }
        .table td, .table th {
            text-align: center;
            vertical-align: middle;
        }
        .table img {
            width: 80px;
            cursor: pointer;
            transition: transform 0.3s ease-in-out;
        }
        .table img:hover {
            transform: scale(1.8);
            border: 2px solid #007bff;
        }
        .no-data {
            text-align: center;
            font-size: 18px;
            color: #6c757d;
            padding: 20px;
        }
        #searchBox {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Your Transaction History</h2>

        <input type="text" id="searchBox" class="form-control" placeholder="Search by Flat Size (e.g., 1BHK, 2BHK, 3BHK)" onkeyup="filterTable()">

        <%
            // Retrieve email from session (set in SavePaymentServlet)
            String userEmail = (String) session.getAttribute("userEmail");

            if (userEmail == null || userEmail.isEmpty()) {
        %>
                <p class="no-data">No transactions found.</p>
        <%
            } else {
                // Hibernate session to fetch records
                Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
                List<UserPayment> transactions = hibernateSession.createQuery(
                    "FROM UserPayment WHERE email = :email ORDER BY paymentDate DESC", UserPayment.class)
                    .setParameter("email", userEmail)
                    .list();
                hibernateSession.close();

                if (transactions.isEmpty()) {
        %>
                    <p class="no-data">No transaction history found.</p>
        <%
                } else {
        %>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Flat Size</th>
                                    <th>Amount(In thousand)</th>
                                    <th>Payment Screenshot</th>
                                    <th>Payment Date</th>
                                </tr>
                            </thead>
                            <tbody id="transactionTable">
        <%
                        for (UserPayment payment : transactions) {
        %>
                                <tr>
                                    <td><%= payment.getName() %></td>
                                    <td><%= payment.getEmail() %></td>
                                    <td><%= payment.getPhone() %></td>
                                    <td class="flat-size"><%= payment.getFlatSize() %></td>
                                    <td><b>₹<%= payment.getAmount() %></b></td>
                                    <td>
                                        <a href="<%= payment.getPaymentScreenshot() %>" target="_blank">
                                            <img src="<%= payment.getPaymentScreenshot() %>" alt="Screenshot">
                                        </a>
                                    </td>
                                    <td><%= payment.getPaymentDate() %></td>
                                </tr>
        <%
                        }
        %>
                            </tbody>
                        </table>
                    </div>
        <%
                }
            }
        %>
    </div>

    <script>
        function filterTable() {
            let input = document.getElementById("searchBox").value.toLowerCase();
            let rows = document.querySelectorAll("#transactionTable tr");

            rows.forEach(row => {
                let flatSize = row.querySelector(".flat-size").textContent.toLowerCase();
                row.style.display = flatSize.includes(input) ? "" : "none";
            });
        }
    </script>

</body>
</html>
