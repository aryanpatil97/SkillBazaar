package com.ninfinity.controller;

import com.ninfinity.dao.*;
//import com.skillbazaar.dao.CourseDAOImpl;
import com.ninfinity.entities.*;
//import com.ninfinity.dao.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("userRole");
        String userName = (String) session.getAttribute("username");

        try {
            // Fetch popular courses (top 5 by rating)
            System.out.println("Fetching popular courses...");
            List<Course> popularCourses = courseDAO.getPopularCourses();
            request.setAttribute("popularCourses", popularCourses);

            // Fetch categories
            System.out.println("Fetching categories...");
            Set<String> categories = new HashSet<>();
            List<Course> allCourses = courseDAO.getAllCourses();
            for (Course course : allCourses) {
                categories.add(course.getCategory());
            }
            request.setAttribute("categories", categories);

            // Fetch tags
            System.out.println("Fetching tags...");
            List<String> tags = new ArrayList<>();
            String sql = "SELECT tag_name FROM tags";
            try (Connection conn = DatabaseConnect.connect();
                 PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tags.add(rs.getString("tag_name"));
                }
            }
            request.setAttribute("tags", tags);

            // Set cart count if user is logged in
            if (userId != null) {
                System.out.println("Fetching cart items for user: " + userId);
                List<Course> cartItems = courseDAO.getCartItems(userId);
                session.setAttribute("cartCount", cartItems.size());
            }

            // Set user session attributes for index.jsp
            session.setAttribute("userRole", userRole != null ? userRole : "");
            session.setAttribute("userName", userName != null ? userName : "");

            // Forward to index.jsp
            System.out.println("Forwarding to index.jsp...");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading homepage: " + e.getMessage());
        }
    }
}