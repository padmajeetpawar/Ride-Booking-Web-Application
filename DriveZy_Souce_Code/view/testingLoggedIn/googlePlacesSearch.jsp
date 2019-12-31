<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DriveZy: Google Place Search</title>
<style>
	 /* Set the size of the div element that contains the map */
	#map
	{
		height: 400px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
</style>
	<jsp:include page="../../view/common/header.jsp"></jsp:include>

		<jsp:include page="../../view/common/leftSidebar.jsp"></jsp:include>
		
<div class="container-fluid">
	<!-- Breadcrumbs-->
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="#">Dashboard</a></li>
		<li class="breadcrumb-item active">Overview</li>
	</ol>
	<!-- Breadcrumbs-->
	
	<!-- Icon Cards-->
	<div class="row">
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-primary o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fa fa-fw fa-comments"></i>
					</div>
					<div class="mr-5">26 New Messages!</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fa fa-angle-right"></i>
					</span>
				</a>
			</div>
		</div>
	  
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-warning o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fa fa-fw fa-list"></i>
					</div>
					<div class="mr-5">11 New Tasks!</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fa fa-angle-right"></i>
					</span>
				</a>
			</div>
		</div>
		
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-success o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fa fa-fw fa-shopping-cart"></i>
					</div>
					<div class="mr-5">123 New Orders!</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fa fa-angle-right"></i>
					</span>
				</a>
			</div>
		</div>
		
		<div class="col-xl-3 col-sm-6 mb-3">
			<div class="card text-white bg-danger o-hidden h-100">
				<div class="card-body">
					<div class="card-body-icon">
						<i class="fa fa-fw fa-life-ring"></i>
					</div>
					<div class="mr-5">13 New Tickets!</div>
				</div>
				<a class="card-footer text-white clearfix small z-1" href="#">
					<span class="float-left">View Details</span>
					<span class="float-right">
						<i class="fa fa-angle-right"></i>
					</span>
				</a>
			</div>
		</div>
	</div>
	<!-- Icon Cards-->
	
	<!-- Area Chart Example-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fa fa-chart-area"></i>Section Header
		</div>
		<div class="card-body">
			<!-- <canvas id="myAreaChart" width="100%" height="30"></canvas> -->
			Section Content
			<input name="sourceLocation" id="sourceLocation" class="form-control required" type="text" placeholder="Source Location">
			<input name="destinationLocation" id="destinationLocation" class="form-control required" type="text" placeholder="Destination Location">
			<div id="map"></div>
				<!-- Google Places Search -->
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdMHt-mrO06qcH0_4nIVhTLnk6-UNgC20&libraries=places&callback=initAutocomplete" async defer></script>
	<!-- Google Places Search -->
			<script>
			function initAutocomplete() {
				// Create the search box and link it to the UI element.
			    var sourceLocation = document.getElementById('sourceLocation');
			    var searchBox = new google.maps.places.SearchBox(sourceLocation);
			    
			    var destinationLocation = document.getElementById('destinationLocation');
			    var searchBox = new google.maps.places.SearchBox(destinationLocation);
			    
			    var map = new google.maps.Map(document.getElementById('map'), {
			        center: {
			            lat: 27.6648,
			            lng: -81.5158
			        },
			        zoom: 6,
			        mapTypeId: 'roadmap'
			    });
			    //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
			    // Bias the SearchBox results towards current map's viewport.
			    map.addListener('bounds_changed', function() {
			        searchBox.setBounds(map.getBounds());
			    });
			    var markers = [];
			    // Listen for the event fired when the user selects a prediction and retrieve
			    // more details for that place.
			    searchBox.addListener('places_changed', function() {
			        var places = searchBox.getPlaces();
			        if (places.length == 0) {
			            return;
			        }
			        // Clear out the old markers.
			        markers.forEach(function(marker) {
			            marker.setMap(null);
			        });
			        markers = [];
			        // For each place, get the icon, name and location.
			        var bounds = new google.maps.LatLngBounds();
			        places.forEach(function(place) {
			            if (!place.geometry) {
			                console.log("Returned place contains no geometry");
			                return;
			            }
			            var icon = {
			                url: place.icon,
			                size: new google.maps.Size(71, 71),
			                origin: new google.maps.Point(0, 0),
			                anchor: new google.maps.Point(17, 34),
			                scaledSize: new google.maps.Size(25, 25)
			            };
			            // Create a marker for each place.
			            markers.push(new google.maps.Marker({
			                map: map,
			                icon: icon,
			                title: place.name,
			                position: place.geometry.location
			            }));
			            if (place.geometry.viewport) {
			                // Only geocodes have viewport.
			                bounds.union(place.geometry.viewport);
			            } else {
			                bounds.extend(place.geometry.location);
			            }
			        });
			        map.fitBounds(bounds);
			    });
			}
			</script>
		</div>
		<div class="card-footer small text-muted">Section Footer</div>
	</div>
</div>
<!-- /.container-fluid -->
	
	<jsp:include page="../../view/common/footer.jsp"></jsp:include>