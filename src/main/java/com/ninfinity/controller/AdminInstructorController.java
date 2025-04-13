package com.ninfinity.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ninfinity.dao.InstructorDAO;
import com.ninfinity.dao.InstructorDAOImpl;
import com.ninfinity.dao.UserDAO;
import com.ninfinity.dao.UserDAOImpl;
import com.ninfinity.dao.DatabaseConnect;

@WebServlet("/adminInstructorController")
public class AdminInstructorController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDao;
    private InstructorDAO iDao;

    @Override
    public void init() throws ServletException {
        Connection con = DatabaseConnect.connect();
        userDao = new UserDAOImpl(con);
        iDao = new InstructorDAOImpl(con);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String userIdStr = request.getParameter("userId");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");

            // Check for null or empty inputs
            if (userIdStr == null || userIdStr.trim().isEmpty() || username == null || password == null || name == null || email == null) {
                response.sendRedirect(request.getContextPath() + "/AdminAddInstructor.jsp?error=true");
                return;
            }

            try {
                int userId = Integer.parseInt(userIdStr);
                if (userId < 101) {
                    response.sendRedirect(request.getContextPath() + "/AdminAddInstructor.jsp?error=true");
                    return;
                }

                boolean userAdded = userDao.addUser(userId, username, password, email, "instructor");
                if (userAdded && iDao.addInstructor(userId, name, email)) {
                    response.sendRedirect(request.getContextPath() + "/adminInstructor.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/AdminAddInstructor.jsp?error=true");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/AdminAddInstructor.jsp?error=true");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/AdminAddInstructor.jsp?error=true");
            }
        } else if ("edit".equals(action)) {
            String instructorIdStr = request.getParameter("instructorId");
            if (instructorIdStr == null || instructorIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/adminInstructor.jsp?error=true");
                return;
            }
            try {
                int instructorId = Integer.parseInt(instructorIdStr);
                request.setAttribute("instructorId", instructorId);
                request.getRequestDispatcher("/EditInstructor.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/adminInstructor.jsp?error=true");
            }
        } else if ("update".equals(action)) {
            String instructorIdStr = request.getParameter("instructorId");
            String name = request.getParameter("name");
            String email = request.getParameter("email");

            if (instructorIdStr == null || instructorIdStr.trim().isEmpty() || name == null || email == null) {
                response.sendRedirect(request.getContextPath() + "/EditInstructor.jsp?error=true");
                return;
            }

            try {
                int instructorId = Integer.parseInt(instructorIdStr);
                if (iDao.updateInstructor(instructorId, name, email)) {
                    response.sendRedirect(request.getContextPath() + "/adminInstructor.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/EditInstructor.jsp?instructorId=" + instructorId + "&error=true");
                }
            } catch (NumberFormatException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/EditInstructor.jsp?instructorId=" + instructorIdStr + "&error=true");
            }
        } else if ("delete".equals(action)) {
            String instructorIdStr = request.getParameter("instructorId");
            if (instructorIdStr == null || instructorIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/adminInstructor.jsp?error=true");
                return;
            }

            try {
                int instructorId = Integer.parseInt(instructorIdStr);
                if (iDao.deleteInstructor(instructorId)) {
                    userDao.deleteUserById(instructorId); // Optional: delete from users too
                    response.sendRedirect(request.getContextPath() + "/adminInstructor.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/adminInstructor.jsp?error=true");
                }
            } catch (NumberFormatException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/adminInstructor.jsp?error=true");
            }
        }
    }

    @Override
    public void destroy() {
        if (userDao != null) {
            userDao.closeConnection();
        }
        if (iDao != null) {
            iDao.closeConnection();
        }
    }
}