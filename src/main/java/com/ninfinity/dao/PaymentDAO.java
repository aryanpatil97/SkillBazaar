package com.ninfinity.dao;

import java.util.List;

import com.ninfinity.entities.Payment;

public interface PaymentDAO {
	
	 // Create a new payment record
    boolean createPayment(Payment payment);
    
    // Get payment by payment ID
    Payment getPaymentById(int paymentId);
    
    // Get all payments for a specific user
    List<Payment> getPaymentsByUserId(int userId);
    
    // Get all payments for a specific course
    List<Payment> getPaymentsByCourseId(int courseId);
    
    // Update payment status
    boolean updatePaymentStatus(int paymentId, String status);
    
    // Get all payments
    List<Payment> getAllPayments();
    
    // Check if a user has already paid for a specific course
    boolean hasUserPaidForCourse(int userId, int courseId);
    void closeConnection(); // Add this method
}
