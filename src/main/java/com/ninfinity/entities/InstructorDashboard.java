package com.ninfinity.entities;

public class InstructorDashboard {
    private int totalCourses;
    private int totalStudents;
    private double totalEarnings;
    private double avgRating;
    private String instructorName;

    public InstructorDashboard() {}

    public InstructorDashboard(int totalCourses, int totalStudents, double totalEarnings, double avgRating, String instructorName) {
        this.totalCourses = totalCourses;
        this.totalStudents = totalStudents;
        this.totalEarnings = totalEarnings;
        this.avgRating = avgRating;
        this.instructorName = instructorName;
    }

    public int getTotalCourses() { return totalCourses; }
    public void setTotalCourses(int totalCourses) { this.totalCourses = totalCourses; }

    public int getTotalStudents() { return totalStudents; }
    public void setTotalStudents(int totalStudents) { this.totalStudents = totalStudents; }

    public double getTotalEarnings() { return totalEarnings; }
    public void setTotalEarnings(double totalEarnings) { this.totalEarnings = totalEarnings; }

    public double getAvgRating() { return avgRating; }
    public void setAvgRating(double avgRating) { this.avgRating = avgRating; }

    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }

    @Override
    public String toString() {
        return "InstructorDashboard [instructorName=" + instructorName + ", totalCourses=" + totalCourses + "]";
    }
}