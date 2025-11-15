<%@ page import="java.util.List, societymanagement.UserPayment" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>User Payment Records</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            transition: 0.3s ease-in-out;
        }
        .container:hover {
            box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.15);
        }
        h2 {
            color: #0056b3;
            text-align: center;
            font-weight: bold;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .search-container {
            margin-bottom: 20px;
            text-align: right;
        }
        .search-box {
            width: 100%;
            max-width: 300px;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        thead th {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: white;
            text-align: center;
            padding: 12px;
            font-size: 16px;
            text-transform: uppercase;
        }
        tbody tr:hover {
            background-color: #f1f1f1;
            transition: 0.3s ease-in-out;
        }
        td {
            text-align: center;
            vertical-align: middle;
            padding: 10px;
            font-size: 14px;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
            padding: 6px 12px;
            font-size: 14px;
            transition: all 0.3s ease-in-out;
        }
        .btn-danger:hover {
            background-color: #c82333;
            transform: scale(1.05);
        }
        img.img-thumbnail {
            border-radius: 8px;
            transition: 0.3s ease-in-out;
        }
        img.img-thumbnail:hover {
            transform: scale(1.2);
            box-shadow: 0px 0px 8px rgba(0, 0, 0, 0.2);
        }
    </style>

    <!-- JavaScript for Search Functionality -->
    <script>
        function searchPayments() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.getElementById("paymentTable").getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Start from 1 to skip table headers
                let cells = rows[i].getElementsByTagName("td");
                let match = false;

                for (let j = 0; j < cells.length; j++) {
                    if (cells[j].textContent.toLowerCase().includes(input)) {
                        match = true;
                        break;
                    }
                }
                rows[i].style.display = match ? "" : "none";
            }
        }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2>User Payment Records</h2>

        <!-- Search Bar -->
        <div class="search-container">
            <input type="text" id="searchInput" class="search-box" onkeyup="searchPayments()" placeholder="Search records...">
        </div>

        <!-- Payment Records Table -->
        <table class="table table-bordered table-striped" id="paymentTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Flat Size</th>
                    <th>Amount</th>
                    <th>Payment Date</th>
                    <th>Screenshot</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<UserPayment> payments = (List<UserPayment>) request.getAttribute("payments");
                    if (payments != null && !payments.isEmpty()) {
                        for (UserPayment payment : payments) {
                %>
                <tr>
                    <td><%= payment.getId() %></td>
                    <td><%= payment.getName() %></td>
                    <td><%= payment.getEmail() %></td>
                    <td><%= payment.getPhone() %></td>
                    <td><%= payment.getFlatSize() %></td>
                    <td>₹<%= payment.getAmount() %></td>
                    <td><%= payment.getPaymentDate() %></td>
                    <td>
                        <a href="<%= payment.getPaymentScreenshot() %>" target="_blank">
                            <img src="<%= payment.getPaymentScreenshot() %>" width="50" class="img-thumbnail">
                        </a>
                    </td>
                    <td>
                        <a href="DeletePaymentServlet?id=<%= payment.getId() %>" class="btn btn-danger btn-sm" 
                           onclick="return confirm('Are you sure you want to delete this record?');">
                            Delete
                        </a>
                    </td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="9" class="text-center">No Payment Records Found</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
