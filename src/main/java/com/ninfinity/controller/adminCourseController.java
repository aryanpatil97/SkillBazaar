package com.ninfinity.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ninfinity.dao.CourseDAO;
import com.ninfinity.dao.CourseDAOImpl;
import com.ninfinity.dao.DatabaseConnect;
import com.ninfinity.entities.Course;

@WebServlet("/adminCourseController")
public class adminCourseController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            CourseDAO cDao = new CourseDAOImpl(DatabaseConnect.connect());
            int id = Integer.parseInt(idParam);
            System.out.println("Processing delete request for course ID: " + id);

            // Check if the course exists before deletion
            Course course = null;
			try {
				course = cDao.getCourseById(id);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            if (course == null) {
                System.out.println("Course ID " + id + " not found in database");
                response.sendRedirect("adminCourses.jsp?error=courseNotFound");
                return;
            }

            boolean status = false;
			try {
				status = cDao.deleteCourseById(id);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            cDao.closeConnection();
            if (status) {
                System.out.println("Delete successful for course ID: " + id);
                response.sendRedirect("adminCourses.jsp");
            } else {
                System.out.println("Delete failed for course ID: " + id + " - Possible database constraint or error");
                response.sendRedirect("adminCourses.jsp?error=deleteFailed");
            }
        } else {
            CourseDAO cDao = new CourseDAOImpl(DatabaseConnect.connect());
            ArrayList<Course> courses = null;
			try {
				courses = cDao.getAllCourses();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            cDao.closeConnection();
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/adminCourses.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseIdParam = request.getParameter("courseId");
        CourseDAO cDao = new CourseDAOImpl(DatabaseConnect.connect());
        
        if (courseIdParam != null && !courseIdParam.isEmpty()) {
            int courseId = Integer.parseInt(courseIdParam);
            String title = request.getParameter("title");
            String instructor = request.getParameter("instructor");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String ratingParam = request.getParameter("rating");
            double rating = (ratingParam != null && !ratingParam.isEmpty()) ? Double.parseDouble(ratingParam) : 0.0;
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            String videoUrl = request.getParameter("videoUrl");

            boolean status = false;
			try {
				status = cDao.updateCourse(courseId, title, instructor, price, category, rating, description, imageUrl, videoUrl);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            cDao.closeConnection();
            if (status) {
                System.out.println("Course ID " + courseId + " updated successfully");
                response.sendRedirect("adminCourses.jsp");
            } else {
                System.out.println("Failed to update course ID " + courseId);
                response.sendRedirect("adminCourses.jsp?error=updateFailed");
            }
        } else {
            // Add new course (assuming form submits without courseId for new entries)
            String title = request.getParameter("title");
            String instructor = request.getParameter("instructor");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String ratingParam = request.getParameter("rating");
            double rating = (ratingParam != null && !ratingParam.isEmpty()) ? Double.parseDouble(ratingParam) : 0.0;
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            String videoUrl = request.getParameter("videoUrl");

            boolean status = false;
			try {
				status = cDao.addCourse(title, instructor, price, category, rating, description, imageUrl, videoUrl);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            cDao.closeConnection();
            if (status) {
                System.out.println("New course added successfully");
                response.sendRedirect("adminCourses.jsp");
            } else {
                System.out.println("Failed to add new course");
                response.sendRedirect("adminCourses.jsp?error=addFailed");
            }
        }
    }
}