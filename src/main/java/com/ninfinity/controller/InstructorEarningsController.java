package com.ninfinity.controller;

import com.ninfinity.dao.OrderDAO;
import com.ninfinity.dao.OrderDAOImpl;
import com.ninfinity.dao.DatabaseConnect;
import com.ninfinity.entities.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/InstructorEarningsController")
public class InstructorEarningsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        Connection con = DatabaseConnect.connect();
        if (con == null) {
            throw new ServletException("Failed to initialize database connection.");
        }
        orderDAO = new OrderDAOImpl(con);
        System.out.println("InstructorEarningsController initialized with DAO. Connection: " + con);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer instructorId = (Integer) session.getAttribute("instructorId");

        if (instructorId == null) {
            System.out.println("No instructorId in session, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("InstructorEarningsController: Processing GET request... Instructor ID: " + instructorId);

        try {
            List<Order> transactions = orderDAO.getOrdersByInstructorId(instructorId);
            double totalEarnings = transactions.stream()
                    .mapToDouble(Order::getAmount)
                    .sum();

            request.setAttribute("totalEarnings", totalEarnings);
            request.setAttribute("transactions", transactions);
            System.out.println("Total Earnings: " + totalEarnings + ", Transactions: " + transactions.size());
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQLException in InstructorEarningsController: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.getRequestDispatcher("/instructorEarnings.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        if (orderDAO != null) {
            orderDAO.closeConnection();
            System.out.println("InstructorEarningsController: Connection closed.");
        }
    }
}