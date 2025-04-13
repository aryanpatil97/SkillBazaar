package com.ninfinity.dao;

import com.ninfinity.entities.Progress;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProgressDAOImpl implements ProgressDAO {
    private Connection con;

    public ProgressDAOImpl(Connection con) {
        this.con = con;
    }

    public List<Progress> getStudentProgress(int instructorId) {
        List<Progress> progressList = new ArrayList<>();
        String query = "SELECT p.student_id, u.username AS student_name, p.course_id, c.title AS course_title, " +
                       "p.progress_percentage, p.progress_percentage = 100 AS completed " +
                       "FROM user_course_progress p " +
                       "JOIN users u ON p.student_id = u.user_id " +
                       "JOIN courses c ON p.course_id = c.course_id " +
                       "WHERE p.instructor_id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, instructorId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Progress progress = new Progress();
                progress.setUserId(rs.getInt("student_id"));
                progress.setStudentName(rs.getString("student_name"));
                progress.setCourseId(rs.getInt("course_id"));
                progress.setCourseTitle(rs.getString("course_title"));
                progress.setProgressPercentage(rs.getDouble("progress_percentage"));
                progress.setCompleted(0);
                progressList.add(progress);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return progressList;
    }

    @Override
    public List<Progress> getProgressByInstructorId(int instructorId) throws SQLException {
        List<Progress> progressList = new ArrayList<>();
        String query = "SELECT p.user_id, p.course_id, u.username AS student_name, c.title AS course_title, " +
                "i.name AS instructor_name, COALESCE(p.progress, 0.0) AS progress, p.completed, " +
                "COALESCE(ip.transaction_id, 'N/A') AS transaction_id, COALESCE(ip.payment_status, 'Pending') AS payment_status " +
                "FROM user_course_progress p " +
                "JOIN users u ON p.user_id = u.user_id " +
                "JOIN courses c ON p.course_id = c.course_id " +
                "JOIN instructors i ON c.instructor_id = i.instructor_id " +
                "LEFT JOIN instructor_payments ip ON i.instructor_id = ip.instructor_id " + // FIXED HERE
                "WHERE c.instructor_id = ?";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, instructorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Progress progress = new Progress();
                progress.setUserId(rs.getInt("user_id"));
                progress.setCourseId(rs.getInt("course_id"));
                progress.setStudentName(rs.getString("student_name"));
                progress.setCourseTitle(rs.getString("course_title"));
                progress.setInstructorName(rs.getString("instructor_name"));
                progress.setProgressPercentage(rs.getDouble("progress"));
                progress.setCompleted(rs.getInt("completed"));
                progress.setTransactionId(rs.getString("transaction_id"));
                progress.setPaymentStatus(rs.getString("payment_status"));
                progressList.add(progress);
            }
        }
        return progressList;
    }


    @Override
    public List<Progress> getAllProgress() throws SQLException {
        List<Progress> progressList = new ArrayList<>();
        String query = "SELECT p.user_id, p.course_id, u.username AS student_name, c.title AS course_title, " +
                      "i.name AS instructor_name, p.progress, p.completed, pm.transaction_id, pm.payment_status " +
                      "FROM user_course_progress p " +
                      "JOIN users u ON p.user_id = u.user_id " +
                      "JOIN courses c ON p.course_id = c.course_id " +
                      "JOIN instructors i ON c.instructor_id = i.instructor_id " +
                      "LEFT JOIN payments pm ON p.user_id = pm.user_id AND p.course_id = pm.course_id";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Progress progress = new Progress();
                progress.setUserId(rs.getInt("user_id"));
                progress.setCourseId(rs.getInt("course_id"));
                progress.setStudentName(rs.getString("student_name"));
                progress.setCourseTitle(rs.getString("course_title"));
                progress.setInstructorName(rs.getString("instructor_name"));
                progress.setProgressPercentage(rs.getDouble("progress"));
                progress.setCompleted(rs.getInt("completed"));
                progress.setTransactionId(rs.getString("transaction_id"));
                progress.setPaymentStatus(rs.getString("payment_status"));
                progressList.add(progress);
            }
        }
        return progressList;
    }

    @Override
    public boolean toggleCompletedStatus(int userId, int courseId) throws SQLException {
        String query = "UPDATE user_course_progress SET completed = 1 - completed WHERE user_id = ? AND course_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, courseId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    @Override
    public boolean updatePaymentStatus(int userId, int courseId, String status) throws SQLException {
        String query = "UPDATE payments SET payment_status = ? WHERE user_id = ? AND course_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, userId);
            pstmt.setInt(3, courseId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    @Override
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