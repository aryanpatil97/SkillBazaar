package com.ninfinity.dao;

public interface CartDAO {
    void addToCart(int userId, int courseId) throws Exception;
    void removeFromCart(int userId, int courseId) throws Exception;
    int getCartCount(int userId) throws Exception;
}