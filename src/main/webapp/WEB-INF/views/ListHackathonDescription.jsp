
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>List Hackathon Description | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<div class="container-scroller"><jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">
  <h3 class="font-weight-bold mb-3">List Hackathon Description</h3>
  <div class="card">
    <div class="card-header" style="display:flex;align-items:center;justify-content:space-between;">
      <p class="card-title">All Descriptions</p>
      <c:url var="newDescriptionUrl" value="newHackathonDescription">
        <c:if test="${hackathonId != null}"><c:param name="hackathonId" value="${hackathonId}" /></c:if>
      </c:url>
      <a href="${newDescriptionUrl}" class="text-info">New</a>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered table-striped">
          <thead class="table-dark"><tr><th>#</th><th>Hackathon ID</th><th>Hackathon Details</th><th>Action</th></tr></thead>
          <tbody>
            <c:if test="${empty descriptionList}"><tr><td colspan="4" class="text-center text-muted">No descriptions found</td></tr></c:if>
            <c:forEach var="d" items="${descriptionList}" varStatus="i">
              <tr>
                <td>${i.index + 1}</td><td>${d.hackathonId}</td>
                <td style="max-width:450px;white-space:normal;">${d.hackathonDetails}</td>
                <td>
                  <a href="editHackathonDescription?hackathonDescriptionId=${d.hackathonDescriptionId}" class="btn btn-sm btn-warning">Edit</a>
                  <a href="deleteHackathonDescription?hackathonDescriptionId=${d.hackathonDescriptionId}&hackathonId=${d.hackathonId}" class="btn btn-sm btn-danger" onclick="return confirm('Delete this description?')">Delete</a>
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
