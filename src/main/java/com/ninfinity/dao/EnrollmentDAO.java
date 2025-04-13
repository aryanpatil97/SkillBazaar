package com.ninfinity.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ninfinity.entities.Enrollment;

public class EnrollmentDAO {
    Connection con;

    public EnrollmentDAO(Connection con) {
        this.con = con;
    }

    public ArrayList<Enrollment> getAllEnrollments() {
        ArrayList<Enrollment> enrollmentList = new ArrayList<>();
        String query = "SELECT enrollment_id, user_id, course_id, enrollment_date FROM enrollments";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                Enrollment e = new Enrollment();
                e.setEnrollmentId(result.getInt("enrollment_id"));
                e.setUserId(result.getInt("user_id"));
                e.setCourseId(result.getInt("course_id"));
                e.setEnrollmentDate(result.getString("enrollment_date"));
                enrollmentList.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollmentList;
    }

    public String getStudentName(int userId) {
        String name = "Unknown";
        String query = "SELECT username FROM users WHERE user_id = ? AND role = 'student'";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);
            ResultSet result = pstmt.executeQuery();
            if (result.next()) {
                name = result.getString("username");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return name;
    }

    public String getCourseTitle(int courseId) {
        String title = "Unknown";
        String query = "SELECT title FROM courses WHERE course_id = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, courseId);
            ResultSet result = pstmt.executeQuery();
            if (result.next()) {
                title = result.getString("title");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return title;
    }

    public double getCoursePrice(int courseId) {
        double price = 0.0;
        String query = "SELECT price FROM courses WHERE course_id = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, courseId);
            ResultSet result = pstmt.executeQuery();
            if (result.next()) {
                price = result.getDouble("price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return price;
    }

    public boolean deleteEnrollment(int enrollmentId) {
        boolean success = false;
        String query = "DELETE FROM enrollments WHERE enrollment_id = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, enrollmentId);
            int n = pstmt.executeUpdate();
            if (n == 1) success = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
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
    
    public Enrollment getEnrollmentById(int enrollmentId) {
        Enrollment enrollment = null;
        String query = "SELECT enrollment_id, user_id, course_id, enrollment_date FROM enrollments WHERE enrollment_id = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, enrollmentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                enrollment = new Enrollment();
                enrollment.setEnrollmentId(rs.getInt("enrollment_id"));
                enrollment.setUserId(rs.getInt("user_id"));
                enrollment.setCourseId(rs.getInt("course_id"));
                enrollment.setEnrollmentDate(rs.getString("enrollment_date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollment;
    }

    public boolean updateEnrollment(int enrollmentId, int userId, int courseId, String enrollmentDate) {
        String query = "UPDATE enrollments SET user_id = ?, course_id = ?, enrollment_date = ? WHERE enrollment_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, courseId);
            pstmt.setString(3, enrollmentDate);
            pstmt.setInt(4, enrollmentId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}