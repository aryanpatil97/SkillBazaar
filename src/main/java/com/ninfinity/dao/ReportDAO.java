package com.ninfinity.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {
    Connection con;

    public ReportDAO(Connection con) {
        this.con = con;
    }

    public boolean generateReport(String reportType) {
        double value = 0.0;
        switch (reportType) {
            case "Total Revenue":
                value = getTotalRevenue();
                break;
            case "Total Enrollments":
                value = getTotalEnrollments();
                break;
            case "Average Course Rating":
                value = getAverageCourseRating();
                break;
            case "Daily Revenue":
                value = getDailyRevenue();
                break;
            default:
                return false; // Invalid report type
        }

        // Save the report to the database
        String query = "INSERT INTO reports (report_type, value) VALUES (?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, reportType);
            pstmt.setDouble(2, value);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalEnrollments() {
        int total = 0;
        String query = "SELECT COUNT(*) AS total FROM enrollments";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet result = pstmt.executeQuery()) {
            if (result.next()) {
                total = result.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public double getTotalRevenue() {
        double total = 0.0;
        String query = "SELECT SUM(c.price) AS total FROM enrollments e JOIN courses c ON e.course_id = c.course_id";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet result = pstmt.executeQuery()) {
            if (result.next()) {
                total = result.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public double getAverageCourseRating() {
        double avg = 0.0;
        String query = "SELECT AVG(rating) AS avg_rating FROM courses WHERE rating IS NOT NULL";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet result = pstmt.executeQuery()) {
            if (result.next()) {
                avg = result.getDouble("avg_rating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return avg;
    }

    public int getActiveInstructors() {
        int count = 0;
        String query = "SELECT COUNT(DISTINCT username) AS active FROM users WHERE role = 'instructor'";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet result = pstmt.executeQuery()) {
            if (result.next()) {
                count = result.getInt("active");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public double getDailyRevenue() {
        double total = 0.0;
        String query = "SELECT SUM(c.price) AS total FROM enrollments e JOIN courses c ON e.course_id = c.course_id " +
                       "WHERE DATE(e.enrollment_date) = CURDATE()";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet result = pstmt.executeQuery()) {
            if (result.next()) {
                total = result.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Add method to fetch all reports for display
    public List<Object[]> getAllReports() {
        List<Object[]> reports = new ArrayList<>();
        String query = "SELECT report_id, report_type, value, generated_date FROM reports ORDER BY generated_date DESC";
        try (PreparedStatement pstmt = con.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Object[] report = new Object[4];
                report[0] = rs.getInt("report_id");
                report[1] = rs.getString("report_type");
                report[2] = rs.getDouble("value");
                report[3] = rs.getTimestamp("generated_date");
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    public void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}