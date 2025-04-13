package com.ninfinity.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ninfinity.dao.DatabaseConnect;
import com.ninfinity.dao.InstructorDashboardDAO;
import com.ninfinity.dao.InstructorDashboardDAOImpl;
import com.ninfinity.entities.InstructorDashboard;

@WebServlet("/InstructorDashboardController")
public class InstructorDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InstructorDashboardDAO dashboardDAO;

    @Override
    public void init() throws ServletException {
        Connection con = DatabaseConnect.connect();
        dashboardDAO = new InstructorDashboardDAOImpl(con);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("InstructorDashboardController: Processing GET request...");
        HttpSession session = request.getSession();
        Integer instructorId = (Integer) session.getAttribute("instructorId");

        if (instructorId == null) {
            System.out.println("No instructorId in session, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("Instructor ID: " + instructorId);
        try {
            InstructorDashboard dashboard = dashboardDAO.getDashboardData(instructorId);
            if (dashboard != null) {
                request.setAttribute("totalCourses", dashboard.getTotalCourses());
                request.setAttribute("totalStudents", dashboard.getTotalStudents());
                request.setAttribute("totalEarnings", String.format("%.2f", dashboard.getTotalEarnings()));
                request.setAttribute("avgRating", dashboard.getAvgRating() == 0 ? "N/A" : String.format("%.1f", dashboard.getAvgRating()));
                request.setAttribute("instructorName", dashboard.getInstructorName());
                System.out.println("Dashboard Data: " + dashboard);
            } else {
                System.out.println("Dashboard data is null");
                request.setAttribute("error", "Unable to load dashboard data.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQLException: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        System.out.println("Forwarding to instructorMainPage.jsp");
        request.getRequestDispatcher("/instructorMainPage.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        if (dashboardDAO != null) {
            dashboardDAO.closeConnection();
        }
    }
}