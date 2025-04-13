<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% if (request.getAttribute("activeCourses") == null) { response.sendRedirect(request.getContextPath() + "/adminMainController"); return; } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - SkillBazaar</title>
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
            background: linear-gradient(135deg, #34495e, #2c3e50); /* Gradient for style */
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
            padding: 120px 50px 100px; /* Increased bottom padding to drag footer down */
            max-width: 1200px;
        }
        .main-heading {
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
        <li class="active"><a href="AdminMainPage.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
        <li><a href="adminCourses.jsp"><i class="fas fa-book-open"></i> Courses</a></li>
        <li><a href="adminInstructor.jsp"><i class="fas fa-chalkboard-teacher"></i> Instructors</a></li>
        <li><a href="adminOrder.jsp"><i class="fas fa-shopping-cart"></i> Orders</a></li>
        <li><a href="adminUsers.jsp"><i class="fas fa-users"></i> Users</a></li>
        <li><a href="adminPayments.jsp"><i class="fas fa-money-check-alt"></i> Payments</a></li>
        <li><a href="adminReports.jsp"><i class="fas fa-chart-bar"></i> Reports</a></li>
    </ul>
</div>

    <div class="container">
        <h1 class="main-heading">Admin Dashboard</h1>
        <div class="summary">
            <div class="summary-card">
                <h3>Active Courses</h3>
                <p>${activeCourses}</p>
            </div>
            <div class="summary-card">
                <h3>Active Instructors</h3>
                <p>${activeInstructors}</p>
            </div>
            <div class="summary-card">
                <h3>Enrolled Students</h3>
                <p>${enrolledStudents}</p>
            </div>
            <div class="summary-card">
                <h3>Monthly Revenue</h3>
                <p>₹${monthlyRevenue}</p>
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