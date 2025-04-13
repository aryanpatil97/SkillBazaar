//package com.ninfinity.controller;
//
//import com.ninfinity.dao.*;
////import com.skillbazaar.dao.CartDAOImpl;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//@WebServlet("/removeFromCart")
//public class RemoveFromCartServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//    private CartDAO cartDAO;
//
//    @Override
//    public void init() throws ServletException {
//        cartDAO = new CartDAOImpl();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String userRole = (String) request.getSession().getAttribute("userRole");
//        Integer userId = (Integer) request.getSession().getAttribute("userId");
//
//        if (!"student".equals(userRole) || userId == null) {
//            response.sendRedirect("login");
//            return;
//        }
//
//        int courseId = Integer.parseInt(request.getParameter("course_id"));
//
//        try {
//            cartDAO.removeFromCart(userId, courseId);
//            int cartCount = cartDAO.getCartCount(userId);
//            request.getSession().setAttribute("cartCount", cartCount);
//            response.sendRedirect("cart.jsp");
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error removing from cart: " + e.getMessage());
//        }
//    }
//}