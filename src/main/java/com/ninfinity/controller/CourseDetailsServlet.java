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

@WebServlet("/courseDetails")
public class CourseDetailsServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("CourseDetailsServlet: GET request for course_id=" + request.getParameter("course_id"));

        String courseIdStr = request.getParameter("course_id");
        if (courseIdStr == null || courseIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Course ID is required.");
            return;
        }

        int courseId;
        try {
            courseId = Integer.parseInt(courseIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Course ID.");
            return;
        }

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        try {
            Course course = courseDAO.getCourseById(courseId);
            if (course == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Course not found.");
                return;
            }

            // Check if the student is enrolled
            boolean isEnrolled = false;
            if (userId != null) {
                List<Course> enrolledCourses = courseDAO.getEnrolledCourses(userId);
                for (Course enrolledCourse : enrolledCourses) {
                    if (enrolledCourse.getCourseId() == courseId) {
                        isEnrolled = true;
                        break;
                    }
                }
            }

            request.setAttribute("course", course);
            request.setAttribute("isEnrolled", isEnrolled);
            request.getRequestDispatcher("courseDetails.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching course details: " + e.getMessage());
        }
    }
}