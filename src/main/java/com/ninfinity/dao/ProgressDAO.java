package com.ninfinity.dao;

import com.ninfinity.entities.Progress;
import java.sql.SQLException;
import java.util.List;

public interface ProgressDAO {
    List<Progress> getProgressByInstructorId(int instructorId) throws SQLException;
    List<Progress> getAllProgress() throws SQLException;
    boolean toggleCompletedStatus(int userId, int courseId) throws SQLException;
    boolean updatePaymentStatus(int userId, int courseId, String status) throws SQLException; // Add for payment status
    void closeConnection();
}