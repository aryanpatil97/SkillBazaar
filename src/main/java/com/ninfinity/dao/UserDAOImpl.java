package com.ninfinity.dao;

import com.ninfinity.*;
import com.ninfinity.entities.*;
//import com.skillbazaar.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAOImpl implements UserDAO {
	
	public UserDAOImpl(Connection con) {
		// TODO Auto-generated constructor stub
	   this.con=con;
	}
	
	

	Connection con = DatabaseConnect.connect();
	
	

    @Override
    
	
	public User loginUser(String username, String password) {
        User user = null;
        try {
            String query = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setPhoneNumber(rs.getString("phone_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
	
	 public ArrayList<User> getUsersByRole(String role) {
	        ArrayList<User> userList = new ArrayList<>();
	        String query = "SELECT user_id, username, email FROM users WHERE role = ?";
	        try {
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setString(1, role);
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {
	                User u = new User();
	                u.setUserId(rs.getInt("user_id"));
	                u.setUsername(rs.getString("username"));
	                u.setEmail(rs.getString("email"));
	                u.setRole(role);
	                userList.add(u);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return userList;
	    }
	 
	 public boolean deleteUserById(int id) {
	        boolean status = false;
	        String query = "DELETE FROM users WHERE user_id = ?";
	        try {
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setInt(1, id);
	            int n = pstmt.executeUpdate();
	            if (n == 1) status = true;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return status;
	    }
	 
	 public boolean updateUser(int userId, String username, String email) {
	        boolean status = false;
	        String query = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";
	        try {
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setString(1, username);
	            pstmt.setString(2, email);
	            pstmt.setInt(3, userId);
	            int n = pstmt.executeUpdate();
	            if (n == 1) status = true;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return status;
	    }
	 
	 public String getEnrolledCourses(int userId) {
	        String enrolledCourses = "None";
	        String query = "SELECT GROUP_CONCAT(c.title SEPARATOR ', ') AS enrolled_courses " +
	                       "FROM enrollments e " +
	                       "JOIN courses c ON e.course_id = c.course_id " +
	                       "WHERE e.user_id = ?";
	        try {
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setInt(1, userId);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next() && rs.getString("enrolled_courses") != null) {
	                enrolledCourses = rs.getString("enrolled_courses");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return enrolledCourses;
	    }
	 
	 public String getCoursesTaught(int userId) {
	        String coursesTaught = "None";
	        String query = "SELECT GROUP_CONCAT(title SEPARATOR ', ') AS courses_taught " +
	                       "FROM courses c " +
	                       "JOIN users u ON c.instructor = u.username " +
	                       "WHERE u.user_id = ?";
	        try {
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setInt(1, userId);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next() && rs.getString("courses_taught") != null) {
	                coursesTaught = rs.getString("courses_taught");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return coursesTaught;
	    }
	 
	 public User getUserById(int userId) {
	        User user = null;
	        String query = "SELECT * FROM users WHERE user_id = ?";
	        try {
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setInt(1, userId);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setUsername(rs.getString("username"));
	                user.setEmail(rs.getString("email"));
	                user.setRole(rs.getString("role"));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return user;
	    }
	    
	 public boolean addInstructor(String username, String password, String email) {
	        String query = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, 'instructor')";
	        try (PreparedStatement pstmt = con.prepareStatement(query)) {
	            pstmt.setString(1, username);
	            pstmt.setString(2, password);
	            pstmt.setString(3, email);
	            int rowsAffected = pstmt.executeUpdate();
	            return rowsAffected > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	 
	 public boolean addUser(int userId, String username, String password, String email, String role) {
	        String query = "INSERT INTO users (user_id, username, password, email, role) VALUES (?, ?, ?, ?, ?)";
	        try (PreparedStatement pstmt = con.prepareStatement(query)) {
	            pstmt.setInt(1, userId);
	            pstmt.setString(2, username);
	            pstmt.setString(3, password);
	            pstmt.setString(4, email);
	            pstmt.setString(5, role);
	            return pstmt.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    
	 // Get user role (for login/dashboard routing)
	    public String getUserRole(int userId) {
	        String query = "SELECT role FROM users WHERE user_id = ?";
	        try (PreparedStatement pstmt = con.prepareStatement(query)) {
	            pstmt.setInt(1, userId);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return rs.getString("role");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return null;
	    }
	    

	    

	    @Override
	    public User authenticate(String username, String password) throws SQLException {
	        User user = null;
	        String query = "SELECT * FROM users WHERE username = ?";
	        try (PreparedStatement pstmt = con.prepareStatement(query)) {
	            pstmt.setString(1, username);
	            ResultSet rs = pstmt.executeQuery();
	            if (rs.next()) {
	                user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setUsername(rs.getString("username"));
	                user.setPassword(rs.getString("password"));
	                user.setEmail(rs.getString("email"));
	                user.setRole(rs.getString("role"));
	            }
	        }
	        return user;
	    }

    @Override
    public void register(User user) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnect.connect();
            String sql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getRole());
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            conn.close();
        }
    }
    
    public void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}