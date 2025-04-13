package com.ninfinity.controller;

import com.ninfinity.dao.ProgressDAO;
import com.ninfinity.dao.ProgressDAOImpl;
import com.ninfinity.dao.DatabaseConnect;
import com.ninfinity.entities.Progress;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/InstructorStudentController")
public class InstructorStudentController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProgressDAO progressDAO;

    @Override
    public void init() throws ServletException {
        Connection con = DatabaseConnect.connect();
        if (con == null) {
            throw new ServletException("Failed to initialize database connection.");
        }
        progressDAO = new ProgressDAOImpl(con);
        System.out.println("InstructorStudentController initialized with DAO. Connection: " + con);
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

        System.out.println("InstructorStudentController: Processing GET request... Instructor ID: " + instructorId);

        try {
            List<Progress> progressList = progressDAO.getProgressByInstructorId(instructorId);
            request.setAttribute("progressList", progressList);
            System.out.println("Progress records fetched: " + (progressList != null ? progressList.size() : "null"));
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQLException in InstructorStudentController: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.getRequestDispatcher("/instructorStudents.jsp").forward(request, response);
    }
    
   
    //List<Progress> progressList = progressDAO.getStudentProgress(int instructorId);

    @Override
    public void destroy() {
        if (progressDAO != null) {
            progressDAO.closeConnection();
            System.out.println("InstructorStudentController: Connection closed.");
        }
    }
}