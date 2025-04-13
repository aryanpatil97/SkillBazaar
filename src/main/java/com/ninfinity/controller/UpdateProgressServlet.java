package com.ninfinity.controller; // Updated package

import com.ninfinity.dao.*;
//import com.skillbazaar.dao.CourseDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updateProgress") // Already present, ensuring it’s correct
public class UpdateProgressServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int progress = Integer.parseInt(request.getParameter("progress"));

        try {
            courseDAO.updateProgress(userId, courseId, progress);
            if (progress >= 100) {
                courseDAO.markCourseCompleted(userId, courseId);
            }
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating progress");
        }
    }
}