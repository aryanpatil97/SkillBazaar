<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBazaar - Cart</title>
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
        .auth-buttons {
            display: flex;
            align-items: center;
            gap: 15px; /* Add gap to space elements evenly */
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
            display: flex;
            align-items: center;
            padding: 8px 15px; /* Adjust padding for consistency */
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
        .cart-section {
            max-width: 1200px;
            margin: 120px auto 50px; /* Adjust margin to account for fixed header */
            padding: 20px;
            background-color: #FFFFFF;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        .cart-section h2 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 20px;
            text-align: center;
        }
        .cart-items {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .cart-item {
            background-color: #F9FAFB;
            border-radius: 10px;
            padding: 15px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .cart-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .cart-item img {
            width: 100%;
            max-height: 150px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
        }
        .cart-item h3 {
            font-size: 18px;
            color: #333333;
            margin-bottom: 5px;
        }
        .cart-item p {
            font-size: 14px;
            color: #666666;
            margin-bottom: 5px;
        }
        .cart-item .price {
            color: #00C4B4;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .cart-item .remove-btn {
            background-color: #FF4D4F;
            color: #FFFFFF;
            border: none;
            padding: 8px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }
        .cart-item .remove-btn:hover {
            background-color: #E63946;
        }
        .checkout-section {
            text-align: center;
            margin-top: 20px;
        }
        .checkout-btn {
            background-color: #00C4B4;
            color: #FFFFFF;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .checkout-btn:hover {
            background-color: #00A89A;
        }
        .empty-message {
            text-align: center;
            font-size: 18px;
            color: #666666;
            padding: 20px;
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
        @media (max-width: 600px) {
            .nav-links {
                flex-wrap: wrap;
                gap: 10px;
            }
            .auth-buttons {
                flex-wrap: wrap;
                gap: 10px;
            }
            .auth-buttons a {
                padding: 6px 15px;
                font-size: 12px;
            }
            .auth-buttons span {
                font-size: 14px;
            }
            .cart-icon a {
                padding: 6px 10px;
                font-size: 12px;
            }
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
                    <a href="myLearning">My Learning</a>
                    <div class="auth-buttons">
                        <span>Welcome, ${sessionScope.userName}</span>
                        <a href="logout">Logout</a>
                        <div class="cart-icon">
                            <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Cart</a>
                            <span class="cart-count">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="allCourses">Courses</a>
                    <div class="auth-buttons">
                        <a href="login.jsp">Login</a>
                        <a href="signup.jsp">Signup</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <section class="cart-section">
        <h2>Your Cart</h2>
        <c:choose>
            <c:when test="${empty cartItems}">
                <p class="empty-message">Your cart is empty. Start exploring <a href="allCourses">courses</a> now!</p>
            </c:when>
            <c:otherwise>
                <div class="cart-items">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item">
                            <img src="${item.imageUrl}" alt="${item.title}">
                            <h3>${item.title}</h3>
                            <p>Instructor: ${item.instructor}</p>
                            <p class="price">₹${item.price}</p>
                            <button class="remove-btn" onclick="window.location.href='removeFromCart?course_id=${item.courseId}'">Remove</button>
                        </div>
                    </c:forEach>
                </div>
                <div class="checkout-section">
                    <form action="${pageContext.request.contextPath}/paymentCheckout" method="post">
                        <button type="submit" class="checkout-btn">Proceed to Checkout</button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
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