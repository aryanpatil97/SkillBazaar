package com.ninfinity.dao;

import com.ninfinity.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartDAOImpl implements CartDAO {
	Connection con;
	
	public CartDAOImpl(Connection con) {
		this.con=con;
	}

    @Override
    public void addToCart(int userId, int courseId) throws Exception {
        
       
    	con = DatabaseConnect.connect();
        
//            con = DBUtil.getConnection();
            String sql = "INSERT INTO cart (user_id, course_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE user_id = user_id";
           try {
        	   PreparedStatement pstmt = con.prepareStatement(sql);
        	   
               pstmt.setInt(1, userId);
               pstmt.setInt(2, courseId);
               pstmt.executeUpdate();
           } catch (SQLException e) {
               e.printStackTrace();
           }
           
        
            
        
    }

    @Override
    public void removeFromCart(int userId, int courseId) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
           con = DatabaseConnect.connect();
            String sql = "DELETE FROM cart WHERE user_id = ? AND course_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, courseId);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
            con.close();
        }
    }

    @Override
    public int getCartCount(int userId) throws Exception {
        int count = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            
            String sql = "SELECT COUNT(*) FROM cart WHERE user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            con.close();
        }
        return count;
    }
}