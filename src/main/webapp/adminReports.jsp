<%@ page import="java.util.List" %>
<%@page import="com.ninfinity.dao.ReportDAO"%>
<%@page import="com.ninfinity.dao.DatabaseConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports & Analytics - SkillBazaar</title>
    <link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F7FA;
            color: #333333;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            background-color: #FFFFFF;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }
        .logo img {
            height: 60px;
        }
        .auth-buttons {
            display: flex;
            align-items: center;
        }
        .auth-buttons span {
            font-size: 16px;
            font-weight: 500;
            margin-right: 20px;
        }
        .auth-buttons a {
            color: #333333;
            text-decoration: none;
            padding: 8px 20px;
            border: 2px solid #00C4B4;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .auth-buttons a:hover {
            background-color: #00C4B4;
            color: #FFFFFF;
        }
        .sidebar {
            width: 270px;
            background: linear-gradient(135deg, #34495e, #2c3e50);
            position: fixed;
            top: 80px;
            bottom: 0;
            left: 0;
            padding-top: 40px;
            color: #FFFFFF;
            z-index: 999;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.15);
            border-right: 1px solid rgba(255, 255, 255, 0.1);
        }
        .sidebar ul {
            list-style: none;
        }
        .sidebar ul li {
            padding: 20px 25px;
            margin: 5px 10px;
            transition: all 0.3s ease;
        }
        .sidebar ul li a {
            color: #FFFFFF;
            text-decoration: none;
            display: flex;
            align-items: center;
            font-size: 18px;
            font-weight: 500;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .sidebar ul li a i {
            margin-right: 15px;
            font-size: 20px;
        }
        .sidebar ul li:hover,
        .sidebar ul li.active {
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
        }
        .sidebar ul li a:hover,
        .sidebar ul li.active a {
            background-color: #00C4B4;
            color: #FFFFFF;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .container {
            margin-left: 290px;
            padding: 120px 50px 100px;
            max-width: 1200px;
        }
        h1 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #333333;
        }
        .summary {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 25px;
        }
        .summary-card {
            background-color: #FFFFFF;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            flex: 1;
            min-width: 220px;
            text-align: center;
            transition: all 0.3s ease;
        }
        .summary-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
        }
        .summary-card h3 {
            font-size: 18px;
            color: #333333;
            margin-bottom: 15px;
            font-weight: 500;
        }
        .summary-card p {
            font-size: 26px;
            color: #00C4B4;
            font-weight: 600;
        }
        .add-btn-container {
            margin-top: 40px;
            text-align: center;
        }
        .add-btn-container form {
            display: inline-block;
        }
        .add-btn-container select {
            padding: 10px 15px;
            border: 2px solid #E0E0E0;
            border-radius: 8px;
            font-size: 14px;
            margin-right: 15px;
            background-color: #FFFFFF;
            transition: border-color 0.3s ease;
        }
        .add-btn-container select:focus {
            border-color: #00C4B4;
            outline: none;
        }
        .add-btn-container button {
            padding: 10px 25px;
            background-color: #00C4B4;
            color: #FFFFFF;
            border: none;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .add-btn-container button:hover {
            background-color: #00A89A;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
        .error {
            color: #dc3545;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
        }
        /* Enhanced Table Styling */
        /* Enhanced Table Styling */
.table-wrapper {
    margin-top: 40px;
    background-color: #FFFFFF;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    animation: fadeIn 0.5s ease-in-out;
}
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    table-layout: fixed; /* Ensure columns are evenly distributed */
}
thead {
    display: table; /* Keep thead as a table for proper column alignment */
    width: 100%;
}
thead th {
    background: linear-gradient(135deg, #00C4B4, #00A89A);
    color: #FFFFFF;
    font-weight: 600;
    font-size: 15px;
    padding: 18px 20px;
    text-transform: uppercase;
    letter-spacing: 1px;
    position: sticky;
    top: 0;
    z-index: 10;
    border-bottom: 2px solid rgba(255, 255, 255, 0.2);
    cursor: pointer;
}
thead th:hover {
    background: linear-gradient(135deg, #00A89A, #00897B);
}
thead th i {
    margin-left: 8px;
    font-size: 12px;
    opacity: 0.7;
}
tbody {
    display: table; /* Change from block to table for proper column alignment */
    width: 100%;
    max-height: 400px; /* Retain scrolling */
    overflow-y: auto;
}
tbody tr {
    display: table; /* Ensure rows span full width */
    width: 100%;
    table-layout: fixed; /* Match table’s fixed layout */
    background-color: #FFFFFF;
    transition: all 0.3s ease;
}
tbody tr:nth-child(even) {
    background-color: #F9FAFB;
}
tbody tr:hover {
    background-color: #E6F7F6;
    transform: scale(1.01);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}
td {
    padding: 15px 20px;
    font-size: 14px;
    color: #444444;
    border-bottom: 1px solid #E0E0E0;
    word-wrap: break-word; /* Ensure content fits within cell */
}
td:first-child {
    font-weight: 500;
    color: #00C4B4;
}
        /* Pagination */
        .pagination {
            padding: 20px;
            text-align: center;
            background-color: #FFFFFF;
            border-top: 1px solid #E0E0E0;
        }
        .pagination a {
            color: #00C4B4;
            text-decoration: none;
            padding: 8px 15px;
            margin: 0 5px;
            border: 1px solid #E0E0E0;
            border-radius: 25px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .pagination a:hover,
        .pagination a.active {
            background-color: #00C4B4;
            color: #FFFFFF;
            border-color: #00C4B4;
        }
        footer {
            background-color: #FFFFFF;
            color: #666666;
            text-align: center;
            padding: 20px;
            border-top: 1px solid #E0E0E0;
            margin-top: 40px;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.05);
            margin-left: 270px;
        }
        footer a {
            color: #00C4B4;
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s ease;
        }
        footer a:hover {
            color: #00A89A;
        }
        .project-note {
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <a href="home"><img src="assets/logos/skillbazaar.png" alt="SkillBazaar Logo"></a>
        </div>
        <div class="auth-buttons">
            <span>Welcome, Admin</span>
            <a href="logout">Logout</a>
        </div>
    </header>

    <div class="sidebar">
        <ul>
            <li><a href="AdminMainPage.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="adminCourses.jsp"><i class="fas fa-book-open"></i> Courses</a></li>
            <li><a href="adminInstructor.jsp"><i class="fas fa-chalkboard-teacher"></i> Instructors</a></li>
            <li><a href="adminOrder.jsp"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="adminUsers.jsp"><i class="fas fa-users"></i> Users</a></li>
            <li><a href="adminPayments.jsp"><i class="fas fa-money-check-alt"></i> Payments</a></li>
            <li class="active"><a href="adminReports.jsp"><i class="fas fa-chart-bar"></i> Reports</a></li>
        </ul>
    </div>

    <div class="container">
        <h1>Reports & Analytics</h1>
        <%
        ReportDAO rDao = new ReportDAO(DatabaseConnect.connect());
        %>
        <div class="summary">
            <div class="summary-card">
                <h3>Total Enrollments</h3>
                <p><%= rDao.getTotalEnrollments() %></p>
            </div>
            <div class="summary-card">
                <h3>Total Revenue</h3>
                <p>₹<%= String.format("%.2f", rDao.getTotalRevenue()) %></p>
            </div>
            <div class="summary-card">
                <h3>Average Course Rating</h3>
                <p><%= String.format("%.1f", rDao.getAverageCourseRating()) %></p>
            </div>
            <div class="summary-card">
                <h3>Active Instructors</h3>
                <p><%= rDao.getActiveInstructors() %></p>
            </div>
        </div>
        <div class="add-btn-container">
            <% if (request.getParameter("error") != null) { %>
                <div class="error">Failed to generate report. Please try again.</div>
            <% } %>
            <form action="<%= request.getContextPath() %>/adminReportsController" method="post">
                <select name="reportType" required>
                    <option value="">Select Report Type</option>
                    <option value="Total Revenue">Total Revenue</option>
                    <option value="Total Enrollments">Total Enrollments</option>
                    <option value="Average Course Rating">Average Course Rating</option>
                    <option value="Daily Revenue">Daily Revenue</option>
                </select>
                <button type="submit">Generate Report</button>
            </form>
        </div>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Report ID <i class="fas fa-sort"></i></th>
                        <th>Report Type <i class="fas fa-sort"></i></th>
                        <th>Value <i class="fas fa-sort"></i></th>
                        <th>Generated Date <i class="fas fa-sort"></i></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    List<Object[]> reports = rDao.getAllReports();
                    int itemsPerPage = 10;
                    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int start = (currentPage - 1) * itemsPerPage;
                    int end = Math.min(start + itemsPerPage, reports.size());
                    for (int i = start; i < end && i < reports.size(); i++) {
                        Object[] report = reports.get(i);
                    %>
                        <tr>
                            <td><%= report[0] %></td>
                            <td><%= report[1] %></td>
                            <td>
                                <% 
                                String reportType = (String) report[1];
                                double value = (Double) report[2];
                                if (reportType.equals("Total Revenue") || reportType.equals("Daily Revenue")) {
                                    out.print("₹" + String.format("%.2f", value));
                                } else if (reportType.equals("Average Course Rating")) {
                                    out.print(String.format("%.1f", value));
                                } else {
                                    out.print((int) value);
                                }
                                %>
                            </td>
                            <td><%= report[3] %></td>
                        </tr>
                    <% } rDao.closeConnection(); %>
                </tbody>
            </table>
            <%
            int totalPages = (int) Math.ceil((double) reports.size() / itemsPerPage);
            if (totalPages > 1) {
            %>
            <div class="pagination">
                <% if (currentPage > 1) { %>
                    <a href="adminReports.jsp?page=<%= currentPage - 1 %>">« Prev</a>
                <% } %>
                <%
                for (int p = 1; p <= totalPages; p++) {
                %>
                    <a href="adminReports.jsp?page=<%= p %>" class="<%= p == currentPage ? "active" : "" %>"><%= p %></a>
                <% } %>
                <% if (currentPage < totalPages) { %>
                    <a href="adminReports.jsp?page=<%= currentPage + 1 %>">Next »</a>
                <% } %>
            </div>
            <% } %>
        </div>
    </div>

    <footer>
        <p>© 2025 SkillBazaar. All rights reserved.</p>
        <p class="project-note">A project by N-Infinity Info Solutions under the guidance of Prof. Prasad Sase.</p>
        <a href="#">About</a>
        <a href="#">Contact</a>
        <a href="#">Privacy Policy</a>
    </footer>
</body>
</html>