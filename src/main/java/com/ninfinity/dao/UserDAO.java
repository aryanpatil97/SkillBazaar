package com.ninfinity.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ninfinity.entities.*;





public interface UserDAO {
	
	Connection con = null;
	//user student
	User authenticate(String username, String password) throws Exception;
    void register(User user) throws Exception;

    //admin 
    User loginUser(String username, String password) throws SQLException;
    ArrayList<User> getUsersByRole(String role) throws SQLException;
    boolean deleteUserById(int id) throws SQLException;
    boolean updateUser(int userId, String username, String email) throws SQLException;
    String getEnrolledCourses(int userId) throws SQLException;
    String getCoursesTaught(int userId) throws SQLException;
    User getUserById(int userId) throws SQLException;
    boolean addInstructor(String username, String password, String email) throws SQLException;
    boolean addUser(int userId, String username, String password, String email, String role) throws SQLException;
    String getUserRole(int userId) throws SQLException;
	void closeConnection();
    
}

