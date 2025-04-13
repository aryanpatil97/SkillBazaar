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
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CoursesInstructorController")
public class CoursesInstructorController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CourseDAO courseDAO;

    @Override
    public void init() throws ServletException {
        Connection con = DatabaseConnect.connect();
        courseDAO = new CourseDAOImpl(con);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("CoursesInstructorController: Processing POST request, Action = " + action);

        if (action == null) {
            response.sendRedirect("coursesInstructor.jsp");
            return;
        }

        try {
            if (action.equals("delete")) {
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                System.out.println("Deleting course with ID: " + courseId);
                courseDAO.deleteCourse(courseId);
                response.sendRedirect("CoursesInstructorController"); // Refresh page after deletion

            } else if (action.equals("update") || action.equals("edit")) {  // Ensure both 'update' & 'edit' work
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                String category = request.getParameter("category");
                String imageUrl = request.getParameter("imageUrl");
                String videoUrl = request.getParameter("videoUrl");

                System.out.println("Updating course ID: " + courseId);
                Course updatedCourse = new Course(courseId, title, description, price, category, price, imageUrl, videoUrl, videoUrl);
                courseDAO.updateCourse(updatedCourse);
                response.sendRedirect("CoursesInstructorController"); // Refresh page after update
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/coursesInstructor.jsp").forward(request, response);
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("CoursesInstructorController: Processing GET request...");
        HttpSession session = request.getSession();
        Integer instructorId = (Integer) session.getAttribute("instructorId");

        if (instructorId == null) {
            System.out.println("No instructorId in session, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("Instructor ID: " + instructorId);
        try {
            List<Course> courses = courseDAO.getCoursesByInstructorId(instructorId);
            if (courses != null && !courses.isEmpty()) {
                request.setAttribute("courses", courses);
                System.out.println("Courses fetched: " + courses.size());
                for (Course course : courses) {
                    System.out.println("Course: " + course);
                }
            } else {
                System.out.println("No courses found for instructorId: " + instructorId);
                request.setAttribute("message", "You have no courses yet.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQLException: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        System.out.println("Forwarding to coursesInstructor.jsp");
        request.getRequestDispatcher("/coursesInstructor.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        if (courseDAO != null) {
            courseDAO.closeConnection();
        }
    }
}