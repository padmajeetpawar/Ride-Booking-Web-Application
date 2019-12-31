<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logout Action</title>
</head>
<body>
<%@ page import="java.sql.*, java.util.*" %>
<%
	//HttpSession javaSession = request.getSession();
	if(session!=null)
	{
		session.invalidate();
	}
	//response.sendRedirect("../../view/login/login.jsp");
	response.sendRedirect("../../");
%>
</body>
</html>