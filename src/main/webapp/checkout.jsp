<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBazaar - Checkout</title>
    <link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
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
            padding: 10px 0;
            transform: translateY(10px);
            opacity: 0;
            transition: all 0.3s ease;
        }
        .dropdown-content a {
            color: #333333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-size: 14px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .dropdown-content a:hover {
            background-color: #00C4B4;
            color: #FFFFFF;
        }
        .dropdown:hover .dropdown-content {
            display: block;
            transform: translateY(0);
            opacity: 1;
        }
        .dropbtn::after {
            content: '▼';
            margin-left: 5px;
            font-size: 12px;
            transition: transform 0.3s ease;
        }
        .dropdown:hover .dropbtn::after {
            transform: rotate(180deg);
        }
        .auth-buttons {
            display: flex;
            align-items: center;
            gap: 15px;
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
            display: flex;
            align-items: center;
            padding: 8px 15px;
        }
        .cart-icon i {
            margin-right: 5px;
            font-size: 16px;
        }
        .cart-count {
            position: absolute;
            top: -10px;
            right: 0;
            background-color: #00C4B4;
            color: #FFFFFF;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
        }
        .checkout-section {
            padding: 120px 20px 50px;
            max-width: 600px;
            margin: 0 auto;
            text-align: center;
        }
        .checkout-section h2 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 20px;
        }
        .checkout-section p {
            font-size: 18px;
            color: #666666;
            margin-bottom: 30px;
        }
        .continue-btn {
            background-color: #00C4B4;
            color: #FFFFFF;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .continue-btn:hover {
            background-color: #00A89A;
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
            <a href="home"><img src="assets/logos/skillbazaar.png" alt="SkillBazaar Logo"></a>
        </div>
        <div class="nav-links">
            <c:choose>
                <c:when test="${sessionScope.userRole == 'student'}">
                    <a href="allCourses">Courses</a>
                    <div class="dropdown">
                        <div class="dropbtn">Categories</div>
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
                            <a href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
                            <span class="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="allCourses">Courses</a>
                    <div class="dropdown">
                        <div class="dropbtn">Categories</div>
                        <div class="dropdown-content">
                            <c:forEach var="category" items="${categories}">
                                <a href="coursesByCategory?category=${category}">${category}</a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="auth-buttons">
                        <a href="login">Login</a>
                        <a href="signup">Signup</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <section class="checkout-section">
        <h2>Checkout Successful!</h2>
        <p>Thank you for your purchase. Please wait for the admin to process your payment. Once approved, you can access your courses in the My Learning section.</p>
        <button class="continue-btn" onclick="window.location.href='myLearning'">Go to My Learning</button>
    </section>

    <footer>
        <p>© 2025 SkillBazaar. All rights reserved.</p>
        <p class="project-note">A project by N-Infinity Info Solutions under the guidance of Prof. Prasad Sase.</p>
        <a href="#">About</a>
        <a href="#">Contact</a>
        <a href="#">Privacy Policy</a>
    </footer>
</body>
</html>