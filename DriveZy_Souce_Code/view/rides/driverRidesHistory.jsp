<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="com.drivezy.common.MySQLDbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Driver Rides History</title>
	<jsp:include page="../../view/common/header.jsp"></jsp:include>
		<jsp:include page="../../view/common/leftSidebar.jsp"></jsp:include>
		
<div class="container-fluid">
	<h1>My Rides</h1>
	<hr>
	<!-- Section Example-->
	<div class="card mb-3">
		<div class="card-header">
			<i class="fa fa-chart-area"></i>
		</div>
		<div class="card-body">
			<!-- <canvas id="myAreaChart" width="100%" height="30"></canvas> -->
			<div class="table-responsive">
			    <table class="table table-bordered table-hover table-condensed" id="driverRideHistoryTable">
			      <thead>
			        <tr>
			          <th>#</th>
			          <th>Source</th>
			          <th>Destination</th>
			          <th>Date</th>
			          <th>Time</th>
			          <th>Cost</th>
			          <th>Customer Name</th>
			          <th>View</th>
			        </tr>
			      </thead>
			      <tbody>
<%
	Connection mySqlCon = null;
	try
	{
		int driverId = Integer.parseInt(session.getAttribute("userId").toString()); // userId = driverId for Driver userType
		mySqlCon = MySQLDbConnection.getConnection();
		
		PreparedStatement ps = mySqlCon.prepareStatement("SELECT r.rideId, r.userId, r.driverId,r.source, r.destination, r.rideDate, r.rideTime, r.estimatedArrivalTime AS totalDurationOfJourney, r.paymentAmount, r.paymentCardNumber,u.name AS customerName, u.email AS customerEmail, u.mobile AS customerMobile,d.driverName, d.driverEmail, d.driverMobile, d.vehicleNumber, d.vehicleModel, d.driverRating FROM rides r INNER JOIN user u ON r.userId = u.userId INNER JOIN driver d ON r.driverId = d.driverId WHERE r.driverId = ? ORDER BY CONCAT(r.rideDate, ' ', r.rideTime) DESC");
		ps.setInt(1, driverId);
		
		ResultSet rs = ps.executeQuery();
		SimpleDateFormat simpDate = new SimpleDateFormat("MMM dd, yyyy");
		SimpleDateFormat simpTime = new SimpleDateFormat("hh:mm a");
		Date sqlRideDate;
		Time sqlRideTime;
		int srNo = 0;
		
		while(rs.next())
		{
			srNo++;
			sqlRideDate = rs.getDate("rideDate");
			sqlRideTime = rs.getTime("rideTime");
%>
					<tr>
						<td><%=srNo %></td>
						<td><%=rs.getString("source") %></td>
						<td><%=rs.getString("destination") %></td>
						<td><%=simpDate.format(sqlRideDate) %></td>
						<td><%=simpTime.format(sqlRideTime) %></td>
						<td>$<%=rs.getString("paymentAmount") %></td>
						<td><%=rs.getString("customerName") %></td>
						<td><a href="rideInfoDriver.jsp?rideId=<%=rs.getString("rideId") %>"><i class="fa fa-eye"></i></a></td>
			        </tr>
<%
		}
	}
	catch(Exception e)
	{
		System.out.println("driverRidesHistory page- Error in fetching rides info "+e);
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
			      </tbody>
			    </table>
			  </div>
			</div>
		</div>
		<div class="card-footer small text-muted"></div>
	</div>
</div>
<!-- /.container-fluid -->
<script type="text/javascript">
$(document).ready( function () {
    $('#driverRideHistoryTable').DataTable();
})
</script>
	
	<jsp:include page="../../view/common/footer.jsp"></jsp:include>