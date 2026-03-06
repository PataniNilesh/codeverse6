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
	            <h4 class="mb-0">User Management</h4>
	        </div>
	
	        <div class="col-md-6 text-end">
	            <a href="newUser" class="btn btn-primary btn-sm">
	                + Add User
	            </a>
	        </div>
	    </div>
	</div>
	
	
	<!-- User List Card -->
	<div class="card shadow-sm">
	
	    <div class="card-header bg-dark text-white">
	        <h5 class="mb-0">User List</h5>
	    </div>
	
	    <div class="card-body table-responsive">
	
	        <table class="table table-bordered table-hover align-middle text-center">
	
	            <thead class="table-secondary">
	                <tr>
	                    <th>#</th>
	                    <th>First Name</th>
	                    <th>Last Name</th>
	                    <th>Email</th>
	                    <th>Role</th>
	                    <th>Gender</th>
	                    <th>Birth Year</th>
	                    <th>Contact</th>
	                    <th>Profile Pic</th>
	                    <th>Status</th>
	                    <th width="200">Action</th>
	                </tr>
	            </thead>
	
	            <tbody>
	
	                <c:if test="${empty userList}">
	                    <tr>
	                        <td colspan="11" class="text-muted">
	                            No users found
	                        </td>
	                    </tr>
	                </c:if>
	
	                <c:forEach var="u" items="${userList}">
	                    <tr>
	
	                        <td>${u.userId}</td>
	                        <td>${u.firstName}</td>
	                        <td>${u.lastName}</td>
	                        <td>${u.email}</td>
	
	                        <td>
	                            <span class="badge bg-info text-dark">
	                                ${u.role}
	                            </span>
	                        </td>
	
	                        <td>${u.gender}</td>
	                        <td>${u.birthYear}</td>
	                        <td>${u.contactNum}</td>
	
	                        <td>
	                            <img src="${u.profilePicUrl}"
	                                 width="40"
	                                 height="40"
	                                 class="rounded-circle border">
	                        </td>
	
	                        <td>
	                            <c:choose>
	                                <c:when test="${u.active}">
	                                    <span class="badge bg-success">
	                                        Active
	                                    </span>
	                                </c:when>
	                                <c:otherwise>
	                                    <span class="badge bg-danger">
	                                        Inactive
	                                    </span>
	                                </c:otherwise>
	                            </c:choose>
	                        </td>
	
	                        <td>
	
	                            <a href="viewuser?userId=${u.userId}"
	                               class="btn btn-sm btn-secondary">
	                               View
	                            </a>
	
	                            <a href="editUser?userId=${u.userId}"
	                               class="btn btn-sm btn-warning">
	                               Edit
	                            </a>
	
	                            <a href="deleteUser?userId=${u.userId}"
	                               class="btn btn-sm btn-danger"
	                               onclick="return confirm('Are you sure?')">
	                               Delete
	                            </a>
	
	                        </td>
	
	                    </tr>
	                </c:forEach>
	
	            </tbody>
	
	        </table>
	
	    </div>
	</div>
 
	
  </div>
</div>

<!-- Footer -->
  <jsp:include page="AdminFooter.jsp"></jsp:include>

</body>
</html>