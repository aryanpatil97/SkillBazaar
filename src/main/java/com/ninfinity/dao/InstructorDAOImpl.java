package com.ninfinity.dao;

import com.ninfinity.entities.Instructor; // Assuming you have this entity
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InstructorDAOImpl implements InstructorDAO {
    private Connection con;

    public InstructorDAOImpl(Connection con) {
        this.con = con;
    }

    @Override
    public boolean addInstructor(int userId, String name, String email) throws SQLException {
        String query = "INSERT INTO instructors (instructor_id, user_id, name, email) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId); // instructor_id = user_id
            pstmt.setInt(2, userId);
            pstmt.setString(3, name);
            pstmt.setString(4, email);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                updateCoursesTaught(userId); // Update courses_taught after adding
                return true;
            }
            return false;
        }
    }

    @Override
    public List<Object[]> getAllInstructors() throws SQLException {
        List<Object[]> instructors = new ArrayList<>();
        String query = "SELECT i.instructor_id, i.user_id, i.name, i.email, i.courses_taught, i.total_earnings " +
                       "FROM instructors i";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Integer coursesTaught = rs.getObject("courses_taught") != null ? rs.getInt("courses_taught") : 0;
                Double totalEarnings = rs.getObject("total_earnings") != null ? rs.getDouble("total_earnings") : 0.0;
                instructors.add(new Object[]{
                    rs.getInt("instructor_id"),
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    coursesTaught,
                    totalEarnings
                });
            }
        }
        return instructors;
    }

    @Override
    public Object[] getInstructorById(int instructorId) throws SQLException {
        String query = "SELECT instructor_id, user_id, name, email FROM instructors WHERE instructor_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, instructorId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Object[]{
                    rs.getInt("instructor_id"),
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email")
                };
            }
        }
        return null;
    }

    @Override
    public boolean updateInstructor(int instructorId, String name, String email) throws SQLException {
        String query = "UPDATE instructors SET name = ?, email = ? WHERE instructor_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setInt(3, instructorId);
            return pstmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteInstructor(int instructorId) throws SQLException {
        String query = "DELETE FROM instructors WHERE instructor_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, instructorId);
            return pstmt.executeUpdate() > 0;
        }
    }

    @Override
    public void updateAllInstructors() throws SQLException {
        String query = "UPDATE instructors i SET " +
                       "courses_taught = (SELECT COUNT(*) FROM courses c WHERE c.instructor_id = i.instructor_id), " +
                       "total_earnings = (SELECT COALESCE(SUM(c.price * (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id)), 0) " +
                       "FROM courses c WHERE c.instructor_id = i.instructor_id)";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.executeUpdate();
        }
    }

    @Override
    public void updateCoursesTaught(int instructorId) throws SQLException {
        String query = "UPDATE instructors SET courses_taught = (SELECT COUNT(*) FROM courses WHERE instructor_id = ?) WHERE instructor_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, instructorId);
            pstmt.setInt(2, instructorId);
            pstmt.executeUpdate();
        }
    }

    @Override
    public void updateEarnings(int instructorId) throws SQLException {
        String query = "UPDATE instructors SET total_earnings = (" +
                       "SELECT COALESCE(SUM(c.price * (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.course_id)), 0) " +
                       "FROM courses c WHERE c.instructor_id = ?) WHERE instructor_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, instructorId);
            pstmt.setInt(2, instructorId);
            pstmt.executeUpdate();
        }
    }

    @Override
    public Instructor getInstructorByUserId(int userId) throws SQLException {
        Instructor instructor = null;
        String query = "SELECT * FROM instructors WHERE user_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                instructor = new Instructor();
                instructor.setInstructorId(rs.getInt("instructor_id"));
                instructor.setUserId(rs.getInt("user_id"));
                instructor.setName(rs.getString("name"));
                instructor.setEmail(rs.getString("email"));
                instructor.setBio(rs.getString("bio"));
                instructor.setCoursesTaught(rs.getInt("courses_taught"));
                instructor.setTotalEarnings(rs.getDouble("total_earnings"));
            }
        }
        return instructor;
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