package com.ninfinity.controller;

import com.ninfinity.dao.PaymentDAO;
import com.ninfinity.dao.PaymentDAOImpl;
import com.ninfinity.dao.DatabaseConnect;
import com.ninfinity.entities.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/AdminPaymentsController")
public class AdminPaymentsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        Connection con = DatabaseConnect.connect();
        if (con == null) {
            throw new ServletException("Failed to initialize database connection.");
        }
        paymentDAO = new PaymentDAOImpl(con);
        System.out.println("AdminPaymentsController initialized with DAO. Connection: " + con);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Payment> paymentsList = paymentDAO.getAllPayments();
            request.setAttribute("paymentsList", paymentsList);
            System.out.println("Payment records fetched: " + (paymentsList != null ? paymentsList.size() : "null"));
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in AdminPaymentsController: " + e.getMessage());
            request.setAttribute("error", "Error fetching payments: " + e.getMessage());
        }

        request.getRequestDispatcher("/adminPayments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updatePaymentStatus".equals(action)) {
            try {
                int paymentId = Integer.parseInt(request.getParameter("paymentId"));
                String paymentStatus = request.getParameter("paymentStatus");
                boolean success = paymentDAO.updatePaymentStatus(paymentId, paymentStatus);
                if (success) {
                    request.setAttribute("message", "Payment status updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update payment status.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Error in AdminPaymentsController: " + e.getMessage());
                request.setAttribute("error", "Error updating payment status: " + e.getMessage());
            }
        }

        doGet(request, response);
    }

    @Override
    public void destroy() {
        if (paymentDAO != null) {
            // Assuming PaymentDAOImpl has a closeConnection method
            try {
                ((PaymentDAOImpl) paymentDAO).closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        System.out.println("AdminPaymentsController: Connection closed.");
    }
}