package com.ninfinity.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ninfinity.dao.UserDAO;
import com.ninfinity.dao.UserDAOImpl;
import com.ninfinity.dao.DatabaseConnect;

@WebServlet("/adminUsersController")
public class AdminUsersController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String type = request.getParameter("type");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            UserDAO uDao = new UserDAOImpl(DatabaseConnect.connect());
            System.out.println("Processing delete request for user ID: " + id + " (type: " + type + ")");
            boolean status = false;
			try {
				status = uDao.deleteUserById(id);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            uDao.closeConnection();
            if (status) {
                System.out.println("Delete successful for user ID: " + id);
                response.sendRedirect("instructor".equals(type) ? "adminInstructor.jsp" : "adminUsers.jsp");
            } else {
                response.sendRedirect(("instructor".equals(type) ? "adminInstructor.jsp" : "adminUsers.jsp") + "?error=deleteFailed");
            }
        } else {
            response.sendRedirect("adminUsers.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String type = request.getParameter("type");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            UserDAO uDao = new UserDAOImpl(DatabaseConnect.connect());
            boolean status = false;
			try {
				status = uDao.updateUser(id, username, email);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            uDao.closeConnection();
            if (status) {
                response.sendRedirect("instructor".equals(type) ? "adminInstructor.jsp" : "adminUsers.jsp");
            } else {
                response.sendRedirect(("instructor".equals(type) ? "EditInstructor.jsp" : "EditStudent.jsp") + 
                                      "?id=" + id + "&error=updateFailed");
            }
        } else {
            response.sendRedirect("adminUsers.jsp?error=noId");
        }
    }
}