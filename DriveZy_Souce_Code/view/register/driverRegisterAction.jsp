<%@page import="com.drivezy.common.MySQLDbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Driver Registration Action</title>
</head>
<body>
<%@ page import="com.drivezy.dao.*, java.sql.*, java.util.*" %>
<%
	//response.sendRedirect("../../view/login/login.jsp");
	String userName = request.getParameter("userName");
	String userEmail = request.getParameter("userEmail");
	String userPassword = request.getParameter("userPassword");
	String userMobile = "+1 " + request.getParameter("userMobile");
	String userType = request.getParameter("userType");
	String vehicleNumber = request.getParameter("vehicleNumber");
	String vehicleModel = request.getParameter("vehicleModel");
	
	Connection mySqlCon = null;
	int status;
	
	try
	{
		mySqlCon = MySQLDbConnection.getConnection();
		
		PreparedStatement ps = mySqlCon.prepareStatement("INSERT INTO driver (driverName,driverEmail,driverPassword,driverMobile,userType,vehicleNumber,vehicleModel) VALUES (?,?,?,?,?,?,?)");
		
		ps.setString(1,userName);  
        ps.setString(2,userEmail);  
        ps.setString(3,userPassword);  
        ps.setString(4,userMobile);  
        ps.setString(5,userType);
        ps.setString(6,vehicleNumber);
        ps.setString(7,vehicleModel);
        
        status = ps.executeUpdate();
        
        if(status > 0)
        {
        	response.sendRedirect("../../view/login/driverLogin.jsp");
        }
        else
        {
        	response.sendRedirect("driverRegister.jsp");
        }
	}
	catch(Exception e)
	{
		System.out.println("Driver Registration - driverRegisterAction page: "+e);
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