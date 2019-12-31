<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ride Booking Confirmation</title>
<style type="text/css">
#map {
        height: 100%;
      }
</style>
	<jsp:include page="../../view/common/header.jsp"></jsp:include>
		<jsp:include page="../../view/common/leftSidebar.jsp"></jsp:include>
		
<div class="container-fluid">
	<h1>Ride Confirmation</h1>
	<hr>
	<!-- Section Example-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fa fa-chart-area"></i>Ride Datails:
		</div>
		<div class="card-body">
			<!-- <canvas id="myAreaChart" width="100%" height="30"></canvas> -->
			<div class="row">
				<div class="col-sm-4">
					<form action="rideDetailsAction.jsp" method="POST">
						<div class="form-group">
							<label for="sourceLocation">Start Location:</label>
							<div name="sourceLocation" id="sourceLocation" value="<%= request.getParameter("sourceLocation") %>"><%= request.getParameter("sourceLocation") %></div>
							<input type="hidden" name="hiddenSourceLocation" id="hiddenSourceLocation" class="form-control" value="<%= request.getParameter("sourceLocation") %>">
							<input type="hidden" name="hiddenSourceLat" id="hiddenSourceLat" class="form-control" value="<%= request.getParameter("sourceLocationLat") %>">
							<input type="hidden" name="hiddenSourceLong" id="hiddenSourceLong" class="form-control" value="<%= request.getParameter("sourceLocationLong") %>">
							<input type="hidden" name="hiddenSourceZipCode" id="hiddenSourceZipCode" class="form-control" value="<%= request.getParameter("sourceZipCode") %>">
						</div>
						
						<div class="form-group">
							<label for="destinationLocation">End Location:</label>
							<div name="destinationLocation" id="destinationLocation" value="<%= request.getParameter("destinationLocation") %>"><%= request.getParameter("destinationLocation") %></div>
							<input type="hidden" name="hiddenDestinationLocation" id="hiddenDestinationLocation" class="form-control" value="<%= request.getParameter("destinationLocation") %>">
							<input type="hidden" name="hiddenDestinationLat" id="hiddenDestinationLat" class="form-control" value="<%= request.getParameter("destinationLocationLat") %>">
							<input type="hidden" name="hiddenDestinationLong" id="hiddenDestinationLong" class="form-control" value="<%= request.getParameter("destinationLocationLong") %>">
						</div>
						
						<div class="form-group">
							<label for="sourceLocation">Ride Date and Time:</label>
							<div name="sourceLocation" id="sourceLocation" value="<%= request.getParameter("rideDate") + " " + request.getParameter("rideTime") %>"><%= request.getParameter("rideDate") + " " + request.getParameter("rideTime") %></div>
							<input type="hidden" name="hiddenRideDate" id="hiddenRideDate" class="form-control" value="<%= request.getParameter("rideDate") %>">
							<input type="hidden" name="hiddenRideTime" id="hiddenRideTime" class="form-control" value="<%= request.getParameter("rideTime") %>">
						</div>
						
						<div class="form-group">
							<label for="rideCost">Ride Cost:</label>
							<div name="rideCost" id="rideCost" value="">$ <span id="rideCostFromAPI"></span></div>
							<input type="hidden" name="hiddenRideCost" id="hiddenRideCost" value="" class="form-control" >
						</div>
						
						<div class="form-group">
							<label for="rideType">Ride Type:</label>
							<div name="rideType" id="rideType" value="<%= request.getParameter("rideType") %>"><%= request.getParameter("rideType") %></div>
							<input type="hidden" name="hiddenRideType" id="hiddenRideType" value="<%= request.getParameter("rideType") %>">
						</div>
						
						<div class="form-group">
							<label for="rideDistance">Ride Distance:</label>
							<div name="rideDistance" id="rideDistance" value=""><%= request.getParameter("rideDistanceInMiles") %></div>
							<input type="hidden" name="hiddenRideDistance" id="hiddenRideDistance" value="<%= request.getParameter("rideDistanceInMiles") %>" class="form-control">
						</div>
						
						<div class="form-group">
							<label for="expecetdRideDuration">Expected Ride Time:</label>
							<div name="expecetdRideDuration" id="expecetdRideDuration" value=""><%= request.getParameter("rideExpectedDuration") %></div>
							<input type="hidden" name="hiddenExpecetdRideDuration" id="hiddenExpecetdRideDuration" value="<%= request.getParameter("rideExpectedDuration") %>" class="form-control">
						</div>
						
						<div class="form-group">
							<label for="cardNumber">Credit / Debit Card:</label>
							<input type="input" name="cardNumber" id="cardNumber" placeholder="Card Number" class="form-control" required>
						</div>
						
						<div class="form-group">
							<input type="submit" style="width: 100%" class="btn btn-success" name="confirmPaymentBtn" id="confirmPaymentBtn" value="Confirm Payment" class="form-control">
						</div>
					</form>
				</div>
				<div class="col-sm-8" style="height: 500px;">
					<div id="map"></div>
					<!-- <div id="panel" style="width: 300px; float: right;"></div> -->
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
				</div>
			</div>
		</div>
		<div class="card-footer small text-muted">Section Footer</div>
	</div>
