package com.ninfinity.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.ninfinity.entities.*;

public interface CourseDAO {


	Connection con = null;
	//instructor page
	List<Course> getCoursesByInstructorId(int instructorId) throws SQLException;

	//  Course getCourseById(int courseId) throws SQLException;
	boolean addCourse(Course course) throws SQLException;
	boolean updateCourse(Course course) throws SQLException;
	boolean deleteCourse(int courseId) throws SQLException;


	//admin
	ArrayList<Course> getAllCourses() throws SQLException;
	boolean deleteCourseById(int id) throws SQLException;
	boolean updateCourse(int courseId, String title, String instructor, double price, String category, 
			double rating, String description, String imageUrl, String videoUrl) throws SQLException;
	boolean addCourse(String title, String instructor, double price, String category, 
			double rating, String description, String imageUrl, String videoUrl) throws SQLException;
	Course getCourseById(int courseId) throws SQLException;



	//user student
	//List<Course> getAllCourses() throws SQLException;
	// Course getCourseById(int courseId) throws SQLException;
	List<Course> getCoursesByTag(String tag) throws SQLException;
	List<Course> getCoursesByCategory(String category) throws SQLException; // New method
	static Set<String> getAllCategories() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	List<Course> getCartItems(int userId) throws SQLException;
	void addToCart(int userId, int courseId) throws SQLException;
	void removeFromCart(int userId, int courseId) throws SQLException;
	void enrollStudent(int userId, int courseId) throws SQLException;
	List<Course> getEnrolledCourses(int userId) throws SQLException;
	List<Course> getCertifiedCourses(int userId) throws SQLException;
	void updateProgress(int userId, int courseId, int progress) throws SQLException;
	void markCourseCompleted(int userId, int courseId) throws SQLException;
	List<Course> getPopularCourses() throws SQLException;
	void closeConnection();



	void enrollUser(Integer userId, int courseId);



	void enrollUser(int userId, int courseId) throws SQLException;

}
