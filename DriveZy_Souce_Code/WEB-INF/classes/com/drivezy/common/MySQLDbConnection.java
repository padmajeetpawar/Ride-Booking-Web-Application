package com.drivezy.common;

import java.sql.*;

public class MySQLDbConnection
{
	public static Connection mySqlCon = null;
	
	public static Connection getConnection()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			mySqlCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/drivezy?useSSL=false","root","root");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		
		return mySqlCon;
	}
}
