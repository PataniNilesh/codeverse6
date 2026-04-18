<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>Manage Hackathon Judges | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<div class="container-scroller"><jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">
  <div class="card">
    <div class="card-header" style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px;">
      <div>
        <p class="card-title" style="margin-bottom:4px;">Manage Judges</p>
        <p class="text-muted mb-0" style="font-size:13px;">Hackathon: <b style="color:#e2e8f0;">${hackathon.title}</b></p>
      </div>
      <a href="listHackathon" class="text-info">Back to Hackathons</a>
    </div>
    <div class="card-body">

      <!-- EL/JSTL kept exactly -->
      <c:if test="${success == 'added'}"><div class="alert alert-success mt-2">Judge assigned successfully.</div></c:if>
      <c:if test="${success == 'removed'}"><div class="alert alert-success mt-2">Judge removed from hackathon.</div></c:if>
      <c:if test="${error == 'alreadyAssigned'}"><div class="alert alert-warning mt-2">Judge already assigned.</div></c:if>
      <c:if test="${error == 'invalidJudge'}"><div class="alert alert-danger mt-2">Invalid judge selection.</div></c:if>

      <form action="saveHackathonJudge" method="post" style="margin-top:16px;">
        <input type="hidden" name="hackathonId" value="${hackathon.hackathonId}">
        <div style="display:flex;gap:10px;flex-wrap:wrap;align-items:flex-end;">
          <div style="flex:1;min-width:200px;">
            <select name="userId" class="form-control" required>
              <option value="">Select judge to assign</option>
              <c:forEach items="${availableJudges}" var="j">
                <option value="${j.userId}">${j.firstName} ${j.lastName} – ${j.email}</option>
              </c:forEach>
            </select>
          </div>
          <button type="submit" class="btn btn-primary">Assign Judge</button>
        </div>
      </form>

      <div class="table-responsive" style="margin-top:20px;">
        <table class="table table-bordered table-striped">
          <thead class="table-dark"><tr><th>#</th><th>Name</th><th>Email</th><th>Contact</th><th>Action</th></tr></thead>
          <tbody>
            <c:if test="${empty assignedJudges}"><tr><td colspan="5">No judges assigned for this hackathon.</td></tr></c:if>
            <c:forEach items="${assignedJudges}" var="a" varStatus="i">
              <tr>
                <td>${i.count}</td>
                <td>${judgeMap[a.userId].firstName} ${judgeMap[a.userId].lastName}</td>
                <td>${judgeMap[a.userId].email}</td>
                <td>${judgeMap[a.userId].contactNum}</td>
                <td>
                  <a class="btn btn-sm btn-danger"
                    href="deleteHackathonJudge?hackathonJudgeId=${a.hackathonJudgeId}&hackathonId=${hackathon.hackathonId}"
                    onclick="return confirm('Remove this judge from hackathon?')">Remove</a>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

    </div>
  </div>
</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body></html>
