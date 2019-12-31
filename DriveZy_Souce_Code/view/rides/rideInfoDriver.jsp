<%@page import="java.sql.*"%>
<%@page import="com.drivezy.common.MySQLDbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ride Information for Driver</title>
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
	<!-- Section Example-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fa fa-chart-area"></i>
		</div>
		<div class="card-body">
		
<%
Connection mySqlCon = null;
int rideId = Integer.parseInt(request.getParameter("rideId").toString());
try
{
	mySqlCon = MySQLDbConnection.getConnection();
	
	PreparedStatement ps = mySqlCon.prepareStatement("SELECT r.rideId, r.userId, r.driverId,r.source, r.destination, r.rideDate, r.rideTime, r.estimatedArrivalTime AS totalDurationOfJourney, r.paymentAmount, r.paymentCardNumber, r.rideType, u.name AS customerName, u.email AS customerEmail, u.mobile AS customerMobile,d.driverName, d.driverEmail, d.driverMobile, d.vehicleNumber, d.vehicleModel, d.driverRating FROM rides r INNER JOIN user u ON r.userId = u.userId INNER JOIN driver d ON r.driverId = d.driverId WHERE r.rideId = ?");
	
	ps.setInt(1, rideId);
    
	ResultSet rs = ps.executeQuery();
	
	if(rs.next() == false)
	{
		System.out.println("Invalid ride Id");
	}
	else
	{	
%>
			<div class="row">
				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-12" style="height: 500px;">
							<div id="map"></div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<!-- <form action="#" method="POST"> -->
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
								<div name="sourceLocation" id="sourceLocation" value="<%= rs.getString("rideDate") + " " + rs.getString("rideTime") %>"><%= rs.getString("rideDate") + " " + rs.getString("rideTime") %></div>
								<input type="hidden" name="hiddenRideDate" id="hiddenRideDate" class="form-control" value="<%= rs.getString("rideDate") %>">
								<input type="hidden" name="hiddenRideTime" id="hiddenRideTime" class="form-control" value="<%= rs.getString("rideTime") %>">
							</div>
						</div>
						<div class="col-sm-6">
						<%-- 
							<div class="form-group">
								<label for="rideCost">Ride Cost:</label>
								<div name="rideCost" id="rideCost" value="">$ <%= rs.getString("paymentAmount") %></div>
								<input type="hidden" name="hiddenRideCost" id="hiddenRideCost" value="<%= rs.getString("paymentAmount") %>" class="form-control" >
							</div>
							
							<div class="form-group">
								<label for="expecetdRideDuration">Expected Ride Time (in minutes):</label>
								<div name="expecetdRideDuration" id="expecetdRideDuration" value=""><%= rs.getString("totalDurationOfJourney") %></div>
								<input type="hidden" name="hiddenExpecetdRideDuration" id="hiddenExpecetdRideDuration" value="<%= rs.getString("totalDurationOfJourney") %>" class="form-control">
							</div>
						 --%>	
							<div class="form-group">
								<label for="customerName">Customer Details:</label>
								<div name="customerName" id="customerName" value="">Name-<%= rs.getString("customerName") %></div>
								<div name="customerEmail" id="customerEmail" value="">Email-<%= rs.getString("customerEmail") %></div>
								<div name="customerMobile" id="customerMobile" value="">Mobile-<%= rs.getString("customerMobile") %></div>
							</div>
							
							<div class="form-group">
								<label for="expecetdRideType">Ride Type:</label>
								<div name="expecetdRideType" id="expecetdRideType" value=""><%= rs.getString("rideType") %></div>
								<input type="hidden" name="hiddenRideType" id="hiddenRideType" value="<%= rs.getString("rideType") %>" class="form-control">
							</div>
							<!-- </form> -->
						</div>
					</div>
				</div>
				
				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-12">
							<div id="panel"></div>
						</div>
					</div>
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
		<div class="card-footer small text-muted"></div>
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
        directionsRenderer.setPanel(document.getElementById('panel'));
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