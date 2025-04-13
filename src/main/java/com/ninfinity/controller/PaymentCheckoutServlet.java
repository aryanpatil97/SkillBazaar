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
import java.sql.SQLException;
import java.util.List;

@WebServlet("/paymentCheckout")
public class PaymentCheckoutServlet extends HttpServlet {
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl(DatabaseConnect.connect());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Course> cartItems = courseDAO.getCartItems(userId);
            if (cartItems.isEmpty()) {
                session.setAttribute("errorMessage", "Your cart is empty. Add courses to proceed.");
                response.sendRedirect("cart");
                return;
            }

            double totalAmount = cartItems.stream().mapToDouble(Course::getPrice).sum();
            request.setAttribute("totalAmount", totalAmount);
            request.getRequestDispatcher("/paymentCheckout.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching cart items: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}