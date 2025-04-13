<%@page import="com.ninfinity.dao.CourseDAOImpl"%>
<%@page import="com.ninfinity.entities.Course"%>
<%@page import="com.ninfinity.dao.DatabaseConnect"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ninfinity.dao.CourseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Course Management - SkillBazaar</title>
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
	font-size: 18px; /* Larger text */
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
	margin-right: 10px; /* Increased from 5px to 10px for more spacing */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	display: inline-block; /* Ensures buttons don’t overlap */
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

.add-course-form {
	margin-top: 40px;
	background-color: #FFFFFF;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
	display: none;
}

.add-course-form.active {
	display: block;
}

.add-course-form h2 {
	font-size: 24px;
	font-weight: 600;
	color: #333333;
	margin-bottom: 20px;
}

.add-course-form input, .add-course-form textarea {
	width: 100%;
	padding: 12px;
	margin-bottom: 20px;
	border: 2px solid #E0E0E0;
	border-radius: 8px;
	font-size: 14px;
	transition: border-color 0.3s ease;
}

.add-course-form input:focus, .add-course-form textarea:focus {
	border-color: #00C4B4;
	outline: none;
}

.add-course-form textarea {
	height: 120px;
	resize: vertical;
}

.add-course-form button {
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

.add-course-form button:hover {
	background-color: #00A89A;
	transform: translateY(-2px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

.add-course-form .cancel {
	background-color: #6c757d;
	margin-left: 15px;
}

.add-course-form .cancel:hover {
	background-color: #5a6268;
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
	white-space: nowrap; /* Prevents wrapping of buttons */
	min-width: 150px; /* Ensures enough space for both buttons */
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
		<ul class="sidebar-menu">
			<li><a href="AdminMainPage.jsp"><i
					class="fas fa-tachometer-alt"></i> Dashboard</a></li>
			<li class="active"><a href="adminCourses.jsp"><i
					class="fas fa-book-open"></i> Courses</a></li>
			<li><a href="adminInstructor.jsp"><i
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
		<h1>Course Management</h1>
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>Title</th>
					<th>Instructor</th>
					<th>Price</th>
					<th>Category</th>
					<th>Rating</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				CourseDAO cdao = new CourseDAOImpl(DatabaseConnect.connect());
				ArrayList<Course> courseList = cdao.getAllCourses();
				for (Course c : courseList) {
				%>
				<tr>
					<td><%=c.getCourseId()%></td>
					<td><%=c.getTitle()%></td>
					<td><%=c.getInstructor()%></td>
					<td>₹<%=c.getPrice()%></td>
					<td><%=c.getCategory()%></td>
					<td><%=c.getRating()%></td>
					<td><a href="EditCourse.jsp?id=<%=c.getCourseId()%>"
						class="btn">Edit</a> <a
						href="adminCourseController?id=<%=c.getCourseId()%>"
						class="btn btn-delete"
						onclick="return confirm('Are you sure you want to delete this course?')">Delete</a>
					</td>
				</tr>
				<%
				}
				cdao.closeConnection();
				%>
			</tbody>
		</table>

		<div class="add-course-form" id="courseForm">
			<h2>Add New Course</h2>
			<form action="adminCourseController" method="post">
				<input type="text" name="title" placeholder="Course Title" required>
				<input type="text" name="instructor" placeholder="Instructor"
					required> <input type="number" step="0.01" name="price"
					placeholder="Price ($)" min="0" required> <input
					type="text" name="category" placeholder="Category" required>
				<input type="number" step="0.1" name="rating"
					placeholder="Rating (0-5)" min="0" max="5">
				<textarea name="description" placeholder="Course Description"
					required></textarea>
				<input type="text" name="imageUrl" placeholder="Image URL" required>
				<input type="text" name="videoUrl" placeholder="Video URL" required>
				<button type="submit">Save Course</button>
				<button type="button" class="cancel" onclick="toggleForm()">Cancel</button>
			</form>
		</div>
	</div>

	<footer>
		<p>© 2025 SkillBazaar. All rights reserved.</p>
		<p class="project-note">A project by N-Infinity Info Solutions
			under the guidance of Prof. Prasad Sase.</p>
		<a href="#">About</a> <a href="#">Contact</a> <a href="#">Privacy
			Policy</a>
	</footer>

	<script>
		function toggleForm() {
			document.getElementById('courseForm').classList.toggle('active');
		}
	</script>
</body>
</html>