</div>
<!-- /.container-fluid -->
<script type="text/javascript">
$(document).ready(function(){
	var rideType;
	if($("#hiddenRideType").val() == "share")
	{
		rideType = 2;
	}
	else if($("#hiddenRideType").val() == "private")
	{
		rideType = 1;
	}
	//var rideType = $("#hiddenRideType").val();
	var sourceLat = $("#hiddenSourceLat").val();
	var sourceLong = $("#hiddenSourceLong").val();
	var destinationLat = $("#hiddenDestinationLat").val();
	var destinationLong = $("#hiddenDestinationLong").val();
	var rideDistance = $("#hiddenRideDistance").val();
	var rideDistanceArr = rideDistance.split(" ");
	rideDistance = rideDistanceArr[0];
	var rideDateTimeStamp = $("#hiddenRideDate").val() + " "+ $("#hiddenRideTime").val();
	//alert(rideDateTimeStamp);
	//22-Nov-2019 1:00 PM
	//25-Nov-2019 9:00 AM
	var dateFormattedRideTimestamp = new Date(rideDateTimeStamp);
	//alert(dateFormattedRideTimestamp);
	var rideYear = dateFormattedRideTimestamp.getFullYear();
	rideYear = rideYear.toString();
	rideYear = rideYear.replace("-", "");
	var rideMonth = dateFormattedRideTimestamp.getMonth() + 1;
	var rideDate = dateFormattedRideTimestamp.getDate();
	var rideDateTimeStampForDay = rideDateTimeStamp.toString();
	
	
	//var dateFormattedRideDateTimeStampForDay = new Date(rideDateTimeStampForDay);
	//var rideDay = dateFormattedRideDateTimeStampForDay.getDay();
	//var rideDay = dateFormattedRideTimestamp.getDay();
	var dateStringForRideDay = rideYear +" "+ rideMonth +" "+ rideDate;
	var dateFormattedDateStringForRideDay = new Date(dateStringForRideDay);
	var rideDay = dateFormattedDateStringForRideDay.getDay();
	//alert(rideDay);
	var ride24Hour = dateFormattedRideTimestamp.getHours();
	//"Year":2019,"Month":11,"Date":18,"Day of Week":1,"Hour":18

	var jsonRequest = '{"passenger_count":'+rideType+',"pickup_latitude":'+sourceLat+',"pickup_longitude":'+sourceLong+',"dropoff_latitude":'+destinationLat+',"dropoff_longitude":'+destinationLong+',"H_Distance":'+rideDistance+',"Year":'+rideYear+',"Month":'+rideMonth+',"Date":'+rideDate+',"Day of Week":'+rideDay+',"Hour":'+ride24Hour+'}';
	var parsedJsonRequest = JSON.parse(jsonRequest);
	//alert(JSON.stringify(parsedJsonRequest));
	
	$.ajax
	({ 
		type: "POST",
		url:"http://localhost:5000/predict_api",
		//contentType: "application/json",
		//dataType: "json",
		data: JSON.stringify(parsedJsonRequest),
		/*
		data: JSON.stringify({
			'passenger_count':1,
			'pickup_latitude':9,
			'pickup_longitude':6,
			'dropoff_latitude':41.8406176,
			'dropoff_longitude':-87.6159749,
			'H_Distance':4,
			'Year':2019,
			'Month':11,
			'Date':18,
			'Day_of_Week':1,
			'Hour':18
		}),
		*/
		success: function(response)
		{        
			var stringifiedResponse = JSON.stringify(response);
			stringifiedResponse = stringifiedResponse.replace("{", "");
			stringifiedResponse = stringifiedResponse.replace("}", "");
			stringifiedResponseArray = stringifiedResponse.split(":");
			var fare = parseFloat(stringifiedResponseArray[1]).toFixed(2);
			//alert(fare);
			$("#hiddenRideCost").val(fare);
			$("#rideCostFromAPI").text(fare);
		},
		/*
		complete: function(response)
		{
			var stringifiedResponse = JSON.stringify(response);
			alert(stringifiedResponse);
		},
		*/
		error:function(error)
		{
			alert(JSON.stringify(error));
		}
	});
});
</script>
	
	<jsp:include page="../../view/common/footer.jsp"></jsp:include>