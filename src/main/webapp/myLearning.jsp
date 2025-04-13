<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SkillBazaar - My Learning</title>
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
	gap: 15px;
}

.auth-buttons span {
	font-size: 16px;
	font-weight: 500;
}

.auth-buttons a {
	color: #333333;
	text-decoration: none;
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
	display: flex;
	align-items: center;
}

.cart-icon a {
	padding: 0;
	border: none;
	font-size: 16px;
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

.my-learning-section {
	max-width: 1200px;
	margin: 50px auto;
	padding: 20px;
}

.my-learning-section h2 {
	font-size: 32px;
	color: #333333;
	margin-bottom: 30px;
	text-align: center;
}

.course-card {
	background-color: #FFFFFF;
	border-radius: 10px;
	padding: 15px;
	margin-bottom: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.course-card h3 {
	font-size: 20px;
	color: #333333;
	margin-bottom: 10px;
}

.course-card p {
	font-size: 14px;
	color: #666666;
	margin-bottom: 5px;
}

.video-player {
	margin-top: 15px;
	text-align: center;
}

.video-player iframe {
	width: 100%;
	max-width: 800px;
	height: 450px;
	border: none;
	border-radius: 10px;
}

.pending-message {
	color: #FFA500;
	font-size: 14px;
	margin-top: 10px;
	text-align: center;
}

.failed-message {
	color: #FF4444;
	font-size: 14px;
	margin-top: 10px;
	text-align: center;
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
.pending-message { color: #FFA500; font-size: 14px; margin-top: 10px; text-align: center; }
.canceled-message { color: #FF4444; font-size: 14px; margin-top: 10px; text-align: center; }
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="home"><img src="assets/logos/skillbazaar.png"
				alt="SkillBazaar Logo"></a>
		</div>
		<div class="nav-links">
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
					<a href="cart.jsp">[Cart]</a> <span class="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
				</div>
			</div>
		</div>
	</header>

	
	<section class="my-learning-section">
    <h2>My Learning</h2>
    <c:if test="${empty enrolledCourses}">
        <p>You have not purchased any courses yet.</p>
    </c:if>
    <c:forEach var="course" items="${enrolledCourses}">
        <div class="course-card">
            <h3>${course.title}</h3>
            <p><strong>Instructor:</strong> ${course.instructor}</p>
            <p><strong>Description:</strong> ${course.description}</p>
            <p><strong>Category:</strong> ${course.category}</p>
            <p><strong>Debug Payment Status:</strong> ${course.paymentStatus}</p> <!-- Debug line -->
            <c:choose>
                <c:when test="${course.paymentStatus == 'Completed'}">
                    <div class="video-player">
                        <iframe src="${course.videoUrl.replace('watch?v=', 'embed/')}" allowfullscreen></iframe>
                    </div>
                </c:when>
                <c:when test="${course.paymentStatus == 'Pending'}">
                    <p class="pending-message">Payment is pending. Please wait for admin approval to access the course content.</p>
                </c:when>
                <c:when test="${course.paymentStatus == 'Canceled'}">
                    <p class="canceled-message">Payment has been canceled. Please contact support or try purchasing the course again.</p>
                </c:when>
                <c:otherwise>
                    <p class="pending-message">Payment status is not available. Please contact support.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </c:forEach>
</section>

	<footer>
		<p>© 2025 SkillBazaar. All rights reserved.</p>
		<p class="project-note">A project by N-Infinity Info Solutions
			under the guidance of Prof. Prasad Sase.</p>
		<a href="#">About</a> <a href="#">Contact</a> <a href="#">Privacy
			Policy</a>
	</footer>
</body>
</html>