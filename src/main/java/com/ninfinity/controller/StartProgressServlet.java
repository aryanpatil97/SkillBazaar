package com.ninfinity.controller;

import com.ninfinity.dao.CourseDAO;
import com.ninfinity.dao.CourseDAOImpl;
import com.ninfinity.dao.DatabaseConnect;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/startProgress")
public class StartProgressServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = Integer.parseInt(request.getParameter("userId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        courseDAO.enrollUser(userId, courseId); // Inserts into user_course_progress
    }
}