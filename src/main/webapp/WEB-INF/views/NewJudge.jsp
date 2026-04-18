<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>Invite Judge | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>textarea.form-control{height:auto !important;padding:12px 14px !important}</style>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<div class="container-scroller"><jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">

  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;">
    <h3 style="font-size:22px;font-weight:800;">Invite New Judge</h3>
    <a href="listJudge" class="text-info">View all</a>
  </div>

  <div style="max-width:620px;">
    <div class="card">
      <div class="card-body">
        <form action="saveJudge" method="post">
          <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;">
            <div class="form-group">
              <label>First Name</label>
              <input type="text" name="firstName" class="form-control" required>
            </div>
            <div class="form-group">
              <label>Last Name</label>
              <input type="text" name="lastName" class="form-control" required>
            </div>
            <div class="form-group">
              <label>Email</label>
              <input type="email" name="email" class="form-control" required>
            </div>
            <div class="form-group">
              <label>Contact Number</label>
              <input type="text" name="contactNum" class="form-control">
            </div>
            <div class="form-group">
              <label>Qualification</label>
              <input type="text" name="qualification" class="form-control" placeholder="e.g. M.Tech, PhD">
            </div>
            <div class="form-group">
              <label>Designation</label>
              <input type="text" name="designation" class="form-control" placeholder="e.g. Senior Engineer, Professor">
            </div>
            <div class="form-group" style="grid-column:1/-1;">
              <label>Organization</label>
              <input type="text" name="organization" class="form-control" placeholder="Company or Institute">
            </div>
          </div>
          <div style="display:flex;gap:10px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">Send Invite</button>
          </div>
          <!-- EL kept: ${error} -->
          <c:if test="${not empty error}">
            <div class="text-danger mt-2">${error}</div>
          </c:if>
        </form>
      </div>
    </div>
  </div>

</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body></html>
