package com.ninfinity.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ninfinity.dao.DatabaseConnect;

@WebServlet("/adminMainController")
public class AdminMainController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AdminMainController: Processing request...");
        Connection con = DatabaseConnect.connect();
        
        try {
            int activeCourses = getActiveCourses(con);
            request.setAttribute("activeCourses", activeCourses);
            System.out.println("Active Courses: " + activeCourses);

            int activeInstructors = getActiveInstructors(con);
            request.setAttribute("activeInstructors", activeInstructors);
            System.out.println("Active Instructors: " + activeInstructors);

            int enrolledStudents = getEnrolledStudents(con);
            request.setAttribute("enrolledStudents", enrolledStudents);
            System.out.println("Enrolled Students: " + enrolledStudents);

            double monthlyRevenue = getMonthlyRevenue(con);
            request.setAttribute("monthlyRevenue", String.format("%.2f", monthlyRevenue));
            System.out.println("Monthly Revenue: $" + String.format("%.2f", monthlyRevenue));

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("activeCourses", "N/A");
            request.setAttribute("activeInstructors", "N/A");
            request.setAttribute("enrolledStudents", "N/A");
            request.setAttribute("monthlyRevenue", "N/A");
        } finally {
            try {
                if (con != null && !con.isClosed()) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        System.out.println("AdminMainController: Forwarding to AdminMainPage.jsp");
        request.getRequestDispatcher("/AdminMainPage.jsp").forward(request, response);
    }

    private int getActiveCourses(Connection con) throws SQLException {
        String query = "SELECT COUNT(*) AS total FROM courses";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    private int getActiveInstructors(Connection con) throws SQLException {
        String query = "SELECT COUNT(DISTINCT username) AS total FROM users WHERE role = 'instructor'";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    private int getEnrolledStudents(Connection con) throws SQLException {
        String query = "SELECT COUNT(DISTINCT user_id) AS total FROM enrollments";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    private double getMonthlyRevenue(Connection con) throws SQLException {
        String query = "SELECT SUM(c.price) AS total " +
                       "FROM enrollments e " +
                       "JOIN courses c ON e.course_id = c.course_id " +
                       "WHERE MONTH(e.enrollment_date) = MONTH(CURDATE()) AND YEAR(e.enrollment_date) = YEAR(CURDATE())";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("total");
            }
        }
        return 0.0;
    }
}