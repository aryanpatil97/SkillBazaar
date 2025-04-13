package com.ninfinity.dao;

import com.ninfinity.entities.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class CourseDAOImpl implements CourseDAO {
    Connection con;

    public CourseDAOImpl(Connection con) {
        this.con = con;
    }

    @Override
    public boolean addCourse(Course course) throws SQLException {
        String query = "INSERT INTO courses (title, description, instructor, price, category, image_url, video_url, rating, instructor_id) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, course.getTitle());
            pstmt.setString(2, course.getDescription());
            pstmt.setString(3, course.getInstructor());
            pstmt.setDouble(4, course.getPrice());
            pstmt.setString(5, course.getCategory());
            pstmt.setString(6, course.getImageUrl());
            pstmt.setString(7, course.getVideoUrl());
            pstmt.setDouble(8, course.getRating());
            pstmt.setInt(9, course.getInstructorId());
            return pstmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateCourse(Course course) throws SQLException {
        String query = "UPDATE courses SET title = ?, description = ?, price = ?, category = ?, image_url = ?, video_url = ? " +
                      "WHERE course_id = ? AND instructor_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, course.getTitle());
            pstmt.setString(2, course.getDescription());
            pstmt.setDouble(3, course.getPrice());
            pstmt.setString(4, course.getCategory());
            pstmt.setString(5, course.getImageUrl());
            pstmt.setString(6, course.getVideoUrl());
            pstmt.setInt(7, course.getCourseId());
            pstmt.setInt(8, course.getInstructorId());
            return pstmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteCourse(int courseId) throws SQLException {
        String sql = "DELETE FROM courses WHERE courseId=?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, courseId);
           // stmt.setInt(2, instructorId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }


    @Override
    public List<Course> getCoursesByInstructorId(int instructorId) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.course_id, c.title, i.name AS instructor, c.price, c.category, c.rating, " +
                      "c.description, c.image_url, c.video_url " +
                      "FROM courses c " +
                      "JOIN instructors i ON c.instructor_id = i.instructor_id " +
                      "WHERE c.instructor_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, instructorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setTitle(rs.getString("title"));
                course.setInstructor(rs.getString("instructor"));
                course.setPrice(rs.getDouble("price"));
                course.setCategory(rs.getString("category"));
                course.setRating(rs.getDouble("rating"));
                course.setDescription(rs.getString("description"));
                course.setImageUrl(rs.getString("image_url"));
                course.setVideoUrl(rs.getString("video_url"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error fetching courses: " + e.getMessage());
        }
        return courses;
    }

    public ArrayList<Course> getAllCourses() {
        ArrayList<Course> courseList = new ArrayList<>();
        String query = "SELECT course_id, title, instructor, price, category, rating, description, image_url, video_url FROM courses";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                Course c = new Course();
                c.setCourseId(result.getInt("course_id"));
                c.setTitle(result.getString("title"));
                c.setInstructor(result.getString("instructor"));
                c.setPrice(result.getDouble("price"));
                c.setCategory(result.getString("category"));
                c.setRating(result.getDouble("rating"));
                c.setDescription(result.getString("description"));
                c.setImageUrl(result.getString("image_url"));
                c.setVideoUrl(result.getString("video_url"));
                courseList.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courseList;
    }

    public boolean deleteCourseById(int id) {
        String sql = "DELETE FROM courses WHERE course_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCourse(int courseId, String title, String instructor, double price, String category,
                               double rating, String description, String imageUrl, String videoUrl) {
        boolean status = false;
        String query = "UPDATE courses SET title = ?, instructor = ?, price = ?, category = ?, rating = ?, " +
                      "description = ?, image_url = ?, video_url = ? WHERE course_id = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, title);
            pstmt.setString(2, instructor);
            pstmt.setDouble(3, price);
            pstmt.setString(4, category);
            pstmt.setDouble(5, rating);
            pstmt.setString(6, description);
            pstmt.setString(7, imageUrl);
            pstmt.setString(8, videoUrl);
            pstmt.setInt(9, courseId);
            int n = pstmt.executeUpdate();
            if (n == 1) status = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean addCourse(String title, String instructor, double price, String category,
                            double rating, String description, String imageUrl, String videoUrl) {
        boolean status = false;
        String query = "INSERT INTO courses (title, instructor, price, category, rating, description, image_url, video_url) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, title);
            pstmt.setString(2, instructor);
            pstmt.setDouble(3, price);
            pstmt.setString(4, category);
            pstmt.setDouble(5, rating);
            pstmt.setString(6, description);
            pstmt.setString(7, imageUrl);
            pstmt.setString(8, videoUrl);
            int n = pstmt.executeUpdate();
            if (n == 1) status = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public Course getCourseById(int courseId) {
        Course course = null;
        String query = "SELECT * FROM courses WHERE course_id = ?";
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, courseId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setTitle(rs.getString("title"));
                course.setInstructor(rs.getString("instructor"));
                course.setPrice(rs.getDouble("price"));
                course.setCategory(rs.getString("category"));
                course.setRating(rs.getDouble("rating"));
                course.setDescription(rs.getString("description"));
                course.setImageUrl(rs.getString("image_url"));
                course.setVideoUrl(rs.getString("video_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return course;
    }

    @Override
    public List<Course> getCoursesByTag(String tag) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.* FROM courses c JOIN course_tags ct ON c.course_id = ct.course_id JOIN tags t ON ct.tag_id = t.tag_id WHERE t.tag_name = ?";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tag);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setCourseId(rs.getInt("course_id"));
                    course.setTitle(rs.getString("title"));
                    course.setDescription(rs.getString("description"));
                    course.setInstructor(rs.getString("instructor"));
                    course.setPrice(rs.getDouble("price"));
                    course.setCategory(rs.getString("category"));
                    course.setImageUrl(rs.getString("image_url"));
                    course.setVideoUrl(rs.getString("video_url"));
                    course.setRating(rs.getDouble("rating"));
                    courses.add(course);
                }
            }
        }
        return courses;
    }

    @Override
    public void addToCart(int userId, int courseId) throws SQLException {
        String sql = "INSERT INTO cart (user_id, course_id) VALUES (?, ?)";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("CourseDAOImpl.addToCart: Added course " + courseId + " for user " + userId + ", rows affected: " + rowsAffected);
        }
    }

    @Override
    public List<Course> getCartItems(int userId) throws SQLException {
        List<Course> cartItems = new ArrayList<>();
        String sql = "SELECT c.* FROM courses c JOIN cart ct ON c.course_id = ct.course_id WHERE ct.user_id = ?";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setCourseId(rs.getInt("course_id"));
                    course.setTitle(rs.getString("title"));
                    course.setDescription(rs.getString("description"));
                    course.setInstructor(rs.getString("instructor"));
                    course.setPrice(rs.getDouble("price"));
                    course.setCategory(rs.getString("category"));
                    course.setImageUrl(rs.getString("image_url"));
                    course.setVideoUrl(rs.getString("video_url"));
                    course.setRating(rs.getDouble("rating"));
                    cartItems.add(course);
                }
            }
        }
        System.out.println("CourseDAOImpl.getCartItems: Fetching cart for user " + userId + ", items found: " + cartItems.size());
        return cartItems;
    }

    @Override
    public void removeFromCart(int userId, int courseId) throws SQLException {
        String sql = "DELETE FROM cart WHERE user_id = ? AND course_id = ?";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            stmt.executeUpdate();
        }
    }

    @Override
    public void enrollStudent(int userId, int courseId) throws SQLException {
        // Check if the student is already enrolled
        String checkSql = "SELECT COUNT(*) FROM enrollments WHERE user_id = ? AND course_id = ?";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, courseId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    // Student is already enrolled, skip insertion
                    return;
                }
            }
        }

        // If not enrolled, proceed with insertion
        String sql = "INSERT INTO enrollments (user_id, course_id) VALUES (?, ?)";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            stmt.executeUpdate();
        }
    }

    @Override
    public List<Course> getEnrolledCourses(int userId) throws SQLException {
        List<Course> enrolledCourses = new ArrayList<>();
        
        
        String query = "SELECT c.course_id, c.title, c.instructor_id, c.description, c.price, " +
                "c.rating, c.category, c.video_url, c.instructor AS instructor_name, " +
                "p.payment_status " +
                "FROM (SELECT p.*, " +
                "      ROW_NUMBER() OVER (PARTITION BY course_id ORDER BY payment_date DESC) as rn " +
                "      FROM payments p " +
                "      WHERE user_id = ? " +
                "      AND payment_status IN ('Pending', 'Completed', 'Canceled')) p " +
                "JOIN courses c ON p.course_id = c.course_id " +
                "WHERE p.rn = 1 " +
                "ORDER BY p.payment_date DESC";
        
        // Solution 2: Alternative using window functions (MySQL 8.0+)
        /*
        String query = "SELECT c.course_id, c.title, c.instructor_id, c.description, c.price, " +
                     "c.rating, c.category, c.video_url, c.instructor AS instructor_name, " +
                     "p.payment_status " +
                     "FROM (SELECT p.*, " +
                     "      ROW_NUMBER() OVER (PARTITION BY course_id ORDER BY payment_date DESC) as rn " +
                     "      FROM payments p " +
                     "      WHERE user_id = ? " +
                     "      AND payment_status IN ('Pending', 'Completed', 'Canceled')) p " +
                     "JOIN courses c ON p.course_id = c.course_id " +
                     "WHERE p.rn = 1 " +
                     "ORDER BY p.payment_date DESC";
        */
        
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setTitle(rs.getString("title"));
                course.setInstructorId(rs.getInt("instructor_id"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getDouble("price"));
                course.setRating(rs.getDouble("rating"));
                course.setCategory(rs.getString("category"));
                course.setVideoUrl(rs.getString("video_url"));
                course.setInstructor(rs.getString("instructor_name"));
                course.setPaymentStatus(rs.getString("payment_status"));
                enrolledCourses.add(course);
            }
        }
        return enrolledCourses;
    }
    @Override
    public List<Course> getCertifiedCourses(int userId) throws SQLException {
        List<Course> certifiedCourses = new ArrayList<>();
        String sql = "SELECT c.* FROM courses c JOIN user_course_progress ucp ON c.course_id = ucp.course_id WHERE ucp.user_id = ? AND ucp.completed = TRUE";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setCourseId(rs.getInt("course_id"));
                    course.setTitle(rs.getString("title"));
                    course.setDescription(rs.getString("description"));
                    course.setInstructor(rs.getString("instructor"));
                    course.setPrice(rs.getDouble("price"));
                    course.setCategory(rs.getString("category"));
                    course.setImageUrl(rs.getString("image_url"));
                    course.setVideoUrl(rs.getString("video_url"));
                    course.setRating(rs.getDouble("rating"));
                    certifiedCourses.add(course);
                }
            }
        }
        return certifiedCourses;
    }

    @Override
    public void updateProgress(int userId, int courseId, int progress) throws SQLException {
        String sql = "INSERT INTO user_course_progress (user_id, course_id, progress) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE progress = ?";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            stmt.setInt(3, progress);
            stmt.setInt(4, progress);
            stmt.executeUpdate();
        }
    }

    @Override
    public void markCourseCompleted(int userId, int courseId) throws SQLException {
        String sql = "INSERT INTO user_course_progress (user_id, course_id, progress, completed) VALUES (?, ?, 100, TRUE) ON DUPLICATE KEY UPDATE progress = 100, completed = TRUE";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            stmt.executeUpdate();
        }
    }

    @Override
    public List<Course> getPopularCourses() throws SQLException {
        List<Course> popularCourses = new ArrayList<>();
        String sql = "SELECT * FROM courses ORDER BY rating DESC LIMIT 8";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setInstructor(rs.getString("instructor"));
                course.setPrice(rs.getDouble("price"));
                course.setCategory(rs.getString("category"));
                course.setImageUrl(rs.getString("image_url"));
                course.setVideoUrl(rs.getString("video_url"));
                course.setRating(rs.getDouble("rating"));
                popularCourses.add(course);
            }
        }
        return popularCourses;
    }

    @Override
    public List<Course> getCoursesByCategory(String category) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses WHERE category = ?";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setCourseId(rs.getInt("course_id"));
                    course.setTitle(rs.getString("title"));
                    course.setDescription(rs.getString("description"));
                    course.setInstructor(rs.getString("instructor"));
                    course.setPrice(rs.getDouble("price"));
                    course.setCategory(rs.getString("category"));
                    course.setImageUrl(rs.getString("image_url"));
                    course.setVideoUrl(rs.getString("video_url"));
                    course.setRating(rs.getDouble("rating"));
                    courses.add(course);
                }
            }
        }
        return courses;
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

    @Override
    public void enrollUser(int userId, int courseId) throws SQLException {
        String checkQuery = "SELECT COUNT(*) FROM user_course_progress WHERE user_id = ? AND course_id = ?";
        try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, courseId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return; // User already enrolled
            }
        }

        String insertQuery = "INSERT INTO user_course_progress (user_id, course_id, progress, completed) VALUES (?, ?, 0, 0)";
        try (PreparedStatement insertStmt = con.prepareStatement(insertQuery)) {
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, courseId);
            insertStmt.executeUpdate();
        }
    }

    @Override
    public void enrollUser(Integer userId, int courseId) {
        String sql = "INSERT INTO enrollments (user_id, course_id) VALUES (?, ?)";
        try (Connection conn = DatabaseConnect.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

  
    public Set<String> getAllCategories() throws SQLException {
        Set<String> categories = new HashSet<>();
        String query = "SELECT DISTINCT category FROM courses WHERE category IS NOT NULL";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        }
        return categories;
    }
}