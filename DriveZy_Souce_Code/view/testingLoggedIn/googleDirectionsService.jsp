<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>googleDirectionsService</title>
<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
    </style>
	<jsp:include page="../../view/common/header.jsp"></jsp:include>
		<jsp:include page="../../view/common/leftSidebar.jsp"></jsp:include>
		
<div class="container-fluid">
	<h1>Dashboard</h1>
	<hr>
	<!-- Section Example-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fa fa-chart-area"></i>Section Header
		</div>
		<div class="card-body" style="height: 300px;">
			<!-- <canvas id="myAreaChart" width="100%" height="30"></canvas> -->
    <div id="map"></div>
    
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdMHt-mrO06qcH0_4nIVhTLnk6-UNgC20&callback=initMap"></script>
<script>
      function initMap() {
        var directionsService = new google.maps.DirectionsService();
        var directionsRenderer = new google.maps.DirectionsRenderer();
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 7,
          center: {lat: 41.85, lng: -87.65}
        });
        directionsRenderer.setMap(map);

        //var onChangeHandler = function() {
          calculateAndDisplayRoute(directionsService, directionsRenderer);
        //};
        //document.getElementById('start').addEventListener('change', onChangeHandler);
        //document.getElementById('end').addEventListener('change', onChangeHandler);
      }

      function calculateAndDisplayRoute(directionsService, directionsRenderer) {
        directionsService.route(
            {
              origin: {query: "10 West 31st Street, Chicago, IL, USA"},
              destination: {query: "Patel Brothers, West Devon Avenue, Chicago, IL, USA"},
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
    
		</div>
		<div class="card-footer small text-muted">Section Footer</div>
	</div>
</div>
<!-- /.container-fluid -->
	<jsp:include page="../../view/common/footer.jsp"></jsp:include>