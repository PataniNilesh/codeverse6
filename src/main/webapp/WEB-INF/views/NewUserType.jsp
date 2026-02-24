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
		<div class="col-12 grid-margin">
			<h3 class="font-weight-bold text-center">New User Type</h3>
		</div>
	</div>

	<!-- Center Form -->
	<div class="row justify-content-center">
		<div class="col-md-6 col-lg-5">

			<div class="card shadow-sm">
				<div class="card-body">

					<div class="d-flex justify-content-between align-items-center mb-3">
						<p class="card-title mb-0">Add New User Type</p>
						<a href="listuser" class="text-info">View all</a>
					</div>

					<form action="saveUserType" method="post">

						<!-- Category Name -->
						<div class="mb-3">
							<label class="form-label">User Type</label>
							<input type="text"
								name="userType"
								class="form-control"
								placeholder="Enter User Type"
								required>
						</div>

						<!-- Buttons -->
						<div class="text-center">
							<button type="submit" class="btn btn-primary me-2">
								Save User Type
							</button>

							<a href="admin-dashboard" class="btn btn-secondary">
								Cancel
							</a>
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