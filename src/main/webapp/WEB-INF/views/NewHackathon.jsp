<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<!-- [Head] start -->

<head>
  <title>Home | Codeverse6 Admin Template</title>
  <!-- [Meta] -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Mantis is made using Bootstrap 5 design framework. Download the free admin template & use it for your project.">
  <meta name="keywords" content="Mantis, Dashboard UI Kit, Bootstrap 5, Admin Template, Admin Dashboard, CRM, CMS, Bootstrap Admin Template">
  <meta name="author" content="CodedThemes">
  
  <jsp:include page="AdminCSS.jsp"></jsp:include>

</head>
<!-- [Head] end -->
<!-- [Body] Start -->

<body data-pc-preset="preset-1"
      data-pc-direction="ltr"
      data-pc-theme="light">

<!-- Loader -->
<div class="loader-bg">
  <div class="loader-track">
    <div class="loader-fill"></div>
  </div>
</div>

<!-- Sidebar -->
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>

<!-- Header -->
<jsp:include page="AdminHeader.jsp"></jsp:include>

<!-- ===== DYNAMIC CONTENT ===== -->
<div class="pc-container">
  <div class="pc-content">
	<!-- Page Heading -->
	<div class="row mb-4">
		<div class="col-12">
			<h3 class="font-weight-bold text-center">New Hackathon</h3>
		</div>
	</div>
	
	<!-- Center Form -->
	<div class="row justify-content-center">
		<div class="col-md-6 col-lg-5">
	
			<div class="card shadow-sm">
				<div class="card-body">
	
					<div class="d-flex justify-content-between align-items-center mb-3">
						<p class="card-title mb-0">Add New Hackathon</p>
						<a href="listHackathon" class="text-info">View all</a>
					</div>
	
					<form action="saveHackathon" method="post">
	
						<!-- Title -->
						<div class="form-group">
							<label>Hackathon Title</label> <input type="text"
								class="form-control" name="title" required />
						</div>
	
						<!-- Status -->
						<div class="form-group">
							<label>Status</label> <select name="status" required
								class="form-control">
								<option value="">-- Select Status --</option>
								<option value="UPCOMING">Upcoming</option>
								<option value="ONGOING">Ongoing</option>
								<option value="COMPLETED">Completed</option>
							</select>
						</div>
	
						<!-- Event Type -->
						<div class="form-group">
							<label>Event Type</label> <select name="eventType"
								class="form-control" required>
								<option value="">-- Select Event Type --</option>
								<option value="ONLINE">Online</option>
								<option value="OFFLINE">Offline</option>
								<option value="HYBRID">Hybrid</option>
							</select>
						</div>
	
						<!-- Payment -->
						<div class="form-group">
							<label>Payment</label> <select name="payment"
								class="form-control" required>
								<option value="">-- Select Payment Type --</option>
								<option value="FREE">Free</option>
								<option value="PAID">Paid</option>
							</select>
						</div>
	
						<!-- Team Size -->
						<div class="row">
							<div class="form-group">
								<label>Minimum Team Size</label> <input class="form-control"
									type="number" name="minTeamSize" min="1" required />
							</div>
	
							<div class="form-group">
								<label>Maximum Team Size</label> <input class="form-control"
									type="number" name="maxTeamSize" min="1" required />
							</div>
						</div>
	
						<!-- Location -->
						<div class="form-group">
							<label>Location</label> <input type="text"
								class="form-control" name="location" />
						</div>
	
						<!-- User Type -->
						<div class="form-group">
							<label>User Type</label> <select class="form-control"
								name="userTypeId" required>
								<option value="">-- Select User Type --</option>
								<c:forEach var="u" items="${allUserType}">
									<option value="${u.userTypeId}">${u.userType}</option>
								</c:forEach>
							</select>
						</div>
	
						<!-- Registration Dates -->
						<div class="row">
							<div class="form-group">
								<label>Registration Start Date</label> <input
									class="form-control" type="date"
									name="registrationStartDate" required />
							</div>
	
							<div class="form-group">
								<label>Registration End Date</label> <input
									class="form-control" type="date" name="registrationEndDate"
									required />
							</div>
						</div>
	
						<!-- Submit -->
						<div style="text-align: center; margin-top: 20px;">
							<button type="submit" class="btn btn-primary">Save
								Hackathon</button>
						</div>
	
					</form>
	
				</div>
			</div>
	
		</div>
	</div>
	
  </div>
</div>

<!-- Footer -->
  <jsp:include page="AdminFooter.jsp"></jsp:include>

</body>
</html>