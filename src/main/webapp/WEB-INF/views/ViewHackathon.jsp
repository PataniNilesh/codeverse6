<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>View Hackathon | ICH Admin</title>
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>
.judge-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:12px;margin-top:10px}
.judge-card{border:1px solid var(--border);border-radius:10px;padding:12px;display:flex;align-items:center;gap:10px;background:var(--surface2);transition:border-color .18s}
.judge-card:hover{border-color:rgba(79,70,229,.35)}
.judge-avatar{width:44px;height:44px;border-radius:10px;object-fit:cover;border:2px solid var(--border);flex-shrink:0}
.judge-name{font-weight:700;font-size:14px}
.judge-email,.judge-meta{font-size:12px;color:var(--muted);margin-top:2px}
.info-row{display:flex;align-items:flex-start;padding:10px 0;border-bottom:1px solid var(--border);gap:14px}
.info-row:last-child{border-bottom:none}
.info-key{font-size:12px;font-weight:700;color:var(--muted);width:160px;flex-shrink:0;font-family:'Space Mono',monospace;text-transform:uppercase;letter-spacing:.3px;padding-top:1px}
.info-val{font-size:14px;color:var(--text2);font-weight:600;flex:1}
</style>
</head>
<body>
<div class="container-scroller">
<jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">

  <div class="card">
    <div class="card-header" style="position:relative;overflow:hidden;">
      <div style="position:absolute;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,#4f46e5,#0ea5e9)"></div>
      <h4 class="mb-0">Hackathon Details</h4>
    </div>
    <div class="card-body">

      <!-- All EL kept exactly -->
      <div style="margin-bottom:20px">
        <div class="info-row"><span class="info-key">Hackathon ID</span><span class="info-val">${hackathon.hackathonId}</span></div>
        <div class="info-row"><span class="info-key">Title</span><span class="info-val">${hackathon.title}</span></div>
        <div class="info-row"><span class="info-key">Status</span><span class="info-val">${hackathon.status}</span></div>
        <div class="info-row"><span class="info-key">Description</span><span class="info-val">${hackathon.description}</span></div>
        <div class="info-row"><span class="info-key">Event Type</span><span class="info-val">${hackathon.eventType}</span></div>
        <div class="info-row"><span class="info-key">Payment</span><span class="info-val">${hackathon.payment}</span></div>
        <div class="info-row"><span class="info-key">Team Size</span><span class="info-val">${hackathon.minTeamSize} &ndash; ${hackathon.maxTeamSize}</span></div>
        <div class="info-row"><span class="info-key">Location</span><span class="info-val">${hackathon.location}</span></div>
        <div class="info-row"><span class="info-key">User Type ID</span><span class="info-val">${hackathon.userTypeId}</span></div>
        <div class="info-row"><span class="info-key">Reg. Start</span><span class="info-val">${hackathon.registrationStartDate}</span></div>
        <div class="info-row"><span class="info-key">Reg. End</span><span class="info-val">${hackathon.registrationEndDate}</span></div>
        <div class="info-row"><span class="info-key">Hackathon Start</span><span class="info-val">${hackathon.hackathonStartDate}</span></div>
        <div class="info-row"><span class="info-key">Hackathon End</span><span class="info-val">${hackathon.hackathonEndDate}</span></div>
        <div class="info-row"><span class="info-key">Submission Deadline</span><span class="info-val">${hackathon.submissionDeadline}</span></div>
        <div class="info-row"><span class="info-key">Banner Image URL</span><span class="info-val" style="word-break:break-all">${hackathon.bannerImageUrl}</span></div>
        <div class="info-row"><span class="info-key">Contact Email</span><span class="info-val">${hackathon.contactEmail}</span></div>
        <div class="info-row"><span class="info-key">Rules URL</span><span class="info-val" style="word-break:break-all">${hackathon.rulesUrl}</span></div>
        <div class="info-row">
          <span class="info-key">Leaderboard</span>
          <span class="info-val">
            <c:choose>
              <c:when test="${hackathon.leaderboardPublished}"><span class="badge bg-success">Published</span></c:when>
              <c:otherwise><span class="badge bg-secondary">Draft</span></c:otherwise>
            </c:choose>
          </span>
        </div>
      </div>

      <hr/>
      <h5>Hackathon Details (HTML)</h5>
      <div class="html-box" style="margin-top:10px">
        <c:choose>
          <c:when test="${not empty hackathonDescription}">
            <c:out value="${hackathonDescription.hackathonDetails}" escapeXml="false"/>
          </c:when>
          <c:otherwise><span class="text-muted">No detailed description added.</span></c:otherwise>
        </c:choose>
      </div>

      <hr/>
      <h5>Assigned Judges</h5>
      <c:choose>
        <c:when test="${empty judgeUsers}">
          <p class="text-muted" style="margin-top:8px">No judges assigned.</p>
        </c:when>
        <c:otherwise>
          <div class="judge-grid">
            <c:forEach items="${judgeUsers}" var="j">
              <div class="judge-card">
                <c:choose>
                  <c:when test="${not empty j.profilePicUrl}"><img src="${j.profilePicUrl}" class="judge-avatar" alt="judge"></c:when>
                  <c:otherwise><img src="assets/images/faces/dummy.jpg" class="judge-avatar" alt="judge"></c:otherwise>
                </c:choose>
                <div>
                  <div class="judge-name">${j.firstName} ${j.lastName}</div>
                  <div class="judge-email">${j.email}</div>
                  <c:if test="${not empty j.designation}"><div class="judge-meta">${j.designation}</div></c:if>
                  <c:if test="${not empty j.qualification}"><div class="judge-meta">${j.qualification}</div></c:if>
                  <c:if test="${not empty j.organization}"><div class="judge-meta">${j.organization}</div></c:if>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>

      <hr/>
      <h5>Prize Details</h5>
      <c:choose>
        <c:when test="${empty prizeList}">
          <p class="text-muted" style="margin-top:8px">No prize details added.</p>
        </c:when>
        <c:otherwise>
          <div class="table-responsive" style="margin-top:10px">
            <table class="table table-bordered">
              <thead class="table-light"><tr><th>#</th><th>Prize Title</th><th>Prize Description</th></tr></thead>
              <tbody>
                <c:forEach var="p" items="${prizeList}" varStatus="i">
                  <tr><td>${i.count}</td><td>${p.prizeTitle}</td><td>${p.prizeDescription}</td></tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
    <div class="card-footer text-end">
      <a href="listHackathon" class="btn btn-secondary">Back</a>
      <a href="editHackathon?hackathonId=${hackathon.hackathonId}" class="btn btn-warning">Edit</a>
    </div>
  </div>

</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body>
</html>
