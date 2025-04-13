<%@page import="com.ninfinity.entities.Enrollment"%>
<%@page import="com.ninfinity.dao.EnrollmentDAO"%>
<%@page import="com.ninfinity.dao.DatabaseConnect"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Order Management - SkillBazaar</title>
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
	/* Stylish gradient */
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

.sidebar ul li:hover, .sidebar ul li.active {
	background-color: rgba(255, 255, 255, 0.1);
	border-radius: 8px;
}

.sidebar ul li a:hover, .sidebar ul li.active a {
	background-color: #00C4B4;
	color: #FFFFFF;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.container {
	margin-left: 290px;
	padding: 120px 50px 100px;
	/* Increased bottom padding to drag footer down */
	max-width: 1200px;
}

h1 {
	font-size: 28px;
	font-weight: 600;
	margin-bottom: 30px;
	color: #333333;
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
	border-radius: 25px;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.3s ease;
	margin-right: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	display: inline-block;
	min-width: 70px;
	/* Ensure buttons have a minimum width to prevent squishing */
	text-align: center; /* Center text inside buttons */
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
	margin-right: 0;
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

td:nth-child(6) { /* Targets the 'Actions' column (6th column) */
	min-width: 180px; /* Ensure enough room for both buttons */
	white-space: nowrap; /* Prevent wrapping */
}
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="home"><img src="assets/logos/skillbazaar.png"
				alt="SkillBazaar Logo"></a>
		</div>
		<div class="auth-buttons">
			<span>Welcome, Admin</span> <a href="logout">Logout</a>
		</div>
	</header>

	<div class="sidebar">
		<ul>
			<li><a href="AdminMainPage.jsp"><i
					class="fas fa-tachometer-alt"></i> Dashboard</a></li>
			<li><a href="adminCourses.jsp"><i class="fas fa-book-open"></i>
					Courses</a></li>
			<li><a href="adminInstructor.jsp"><i
					class="fas fa-chalkboard-teacher"></i> Instructors</a></li>
			<li class="active"><a href="adminOrder.jsp"><i
					class="fas fa-shopping-cart"></i> Orders</a></li>
			<li><a href="adminUsers.jsp"><i class="fas fa-users"></i>
					Users</a></li>
			<li><a href="adminPayments.jsp"><i
					class="fas fa-money-check-alt"></i> Payments</a></li>

			<li><a href="adminReports.jsp"><i class="fas fa-chart-bar"></i>
					Reports</a></li>
		</ul>
	</div>

	<div class="container">
		<h1>Order Management</h1>
		<div class="table-wrapper">
			<table>
				<thead>
					<tr>
						<th>Enrollment ID <i class="fas fa-sort"></i></th>
						<th>Student Username <i class="fas fa-sort"></i></th>
						<th>Course Title <i class="fas fa-sort"></i></th>
						<th>Amount <i class="fas fa-sort"></i></th>
						<th>Enrollment Date <i class="fas fa-sort"></i></th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
                    EnrollmentDAO eDao = new EnrollmentDAO(DatabaseConnect.connect());
                    ArrayList<Enrollment> enrollmentList = eDao.getAllEnrollments();
                    int itemsPerPage = 10;
                    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int start = (currentPage - 1) * itemsPerPage;
                    int end = Math.min(start + itemsPerPage, enrollmentList.size());
                    for (int i = start; i < end && i < enrollmentList.size(); i++) {
                        Enrollment e = enrollmentList.get(i);
                    %>
					<tr>
						<td><%= e.getEnrollmentId() %></td>
						<td><%= eDao.getStudentName(e.getUserId()) %></td>
						<td><%= eDao.getCourseTitle(e.getCourseId()) %></td>
						<td>₹<%= String.format("%.2f", eDao.getCoursePrice(e.getCourseId())) %></td>
						<td><%= e.getEnrollmentDate() %></td>
						<td><a href="EditOrder.jsp?id=<%= e.getEnrollmentId() %>"
							class="btn">Edit</a> <a
							href="adminOrderController?id=<%= e.getEnrollmentId() %>&action=delete"
							class="btn btn-delete"
							onclick="return confirm('Are you sure you want to delete this enrollment?')">Delete</a>
						</td>
					</tr>
					<% } eDao.closeConnection(); %>
				</tbody>
			</table>
			<%
            int totalPages = (int) Math.ceil((double) enrollmentList.size() / itemsPerPage);
            if (totalPages > 1) {
            %>
			<div class="pagination">
				<% if (currentPage > 1) { %>
				<a href="adminOrder.jsp?page=<%= currentPage - 1 %>">« Prev</a>
				<% } %>
				<%
                for (int p = 1; p <= totalPages; p++) {
                %>
				<a href="adminOrder.jsp?page=<%= p %>"
					class="<%= p == currentPage ? "active" : "" %>"><%= p %></a>
				<% } %>
				<% if (currentPage < totalPages) { %>
				<a href="adminOrder.jsp?page=<%= currentPage + 1 %>">Next »</a>
				<% } %>
			</div>
			<% } %>
		</div>
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