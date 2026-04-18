
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<title>Edit Category | ICH</title>
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>
<body>
<div class="container-scroller">
<jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">

  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;">
    <h3 style="font-size:22px;font-weight:800;">Edit Category</h3>
    <a href="listCategory" class="text-info">View all</a>
  </div>

  <div style="max-width:500px;">
    <div class="card">
      <div class="card-body">
        <form action="updateCategory" method="post">
          <div class="form-group">
            <label>Category Name</label>
            <!-- EL kept: ${category.categoryName} ${category.categoryId} -->
            <input type="text" name="categoryName" value="${category.categoryName}" class="form-control" placeholder="Enter category name" required>
          </div>
          <input type="hidden" name="categoryId" value="${category.categoryId}"/>
          <div style="display:flex;gap:10px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">Update Category</button>
            <a href="listCategory" class="btn btn-secondary">Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>

</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body></html>
