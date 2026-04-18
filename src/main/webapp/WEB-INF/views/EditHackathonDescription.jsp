<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<title>Edit Hackathon Description | ICH</title>
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>textarea.form-control{height:auto !important;padding:12px 14px !important;resize:vertical}</style>
</head>
<body>
<div class="container-scroller">
<jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">

  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;">
    <h3 style="font-size:22px;font-weight:800;">Edit Hackathon Description</h3>
  </div>

  <div style="max-width:720px;">
    <div class="card">
      <div class="card-body">
        <form action="updateHackathonDescription" method="post">
          <!-- EL kept: ${description.hackathonDescriptionId} -->
          <input type="hidden" name="hackathonDescriptionId" value="${description.hackathonDescriptionId}">
          <div class="form-group">
            <label>Hackathon</label>
            <select name="hackathonId" class="form-control" required>
              <option value="">-- Select Hackathon --</option>
              <!-- EL kept: ${allHackthon} ${description.hackathonId} -->
              <c:forEach var="h" items="${allHackthon}">
                <option value="${h.hackathonId}" ${description.hackathonId == h.hackathonId ? 'selected' : ''}>${h.title}</option>
              </c:forEach>
            </select>
          </div>
          <div class="form-group">
            <label>Hackathon Details (HTML)</label>
            <textarea name="hackathonDetails" class="form-control" rows="10" required>${description.hackathonDetails}</textarea>
          </div>
          <div style="display:flex;gap:10px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">Update Description</button>
            <a href="listHackathonDescription?hackathonId=${description.hackathonId}" class="btn btn-secondary">Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>

</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body></html>
