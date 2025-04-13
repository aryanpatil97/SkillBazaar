<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBazaar - Login</title>
    <link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #00C4B4 0%, #FFFFFF 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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
        .main-content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .card {
            background-color: #FFFFFF;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 400px;
            text-align: center;
            z-index: 1;
        }
        .card h2 {
            color: #333333;
            margin-bottom: 20px;
        }
        .card form {
            display: flex;
            flex-direction: column;
        }
        .card input {
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #E0E0E0;
            border-radius: 5px;
            font-size: 14px;
        }
        .card button {
            background-color: #00C4B4;
            color: #FFFFFF;
            border: none;
            padding: 12px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }
        .card button:hover {
            background-color: #00A89A;
        }
        .card p {
            margin-top: 15px;
            color: #666666;
            font-size: 14px;
        }
        .card a {
            color: #00C4B4;
            text-decoration: none;
        }
        .card a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #FF0000;
            font-size: 14px;
            margin-bottom: 10px;
            background-color: #FFE6E6;
            padding: 10px;
            border-radius: 5px;
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

        <a href="allCourses">Courses</a>
            <div class="auth-buttons">
                <a href="login.jsp">Login</a>
                <a href="signup.jsp">Signup</a>
            </div>
            
            
        </div>
    </header>

    <div class="main-content">
        <div class="card">
            <h2>Login to SkillBazaar</h2>
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>
            <form action="login" method="post">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit">Login</button>
            </form>
            <p>Don't have an account? <a href="signup.jsp">Signup</a></p>
        </div>
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