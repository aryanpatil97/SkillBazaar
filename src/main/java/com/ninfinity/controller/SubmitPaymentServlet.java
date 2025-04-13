package com.ninfinity.controller;

import com.ninfinity.dao.CourseDAO;
import com.ninfinity.dao.CourseDAOImpl;
import com.ninfinity.dao.PaymentDAO;
import com.ninfinity.dao.PaymentDAOImpl;
import com.ninfinity.dao.DatabaseConnect;
import com.ninfinity.entities.Course;
import com.ninfinity.entities.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/submitPayment")
public class SubmitPaymentServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SubmitPaymentServlet.class.getName());
    private CourseDAO courseDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
        paymentDAO = new PaymentDAOImpl(DatabaseConnect.connect());
        LOGGER.info("SubmitPaymentServlet initialized.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            LOGGER.warning("User not logged in. Redirecting to login.jsp.");
            response.sendRedirect("login.jsp");
            return;
        }

        String transactionId = request.getParameter("transactionId");
        if (transactionId == null || transactionId.trim().isEmpty()) {
            LOGGER.warning("Transaction ID is empty for user ID: " + userId);
            request.setAttribute("error", "Transaction ID is required.");
            request.getRequestDispatcher("/paymentCheckout.jsp").forward(request, response);
            return;
        }

        if (!transactionId.matches("^[a-zA-Z0-9]+$") || transactionId.length() > 50) {
            LOGGER.warning("Invalid Transaction ID: " + transactionId + " for user ID: " + userId);
            request.setAttribute("error", "Invalid Transaction ID. It must be alphanumeric and less than 50 characters.");
            request.getRequestDispatcher("/paymentCheckout.jsp").forward(request, response);
            return;
        }

        try {
            List<Course> cartItems = courseDAO.getCartItems(userId);
            if (cartItems.isEmpty()) {
                LOGGER.warning("Cart is empty for user ID: " + userId);
                session.setAttribute("errorMessage", "Your cart is empty. Add courses to proceed.");
                response.sendRedirect("cart");
                return;
            }

            LOGGER.info("Processing payment for user ID: " + userId + " with transaction ID: " + transactionId);
            for (Course course : cartItems) {
                Payment payment = new Payment();
                payment.setAmount(course.getPrice());
                payment.setPaymentDate(new Date(System.currentTimeMillis())); // Convert to java.sql.Date
                payment.setUserId(userId);
                payment.setCourseId(course.getCourseId());
                payment.setTransactionId(transactionId);
                payment.setPaymentStatus("Pending");
                ((PaymentDAOImpl) paymentDAO).createPayment(payment);

                courseDAO.enrollUser(userId, course.getCourseId());
                LOGGER.info("Enrolled user ID: " + userId + " in course ID: " + course.getCourseId());
            }

            String sql = "DELETE FROM cart WHERE user_id = ?";
            try (var conn = DatabaseConnect.connect(); var stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
                LOGGER.info("Cleared cart for user ID: " + userId);
            }

            session.setAttribute("cartCount", 0);
            LOGGER.info("Payment submitted successfully for user ID: " + userId);
            response.sendRedirect("checkoutSuccess");
        } catch (SQLException e) {
            LOGGER.severe("SQLException while processing payment for user ID: " + userId + ": " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error processing payment: " + e.getMessage());
            request.getRequestDispatcher("/paymentCheckout.jsp").forward(request, response);
        }
    }
}