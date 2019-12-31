<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Ride</title>
	<jsp:include page="../../view/common/header.jsp"></jsp:include>
		<jsp:include page="../../view/common/leftSidebar.jsp"></jsp:include>
		
<div class="container-fluid">
	<h1>Book Ride</h1>
	<hr>
	<!-- Section Example-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fa fa-chart-area"></i>
		</div>
		<div class="card-body">
			<form action="confirmRide.jsp" method="POST" id="bookRideForm">
				<div class="form-group">
					<label for="sourceLocation">Source Location:</label>
					<input type="text" class="form-control" placeholder="Source" id="sourceLocation" name="sourceLocation" required>
					<input type="hidden" class="form-control" id="sourceLocationLat" name="sourceLocationLat" value="">
					<input type="hidden" class="form-control" id="sourceLocationLong" name="sourceLocationLong" value="">
					<input type="hidden" class="form-control" id="sourceZipCode" name="sourceZipCode" value="">
				</div>
				
				<div class="form-group">
					<label for="destinationLocation">Destination:</label>
					<input type="text" class="form-control" placeholder="Destination" id="destinationLocation" name="destinationLocation" required>
					<input type="hidden" class="form-control" id="destinationLocationLat" name="destinationLocationLat" value="">
					<input type="hidden" class="form-control" id="destinationLocationLong" name="destinationLocationLong" value="">
				</div>
				
				<div class="form-group">
					<label for="rideDate">Ride Date:</label>
					<input type="text" class="form-control" placeholder="Date" id="rideDate" name="rideDate" required>
				</div>
				
				<div class="form-group">
					<label for="rideTime">Ride Time:</label>
					<input type="text" class="form-control" placeholder="Time" id="rideTime" name="rideTime" required>
					<input type="hidden" class="form-control" id="rideDistanceInMiles" name="rideDistanceInMiles" value="">
					<input type="hidden" class="form-control" id="rideExpectedDuration" name="rideExpectedDuration" value="">
					<input type="hidden" class="form-control" id="rideExpectedDurationInTraffic" name="rideExpectedDurationInTraffic" value="">
				</div>
				
				<div class="form-group">
					<label for="rideType">Ride Type:</label>
					<select id="rideType" name="rideType" class="form-control" required>
						<option selected disabled hidden>Select Ride Type</option>
						<option value="private">Private Ride</option>
						<option value="share">Share Ride</option>
					</select>
				</div>

  				<button type="submit" class="btn btn-primary">Book Ride</button>
  				
			</form>
		</div>
		<div class="card-footer small text-muted"></div>
	</div>
</div>
<!-- /.container-fluid -->

