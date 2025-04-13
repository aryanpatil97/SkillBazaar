<%@page import="com.ninfinity.dao.InstructorDAOImpl"%>
<%@page import="com.ninfinity.dao.InstructorDAO"%>
<%@page import="com.ninfinity.entities.User"%>
<%@page import="com.ninfinity.dao.UserDAO"%>
<%@page import="com.ninfinity.dao.InstructorDAO"%>
<%@page import="com.ninfinity.dao.DatabaseConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Instructor - SkillBazaar</title>
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
            background: linear-gradient(135deg, #34495e, #2c3e50); /* Stylish gradient */
            position: fixed;
            top: 80px;
            bottom: 0;
            left: 0;
            padding-top: 40px; /* Text shifted lower */
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
            font-size: 18px; /* Larger text */
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
        h1 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #333333;
            text-align: center;
        }
        form {
            background-color: #FFFFFF;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            max-width: 500px;
            margin: 0 auto;
        }
        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 2px solid #E0E0E0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="email"]:focus {
            border-color: #00C4B4;
            outline: none;
        }
        button {
            padding: 12px 25px;
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
        button:hover {
            background-color: #00A89A;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
        .btn-cancel {
            background-color: #6c757d;
            text-decoration: none;
            padding: 12px 25px;
            color: #FFFFFF;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            margin-left: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .btn-cancel:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
        .error {
            color: #dc3545;
            font-size: 14px;
            text-align: center;
            margin-bottom: 20px;
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
            <li class="active"><a href="adminInstructor.jsp"><i class="fas fa-chalkboard-teacher"></i> Instructors</a></li>
            <li><a href="adminOrder.jsp"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="adminUsers.jsp"><i class="fas fa-users"></i> Users</a></li>
            <li><a href="adminReports.jsp"><i class="fas fa-chart-bar"></i> Reports</a></li>
        </ul>
    </div>

    <div class="container">
        <h1>Edit Instructor</h1>
        <%
            int instructorId = Integer.parseInt(request.getParameter("instructorId"));
            InstructorDAO iDao = new InstructorDAOImpl(DatabaseConnect.connect());
            Object[] instructor = iDao.getInstructorById(instructorId);
            iDao.closeConnection();
            if (instructor != null) {
        %>
            <form action="<%= request.getContextPath() %>/adminInstructorController" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="instructorId" value="<%= instructor[0] %>">
                <label>Instructor ID</label>
                <input type="text" value="<%= instructor[0] %>" disabled>
                
                <label>Name</label>
                <input type="text" name="name" value="<%= instructor[2] %>" required>
                <label>Email</label>
                <input type="email" name="email" value="<%= instructor[3] %>" required>
                <% if (request.getParameter("error") != null) { %>
                    <div class="error">Failed to update instructor. Please try again.</div>
                <% } %>
                <button type="submit">Update Instructor</button>
            </form>
        <% } else { %>
            <div class="error">Instructor not found.</div>
        <% } %>
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