package com.ninfinity.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnect {
	
public static Connection con;
	
	public static Connection connect() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Connection successfully done");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			con = DriverManager.getConnection("jdbc:mysql://LocalHost:3307/skillbazaar","root","2004");
			System.out.println("DriverM successfully connected");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}

}
