package com.ninfinity.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ninfinity.dao.EnrollmentDAO;
import com.ninfinity.dao.DatabaseConnect;

@WebServlet("/adminOrderController")
public class AdminOrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String action = request.getParameter("action");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            EnrollmentDAO eDao = new EnrollmentDAO(DatabaseConnect.connect());
            if ("delete".equals(action)) {
                boolean status = eDao.deleteEnrollment(id);
                eDao.closeConnection();
                if (status) {
                    response.sendRedirect(request.getContextPath() + "/adminOrder.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/adminOrder.jsp?error=deleteFailed");
                }
            } else {
                eDao.closeConnection();
                response.sendRedirect(request.getContextPath() + "/adminOrder.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/adminOrder.jsp?error=missingId");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String userIdParam = request.getParameter("userId");
        String courseIdParam = request.getParameter("courseId");
        String enrollmentDate = request.getParameter("enrollmentDate");

        if (idParam != null && userIdParam != null && courseIdParam != null && enrollmentDate != null) {
            int id = Integer.parseInt(idParam);
            int userId = Integer.parseInt(userIdParam);
            int courseId = Integer.parseInt(courseIdParam);
            EnrollmentDAO eDao = new EnrollmentDAO(DatabaseConnect.connect());
            boolean success = eDao.updateEnrollment(id, userId, courseId, enrollmentDate);
            eDao.closeConnection();
            if (success) {
                response.sendRedirect(request.getContextPath() + "/adminOrder.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/adminOrder.jsp?error=updateFailed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/adminOrder.jsp?error=invalidInput");
        }
    }
}