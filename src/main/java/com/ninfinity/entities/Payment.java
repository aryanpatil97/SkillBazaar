package com.ninfinity.entities;

import java.sql.Date;

public class Payment {
    private int paymentId;
    private int userId;
    private int courseId;
    private double amount;
    private Date paymentDate;
    private String transactionId;
    private String paymentStatus;
    private String studentName; // Added for display
    private String courseTitle; // Added for display

    public Payment() {
        super();
    }

    public Payment(int paymentId, int userId, int courseId, double amount, Date paymentDate, String transactionId,
                   String paymentStatus, String studentName, String courseTitle) {
        super();
        this.paymentId = paymentId;
        this.userId = userId;
        this.courseId = courseId;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.transactionId = transactionId;
        this.paymentStatus = paymentStatus;
        this.studentName = studentName;
        this.courseTitle = courseTitle;
    }

    @Override
    public String toString() {
        return "Payment [paymentId=" + paymentId + ", userId=" + userId + ", courseId=" + courseId + ", amount="
               + amount + ", paymentDate=" + paymentDate + ", transactionId=" + transactionId + ", paymentStatus="
               + paymentStatus + ", studentName=" + studentName + ", courseTitle=" + courseTitle + "]";
    }

    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
}