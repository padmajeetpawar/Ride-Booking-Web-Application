<%@page import="com.drivezy.common.MySQLDbConnection"%>
<%@page import="java.sql.*"%>
<%@page import="org.codehaus.jettison.json.JSONArray, org.codehaus.jettison.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DriveZy Dashboard</title>
<!-- Google chart link -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<jsp:include page="../../view/common/header.jsp"></jsp:include>
		<jsp:include page="../../view/common/leftSidebar.jsp"></jsp:include>
<%
Connection mySqlCon = null;
JSONObject jsonObjectForBarchart = new JSONObject();
JSONObject jsonObjectForLinechart = new JSONObject();
JSONObject jsonObjectForPiechart = new JSONObject();
%>
		
<div class="container-fluid">
	<h1>Dashboard</h1>
	<hr>
	<!-- Section Example-->
	<div class="card mb-3">
	<!-- 
		<div class="card-header">
			<i class="fa fa-chart-area"></i>Section Header
		</div>
	 -->	
		<div class="card-body">
			<!-- <canvas id="myAreaChart" width="100%" height="30"></canvas> -->
			<%
			if(session.getAttribute("userType").toString().equalsIgnoreCase("Customer"))
			{
			%>
				<div class="row" style="background:transparent url('../../images/RideSharingApp.jpg') no-repeat center center /cover; height: 420px; opacity: 0.9; color: lightyellow; ">
				</div>
			<%
			}
			else if(session.getAttribute("userType").toString().equalsIgnoreCase("Super Admin"))
			{
			%>
				<div class="row">
					<div class="col-sm-6 card">
						<div class="card-body">
						<%
try
	{
	
		/* JSONArray for 'cols' */
		JSONArray colJSONArray = new JSONArray();
		
			JSONObject col1 = new JSONObject();
				col1.put("id", "");
				col1.put("label", "Zip Code");
				col1.put("pattern", "");
				col1.put("type", "string");
			
			JSONObject col2 = new JSONObject();
				col2.put("id", "");
				col2.put("label", "Number of rides");
				col2.put("pattern", "");
				col2.put("type", "number");
		
		colJSONArray.put(col1);
		colJSONArray.put(col2);
		
		jsonObjectForPiechart.put("cols", colJSONArray);
		/* JSONArray for 'cols' */
		
		/* JSONArray for 'rows' */
		JSONArray rowJSONArray = new JSONArray();
	
			mySqlCon = MySQLDbConnection.getConnection();
			
			PreparedStatement ps = mySqlCon.prepareStatement("SELECT COUNT(r.rideId) AS noOfRides, r.sourceZipcode FROM rides r GROUP BY r.sourceZipcode ORDER BY COUNT(r.rideId) DESC LIMIT 5;");
	        
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				JSONObject outerObject = new JSONObject();
				
					JSONArray rows_c_JSONArray = new JSONArray();//check end
					
						JSONObject col11 = new JSONObject();
								
							col11.put("v", rs.getString("sourceZipcode"));
							col11.put("f", JSONObject.NULL);
						
						JSONObject col12 = new JSONObject();
						
							col12.put("v", rs.getInt("noOfRides"));
							col12.put("f", JSONObject.NULL);
						
					rows_c_JSONArray.put(col11);
					col11 = null;
					rows_c_JSONArray.put(col12);
					col12 = null;
						
					outerObject.put("c", rows_c_JSONArray);
					
				rowJSONArray.put(outerObject);
				outerObject = null;
			}
			jsonObjectForPiechart.put("rows", rowJSONArray);
			
			System.out.println("jsonObjectForPiechart: " + jsonObjectForBarchart);
        
	}
	catch(Exception e)
	{
		System.out.println("jsonObjectForBarchart: "+e);
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
							<label>Number of rides as per Source Location zipcode</label>
							<div id="piechart_3d"></div> <!-- style="width: 900px; height: 500px;" -->
						</div>
					</div>
					<div class="col-sm-6 card">
						<div class="card-body">
						<%
	try
	{
	
		/* JSONArray for 'cols' */
		JSONArray colJSONArray = new JSONArray();
		
			JSONObject col1 = new JSONObject();
				col1.put("id", "");
				col1.put("label", "Ride Rating");
				col1.put("pattern", "");
				col1.put("type", "string");
			
			JSONObject col2 = new JSONObject();
				col2.put("id", "");
				col2.put("label", "Number of rides");
				col2.put("pattern", "");
				col2.put("type", "number");
		
		colJSONArray.put(col1);
		colJSONArray.put(col2);
		
		jsonObjectForLinechart.put("cols", colJSONArray);
		/* JSONArray for 'cols' */
		
		/* JSONArray for 'rows' */
		JSONArray rowJSONArray = new JSONArray();
	
			mySqlCon = MySQLDbConnection.getConnection();
			
			PreparedStatement ps = mySqlCon.prepareStatement("SELECT COUNT(r.rideId) AS noOfRides, DATE_FORMAT(r.rideDate, '%a, %b %d, %Y') AS formattedDate FROM rides r GROUP BY r.rideDate ORDER BY r.rideDate DESC LIMIT 7;");
	        
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				JSONObject outerObject = new JSONObject();
				
					JSONArray rows_c_JSONArray = new JSONArray();//check end
					
						JSONObject col11 = new JSONObject();
								
							col11.put("v", rs.getString("formattedDate"));
							col11.put("f", JSONObject.NULL);
						
						JSONObject col12 = new JSONObject();
						
							col12.put("v", rs.getInt("noOfRides"));
							col12.put("f", JSONObject.NULL);
						
					rows_c_JSONArray.put(col11);
					col11 = null;
					rows_c_JSONArray.put(col12);
					col12 = null;
						
					outerObject.put("c", rows_c_JSONArray);
					
				rowJSONArray.put(outerObject);
				outerObject = null;
			}
			jsonObjectForLinechart.put("rows", rowJSONArray);
			
			System.out.println("jsonObjectForLinechart: " + jsonObjectForBarchart);
        
	}
	catch(Exception e)
	{
		System.out.println("jsonObjectForLinechart: "+e);
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
							<label>Number of Rides on particular date</label>
							<div id="curve_chart"></div> <!-- style="width: 900px; height: 500px" -->
						</div>
					</div>
				</div>
				<div class="row">
					<!-- <div class="col-sm-2"></div> -->
					<div class="col-sm-12 card" style="align-items: center;">
						<div class="card-body">
<%
	try
	{
	
		/* JSONArray for 'cols' */
		JSONArray colJSONArray = new JSONArray();
		
			JSONObject col1 = new JSONObject();
				col1.put("id", "");
				col1.put("label", "Ride Rating");
				col1.put("pattern", "");
				col1.put("type", "string");
			
			JSONObject col2 = new JSONObject();
				col2.put("id", "");
				col2.put("label", "Number of rides");
				col2.put("pattern", "");
				col2.put("type", "number");
		
		colJSONArray.put(col1);
		colJSONArray.put(col2);
		
		jsonObjectForBarchart.put("cols", colJSONArray);
		/* JSONArray for 'cols' */
		
		/* JSONArray for 'rows' */
		JSONArray rowJSONArray = new JSONArray();
	
			mySqlCon = MySQLDbConnection.getConnection();
			
			PreparedStatement ps = mySqlCon.prepareStatement("SELECT COUNT(r.rideId) AS noOfRides, r.rideRating FROM rides r GROUP BY r.rideRating ORDER BY r.rideRating ASC");
	        
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				JSONObject outerObject = new JSONObject();
				
					JSONArray rows_c_JSONArray = new JSONArray();//check end
					
						JSONObject col11 = new JSONObject();
								
							col11.put("v", rs.getString("rideRating"));
							col11.put("f", JSONObject.NULL);
						
						JSONObject col12 = new JSONObject();
						
							col12.put("v", rs.getInt("noOfRides"));
							col12.put("f", JSONObject.NULL);
						
					rows_c_JSONArray.put(col11);
					col11 = null;
					rows_c_JSONArray.put(col12);
					col12 = null;
						
					outerObject.put("c", rows_c_JSONArray);
					
				rowJSONArray.put(outerObject);
				outerObject = null;
			}
			jsonObjectForBarchart.put("rows", rowJSONArray);
			
			System.out.println("jsonObjectForBarchart: " + jsonObjectForBarchart);
        
	}
	catch(Exception e)
	{
		System.out.println("jsonObjectForBarchart: "+e);
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
							<label>Number of rides according to Rating</label>
							<div id="top_x_div"></div> <!-- style="width: 800px; height: 600px;" -->
						</div>
					</div>
				</div>
			<%	
			}
			else if(session.getAttribute("userType").toString().equalsIgnoreCase("Driver")) //Driver, Super Admin
			{
			%>
				<div class="row" style="background:transparent url('../../images/RideSharingApp.jpg') no-repeat center center /cover; height: 420px; opacity: 0.9; color: lightyellow; ">
				</div>
			<%	
			}
			%>
		</div>
		<!-- <div class="card-footer small text-muted">Section Footer</div> -->
	</div>
