<%@page import="com.drivezy.common.MySQLDbConnection"%>
<%@page import="java.sql.Connection, java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Write Review Action</title>
</head>
<body>
<%
	String rideRating = request.getParameter("rideRating");
	String rideReviewText = request.getParameter("rideReviewText");
	String rideId = request.getParameter("rideId");
	
	Connection mySqlCon = null;
	int status;
	
	try
	{
		mySqlCon = MySQLDbConnection.getConnection();
		
		PreparedStatement ps = mySqlCon.prepareStatement("UPDATE rides SET rideReview=? , rideRating=? WHERE rideId=?");
		
		ps.setString(1, rideReviewText);
		ps.setString(2, rideRating);
		ps.setString(3, rideId);
        
        status = ps.executeUpdate();
        
        if(status > 0)
        {
        	response.sendRedirect("../../view/rides/customerRideHistory.jsp");
        }
        else
        {
        	//response.sendRedirect("register.jsp");
        }
	}
	catch(Exception e)
	{
		System.out.println("Update Statement: Adding ride review and rating in MySQL - writeReviewAction page: "+e);
		e.printStackTrace();
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
%>
</body>
</html>