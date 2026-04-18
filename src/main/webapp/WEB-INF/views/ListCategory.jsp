
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>Category Management | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="pc-container"><div class="pc-content">

  <div class="page-header">
    <div style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;">
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
      <a href="newCategory" class="btn btn-primary">+ Add Category</a>
    </div>
  </div>

  <div class="card">
    <div class="card-header" style="display:flex;align-items:center;justify-content:space-between;">
      <h5 class="mb-0 fw-semibold">Category List</h5>
      <input type="text" class="form-control" style="width:200px;" placeholder="Search category...">
    </div>
    <div class="card-body" style="padding:0 !important;">
      <table class="table table-hover" style="margin:0;text-align:center;">
        <thead class="table-light"><tr>
          <th style="width:70px;">#</th><th style="text-align:left;">Category Name</th><th style="width:150px;">Status</th><th style="width:200px;">Action</th>
        </tr></thead>
        <tbody>
          <c:if test="${empty categoryList}">
            <tr><td colspan="4" class="py-4 text-muted">No categories found</td></tr>
          </c:if>
          <c:forEach var="cat" items="${categoryList}" varStatus="i">
            <tr>
              <td class="fw-semibold">${i.index + 1}</td>
              <td style="text-align:left;font-weight:700;">${cat.categoryName}</td>
              <td>
                <c:choose>
                  <c:when test="${cat.active}"><span class="badge rounded-pill bg-success">Active</span></c:when>
                  <c:otherwise><span class="badge rounded-pill bg-secondary">Inactive</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <a href="editCategory?categoryId=${cat.categoryId}" class="btn btn-sm btn-outline-warning me-2">Edit</a>
                <a href="deleteCategory?categoryId=${cat.categoryId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this category?')">Delete</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

</div></div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</body></html>
