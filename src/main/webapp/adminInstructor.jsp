<%@page import="com.ninfinity.dao.InstructorDAOImpl"%>
<%@page import="com.ninfinity.dao.InstructorDAO"%>
<%@page import="com.ninfinity.dao.DatabaseConnect"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Instructor Management - SkillBazaar</title>
<link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap"
	rel="stylesheet">
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

.sidebar-menu {
	list-style: none;
}

.sidebar-menu li {
	padding: 20px 25px;
	margin: 5px 10px;
	transition: all 0.3s ease;
}

.sidebar-menu li a {
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

.sidebar-menu li a i {
	margin-right: 15px;
	font-size: 20px;
}

.sidebar-menu li:hover, .sidebar-menu li.active {
	background-color: rgba(255, 255, 255, 0.1);
	border-radius: 8px;
}

.sidebar-menu li a:hover, .sidebar-menu li.active a {
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

.add-btn {
	padding: 8px 15px;
	background-color: #00C4B4;
	color: #FFFFFF;
	text-decoration: none;
	border-radius: 25px;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.3s ease;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	display: inline-block;
	margin-bottom: 20px;
}

.add-btn:hover {
	background-color: #00A89A;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

table {
	width: 100%;
	border-collapse: collapse;
	background-color: #FFFFFF;
	border-radius: 12px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
	overflow: hidden;
}

th, td {
	padding: 15px;
	text-align: left;
	border-bottom: 1px solid #E0E0E0;
}

th {
	background-color: #00C4B4;
	color: #FFFFFF;
	font-weight: 600;
}

tr:hover {
	background-color: #F0F0F0;
}

.btn {
	padding: 8px 15px;
	background-color: #00C4B4;
	color: #FFFFFF;
	text-decoration: none;
	border: none;
	border-radius: 25px;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.3s ease;
	margin-right: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	cursor: pointer;
}

.btn:hover {
	background-color: #00A89A;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

.btn-delete {
	background-color: #dc3545;
}

.btn-delete:hover {
	background-color: #c82333;
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

td:last-child {
	white-space: nowrap;
	min-width: 150px;
}
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="<%= request.getContextPath() %>/home"><img
				src="assets/logos/skillbazaar.png" alt="SkillBazaar Logo"></a>
		</div>
		<div class="auth-buttons">
			<span>Welcome, Admin</span> <a
				href="<%= request.getContextPath() %>/logout">Logout</a>
		</div>
	</header>

	<div class="sidebar">
		<ul class="sidebar-menu">
			<li><a href="AdminMainPage.jsp"><i
					class="fas fa-tachometer-alt"></i> Dashboard</a></li>
			<li><a href="adminCourses.jsp"><i class="fas fa-book-open"></i>
					Courses</a></li>
			<li class="active"><a href="adminInstructor.jsp"><i
					class="fas fa-chalkboard-teacher"></i> Instructors</a></li>
			<li><a href="adminOrder.jsp"><i class="fas fa-shopping-cart"></i>
					Orders</a></li>
			<li><a href="adminUsers.jsp"><i class="fas fa-users"></i>
					Users</a></li>
			<li><a href="adminPayments.jsp"><i
					class="fas fa-money-check-alt"></i> Payments</a></li>
			<li><a href="adminReports.jsp"><i class="fas fa-chart-bar"></i>
					Reports</a></li>
		</ul>
	</div>

	<div class="container">
		<h1>Instructor Management</h1>
		<a href="AdminAddInstructor.jsp" class="add-btn">Add Instructor</a>
		<table>
			<thead>
				<tr>
					<th>Instructor ID <i class="fas fa-sort"></i></th>
					<!-- <th>User ID <i class="fas fa-sort"></i></th> -->
					<th>Name <i class="fas fa-sort"></i></th>
					<th>Email <i class="fas fa-sort"></i></th>
					<th>Courses Taught <i class="fas fa-sort"></i></th>
					<th>Total Earnings <i class="fas fa-sort"></i></th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
                InstructorDAO iDao = null;
                try {
                    iDao = new InstructorDAOImpl(DatabaseConnect.connect());
                    iDao.updateAllInstructors(); // Batch update all stats
                    List<Object[]> instructors = iDao.getAllInstructors();
                    for (Object[] instructor : instructors) {
                %>
				<tr>
					<td><%= instructor[0] %></td>

					<td><%= instructor[2] %></td>
					<td><%= instructor[3] %></td>
					<td><%= instructor[4] != null ? instructor[4] : "0" %></td>
					<td>₹<%= String.format("%.2f", instructor[5] != null ? (Double) instructor[5] : 0.0) %></td>
					<td>
						<form
							action="<%= request.getContextPath() %>/adminInstructorController"
							method="post" style="display: inline;">
							<input type="hidden" name="action" value="edit"> <input
								type="hidden" name="instructorId" value="<%= instructor[0] %>">
							<button type="submit" class="btn">Edit</button>
						</form>
						<form
							action="<%= request.getContextPath() %>/adminInstructorController"
							method="post" style="display: inline;">
							<input type="hidden" name="action" value="delete"> <input
								type="hidden" name="instructorId" value="<%= instructor[0] %>">
							<button type="submit" class="btn btn-delete"
								onclick="return confirm('Are you sure you want to delete this instructor?');">Delete</button>
						</form>
					</td>
				</tr>
				<%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (iDao != null) {
                        iDao.closeConnection();
                    }
                }
                %>
			</tbody>
		</table>
	</div>

	<footer>
		<p>© 2025 SkillBazaar. All rights reserved.</p>
		<p class="project-note">A project by N-Infinity Info Solutions
			under the guidance of Prof. Prasad Sase.</p>
		<a href="#">About</a> <a href="#">Contact</a> <a href="#">Privacy
			Policy</a>
	</footer>
</body>
</html>