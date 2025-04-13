package com.ninfinity.dao;

import com.ninfinity.entities.Order;
import java.sql.SQLException;
import java.util.List;

public interface OrderDAO {
    List<Order> getOrdersByInstructorId(int instructorId) throws SQLException;
    void closeConnection();
}