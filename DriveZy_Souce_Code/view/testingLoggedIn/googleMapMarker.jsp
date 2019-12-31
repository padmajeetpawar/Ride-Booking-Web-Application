<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DriveZy: Google Map Marker</title>
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
			<div id="map"></div>
				<!-- Google Map Marker -->
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdMHt-mrO06qcH0_4nIVhTLnk6-UNgC20&callback=initMap"></script>
	<!-- Google Map Marker -->
			<script>
				// Initialize and add the map
				function initMap()
				{
					// The location of IIT, Chicago
					//var uluru = {lat: 41.836048, lng: -87.626454};
					
					// The map, centered at Uluru
					var map = new google.maps.Map(document.getElementById('map'), {zoom: 4, center: {lat: 41.836048, lng: -87.626454}});
					
					// The marker, positioned at Uluru
					var marker = new google.maps.Marker({position: {lat: 41.836048, lng: -87.626454}, map: map});
				}
			</script>
		</div>
		<div class="card-footer small text-muted">Section Footer</div>
	</div>
</div>
<!-- /.container-fluid -->
	
	<jsp:include page="../../view/common/footer.jsp"></jsp:include>