<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBazaar - Home</title>
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
        .hero-section {
            background: linear-gradient(135deg, #00C4B4 0%, #FFFFFF 100%);
            padding: 100px 50px;
            text-align: center;
        }
        .hero-section h1 {
            font-size: 48px;
            color: #333333;
            margin-bottom: 20px;
        }
        .hero-section p {
            font-size: 20px;
            color: #666666;
            margin-bottom: 30px;
        }
        .hero-section button {
            background-color: #00C4B4;
            color: #FFFFFF;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .hero-section button:hover {
            background-color: #00A89A;
        }
        .popular-courses-section, .tags-section {
            padding: 50px 20px;
        }
        .popular-courses-section h2, .tags-section h2 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 30px;
            text-align: center;
        }
        .slider {
            position: relative;
            max-width: 1200px;
            margin: 0 auto;
            overflow: hidden;
        }
        .slider-container {
            display: flex;
            transition: transform 0.5s ease-in-out;
        }
        .course-slide {
            flex: 0 0 300px; /* Fixed width for course slides */
            margin: 0 10px;
        }
        .course-card {
            background-color: #FFFFFF;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, border 0.3s ease;
            cursor: pointer;
        }
        .course-card:hover {
            transform: translateY(-5px);
            border: 2px solid #00C4B4;
        }
        .course-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
        }
        .course-card h3 {
            font-size: 18px;
            color: #333333;
            margin: 10px 0;
        }
        .course-card p {
            font-size: 14px;
            color: #666666;
            margin-bottom: 5px;
        }
        .course-card .price {
            color: #00C4B4;
            font-weight: bold;
            margin: 5px 0;
        }
        .course-card .rating {
            color: #00C4B4;
        }
        .course-card button {
            background-color: #00C4B4;
            color: #FFFFFF;
            border: none;
            padding: 8px 15px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
            margin-top: 10px;
            width: 100%;
        }
        .course-card button:hover {
            background-color: #00A89A;
        }
        .tag-slide {
            flex: 0 0 120px; /* Fixed width for tag slides */
            margin: 0 5px;
            text-align: center;
        }
        .tag {
            display: inline-block;
            background-color: #F0F0F0;
            padding: 8px 15px;
            border-radius: 15px;
            font-size: 14px;
            cursor: pointer;
            transition: border 0.3s ease;
        }
        .tag:hover {
            border: 2px solid #00C4B4;
        }
        footer {
            background-color: #F5F7FA;
            color: #666666;
            text-align: center;
            padding: 20px;
            border-top: 1px solid #E0E0E0;
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
            <a href="home"><img src="assets/logos/skillbazaar.png" alt="SkillBazaar Logo"></a>
        </div>
        <div class="nav-links">
            <c:choose>
                <c:when test="${sessionScope.userRole == 'student'}">
                    <a href="allCourses">Courses</a>
                    <div class="dropdown">
                        <div class="dropbtn">Categories <span>▼</span></div>
                        <div class="dropdown-content">
                            <c:forEach var="category" items="${categories}">
                                <a href="coursesByCategory?category=${category}">${category}</a>
                            </c:forEach>
                        </div>
                    </div>
                    <a href="myLearning">My Learning</a>
                    <div class="auth-buttons">
                        <span>Welcome, ${sessionScope.userName}</span>
                        <a href="logout">Logout</a>
                        <div class="cart-icon">
                            <a href="cart.jsp">[Cart]</a>
                            <span class="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="allCourses">Courses</a>
                    <div class="dropdown">
                        <div class="dropbtn">Categories <span>▼</span></div>
                        <div class="dropdown-content">
                            <c:forEach var="category" items="${categories}">
                                <a href="coursesByCategory?category=${category}">${category}</a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="auth-buttons">
                        <a href="login.jsp">Login</a>
                        <a href="signup.jsp">Signup</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <section class="hero-section">
        <h1>Learn Anything, Anytime, Anywhere</h1>
        <p>Explore thousands of courses from top instructors around the world.</p>
        <button onclick="window.location.href='allCourses'">Explore Courses</button>
    </section>

    <section class="popular-courses-section">
        <h2>Popular Courses</h2>
        <c:if test="${empty popularCourses}">
            <p>No popular courses available at the moment.</p>
        </c:if>
        <div class="slider" id="course-slider">
            <div class="slider-container" id="course-slider-container">
                <c:forEach var="course" items="${popularCourses}">
                    <div class="course-slide">
                        <div class="course-card">
                            <img src="${course.imageUrl}" alt="${course.title}">
                            <h3>${course.title}</h3>
                            <p><strong>Instructor:</strong> ${course.instructor}</p>
                            <p><strong>Description:</strong> ${course.description}</p>
                            <p class="price"><strong>Price:</strong> ₹${course.price}</p>
                            <p class="rating"><strong>Rating:</strong> ${course.rating}/5</p>
                            <p><strong>Category:</strong> ${course.category}</p>
                            <button onclick="window.location.href='courseDetails?course_id=${course.courseId}'">View Details</button>
                        </div>
                    </div>
                </c:forEach>
                <!-- Duplicate slides for infinite scrolling -->
                <c:forEach var="course" items="${popularCourses}">
                    <div class="course-slide">
                        <div class="course-card">
                            <img src="${course.imageUrl}" alt="${course.title}">
                            <h3>${course.title}</h3>
                            <p><strong>Instructor:</strong> ${course.instructor}</p>
                            <p><strong>Description:</strong> ${course.description}</p>
                            <p class="price"><strong>Price:</strong> ₹${course.price}</p>
                            <p class="rating"><strong>Rating:</strong> ${course.rating}/5</p>
                            <p><strong>Category:</strong> ${course.category}</p>
                            <button onclick="window.location.href='courseDetails?course_id=${course.courseId}'">View Details</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <section class="tags-section">
        <h2>Explore by Tags</h2>
        <c:if test="${empty tags}">
            <p>No tags available at the moment.</p>
        </c:if>
        <div class="slider" id="tag-slider">
            <div class="slider-container" id="tag-slider-container">
                <c:forEach var="tag" items="${tags}">
                    <div class="tag-slide">
                        <span class="tag" onclick="window.location.href='coursesByTag?tagName=${tag}'">${tag}</span>
                    </div>
                </c:forEach>
                <!-- Duplicate tags for infinite scrolling -->
                <c:forEach var="tag" items="${tags}">
                    <div class="tag-slide">
                        <span class="tag" onclick="window.location.href='coursesByTag?tagName=${tag}'">${tag}</span>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <footer>
        <p>© 2025 SkillBazaar. All rights reserved.</p>
        <p class="project-note">A project by N-Infinity Info Solutions under the guidance of Prof. Prasad Sase.</p>
        <a href="#">About</a>
        <a href="#">Contact</a>
        <a href="#">Privacy Policy</a>
    </footer>

    <script>
        function setupSlider(sliderId, slideClass, slideWidth) {
            const slider = document.getElementById(sliderId);
            const container = slider.querySelector('.slider-container');
            const slides = slider.querySelectorAll('.' + slideClass);
            const totalSlides = slides.length / 2; // Since we duplicated the slides
            let currentIndex = 0;

            // Set initial position
            container.style.transform = 'translateX(0px)';

            function slideNext() {
                currentIndex++;
                container.style.transition = 'transform 0.5s ease-in-out';
                container.style.transform = `translateX(-${currentIndex * slideWidth}px)`;

                // Reset to start for infinite effect
                if (currentIndex >= totalSlides) {
                    setTimeout(() => {
                        container.style.transition = 'none';
                        currentIndex = 0;
                        container.style.transform = 'translateX(0px)';
                    }, 500);
                }
            }

            // Auto-slide every 3 seconds
            setInterval(slideNext, 30);

            // Pause on hover
            slider.addEventListener('mouseenter', () => clearInterval(slideNext));
            slider.addEventListener('mouseleave', () => setInterval(slideNext, 3000));
        }

        // Initialize sliders
        document.addEventListener('DOMContentLoaded', () => {
            // Course slider: 300px width per slide + 20px margin
            if (document.querySelector('#course-slider .course-slide')) {
                setupSlider('course-slider', 'course-slide', 320);
            }
            // Tag slider: 120px width per tag + 10px margin
            if (document.querySelector('#tag-slider .tag-slide')) {
                setupSlider('tag-slider', 'tag-slide', 130);
            }
        });
    </script>
</body>
</html>