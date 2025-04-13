package com.ninfinity.controller;

import com.ninfinity.dao.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AddToCartServlet: POST request received for courseId=" + request.getParameter("courseId"));

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            System.out.println("User not logged in, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null || courseIdStr.trim().isEmpty()) {
            System.out.println("Course ID missing");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Course ID is required.");
            return;
        }

        int courseId;
        try {
            courseId = Integer.parseInt(courseIdStr);
        } catch (NumberFormatException e) {
            System.out.println("Invalid Course ID: " + courseIdStr);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Course ID.");
            return;
        }

        try {
            List<com.ninfinity.entities.Course> cartItems = courseDAO.getCartItems(userId);
            for (com.ninfinity.entities.Course course : cartItems) {
                if (course.getCourseId() == courseId) {
                    System.out.println("Course already in cart: " + courseId);
                    session.setAttribute("errorMessage", "Course is already in your cart.");
                    response.sendRedirect("courseDetails?course_id=" + courseId);
                    return;
                }
            }

            courseDAO.addToCart(userId, courseId);
            cartItems = courseDAO.getCartItems(userId);
            System.out.println("Cart items after adding: " + cartItems.size());
            session.setAttribute("cartCount", cartItems.size());
            response.sendRedirect("courseDetails?course_id=" + courseId);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error adding to cart: " + e.getMessage());
        }
    }
}