</div>
<!-- /.container-fluid -->
<script type="text/javascript">
<%-- var kelu = <%= jsonObject %>; --%>
google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(drawChart);
function drawChart() {
/*
  var data = google.visualization.arrayToDataTable([
    ['Zip-code', 'Hours per Day'],
    ['60608',     11],
    ['60616',      2],
    ['60601',  2],
    ['60604', 2],
    ['60607',    7]
  ]);
*/
  var data = new google.visualization.DataTable(<%= jsonObjectForPiechart %>);
  var options = {
    title: 'Number of rides as per Source Locations zipcode ',
    is3D: true,
  };

  var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
  chart.draw(data, options);
}
</script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        /*
    	 var data = google.visualization.arrayToDataTable([
          ['Date', 'Number of rides'],
          ['Wed, November 27, 2019',  1],
          ['Mon, November 25, 2019',  2],
          ['Sat, November 23, 2019',  4],
          ['Fri, November 22, 2019',  4],
          ['Wed, November 20, 2019',  2],
          ['Mon, November 18, 2019',  2],
          ['Sun, November 17, 2019',  4]
        ]);
        */

        var data = new google.visualization.DataTable(<%= jsonObjectForLinechart %>);
        var options = {
          title: 'Number of Rides on particular date',
          curveType: 'function',
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);
      }
    </script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawStuff);

      function drawStuff() {
        /*
        var data = new google.visualization.arrayToDataTable([
          ['Ride Rating', 'Number of Rides'],
          ["0", 5],
          ["1", 5],
          ["2", 5],
          ["3", 5],
          ['4', 5],
          ['5', 3]
        ]);
        */

        var data = new google.visualization.DataTable(<%= jsonObjectForBarchart %>);
        var options = {
          width: 800,
          legend: { position: 'none' },
          chart: {
            title: 'Number of rides according to Rating',
            //subtitle: 'popularity by percentage'
            },
          bar: { groupWidth: "90%" }
        };

        var chart = new google.charts.Bar(document.getElementById('top_x_div'));
        // Convert the Classic options to Material options.
        chart.draw(data, google.charts.Bar.convertOptions(options));
      };
    </script>
	
	<jsp:include page="../../view/common/footer.jsp"></jsp:include>