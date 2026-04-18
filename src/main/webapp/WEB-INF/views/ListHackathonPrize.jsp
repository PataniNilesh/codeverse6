
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>List Hackathon Prize | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<div class="container-scroller"><jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">
  <h3 class="font-weight-bold mb-3">List Hackathon Prize</h3>
  <div class="card">
    <div class="card-header" style="display:flex;align-items:center;justify-content:space-between;">
      <p class="card-title">All Prizes</p>
      <c:url var="newPrizeUrl" value="newHackathonPrize">
        <c:if test="${hackathonId != null}"><c:param name="hackathonId" value="${hackathonId}" /></c:if>
      </c:url>
      <a href="${newPrizeUrl}" class="text-info">New</a>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered table-striped">
          <thead class="table-dark"><tr><th>#</th><th>Hackathon ID</th><th>Prize Title</th><th>Prize Description</th><th>Action</th></tr></thead>
          <tbody>
            <c:if test="${empty prizeList}"><tr><td colspan="5" class="text-center text-muted">No prizes found</td></tr></c:if>
            <c:forEach var="p" items="${prizeList}" varStatus="i">
              <tr>
                <td>${i.index + 1}</td><td>${p.hackathonId}</td><td>${p.prizeTitle}</td>
                <td style="max-width:450px;white-space:normal;">${p.prizeDescription}</td>
                <td>
                  <a href="editHackathonPrize?hackathonPrizeId=${p.hackathonPrizeId}" class="btn btn-sm btn-warning">Edit</a>
                  <a href="deleteHackathonPrize?hackathonPrizeId=${p.hackathonPrizeId}&hackathonId=${p.hackathonId}" class="btn btn-sm btn-danger" onclick="return confirm('Delete this prize?')">Delete</a>
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
