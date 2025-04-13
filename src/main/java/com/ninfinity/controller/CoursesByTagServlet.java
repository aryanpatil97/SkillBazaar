package com.ninfinity.controller;

import com.ninfinity.dao.*;
//import com.skillbazaar.dao.CourseDAOImpl;
import com.ninfinity.entities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/coursesByTag")
public class CoursesByTagServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tag = request.getParameter("tagName"); // Changed from "tag" to "tagName" to match index.jsp

        if (tag == null || tag.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tag parameter is required.");
            return;
        }

        try {
            List<Course> courses = courseDAO.getCoursesByTag(tag);
            request.setAttribute("courses", courses);
            request.setAttribute("tag", tag);
            request.getRequestDispatcher("coursesByTag.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching courses by tag: " + e.getMessage());
        }
    }
}