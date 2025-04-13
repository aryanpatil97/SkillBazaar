package com.ninfinity.entities;

public class Progress {
    private int userId;
    private int courseId;
    private String studentName;
    private String courseTitle;
    private String instructorName;
    private double progressPercentage;
    private int completed;
    private String transactionId; // Add for transaction ID
    private String paymentStatus; // Add for payment status

    public Progress() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }
    public double getProgressPercentage() { return progressPercentage; }
    public void setProgressPercentage(double progressPercentage) { this.progressPercentage = progressPercentage; }
    public int getCompleted() { return completed; }
    public void setCompleted(int completed) { this.completed = completed; }
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    @Override
    public String toString() {
        return "Progress [userId=" + userId + ", courseId=" + courseId + ", studentName=" + studentName +
               ", courseTitle=" + courseTitle + ", instructorName=" + instructorName +
               ", progressPercentage=" + progressPercentage + ", completed=" + completed +
               ", transactionId=" + transactionId + ", paymentStatus=" + paymentStatus + "]";
    }
}