package com.ninfinity.entities;

import java.sql.Timestamp;

public class Instructor {
    private int instructorId;
    private int userId;
    private String name;
    private String email;
    private String bio;
    private int coursesTaught;
    private double totalEarnings;
    private Timestamp createdAt;

    public Instructor() {}

    public Instructor(int instructorId, int userId, String name, String email, String bio, int coursesTaught, double totalEarnings, Timestamp createdAt) {
        this.instructorId = instructorId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.bio = bio;
        this.coursesTaught = coursesTaught;
        this.totalEarnings = totalEarnings;
        this.createdAt = createdAt;
    }

    public int getInstructorId() { return instructorId; }
    public void setInstructorId(int instructorId) { this.instructorId = instructorId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public int getCoursesTaught() { return coursesTaught; }
    public void setCoursesTaught(int coursesTaught) { this.coursesTaught = coursesTaught; }

    public double getTotalEarnings() { return totalEarnings; }
    public void setTotalEarnings(double totalEarnings) { this.totalEarnings = totalEarnings; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "Instructor [instructorId=" + instructorId + ", name=" + name + "]";
    }
}