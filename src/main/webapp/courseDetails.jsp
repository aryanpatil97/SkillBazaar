<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SkillBazaar - Course Details</title>
<link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
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
	background-color: #F5F7FA;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.logo img {
	height: 60px;
}

.nav-links {
	display: flex;
	align-items: center;
}

.nav-links a {
	color: #333333;
	text-decoration: none;
	margin: 0 20px;
	font-size: 16px;
	font-weight: 500;
}

.nav-links a:hover {
	color: #00C4B4;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropbtn {
	display: flex;
	align-items: center;
	color: #333333;
	font-size: 16px;
	font-weight: 500;
	cursor: pointer;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #FFFFFF;
	min-width: 160px;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
	z-index: 1;
	border-radius: 5px;
}

.dropdown-content a {
	color: #333333;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	font-size: 14px;
}

.dropdown-content a:hover {
	background-color: #00C4B4;
	color: #FFFFFF;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.auth-buttons {
	display: flex;
	align-items: center;
}

.auth-buttons a {
	color: #333333;
	text-decoration: none;
	margin-left: 15px;
	padding: 8px 20px;
	border: 1px solid #00C4B4;
	border-radius: 25px;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.3s ease;
}

.auth-buttons a:hover {
	background-color: #00C4B4;
	color: #FFFFFF;
}

.cart-icon {
	position: relative;
	margin-left: 20px;
}

.cart-count {
	position: absolute;
	top: -10px;
	right: -10px;
	background-color: #00C4B4;
	color: #FFFFFF;
	border-radius: 50%;
	padding: 2px 6px;
	font-size: 12px;
}

.course-details {
	max-width: 1200px;
	margin: 50px auto;
	padding: 20px;
	background-color: #FFFFFF;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.course-details h1 {
	font-size: 32px;
	color: #333333;
	margin-bottom: 20px;
}

.course-details img {
	width: 100%;
	max-height: 400px;
	object-fit: cover;
	border-radius: 10px;
	margin-bottom: 20px;
}

.course-details p {
	font-size: 16px;
	color: #666666;
	margin-bottom: 10px;
}

.course-details .price {
	color: #00C4B4;
	font-weight: bold;
	font-size: 20px;
	margin-bottom: 20px;
}

.course-details .rating {
	color: #00C4B4;
	margin-bottom: 20px;
}

.course-details button {
	background-color: #00C4B4;
	color: #FFFFFF;
	border: none;
	padding: 12px 30px;
	border-radius: 25px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

.course-details button:hover {
	background-color: #00A89A;
}

.video-player {
	margin-top: 20px;
	text-align: center;
}

.video-player iframe {
	width: 100%;
	max-width: 800px;
	height: 450px;
	border: none;
	border-radius: 10px;
}

.message {
	color: #666666;
	font-size: 16px;
	margin-top: 20px;
}

footer {
	background-color: #F5F7FA;
	color: #666666;
	text-align: center;
	padding: 20px;
	border-top: 1px solid #E0E0E0;
	margin-top: 50px;
}

footer a {
	color: #00C4B4;
	text-decoration: none;
	margin: 0 10px;
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
			<a href="home"><img src="assets/logos/skillbazaar.png"
				alt="SkillBazaar Logo"></a>
		</div>
		<div class="nav-links">
			<c:choose>
				<c:when test="${sessionScope.userRole == 'student'}">
					<a href="allCourses">Courses</a>
					<div class="dropdown">
						<div class="dropbtn">
							Categories <span>▼</span>
						</div>
						<div class="dropdown-content">
							<c:forEach var="category" items="${categories}">
								<a href="coursesByCategory?category=${category}">${category}</a>
							</c:forEach>
						</div>
					</div>
					<a href="myLearning">My Learning</a>
					<div class="auth-buttons">
						<span>Welcome, ${sessionScope.userName}</span> <a href="logout">Logout</a>
						<div class="cart-icon">
							<div class="cart-icon">
								<a href="${pageContext.request.contextPath}/cart">[Cart]</a> <span
									class="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
							</div>
						</div>
				</c:when>
				<c:otherwise>
					<a href="allCourses">Courses</a>
					<div class="dropdown">
						<div class="dropbtn">
							Categories <span>▼</span>
						</div>
						<div class="dropdown-content">
							<c:forEach var="category" items="${categories}">
								<a href="coursesByCategory?category=${category}">${category}</a>
							</c:forEach>
						</div>
					</div>
					<div class="auth-buttons">
						<a href="login.jsp">Login</a> <a href="signup.jsp">Signup</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</header>

	<div class="course-details">
		<h1>${course.title}</h1>
		<img src="${course.imageUrl}" alt="${course.title}">
		<p>
			<strong>Description:</strong> ${course.description}
		</p>
		<p>
			<strong>Instructor:</strong> ${course.instructor}
		</p>
		<p>
			<strong>Category:</strong> ${course.category}
		</p>
		<p class="price">Price: ₹${course.price}</p>
		<p class="rating">Rating: ${course.rating}/5</p>

		<!-- Display error message if present -->
		<c:if test="${not empty sessionScope.errorMessage}">
			<p class="message" style="color: #FF4D4F;">${sessionScope.errorMessage}</p>
			<% session.removeAttribute("errorMessage"); %>
			<!-- Clear after displaying -->
		</c:if>

		<c:choose>
			<c:when test="${isEnrolled}">
				<div class="video-player">
					<iframe src="${course.videoUrl.replace('watch?v=', 'embed/')}"
						allowfullscreen></iframe>
				</div>
			</c:when>
			<c:when test="${sessionScope.userId != null}">
				<form action="${pageContext.request.contextPath}/addToCart"
					method="post">
					<input type="hidden" name="courseId" value="${course.courseId}">
					<button type="submit">Add to Cart</button>
				</form>
			</c:when>
			<c:otherwise>
				<p class="message">
					Please <a href="login.jsp">login</a> to enroll in this course.
				</p>
			</c:otherwise>
		</c:choose>
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