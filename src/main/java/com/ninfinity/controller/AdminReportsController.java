package com.ninfinity.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ninfinity.dao.DatabaseConnect;
import com.ninfinity.dao.ReportDAO;

@WebServlet("/adminReportsController")
public class AdminReportsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        ReportDAO rDao = new ReportDAO(DatabaseConnect.connect());

        if (reportType != null && !reportType.isEmpty()) {
            boolean success = rDao.generateReport(reportType);
            rDao.closeConnection();
            if (success) {
                response.sendRedirect("adminReports.jsp");
            } else {
                response.sendRedirect("adminReports.jsp?error=reportFailed");
            }
        } else {
            rDao.closeConnection();
            response.sendRedirect("adminReports.jsp?error=invalidReportType");
        }
    }
}