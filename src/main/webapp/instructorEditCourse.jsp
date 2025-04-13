<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
    if (session.getAttribute("instructorId") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Course - SkillBazaar</title>
    <link rel="icon" type="image/png" href="assets/logos/skillbazaar.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background-color: #F5F7FA; color: #333333; }
        .container { margin: 120px auto; padding: 50px; max-width: 600px; background-color: #FFFFFF; border-radius: 12px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08); }
        h1 { font-size: 28px; font-weight: 600; margin-bottom: 30px; text-align: center; }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-weight: 500; margin-bottom: 5px; }
        input, textarea { width: 100%; padding: 10px; border: 1px solid #E0E0E0; border-radius: 8px; font-size: 14px; }
        textarea { height: 100px; resize: vertical; }
        .submit-btn { background-color: #26c6da; color: #FFFFFF; padding: 12px 20px; border: none; border-radius: 25px; font-weight: 500; cursor: pointer; width: 100%; transition: all 0.3s ease; }
        .submit-btn:hover { background-color: #00A89A; }
        .error { color: red; text-align: center; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Course</h1>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="CoursesInstructorController" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="courseId" value="${course.courseId}">
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" id="title" name="title" value="${course.title}" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" required>${course.description}</textarea>
            </div>
            <div class="form-group">
                <label for="price">Price (₹)</label>
                <input type="number" id="price" name="price" step="0.01" value="${course.price}" required>
            </div>
            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" id="category" name="category" value="${course.category}" required>
            </div>
            <div class="form-group">
                <label for="imageUrl">Image URL</label>
                <input type="text" id="imageUrl" name="imageUrl" value="${course.imageUrl}" required>
            </div>
            <div class="form-group">
                <label for="videoUrl">Video URL</label>
                <input type="text" id="videoUrl" name="videoUrl" value="${course.videoUrl}" required>
            </div>
            <button type="submit" class="submit-btn">Update Course</button>
        </form>
    </div>
</body>
</html>