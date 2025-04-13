package com.ninfinity.controller;

import com.ninfinity.dao.*;
import com.ninfinity.entities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;
    private InstructorDAO instructorDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl(DatabaseConnect.connect());
        instructorDAO = new InstructorDAOImpl(DatabaseConnect.connect());
        System.out.println("LoginServlet initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            User user = userDAO.authenticate(username, password);
            if (user != null) {
                System.out.println("User authenticated: " + user.getUsername() + ", Role: " + user.getRole());
                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("userRole", user.getRole());

                String role = user.getRole();
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("adminMainController");
                } else if ("student".equalsIgnoreCase(role)) {
                    response.sendRedirect("home");
                } else if ("instructor".equalsIgnoreCase(role)) {
                    Instructor instructor = instructorDAO.getInstructorByUserId(user.getUserId());
                    if (instructor != null) {
                        session.setAttribute("instructorId", instructor.getInstructorId());
                        System.out.println("Instructor ID set: " + instructor.getInstructorId());
                        response.sendRedirect("InstructorDashboardController");
                    } else {
                        System.out.println("Instructor profile not found for userId: " + user.getUserId());
                        request.setAttribute("errorMessage", "Instructor profile not found.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    System.out.println("Unknown role: " + role);
                    request.setAttribute("errorMessage", "Unknown user role.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                System.out.println("Authentication failed for username: " + username);
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQLException in LoginServlet: " + e.getMessage());
            request.setAttribute("errorMessage", "Database error during login: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    @Override
    public void destroy() {
        if (userDAO != null) userDAO.closeConnection();
        if (instructorDAO != null) instructorDAO.closeConnection();
        System.out.println("LoginServlet destroyed.");
    }
}