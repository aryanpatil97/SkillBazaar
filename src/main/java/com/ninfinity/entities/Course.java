package com.ninfinity.entities;

public class Course {
    private int courseId;
    private String title;
    private String instructor;
    private double price;
    private String category;
    private double rating;
    private String description;
    private String imageUrl;
    private String videoUrl;
    private int instructorId;
    private String paymentStatus;
    

    public Course() {}

    public Course(int courseId, String title, String instructor, double price, String category, double rating,
                  String description, String imageUrl, String videoUrl) {
        this.courseId = courseId;
        this.title = title;
        this.instructor = instructor;
        this.price = price;
        this.category = category;
        this.rating = rating;
        this.description = description;
        this.imageUrl = imageUrl;
        this.videoUrl = videoUrl;
    }

    public int getCourseId() { 
    	return courseId; 
    }
    public void setCourseId(int courseId) { 
    	this.courseId = courseId;
    }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getInstructor() { return instructor; }
    public void setInstructor(String instructor) { this.instructor = instructor; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    @Override
	public String toString() {
		return "Course [courseId=" + courseId + ", title=" + title + ", instructor=" + instructor + ", price=" + price
				+ ", category=" + category + ", rating=" + rating + ", description=" + description + ", imageUrl="
				+ imageUrl + ", videoUrl=" + videoUrl + ", instructorId=" + instructorId + ", paymentStatus="
				+ paymentStatus + "]";
	}

	public Course(int instructorId) {
		super();
		this.instructorId = instructorId;
	}

	public int getInstructorId() {
		return instructorId;
	}

	public void setInstructorId(int instructorId) {
		this.instructorId = instructorId;
	}
}