<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>List Hackathon | ICH Admin</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>
.hackathon-actions{display:flex;flex-wrap:wrap;gap:5px;min-width:300px}
.hackathon-actions .btn{padding:5px 9px !important;font-size:11px !important}
.badge.UPCOMING{background:#ede9fe !important;color:#6d28d9 !important;border:1px solid #c4b5fd !important}
.badge.ONGOING{background:#f0fdf4 !important;color:#16a34a !important;border:1px solid #86efac !important}
.badge.COMPLETED{background:#f1f5f9 !important;color:#64748b !important;border:1px solid #cbd5e1 !important}
.badge.FREE{background:#f0fdf4 !important;color:#16a34a !important;border:1px solid #86efac !important}
.badge.PAID{background:#fef2f2 !important;color:#b91c1c !important;border:1px solid #fca5a5 !important}
.badge-published{background:#f0fdf4 !important;color:#16a34a !important;border:1px solid #86efac !important}
.badge-draft{background:#f8fafc !important;color:#94a3b8 !important;border:1px solid #e2e8f0 !important}
@media(max-width:991.98px){.hide-md{display:none}}
@media(max-width:767.98px){.hide-sm{display:none}.hackathon-actions{min-width:180px}}
</style>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<div class="container-scroller">
<jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">

  <div class="row">
    <div class="col-md-12 grid-margin">
      <div class="row">
        <div class="col-12 col-xl-8 mb-4 mb-xl-0">
          <h3 class="font-weight-bold">List Hackathon</h3>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-body">
          <div class="d-flex justify-content-between" style="display:flex;align-items:center;justify-content:space-between;margin-bottom:14px">
            <p class="card-title">All Hackathons</p>
            <a href="newHackathon" class="text-info">New</a>
          </div>

          <!-- EL kept: ${success} ${error} -->
          <c:if test="${success == 'leaderboardPublished'}">
            <div class="alert alert-success">Leaderboard published successfully.</div>
          </c:if>
          <c:if test="${success == 'leaderboardUnpublished'}">
            <div class="alert alert-info">Leaderboard unpublished successfully.</div>
          </c:if>
          <c:if test="${error == 'leaderboardNeedsComplete'}">
            <div class="alert alert-danger">Complete the hackathon first, then publish leaderboard.</div>
          </c:if>

          <div class="table-responsive">
            <table class="table table-bordered table-hover" id="myTable">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Title</th>
                  <th>Status</th>
                  <th class="hide-md">Event Type</th>
                  <th class="hide-sm">Payment</th>
                  <th>Team Size</th>
                  <th class="hide-md">Location</th>
                  <th class="hide-sm">Registration Period</th>
                  <th>Leaderboard</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <!-- EL/JSTL kept: ${allHackthon} -->
                <c:choose>
                  <c:when test="${empty allHackathon}">
                    <tr><td colspan="10">No hackathons found</td></tr>
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="h" items="${allHackathon}" varStatus="i">
                      <tr>
                        <td>${i.count}</td>
                        <td style="font-weight:700">${h.title}</td>
                        <td><span class="badge ${h.status}">${h.status}</span></td>
                        <td class="hide-md">${h.eventType}</td>
                        <td class="hide-sm"><span class="badge ${h.payment}">${h.payment}</span></td>
                        <td>${h.minTeamSize}&ndash;${h.maxTeamSize}</td>
                        <td class="hide-md">${h.location}</td>
                        <td class="hide-sm" style="font-size:12px">${h.registrationStartDate} to ${h.registrationEndDate}</td>
                        <td>
                          <c:choose>
                            <c:when test="${h.leaderboardPublished}">
                              <span class="badge badge-published">Published</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge badge-draft">Draft</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <div class="hackathon-actions">
                            <a href="listHackathonDescription?hackathonId=${h.hackathonId}" class="btn btn-sm btn-info">Description</a>
                            <a href="listHackathonPrize?hackathonId=${h.hackathonId}" class="btn btn-sm btn-primary">Prizes</a>
                            <a href="manageHackathonJudge?hackathonId=${h.hackathonId}" class="btn btn-sm btn-secondary">Judges</a>
                            <c:if test="${h.status == 'COMPLETED' || h.status == 'COMPLETE'}">
                              <c:choose>
                                <c:when test="${h.leaderboardPublished}">
                                  <a href="toggleLeaderboardPublish?hackathonId=${h.hackathonId}" class="btn btn-sm btn-warning">Unpublish Board</a>
                                </c:when>
                                <c:otherwise>
                                  <a href="toggleLeaderboardPublish?hackathonId=${h.hackathonId}" class="btn btn-sm btn-success">Publish Board</a>
                                </c:otherwise>
                              </c:choose>
                            </c:if>
                            <a href="viewHackathon?hackathonId=${h.hackathonId}" class="btn btn-sm btn-info">View</a>
                            <a href="editHackathon?hackathonId=${h.hackathonId}" class="btn btn-sm btn-warning">Edit</a>
                            <a href="deleteHackathon?hackathonId=${h.hackathonId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this hackathon?')">Delete</a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>

        </div>
      </div>
    </div>
  </div>

</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body>
</html>
