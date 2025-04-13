<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class="container mt-5">
    <!-- Instructors Section -->
    <h2 class="text-center">Meet Our Expert Instructors</h2>
    <div class="row text-center">
        <div class="col-md-4">
            <img src="assets/prasad.jpg" class="rounded-circle" width="150" height="150" alt="Instructor 1">
            <h4 class="mt-3">Prasad Sir</h4>
            <p>Expert in Java Development</p>
        </div>
        <div class="col-md-4">
            <img src="assets/alakh.jpg" class="rounded-circle" width="150" height="150" alt="Instructor 2">
            <h4 class="mt-3">Alakh Sir</h4>
            <p>Data Science & Machine Learning Specialist</p>
        </div>
        <div class="col-md-4">
            <img src="assets/modi.jpg" class="rounded-circle" width="150" height="150" alt="Instructor 3">
            <h4 class="mt-3">Modi Ji</h4>
            <p>Cybersecurity & Ethical Hacking Trainer</p>
        </div>
    </div>
</div>

<!-- Popular Courses Section -->
<div class="container mt-5">
    <h2 class="text-center">Popular Courses</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <img src="assets/pcourse1.jpg" class="card-img-top" alt="Course 1">
                <div class="card-body">
                    <h5 class="card-title">Full Stack Development</h5>
                    <p class="card-text">Learn front-end and back-end development with real-world projects.</p>
                    <a href="#" class="btn btn-success">Enroll Now</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <img src="assets/pcourse2.jpg" class="card-img-top" alt="Course 2">
                <div class="card-body">
                    <h5 class="card-title">Python for Data Science</h5>
                    <p class="card-text">Master Python, data analysis, and machine learning.</p>
                    <a href="#" class="btn btn-success">Enroll Now</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <img src="assets/pcourse3.jpg" class="card-img-top" alt="Course 3">
                <div class="card-body">
                    <h5 class="card-title">Cybersecurity & Ethical Hacking</h5>
                    <p class="card-text">Protect digital assets and learn ethical hacking techniques.</p>
                    <a href="#" class="btn btn-success">Enroll Now</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>
</body>


</html>
