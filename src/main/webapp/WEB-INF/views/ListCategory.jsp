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
		<!-- ================= PAGE HEADER ================= -->
	<div class="page-header mb-4">
	    <div class="d-flex justify-content-between align-items-center flex-wrap">
	
	        <div>
	            <h4 class="fw-bold mb-1">Category Management</h4>
	            <nav aria-label="breadcrumb">
	                <ol class="breadcrumb small">
	                    <li class="breadcrumb-item">Dashboard</li>
	                    <li class="breadcrumb-item">Category</li>
	                    <li class="breadcrumb-item active">List</li>
	                </ol>
	            </nav>
	        </div>
	
	        <a href="newCategory" class="btn btn-primary shadow-sm">
	            + Add Category
	        </a>
	
	    </div>
	</div>
	
	
	<!-- ================= CATEGORY TABLE ================= -->
	<div class="row">
	    <div class="col-12">
	
	        <div class="card shadow-sm border-0 rounded-3">
	
	            <!-- Card Header -->
	            <div class="card-header bg-white border-bottom d-flex justify-content-between align-items-center">
	
	                <h5 class="mb-0 fw-semibold">Category List</h5>
	
	                <!-- Search -->
	                <input type="text"
	                       class="form-control form-control-sm w-auto"
	                       placeholder="Search category...">
	
	            </div>
	
	
	            <!-- Card Body -->
	            <div class="card-body p-0">
	
	                <div class="table-responsive">
	
	                    <table class="table table-hover align-middle text-center mb-0">
	
	                        <!-- Table Header -->
	                        <thead class="table-light">
	                            <tr>
	                                <th width="70">#</th>
	                                <th class="text-start">Category Name</th>
	                                <th width="150">Status</th>
	                                <th width="200">Action</th>
	                            </tr>
	                        </thead>
	
	
	                        <!-- Table Body -->
	                        <tbody>
	
	                            <!-- Empty Data -->
	                            <c:if test="${empty categoryList}">
	                                <tr>
	                                    <td colspan="4" class="py-4 text-muted">
	                                        No categories found
	                                    </td>
	                                </tr>
	                            </c:if>
	
	
	                            <!-- Category List -->
	                            <c:forEach var="cat" items="${categoryList}" varStatus="i">
	
	                                <tr>
	
	                                    <td class="fw-semibold">
	                                        ${i.index + 1}
	                                    </td>
	
	                                    <td class="text-start fw-semibold">
	                                        ${cat.categoryName}
	                                    </td>
	
	
	                                    <!-- Status -->
	                                    <td>
	                                        <c:choose>
	
	                                            <c:when test="${cat.active}">
	                                                <span class="badge rounded-pill bg-success px-3">
	                                                    Active
	                                                </span>
	                                            </c:when>
	
	                                            <c:otherwise>
	                                                <span class="badge rounded-pill bg-secondary px-3">
	                                                    Inactive
	                                                </span>
	                                            </c:otherwise>
	
	                                        </c:choose>
	                                    </td>
	
	
	                                    <!-- Action Buttons -->
	                                    <td>
	
	                                        <a href="editCategory?id=${cat.categoryId}"
	                                           class="btn btn-sm btn-outline-warning me-2">
	                                           Edit
	                                        </a>
	
	                                        <a href="deleteCategory?id=${cat.categoryId}"
	                                           class="btn btn-sm btn-outline-danger"
	                                           onclick="return confirm('Delete this category?')">
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
	</div>
 
	
  </div>
</div>

<!-- Footer -->
  <jsp:include page="AdminFooter.jsp"></jsp:include>

</body>
</html> 