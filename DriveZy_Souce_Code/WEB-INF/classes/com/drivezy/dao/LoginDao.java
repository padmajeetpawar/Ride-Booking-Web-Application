package com.drivezy.dao;

import java.sql.*;

import com.drivezy.common.MySQLDbConnection;

public class LoginDao
{
	public int checkLoginCredentials()
	{
		Connection mySqlCon = null;
		
		try
		{
			mySqlCon = MySQLDbConnection.getConnection();
			PreparedStatement ps = mySqlCon.prepareStatement("SELECT * FROM user WHERE email=? and password=?");
			ResultSet rs = ps.executeQuery();
			
			/*while(rs.next())
			{
			
			}
			*/
			
			if (rs.next() == false)
			{
				//System.out.println("");
				return 0;
			}
			else
			{
				return 1;
			}
			
		}
		catch(Exception e)
		{
			System.out.println("getAllUserRecords(): "+e);
		}
		finally
		{
			if(mySqlCon != null)
			{
				try
				{
					mySqlCon.close();
				}
				catch(SQLException e)
				{
					e.getSuppressed();
				}
			}
		}
		
		return 0;
	}
}
