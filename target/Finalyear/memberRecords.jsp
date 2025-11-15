<%@ page import="java.util.List" %>
<%@ page import="java.lang.Object" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Member Records</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- DataTables CSS (for Search, Sorting, Pagination) -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #121212;
            color: white;
        }
        .container {
            margin-top: 50px;
        }
        h2 {
            color: #00bcd4;
            text-align: center;
        }
        .table-container {
            background: #1e1e1e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 188, 212, 0.3);
        }
        .table th {
            background-color: #00bcd4;
            color: white;
        }
        .table tbody tr:hover {
            background-color: rgba(0, 188, 212, 0.2);
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Member Records</h2>
        <p class="text-center">Track member records easily</p>

        <div class="table-container">
            <table id="memberTable" class="table table-striped table-dark table-hover">
                <thead>
                    <tr>
                        <th>Resident Name</th>
                        <th>Email</th>
                        <th>Flat No</th>
                        <th>Block No</th>
                        <th>Staff Name</th>
                        <th>Staff Role</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Object[]> records = (List<Object[]>) request.getAttribute("records");
                        if (records != null && !records.isEmpty()) {
                            for (Object[] record : records) {
                                String residentName = record[0] + " " + record[1];
                                String email = (String) record[2];
                                String flatNo = (String) record[3];
                                String blockNo = (String) record[4];
                                String staffName = (record[5] != null) ? (String) record[5] : "N/A";
                                String staffRole = (record[6] != null) ? (String) record[6] : "N/A";
                    %>
                    <tr>
                        <td><%= residentName %></td>
                        <td><%= email %></td>
                        <td><%= flatNo %></td>
                        <td><%= blockNo %></td>
                        <td><%= staffName %></td>
                        <td><%= staffRole %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="text-center">No records found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- jQuery & DataTables JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

    <!-- DataTables Initialization -->
    <script>
        $(document).ready(function () {
            $('#memberTable').DataTable({
                "paging": true,
                "searching": true,
                "ordering": true,
                "lengthMenu": [5, 10, 25, 50]
            });
        });
    </script>

</body>
</html>
