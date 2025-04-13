package com.ninfinity.controller;

import com.ninfinity.dao.*;
import com.ninfinity.*;
import com.ninfinity.entities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/allCourses")
public class AllCoursesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        Connection con = DatabaseConnect.connect();
		courseDAO = new CourseDAOImpl(con);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Course> courses = courseDAO.getAllCourses();
            List<String> categories = courseDAO.getAllCourses().stream()
                    .map(Course::getCategory)
                    .distinct()
                    .toList();

            request.setAttribute("courses", courses);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("allCourses.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching courses: " + e.getMessage());
        }
    }
}