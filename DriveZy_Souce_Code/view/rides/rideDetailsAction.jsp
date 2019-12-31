<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="com.drivezy.common.MySQLDbConnection"%>
<%@page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ride Information</title>
<style type="text/css">
#map
{
	height: 100%;
}
</style>
	<jsp:include page="../../view/common/header.jsp"></jsp:include>
		<jsp:include page="../../view/common/leftSidebar.jsp"></jsp:include>
		
<div class="container-fluid">
	<h1>Ride Details</h1>
	<hr>
<%
	//response.sendRedirect("../../view/login/login.jsp");
	String sourceLocation = request.getParameter("hiddenSourceLocation");
	String sourceZipcode = request.getParameter("hiddenSourceZipCode");
	String destinationLocation = request.getParameter("hiddenDestinationLocation");
	
	String rideDate = request.getParameter("hiddenRideDate");
	SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy");
	java.util.Date date = sdf1.parse(rideDate);
	java.sql.Date sqlRideDate = new java.sql.Date(date.getTime());
	System.out.println("sqlStartDate: " + sqlRideDate);
	
	String rideTime = request.getParameter("hiddenRideTime");
	SimpleDateFormat sdf2 = new SimpleDateFormat("hh:mm a");
	java.util.Date time = sdf2.parse(rideTime);
	java.sql.Time sqlRideTime = new java.sql.Time(time.getTime());
	System.out.println("sqlRideTime: " + sqlRideTime);
	
	String rideCost = request.getParameter("hiddenRideCost");
	String expextedRideDuration = request.getParameter("hiddenExpecetdRideDuration");
	String rideDistance = request.getParameter("hiddenRideDistance");
	String cardNumber = request.getParameter("cardNumber");
	String rideType= request.getParameter("hiddenRideType");
	int userId = Integer.parseInt(session.getAttribute("userId").toString());
	double randomDouble = Math.random();
	randomDouble = randomDouble * 2 + 1;
	int randomInt = (int) randomDouble;
	int driverId = randomInt;
	System.out.println("driverId: " + driverId);
	/*
	if(session.getAttribute("userId").equals(null))
	{
		response.sendRedirect("../../view/login/login.jsp");
	}
	else
	{
		String userId = session.getAttribute("userId").toString();
	}
	*/
	
	Connection mySqlCon = null;
	int status;
	int lastInsertedRideId = 0;
	
	try
	{
		mySqlCon = MySQLDbConnection.getConnection();
		
		PreparedStatement ps = mySqlCon.prepareStatement("INSERT INTO rides (userId,driverId,source,destination,rideDate,rideTime,estimatedArrivalTime,paymentAmount,paymentCardNumber,rideDistance,sourceZipcode,rideType) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
		
		ps.setInt(1, userId);
		ps.setInt(2, driverId);
		ps.setString(3, sourceLocation);
		ps.setString(4, destinationLocation);
		ps.setDate(5, sqlRideDate);
		ps.setTime(6, sqlRideTime);
		ps.setString(7, expextedRideDuration);
		ps.setString(8, rideCost);
		ps.setString(9, cardNumber);
		ps.setString(10, rideDistance);
		ps.setString(11, sourceZipcode);
		ps.setString(12, rideType);
        
        status = ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();
        if(rs.next())
        {
        	lastInsertedRideId = rs.getInt(1);
        }
        System.out.println("Ride Inserted: " + status);
        System.out.println("Last Inserted rideId: " + lastInsertedRideId);
        
        /*
        if(status > 0)
        {
        	response.sendRedirect("../../view/login/login.jsp");
        }
        else
        {
        	response.sendRedirect("register.jsp");
        }
        */
	}
	catch(Exception e)
	{
		System.out.println("Ride Details Action page- Error in inserting ride "+e);
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
	
	<!-- Section Example-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fa fa-chart-area"></i>Section Header
		</div>
		<div class="card-body">
		
<%
try
{
	mySqlCon = MySQLDbConnection.getConnection();
	
	PreparedStatement ps = mySqlCon.prepareStatement("SELECT r.rideId, r.userId, r.driverId,r.source, r.destination, r.rideDate, r.rideTime, r.estimatedArrivalTime AS totalDurationOfJourney, r.paymentAmount, r.paymentCardNumber, r.rideDistance, u.name AS customerName, u.email AS customerEmail, u.mobile AS customerMobile,d.driverName, d.driverEmail, d.driverMobile, d.vehicleNumber, d.vehicleModel, d.driverRating FROM rides r INNER JOIN user u ON r.userId = u.userId INNER JOIN driver d ON r.driverId = d.driverId WHERE r.rideId = ?");
	
	ps.setInt(1, lastInsertedRideId);
    
	ResultSet rs = ps.executeQuery();
	SimpleDateFormat simpDate = new SimpleDateFormat("MMM dd, yyyy");
	SimpleDateFormat simpTime = new SimpleDateFormat("hh:mm a");
	
	if(rs.next() == false)
	{
		System.out.println("Invalid ride Id");
	}
	else
	{	
%>
			<div class="row">
				<div class="col-sm-4">
					<form action="#" method="POST">
						<div class="form-group">
							<label for="sourceLocation">Start Location:</label>
							<div name="sourceLocation" id="sourceLocation" value="<%= rs.getString("source") %>"><%= rs.getString("source") %></div>
							<input type="hidden" name="hiddenSourceLocation" id="hiddenSourceLocation" class="form-control" value="<%= rs.getString("source") %>">
						</div>
						
						<div class="form-group">
							<label for="destinationLocation">End Location:</label>
							<div name="destinationLocation" id="destinationLocation" value="<%= rs.getString("destination") %>"><%= rs.getString("destination") %></div>
							<input type="hidden" name="hiddenDestinationLocation" id="hiddenDestinationLocation" class="form-control" value="<%= rs.getString("destination") %>">
						</div>
						
						<div class="form-group">
							<label for="sourceLocation">Ride Date and Time:</label>
							<div name="sourceLocation" id="sourceLocation" value="<%= simpDate.format(rs.getDate("rideDate")) + " " + simpTime.format(rs.getTime("rideTime")) %>"><%= simpDate.format(rs.getDate("rideDate")) + " " + simpTime.format(rs.getTime("rideTime")) %></div>
							<input type="hidden" name="hiddenRideDate" id="hiddenRideDate" class="form-control" value="<%= simpDate.format(rs.getDate("rideDate")) %>">
							<input type="hidden" name="hiddenRideTime" id="hiddenRideTime" class="form-control" value="<%= simpTime.format(rs.getTime("rideTime")) %>">
						</div>
						
						<div class="form-group">
							<label for="rideCost">Ride Cost:</label>
							<div name="rideCost" id="rideCost" value="">$ <%= rs.getString("paymentAmount") %></div>
							<input type="hidden" name="hiddenRideCost" id="hiddenRideCost" value="<%= rs.getString("paymentAmount") %>" class="form-control" >
						</div>
						
						<div class="form-group">
							<label for="rideDistance">Ride Distance:</label>
							<div name="rideDistance" id="rideDistance" value=""><%= rs.getString("rideDistance") %></div>
							<input type="hidden" name="hiddenRideDistance" id="hiddenRideDistance" value="<%= rs.getString("rideDistance") %>" class="form-control" >
						</div>
						
						<div class="form-group">
							<label for="expecetdRideDuration">Expected Ride Time (in minutes):</label>
							<div name="expecetdRideDuration" id="expecetdRideDuration" value=""><%= rs.getString("totalDurationOfJourney") %></div>
							<input type="hidden" name="hiddenExpecetdRideDuration" id="hiddenExpecetdRideDuration" value="<%= rs.getString("totalDurationOfJourney") %>" class="form-control">
						</div>
						
						<div class="form-group">
							<label for="driverName">Driver Details:</label>
							<div name="driverName" id="driverName" value="">Name-<%= rs.getString("driverName") %></div>
							<div name="driverEmail" id="driverEmail" value="">Email-<%= rs.getString("driverEmail") %></div>
							<div name="driverMobile" id="driverMobile" value="">Mobile-<%= rs.getString("driverMobile") %></div>
							<div name="driverRating" id="driverRating" value="">Rating-<%= rs.getString("driverRating") %></div>
						</div>
						
						<div class="form-group">
							<label for="vehicleDetails">Vehicle Details:</label>
							<div name="vehicleModel" id="vehicleModel" value="">Model: <%= rs.getString("vehicleModel") %></div>
							<div name="vehicleNumber" id="vehicleNumber" value="">Number: <%= rs.getString("vehicleNumber") %></div>
						</div>
						
						<!--
						<div class="form-group">
							<input type="submit" style="width: 100%" class="btn btn-success" name="confirmPaymentBtn" id="confirmPaymentBtn" value="Confirm Payment" class="form-control">
						</div>
						-->
						
					</form>
				</div>
				<div class="col-sm-8" style="height: 500px;">
					<div id="map"></div>
				</div>
			</div>
<%
	}
}
catch(Exception e)
{
	System.out.println("Ride Details Action page: "+e);
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
		</div>
		<div class="card-footer small text-muted">Section Footer</div>
	</div>
</div>
<!-- /.container-fluid -->

<script>
      function initMap() {
        var directionsService = new google.maps.DirectionsService();
        var directionsRenderer = new google.maps.DirectionsRenderer();
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 7,
          center: {lat: 41.85, lng: -87.65}
        });
        directionsRenderer.setMap(map);
        /*
        <div id="panel" style="width: 300px; float: right;"></div>
        directionsRenderer.setPanel(document.getElementById('panel'));
        */

        //var onChangeHandler = function() {
          calculateAndDisplayRoute(directionsService, directionsRenderer);
        //};
        //document.getElementById('hiddenSourceLocation').addEventListener('change', onChangeHandler);
        //document.getElementById('hiddenDestinationLocation').addEventListener('change', onChangeHandler);
      }

      function calculateAndDisplayRoute(directionsService, directionsRenderer) {
        directionsService.route(
            {
              origin: {query: document.getElementById('hiddenSourceLocation').value},
              destination: {query: document.getElementById('hiddenDestinationLocation').value},
              //origin: {query: "10 West 31st Street, Chicago, IL, USA"},
              //destination: {query: "Patel Brothers, West Devon Avenue, Chicago, IL, USA"},
              travelMode: 'DRIVING'
            },
            function(response, status) {
              if (status === 'OK') {
                directionsRenderer.setDirections(response);
              } else {
                window.alert('Directions request failed due to ' + status);
              }
            });
      }
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdMHt-mrO06qcH0_4nIVhTLnk6-UNgC20&callback=initMap">
    </script>
	
	<jsp:include page="../../view/common/footer.jsp"></jsp:include>