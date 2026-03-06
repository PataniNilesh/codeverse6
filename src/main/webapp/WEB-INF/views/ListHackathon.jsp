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
	<!-- Page Header -->
	<div class="page-header mb-4">
	    <div class="row align-items-center">
	        <div class="col-md-6">
	            <h4 class="mb-0">List Hackathon</h4>
	        </div>
	
	        <div class="col-md-6 text-end">
	            <a href="newHackathon" class="btn btn-primary">
	                + New Hackathon
	            </a>
	        </div>
	    </div>
	</div>
	
	
	<!-- Hackathon Table -->
	<div class="row">
	    <div class="col-12">
	
	        <div class="card">
	
	            <div class="card-header">
	                <h5 class="mb-0">All Hackathons</h5>
	            </div>
	
	            <div class="card-body">
	
	                <div class="table-responsive">
	
	                    <table class="table table-hover align-middle text-center">
	
	                        <thead class="table-light">
	                            <tr>
	                                <th>#</th>
	                                <th>Title</th>
	                                <th>Status</th>
	                                <th>Event Type</th>
	                                <th>Payment</th>
	                                <th>Team Size</th>
	                                <th>Location</th>
	                                <th>Registration Period</th>
	                                <th>Actions</th>
	                            </tr>
	                        </thead>
	
	                        <tbody>
	
	                            <c:choose>
	
	                                <c:when test="${empty allHackathon}">
	                                    <tr>
	                                        <td colspan="9" class="text-muted">
	                                            No hackathons found
	                                        </td>
	                                    </tr>
	                                </c:when>
	
	                                <c:otherwise>
	                                    <c:forEach var="h" items="${allHackathon}" varStatus="i">
	
	                                        <tr>
	                                            <td>${i.hackathodId}</td>
	
	                                            <td class="fw-semibold">
	                                                ${h.title}
	                                            </td>
	
	                                            <td>
	                                                <span class="badge bg-info">
	                                                    ${h.status}
	                                                </span>
	                                            </td>
	
	                                            <td>${h.eventType}</td>
	
	                                            <td>
	                                                <span class="badge bg-secondary">
	                                                    ${h.payment}
	                                                </span>
	                                            </td>
	
	                                            <td>
	                                                ${h.minTeamSize} - ${h.maxTeamSize}
	                                            </td>
	
	                                            <td>${h.location}</td>
	
	                                            <td>
	                                                ${h.registrationStartDate}
	                                                <br>
	                                                to
	                                                <br>
	                                                ${h.registrationEndDate}
	                                            </td>
	
	                                            <td>
	
	                                                <a href="viewHackathon?id=${h.hackathonId}"
	                                                   class="btn btn-sm btn-info">
	                                                   View
	                                                </a>
	
	                                                <a href="editHackathon?id=${h.hackathonId}"
	                                                   class="btn btn-sm btn-warning">
	                                                   Edit
	                                                </a>
	
	                                                <a href="deleteHackathon?hackathonId=${h.hackathonId}"
	                                                   class="btn btn-sm btn-danger"
	                                                   onclick="return confirm('Delete this hackathon?')">
	                                                   Delete
	                                                </a>
	
	                                            </td>
	
	                                        </tr>
	
	                                    </c:forEach>
	                                </c:otherwise>
	
	                            </c:choose>
	
	                        </tbody>
	
	                    </table>
	
	                </div>
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