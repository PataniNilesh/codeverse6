<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>New Hackathon Description | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>textarea.form-control{height:auto !important;padding:12px 14px !important;resize:vertical}</style>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<div class="container-scroller"><jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">

  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;">
    <h3 style="font-size:22px;font-weight:800;">New Hackathon Description</h3>
    <a href="listHackathonDescription" class="text-info">View all</a>
  </div>

  <div style="max-width:720px;">
    <div class="card">
      <div class="card-body">
        <form action="saveHackathonDescription" method="post">
          <div class="form-group">
            <label>Hackathon</label>
            <select name="hackathonId" class="form-control" required>
              <option value="">-- Select Hackathon --</option>
              <!-- EL kept: ${allHackthon} ${hackathonId} -->
              <c:forEach var="h" items="${allHackthon}">
                <option value="${h.hackathonId}" ${hackathonId == h.hackathonId ? 'selected' : ''}>${h.title}</option>
              </c:forEach>
            </select>
          </div>
          <div class="form-group">
            <label>Hackathon Details (HTML)</label>
            <textarea name="hackathonDetails" class="form-control" rows="10" required></textarea>
          </div>
          <div style="display:flex;gap:10px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">Save Description</button>
            <a href="listHackathonDescription" class="btn btn-secondary">Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>

</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body></html>
