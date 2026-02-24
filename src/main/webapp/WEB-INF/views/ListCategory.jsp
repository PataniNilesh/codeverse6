<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
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

<body class="bg-light">
<!-- [ Pre-loader ] start -->
<div class="loader-bg">
  <div class="loader-track">
    <div class="loader-fill"></div>
  </div>
</div>
<!-- [ Pre-loader ] End -->
<!-- [ Sidebar Menu ] start -->
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<!-- [ Sidebar Menu ] end --> <!-- [ Header Topbar ] start -->
<jsp:include page="AdminHeader.jsp"></jsp:include>

<!-- [ Header ] end -->

<div class="row">
    <div class="col-12 grid-margin">
        <div class="card">            
            <!-- Card Header -->
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Category List</h5>
                <a href="newCategory" class="btn btn-primary btn-sm">
                    + Add Category
                </a>
            </div>
            <!-- Card Body -->
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle text-center">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Category Name</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty categoryList}">
                                <tr>
                                    <td colspan="4" class="text-muted">
                                        No categories found
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="cat" items="${categoryList}" varStatus="i">
                                <tr>
                                    <td>${i.index + 1}</td>
                                    <td class="fw-semibold">
                                        ${cat.categoryName}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${cat.active}">
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
                                        <a href="editCategory?id=${cat.categoryId}"
                                           class="btn btn-warning btn-sm">
                                           Edit
                                        </a>

                                        <a href="deleteCategory?id=${cat.categoryId}"
                                           class="btn btn-danger btn-sm"
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

<!-- [ Footer ] start-->
  <jsp:include page="AdminFooter.jsp"></jsp:include>
  
 <!-- [ Footer ] end-->

  
</body>
</html>
