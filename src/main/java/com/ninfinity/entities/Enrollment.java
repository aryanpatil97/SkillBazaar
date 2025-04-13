package com.ninfinity.entities;

public class Enrollment {
    private int enrollmentId;
    private int userId;
    private int courseId;
    private String enrollmentDate;

    public Enrollment() {}

    public Enrollment(int enrollmentId, int userId, int courseId, String enrollmentDate) {
        this.enrollmentId = enrollmentId;
        this.userId = userId;
        this.courseId = courseId;
        this.enrollmentDate = enrollmentDate;
    }

    public int getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(int enrollmentId) { this.enrollmentId = enrollmentId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    public String getEnrollmentDate() { return enrollmentDate; }
    public void setEnrollmentDate(String enrollmentDate) { this.enrollmentDate = enrollmentDate; }

    @Override
    public String toString() {
        return "Enrollment [enrollmentId=" + enrollmentId + ", userId=" + userId + ", courseId=" + courseId + 
               ", enrollmentDate=" + enrollmentDate + "]";
    }
}