<!-- Google Places Search -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdMHt-mrO06qcH0_4nIVhTLnk6-UNgC20&libraries=places&callback=initAutocomplete&libraries=places" async defer></script>
<!-- Google Geocoding API -->
<!-- <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDdMHt-mrO06qcH0_4nIVhTLnk6-UNgC20"></script> -->
<script type="text/javascript">
$(document).ready(function(){
	$('#rideDate').datetimepicker({
	    format: 'DD-MMM-YYYY',
	    minDate: new Date()
	});
	
	$('#rideTime').datetimepicker({
		format: 'LT'
	});
	
	$("#sourceLocation").change(function(){
		var geocodeService = new google.maps.Geocoder();
		//var sourceLocation = $("#sourceLocation").val();
		setTimeout(function(){
			geocodeService.geocode({'address': $("#sourceLocation").val()},
		    function(results, status) {
		        if (status === 'OK') //status == google.maps.GeocoderStatus.OKd
				{
					var latlongString = results[0].geometry.location.toString();
					latlongString = latlongString.replace('(','');
					latlongString = latlongString.replace(')','');
					latlongString = latlongString.trim();
					var latLong = latlongString.split(",");
					lattitude = latLong[0];
					longitude = latLong[1];
					
					/* Zip code extraction from Google Geocoding API */
					var addressComponentsObject = results[0].address_components;
					var addressComponentsArray = [];
					for (var i = 0; i < addressComponentsObject.length; i++) {
						//addressComponentsArray.push(JSON.stringify(jsonStringifiedAddressComponentsObject[i]));
						var jsonStringifiedAddressComponentsObject = JSON.stringify(addressComponentsObject[i]);
						var jsonParsedRowObject = JSON.parse(jsonStringifiedAddressComponentsObject);
						if(jsonParsedRowObject.types == "postal_code")
						{
							sourceZip = jsonParsedRowObject.long_name;
						}
						
					}
					//alert(sourceZip);
					$("#sourceZipCode").val(sourceZip);
					/* Zip code extraction from Google Geocoding API */
					
		        }
				else
				{
					lattitude = 0.0;
					longitude = 0.0;
					alert('Geocode was not successful for the following reason: ' + status);
				}
				//alert("Lat: " + lattitude);
				//alert("Long: " + longitude);
				$("#sourceLocationLat").val(lattitude);
				$("#sourceLocationLong").val(longitude);
		    });
		}, 1000);
		
		if($("#sourceLocation").val() == null || $("#destinationLocation").val() == null || $("#sourceLocation").val() == "" || $("#destinationLocation").val() == "" || typeof($("#sourceLocation").val())==='undefined' || typeof($("#destinationLocation").val())==='undefined')
		{
			
		}
		else
		{
			var distanceService = new google.maps.DistanceMatrixService();
			setTimeout(function(){
				distanceService.getDistanceMatrix({
			        origins: [$("#sourceLocation").val()],
			        destinations: [$("#destinationLocation").val()],
			        travelMode: google.maps.TravelMode.DRIVING,
			        unitSystem: google.maps.UnitSystem.IMPERIAL, //IMPERIAL for Miles, METRIC for KMs
			        durationInTraffic: true,
			        avoidHighways: false,
			        avoidTolls: false
			    },
			    function (response, status) {
			        if (status !== google.maps.DistanceMatrixStatus.OK) {
			            console.log('Error:', status);
			        }
			        else
			        {
						var stringifiedJsonResponse = JSON.stringify(response);
						//alert(stringifiedJsonResponse);
						var parsedJsonResponse = response;
						var rowsObject = parsedJsonResponse.rows;
							
						var elementsObject = rowsObject[0].elements;
							var distanceObject = elementsObject[0].distance;
								var distanceInMiles = distanceObject.text;
								$("#rideDistanceInMiles").val(distanceInMiles);
								//alert(distanceInMiles);
							var durationObject = elementsObject[0].duration;
								var duration = durationObject.text;
								$("#rideExpectedDuration").val(duration);
								//alert(duration);
							var durationInTrafficObject = elementsObject[0].duration_in_traffic;
								var durationInTraffic = durationInTrafficObject.text
								$("#rideExpectedDurationInTraffic").val(durationInTraffic);
								//alert(durationInTraffic);
						
						var originAddresses = parsedJsonResponse.originAddresses;
						//alert(originAddresses);
						
						var destinationAddresses = parsedJsonResponse.destinationAddresses;
						//alert(destinationAddresses);
			        }
			    });
			}, 1000);
		}
	});
	
	$("#destinationLocation").change(function(){
		var geocodeService = new google.maps.Geocoder();
		//var sourceLocation = $("#sourceLocation").val();
		setTimeout(function(){
			geocodeService.geocode({'address': $("#destinationLocation").val()},
		    function(results, status) {
		        if (status === 'OK') //status == google.maps.GeocoderStatus.OKd
				{
					var latlongString = results[0].geometry.location.toString();
					latlongString = latlongString.replace('(','');
					latlongString = latlongString.replace(')','');
					latlongString = latlongString.trim();
					var latLong = latlongString.split(",");
					lattitude = latLong[0];
					longitude = latLong[1];
		        }
				else
				{
					lattitude = 0.0;
					longitude = 0.0;
					alert('Geocode was not successful for the following reason: ' + status);
				}
				//alert("Lat: " + lattitude);
				//alert("Long: " + longitude);
				$("#destinationLocationLat").val(lattitude);
				$("#destinationLocationLong").val(longitude);
		    });
		}, 1000);
		
		if($("#sourceLocation").val() == null || $("#destinationLocation").val() == null || $("#sourceLocation").val() == "" || $("#destinationLocation").val() == "" || typeof($("#sourceLocation").val())==='undefined' || typeof($("#destinationLocation").val())==='undefined')
		{
			
		}
		else
		{
			var distanceService = new google.maps.DistanceMatrixService();
			setTimeout(function(){
				distanceService.getDistanceMatrix({
			        origins: [$("#sourceLocation").val()],
			        destinations: [$("#destinationLocation").val()],
			        travelMode: google.maps.TravelMode.DRIVING,
			        unitSystem: google.maps.UnitSystem.IMPERIAL, //IMPERIAL for Miles, METRIC for KMs
			        durationInTraffic: true,
			        avoidHighways: false,
			        avoidTolls: false
			    },
			    function (response, status) {
			        if (status !== google.maps.DistanceMatrixStatus.OK) {
			            console.log('Error:', status);
			        }
			        else
			        {
						var stringifiedJsonResponse = JSON.stringify(response);
						//alert(stringifiedJsonResponse);
						var parsedJsonResponse = response;
						var rowsObject = parsedJsonResponse.rows;
							
						var elementsObject = rowsObject[0].elements;
							var distanceObject = elementsObject[0].distance;
								var distanceInMiles = distanceObject.text;
								$("#rideDistanceInMiles").val(distanceInMiles);
								//alert(distanceInMiles);
							var durationObject = elementsObject[0].duration;
								var duration = durationObject.text;
								$("#rideExpectedDuration").val(duration);
								//alert(duration);
							var durationInTrafficObject = elementsObject[0].duration_in_traffic;
								var durationInTraffic = durationInTrafficObject.text
								$("#rideExpectedDurationInTraffic").val(durationInTraffic);
								//alert(durationInTraffic);
						
						var originAddresses = parsedJsonResponse.originAddresses;
						//alert(originAddresses);
						
						var destinationAddresses = parsedJsonResponse.destinationAddresses;
						//alert(destinationAddresses);
			        }
			    });
			}, 1000);
		}
	});
});

function initAutocomplete()
{
	var sourceLocation = document.getElementById('sourceLocation');
    var searchBox = new google.maps.places.SearchBox(sourceLocation);
    
    var destinationLocation = document.getElementById('destinationLocation');
    var searchBox = new google.maps.places.SearchBox(destinationLocation);
}
</script>
	
	<jsp:include page="../../view/common/footer.jsp"></jsp:include>