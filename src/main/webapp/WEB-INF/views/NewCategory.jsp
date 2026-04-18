
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>New Category | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="pc-container"><div class="pc-content">

  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:24px;">
    <h3 style="font-size:22px;font-weight:800;">New Category</h3>
    <a href="listCategory" class="text-info">View all</a>
  </div>

  <div style="max-width:500px;">
    <div class="card">
      <div class="card-body">
        <form action="saveCategory" method="post">
          <div class="form-group">
            <label>Category Name</label>
            <input type="text" name="categoryName" class="form-control" placeholder="Enter category name" required>
          </div>
          <div style="display:flex;gap:10px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">Save Category</button>
            <a href="admin-dashboard" class="btn btn-secondary">Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>

</div></div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</body></html>
