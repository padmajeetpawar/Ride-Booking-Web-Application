	<div id="wrapper">
		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">
			<li class="nav-item active">
				<a class="nav-link" href="../../view/dashboard/dashboard.jsp">
					<i class="fa fa-dashboard"></i>
					<span> Dashboard</span>
				</a>
			</li>
			<!--
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fa fa-fw fa-folder"></i>
					<span>Pages</span>
				</a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<h6 class="dropdown-header">Login Screens:</h6>
					<a class="dropdown-item" href="login.html">Login</a>
					<a class="dropdown-item" href="register.html">Register</a>
					<a class="dropdown-item" href="forgot-password.html">Forgot Password</a>
					<div class="dropdown-divider"></div>
					<h6 class="dropdown-header">Other Pages:</h6>
					<a class="dropdown-item" href="404.html">404 Page</a>
					<a class="dropdown-item" href="blank.html">Blank Page</a>
				</div>
			</li>
			 -->
			<%
			if(session.getAttribute("userType").equals("Super Admin"))
			{
			%>
			<li class="nav-item active">
			<a class="nav-link" href="../../view/rides/bookRide.jsp">
				<i class="fa fa-car"></i>
				<span> Book Ride</span>
			</a>
			</li>
			<li class="nav-item active">
				<a class="nav-link" href="../../view/rides/customerRideHistory.jsp">
					<i class="fa fa-car"></i>
					<span> My Rides</span>
				</a>
			</li>
			<li class="nav-item active">
			<a class="nav-link" href="../../view/rides/allRidesHistory.jsp">
				<i class="fa fa-car"></i>
				<span> All Rides History</span>
			</a>
			</li>
			<li class="nav-item active">
			<a class="nav-link" href="index.html">
				<i class="fa fa-car"></i>
				<span> My Reviews</span>
			</a>
			</li>
			<li class="nav-item active">
			<a class="nav-link" href="index.html">
				<i class="fa fa-car"></i>
				<span> Reports</span>
			</a>
			</li>
			<li class="nav-item active">
			<a class="nav-link" href="index.html">
				<i class="fa fa-car"></i>
				<span> Driver Reviews</span>
			</a>
			</li>
			<%
			}
			else if(session.getAttribute("userType").equals("Driver"))
			{
			%>
			<li class="nav-item active">
			<a class="nav-link" href="../../view/rides/driverRidesHistory.jsp">
				<i class="fa fa-car"></i>
				<span> My Rides</span>
			</a>
			</li>
			<li class="nav-item active">
			<a class="nav-link" href="../../view/rides/upcomingDriverRide.jsp">
				<i class="fa fa-car"></i>
				<span> Upcoming Rides</span>
			</a>
			</li>
			<li class="nav-item active">
			<a class="nav-link" href="index.html">
				<i class="fa fa-car"></i>
				<span> My Reviews</span>
			</a>
			</li>
			<%
			}
			else if(session.getAttribute("userType").equals("Customer"))
			{
			%>
			<li class="nav-item active">
				<a class="nav-link" href="../../view/rides/bookRide.jsp">
					<i class="fa fa-car"></i>
					<span> Book Ride</span>
				</a>
			</li>
			<li class="nav-item active">
				<a class="nav-link" href="../../view/rides/customerRideHistory.jsp">
					<i class="fa fa-car"></i>
					<span> My Rides</span>
				</a>
			</li>
			<%	
			}
			%>
		</ul>
		<!-- Sidebar -->
		
		<div id="content-wrapper">