package com.ninfinity.controller;

import com.ninfinity.dao.*;
import com.ninfinity.entities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;

@WebServlet("/myLearning")
public class MyLearningServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Prevent caching to ensure fresh data is fetched
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Fetch enrolled courses
            List<Course> enrolledCourses = courseDAO.getEnrolledCourses(userId);
            System.out.println("Fetched " + enrolledCourses.size() + " courses for user ID " + userId);
            request.setAttribute("enrolledCourses", enrolledCourses);

            // Fetch categories for the dropdown
            Set<String> categories = CourseDAO.getAllCategories();
            request.setAttribute("categories", categories);

            request.getRequestDispatcher("myLearning.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching enrolled courses: " + e.getMessage());
        }
    }
}