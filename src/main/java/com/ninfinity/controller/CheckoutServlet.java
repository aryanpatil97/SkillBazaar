package com.ninfinity.controller;

import com.ninfinity.dao.CourseDAO;
import com.ninfinity.dao.CourseDAOImpl;
import com.ninfinity.dao.DatabaseConnect;
import com.ninfinity.entities.Course;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to paymentCheckout.jsp (should be handled by /paymentCheckout)
        response.sendRedirect("cart");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String transactionId = request.getParameter("transactionId");
        if (transactionId == null || transactionId.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Transaction ID is required.");
            response.sendRedirect("paymentCheckout");
            return;
        }

        try {
            // Fetch cart items
            List<Course> cartItems = courseDAO.getCartItems(userId);
            if (cartItems.isEmpty()) {
                session.setAttribute("errorMessage", "Your cart is empty. Add courses to proceed.");
                response.sendRedirect("cart");
                return;
            }

            // Calculate total amount
            double totalAmount = cartItems.stream().mapToDouble(Course::getPrice).sum();

            // Insert payment records for each course
            String insertPaymentSQL = "INSERT INTO payments (user_id, course_id, amount, payment_date, transaction_id, payment_status) VALUES (?, ?, ?, ?, ?, ?)";
            try (Connection conn = DatabaseConnect.connect(); PreparedStatement pstmt = conn.prepareStatement(insertPaymentSQL)) {
                for (Course course : cartItems) {
                    pstmt.setInt(1, userId);
                    pstmt.setInt(2, course.getCourseId());
                    pstmt.setDouble(3, course.getPrice());
                    pstmt.setString(4, LocalDateTime.now().toString());
                    pstmt.setString(5, transactionId);
                    pstmt.setString(6, "Pending");
                    pstmt.executeUpdate();

                    // Enroll user in the course (add to user_course_progress)
                    courseDAO.enrollUser(userId, course.getCourseId());
                }
            }

            // Clear cart after checkout
            String deleteCartSQL = "DELETE FROM cart WHERE user_id = ?";
            try (Connection conn = DatabaseConnect.connect(); PreparedStatement stmt = conn.prepareStatement(deleteCartSQL)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            session.setAttribute("cartCount", 0);
            session.setAttribute("successMessage", "Checkout successful! Please wait for the admin to process your payment.");
            response.sendRedirect("checkout.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error during checkout: " + e.getMessage());
        }
    }
}