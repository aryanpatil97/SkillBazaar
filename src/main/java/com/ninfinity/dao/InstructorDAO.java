package com.ninfinity.dao;

import java.sql.SQLException;
import java.util.List;

import com.ninfinity.entities.Instructor; // Assuming you have this entity

public interface InstructorDAO {
    // Add a new instructor
    boolean addInstructor(int userId, String name, String email) throws SQLException;

    // Fetch all instructors with their details
    List<Object[]> getAllInstructors() throws SQLException;

    // Get instructor by ID for editing
    Object[] getInstructorById(int instructorId) throws SQLException;

    // Update instructor details
    boolean updateInstructor(int instructorId, String name, String email) throws SQLException;

    // Delete instructor
    boolean deleteInstructor(int instructorId) throws SQLException;

    // Batch update all instructors' stats
    void updateAllInstructors() throws SQLException;

    // Update courses_taught for an instructor
    void updateCoursesTaught(int instructorId) throws SQLException;

    // Update total_earnings for an instructor
    void updateEarnings(int instructorId) throws SQLException;

    // Fetch instructor by user_id (required for LoginServlet)
    Instructor getInstructorByUserId(int userId) throws SQLException;

    // Close database connection
    void closeConnection();
}