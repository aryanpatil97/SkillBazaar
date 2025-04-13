<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
    if (session.getAttribute("instructorId") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Earnings - SkillBazaar</title>
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
        .auth-buttons { display: flex; align-items: center; }
        .auth-buttons span { font-size: 16px; font-weight: 500; margin-right: 20px; }
        .auth-buttons a {
            color: #333333; text-decoration: none; padding: 8px 20px; border: 2px solid #26c6da;
            border-radius: 25px; font-size: 14px; font-weight: 500; transition: all 0.3s ease;
        }
        .auth-buttons a:hover { background-color: #26c6da; color: #FFFFFF; }
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
        .sidebar ul li a:hover, .sidebar ul li.active a { background-color: #26c6da; color: #FFFFFF; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); }
        .container { margin-left: 290px; padding: 120px 50px 100px; max-width: 1200px; }
        .main-heading { font-size: 28px; font-weight: 600; margin-bottom: 30px; color: #333333; text-align: center; }
        .earnings-section {
            width: 100%; background-color: #FFFFFF; border-radius: 12px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            padding: 30px; margin-bottom: 30px;
        }
        .total-earnings { text-align: center; margin-bottom: 30px; }
        .total-earnings h2 { font-size: 20px; font-weight: 500; color: #333333; margin-bottom: 10px; }
        .total-earnings p { font-size: 32px; font-weight: bold; color: #26c6da; margin: 0; }
        .transactions-table h2 { font-size: 20px; font-weight: 500; color: #333333; margin-bottom: 20px; }
        .transactions-table table { width: 100%; border-collapse: collapse; }
        .transactions-table th, .transactions-table td { padding: 15px; text-align: left; border-bottom: 1px solid #E0E0E0; }
        .transactions-table th { background-color: #26c6da; color: #FFFFFF; font-weight: 600; }
        .transactions-table td { color: #333333; }
        .transactions-table tr:hover { background-color: #F5F7FA; }
        .message, .error { text-align: center; margin: 20px 0; }
        .message { color: #666666; }
        .error { color: red; }
        footer {
            background-color: #FFFFFF; color: #666666; text-align: center; padding: 20px; border-top: 1px solid #E0E0E0;
            margin-top: 40px; box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.05); margin-left: 270px;
        }
        footer a { color: #26c6da; text-decoration: none; margin: 0 10px; transition: color 0.3s ease; }
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
            <span>Welcome, ${sessionScope.username}</span>
            <a href="logout">Logout</a>
        </div>
    </header>

    <div class="sidebar">
        <ul>
            <li><a href="InstructorDashboardController"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="CoursesInstructorController"><i class="fas fa-book"></i> My Courses</a></li>
            <li><a href="InstructorStudentController"><i class="fas fa-user-graduate"></i> Student Progress</a></li>
            <li class="active"><a href="InstructorEarningsController"><i class="fas fa-rupee-sign"></i> Earnings</a></li>
            <li><a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>

    <div class="container">
        <h1 class="main-heading">Earnings</h1>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <div class="earnings-section">
            <div class="total-earnings">
                <h2>Total Earnings</h2>
                <p>₹<fmt:formatNumber value="${totalEarnings != null ? totalEarnings : 0}" type="number" minFractionDigits="2" maxFractionDigits="2"/></p>
            </div>
            <div class="transactions-table">
                <h2>Transactions</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Course</th>
                            <th>Student</th>
                            <th>Amount (₹)</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty transactions}">
                                <c:forEach var="transaction" items="${transactions}">
                                    <tr>
                                        <td>${transaction.courseTitle != null ? transaction.courseTitle : 'N/A'}</td>
                                        <td>${transaction.studentName != null ? transaction.studentName : 'N/A'}</td>
                                        <td><fmt:formatNumber value="${transaction.amount}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                                        <td>${transaction.orderDate != null ? transaction.orderDate : 'N/A'}</td>
                                        <td>${transaction.status != null ? transaction.status : 'N/A'}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="message">No transactions found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
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