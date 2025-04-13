package com.ninfinity.dao;

import com.ninfinity.entities.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {
    private Connection con;

    public OrderDAOImpl(Connection con) {
        this.con = con;
    }

    @Override
    public List<Order> getOrdersByInstructorId(int instructorId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.order_id, o.student_id, o.course_id, o.amount, o.order_date, o.status, " +
                       "c.title AS course_title, u.username AS student_name " +
                       "FROM orders o " +
                       "JOIN courses c ON o.course_id = c.course_id " +
                       "JOIN users u ON o.student_id = u.user_id " +
                       "WHERE c.instructor_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, instructorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setStudentId(rs.getInt("student_id"));
                order.setCourseId(rs.getInt("course_id"));
                order.setAmount(rs.getDouble("amount"));
                order.setOrderDate(rs.getString("order_date")); // String as per your Order.java
                order.setStatus(rs.getString("status"));
                // Additional fields for display
                order.setCourseTitle(rs.getString("course_title"));
                order.setStudentName(rs.getString("student_name"));
                orders.add(order);
            }
        }
        return orders;
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