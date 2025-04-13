package com.ninfinity.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.ninfinity.entities.InstructorDashboard;

public interface InstructorDashboardDAO {
    Connection con = null;

    InstructorDashboard getDashboardData(int instructorId) throws SQLException;
    void closeConnection();
}