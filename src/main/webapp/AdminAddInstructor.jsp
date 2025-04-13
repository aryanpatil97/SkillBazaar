<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Instructor - SkillBazaar</title>
    <link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
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
            padding: 50px;
        }
        .container {
            max-width: 600px;
            margin: 80px auto 0;
            background: #FFFFFF;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333333;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: 500;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #E0E0E0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus {
            border-color: #00C4B4;
            outline: none;
        }
        .error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
        }
        button {
            padding: 10px 25px;
            background-color: #00C4B4;
            color: #FFFFFF;
            border: none;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            display: block;
            width: 100%;
        }
        button:hover {
            background-color: #00A89A;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add New Instructor</h1>
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Failed to add instructor. Please try again.</div>
        <% } %>
        <form action="<%= request.getContextPath() %>/adminInstructorController" method="post">
            <input type="hidden" name="action" value="add">
            <label>User ID</label>
            <input type="text" name="userId" required>
            <label>Username</label>
            <input type="text" name="username" required>
            <label>Password</label>
            <input type="password" name="password" required>
            <label>Name</label>
            <input type="text" name="name" required>
            <label>Email</label>
            <input type="email" name="email" required>
            <button type="submit">Add Instructor</button>
        </form>
    </div>
</body>
</html>