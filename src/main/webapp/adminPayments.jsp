<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% if (request.getAttribute("paymentsList") == null) { response.sendRedirect(request.getContextPath() + "/AdminPaymentsController"); return; } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payments - SkillBazaar</title>
    <link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background-color: #F5F7FA; color: #333333; }
        header {
            display: flex; justify-content: space-between; align-items: center; padding: 20px 50px;
            background-color: #FFFFFF; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); position: fixed;
            width: 100%; top: 0; z-index: 1000;
        }
        .logo img { height: 60px; }
        .auth-buttons { display: flex; align-items: center; gap: 15px; }
        .auth-buttons span { font-size: 16px; font-weight: 500; }
        .auth-buttons a {
            color: #333333; text-decoration: none; padding: 8px 20px; border: 2px solid #00C4B4;
            border-radius: 25px; font-size: 14px; font-weight: 500; transition: all 0.3s ease;
        }
        .auth-buttons a:hover { background-color: #00C4B4; color: #FFFFFF; }
        .sidebar {
            width: 270px; background: linear-gradient(135deg, #34495e, #2c3e50); position: fixed;
            top: 80px; bottom: 0; left: 0; padding-top: 40px; color: #FFFFFF; z-index: 999;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.15); border-right: 1px solid rgba(255, 255, 255, 0.1);
        }
        .sidebar ul { list-style: none; }
        .sidebar ul li { padding: 20px 25px; margin: 5px 10px; transition: all 0.3s ease; }
        .sidebar ul li a {
            color: #FFFFFF; text-decoration: none; display: flex; align-items: center; font-size: 18px;
            font-weight: 500; padding: 10px; border-radius: 8px; transition: all 0.3s ease;
        }
        .sidebar ul li a i { margin-right: 15px; font-size: 20px; }
        .sidebar ul li:hover, .sidebar ul li.active { background-color: rgba(255, 255, 255, 0.1); border-radius: 8px; }
        .sidebar ul li a:hover, .sidebar ul li.active a { background-color: #00C4B4; color: #FFFFFF; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); }
        .container { margin-left: 290px; padding: 120px 50px 100px; max-width: 1200px; }
        .main-heading { font-size: 28px; font-weight: 600; margin-bottom: 30px; color: #333333; text-align: center; }
        .payments-table {
            width: 100%; background-color: #FFFFFF; border-radius: 12px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            padding: 30px; margin-bottom: 30px;
        }
        .payments-table table { width: 100%; border-collapse: collapse; }
        .payments-table th, .payments-table td { padding: 15px; text-align: left; border-bottom: 1px solid #E0E0E0; }
        .payments-table th { background-color: #00C4B4; color: #FFFFFF; font-weight: 600; }
        .payments-table td { color: #333333; }
        .payments-table tr:hover { background-color: #F5F7FA; }
        .status-completed { color: #4CAF50; font-weight: 500; }
        .status-pending { color: #FFA500; font-weight: 500; }
        .status-canceled { color: #FF4444; font-weight: 500; }
        .payment-status-form select {
            padding: 8px; border: 1px solid #E0E0E0; border-radius: 5px; font-size: 14px; color: #333333;
        }
        .payment-status-form button {
            padding: 8px 15px; border: none; border-radius: 20px; background-color: #00C4B4; color: #FFFFFF;
            font-size: 14px; cursor: pointer; transition: background-color 0.3s ease; margin-left: 10px;
        }
        .payment-status-form button:hover { background-color: #00A89A; }
        .message, .error { text-align: center; margin: 20px 0; }
        .message { color: #666666; }
        .error { color: red; }
        footer {
            background-color: #FFFFFF; color: #666666; text-align: center; padding: 20px; border-top: 1px solid #E0E0E0;
            margin-top: 40px; box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.05); margin-left: 270px;
        }
        footer a { color: #00C4B4; text-decoration: none; margin: 0 10px; transition: color 0.3s ease; }
        footer a:hover { color: #00A89A; }
        .project-note { font-size: 14px; margin-top: 10px; }
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
            <li class="active"><a href="adminPayments.jsp"><i class="fas fa-money-check-alt"></i> Payments</a></li>
            <li><a href="adminReports.jsp"><i class="fas fa-chart-bar"></i> Reports</a></li>
        </ul>
    </div>

    <div class="container">
        <h1 class="main-heading">Payments Management</h1>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>
        <div class="payments-table">
            <table>
                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Student Name</th>
                        <th>Course Name</th>
                        <th>Amount</th>
                        <th>Payment Date</th>
                        <th>Transaction ID</th>
                        <th>Payment Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty paymentsList}">
                            <c:forEach var="payment" items="${paymentsList}">
                                <tr>
                                    <td>${payment.paymentId}</td>
                                    <td>${payment.studentName != null ? payment.studentName : 'N/A'}</td>
                                    <td>${payment.courseTitle != null ? payment.courseTitle : 'N/A'}</td>
                                    <td>₹${payment.amount}</td>
                                    <td><fmt:formatDate value="${payment.paymentDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>${payment.transactionId != null ? payment.transactionId : 'N/A'}</td>
                                    <td class="status-${payment.paymentStatus.toLowerCase()}">
                                        ${payment.paymentStatus}
                                    </td>
                                    <td>
                                        <form class="payment-status-form" action="AdminPaymentsController" method="post" style="display:inline;">
                                            <input type="hidden" name="paymentId" value="${payment.paymentId}">
                                            <input type="hidden" name="action" value="updatePaymentStatus">
                                            <select name="paymentStatus">
                                                <option value="Pending" ${payment.paymentStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                                                <option value="Completed" ${payment.paymentStatus == 'Completed' ? 'selected' : ''}>Completed</option>
                                                <option value="Canceled" ${payment.paymentStatus == 'Canceled' ? 'selected' : ''}>Canceled</option>
                                            </select>
                                            <button type="submit">Update</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" class="message">No payment records found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
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