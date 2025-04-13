package com.ninfinity.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.ninfinity.entities.Payment;

public class PaymentDAOImpl implements PaymentDAO {
    private Connection connection;

    public PaymentDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public boolean createPayment(Payment payment) {
        String sql = "INSERT INTO payments (user_id, course_id, amount, payment_date, transaction_id, payment_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, payment.getUserId());
            stmt.setInt(2, payment.getCourseId());
            stmt.setDouble(3, payment.getAmount());
            stmt.setTimestamp(4, new Timestamp(payment.getPaymentDate().getTime()));
            stmt.setString(5, payment.getTransactionId());
            stmt.setString(6, payment.getPaymentStatus());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Payment getPaymentById(int paymentId) {
        String sql = "SELECT p.*, u.username AS student_name, c.title AS course_title " +
                    "FROM payments p " +
                    "JOIN users u ON p.user_id = u.user_id " +
                    "JOIN courses c ON p.course_id = c.course_id " +
                    "WHERE p.payment_id = ?";
        Payment payment = null;
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setUserId(rs.getInt("user_id"));
                payment.setCourseId(rs.getInt("course_id"));
                payment.setAmount(rs.getDouble("amount"));
                Timestamp timestamp = rs.getTimestamp("payment_date");
                payment.setPaymentDate(new Date(timestamp.getTime()));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setStudentName(rs.getString("student_name"));
                payment.setCourseTitle(rs.getString("course_title"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payment;
    }

    @Override
    public List<Payment> getPaymentsByUserId(int userId) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT p.*, u.username AS student_name, c.title AS course_title " +
                    "FROM payments p " +
                    "JOIN users u ON p.user_id = u.user_id " +
                    "JOIN courses c ON p.course_id = c.course_id " +
                    "WHERE p.user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setUserId(rs.getInt("user_id"));
                payment.setCourseId(rs.getInt("course_id"));
                payment.setAmount(rs.getDouble("amount"));
                Timestamp timestamp = rs.getTimestamp("payment_date");
                payment.setPaymentDate(new Date(timestamp.getTime()));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setStudentName(rs.getString("student_name"));
                payment.setCourseTitle(rs.getString("course_title"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payments;
    }

    @Override
    public List<Payment> getPaymentsByCourseId(int courseId) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT p.*, u.username AS student_name, c.title AS course_title " +
                    "FROM payments p " +
                    "JOIN users u ON p.user_id = u.user_id " +
                    "JOIN courses c ON p.course_id = c.course_id " +
                    "WHERE p.course_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setUserId(rs.getInt("user_id"));
                payment.setCourseId(rs.getInt("course_id"));
                payment.setAmount(rs.getDouble("amount"));
                Timestamp timestamp = rs.getTimestamp("payment_date");
                payment.setPaymentDate(new Date(timestamp.getTime()));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setStudentName(rs.getString("student_name"));
                payment.setCourseTitle(rs.getString("course_title"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payments;
    }

    @Override
    public boolean updatePaymentStatus(int paymentId, String status) {
        String sql = "UPDATE payments SET payment_status = ? WHERE payment_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, paymentId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT p.*, u.username AS student_name, c.title AS course_title " +
                    "FROM payments p " +
                    "JOIN users u ON p.user_id = u.user_id " +
                    "JOIN courses c ON p.course_id = c.course_id";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setUserId(rs.getInt("user_id"));
                payment.setCourseId(rs.getInt("course_id"));
                payment.setAmount(rs.getDouble("amount"));
                Timestamp timestamp = rs.getTimestamp("payment_date");
                payment.setPaymentDate(new Date(timestamp.getTime()));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setStudentName(rs.getString("student_name"));
                payment.setCourseTitle(rs.getString("course_title"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return payments;
    }

    @Override
    public boolean hasUserPaidForCourse(int userId, int courseId) {
        String sql = "SELECT COUNT(*) FROM payments WHERE user_id = ? AND course_id = ? AND payment_status = 'Completed'";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}