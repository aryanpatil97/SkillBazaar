package com.ninfinity.entities;

public class Order {
    private int orderId;
    private int studentId;
    private int courseId;
    private double amount;
    private String orderDate;
    private String status;
    private String courseTitle; // Added for display
    private String studentName; // Added for display

    public Order() {
        super();
    }

    public Order(int orderId, int studentId, int courseId, double amount, String orderDate, String status) {
        this.orderId = orderId;
        this.studentId = studentId;
        this.courseId = courseId;
        this.amount = amount;
        this.orderDate = orderDate;
        this.status = status;
    }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getOrderDate() { return orderDate; }
    public void setOrderDate(String orderDate) { this.orderDate = orderDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", studentId=" + studentId + ", courseId=" + courseId + 
               ", amount=" + amount + ", orderDate=" + orderDate + ", status=" + status + 
               ", courseTitle=" + courseTitle + ", studentName=" + studentName + "]";
    }
}