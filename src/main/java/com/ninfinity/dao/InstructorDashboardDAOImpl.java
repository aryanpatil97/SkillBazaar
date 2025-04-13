package com.ninfinity.dao;

import com.ninfinity.entities.InstructorDashboard;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class InstructorDashboardDAOImpl implements InstructorDashboardDAO {
    Connection con = DatabaseConnect.connect();

    public InstructorDashboardDAOImpl(Connection con) {
        this.con = con;
    }

    public InstructorDashboard getDashboardData(int instructorId) throws SQLException {
        InstructorDashboard dashboard = new InstructorDashboard();
        String query = "SELECT " +
        	    "(SELECT COUNT(*) FROM courses WHERE instructor_id = ?) AS total_courses, " +
        	    "(SELECT COUNT(DISTINCT user_id) FROM enrollments " +
        	    " JOIN courses ON enrollments.course_id = courses.course_id WHERE courses.instructor_id = ?) AS total_students, " +
        	    "COALESCE((SELECT SUM(amount) FROM instructor_payments WHERE instructor_id = ?), 0) AS total_earnings, " +
        	    "COALESCE((SELECT AVG(rating) FROM courses WHERE instructor_id = ?), 0) AS avg_rating, " +
        	    "(SELECT name FROM instructors WHERE instructor_id = ?) AS instructor_name";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, instructorId);
            pstmt.setInt(2, instructorId);
            pstmt.setInt(3, instructorId);
            pstmt.setInt(4, instructorId);
            pstmt.setInt(5, instructorId);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                dashboard.setTotalCourses(rs.getInt("total_courses"));
                dashboard.setTotalStudents(rs.getInt("total_students"));
                dashboard.setTotalEarnings(rs.getDouble("total_earnings"));
                dashboard.setAvgRating(rs.getDouble("avg_rating"));
                dashboard.setInstructorName(rs.getString("instructor_name"));
            } else {
                System.out.println("No data found for instructorId: " + instructorId);
            }
        }
        return dashboard;
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