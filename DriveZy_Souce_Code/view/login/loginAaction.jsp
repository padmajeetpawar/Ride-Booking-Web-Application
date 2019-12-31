<%@page import="com.drivezy.common.MySQLDbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DriveZy Login Action</title>
</head>
<body>
<%@ page import="com.drivezy.dao.*, java.sql.*, java.util.*" %>
<%
//response.sendRedirect("../../view/testingLoggedIn/welcome.jsp");
String email = request.getParameter("email");
String password = request.getParameter("password");

Connection mySqlCon = null;

try
{
	mySqlCon = MySQLDbConnection.getConnection();
	
	PreparedStatement ps = mySqlCon.prepareStatement("SELECT userId, name, email, password, mobile, userType FROM user WHERE email = ? AND password = ?");
	ps.setString(1,email);  
    ps.setString(2,password);
    
    ResultSet rs = ps.executeQuery();
    
    if (rs.next() == false)
    {
    	System.out.println("ResultSet in empty, Login Credentials are not Valid");
    	response.sendRedirect("login.jsp");
    }
    else
    {
   		//session.putValue("userName", rs.getString("name"));
   		session.setAttribute("userName", rs.getString("name"));
   		session.setAttribute("userId", rs.getInt("userId"));
   		session.setAttribute("userEmail", rs.getString("email"));
   		session.setAttribute("userMobile", rs.getString("mobile"));
   		session.setAttribute("userType", rs.getString("userType"));
    		
    	System.out.println("Login Successful: Session: userName-" + session.getAttribute("userName"));
    	
    	response.sendRedirect("../../view/dashboard/dashboard.jsp");
    }
}
catch(Exception e)
{
	System.out.println("Customer Registration - registerAction page: "+e);
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