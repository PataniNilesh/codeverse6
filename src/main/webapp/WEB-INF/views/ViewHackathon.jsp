<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>View Hackathon</title>
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>
.label {
	font-weight: 600;
	color: #555;
}

.html-box {
	background: #f8f9fa;
	padding: 12px;
	border-radius: 6px;
	border: 1px solid #e5e7eb;
}

.judge-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
	gap: 12px;
}

.judge-card {
	border: 1px solid #e5e7eb;
	border-radius: 10px;
	padding: 12px;
	display: flex;
	align-items: center;
	gap: 10px;
	background: #fff;
}

.judge-avatar {
	width: 48px;
	height: 48px;
	border-radius: 50%;
	object-fit: cover;
	border: 2px solid #e2e8f0;
}

.judge-name {
	font-weight: 600;
}

.judge-email {
	font-size: 13px;
	color: #64748b;
}

.judge-meta {
	font-size: 12px;
	color: #6b7280;
	margin-top: 2px;
}
</style>
</head>
<body>
	<div class="container-scroller">
		<jsp:include page="AdminHeader.jsp"></jsp:include>
		<div class="container-fluid page-body-wrapper">
			<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="card">
						<div class="card-header bg-dark text-white">
							<h4 class="mb-0">Hackathon Details</h4>
						</div>
						<div class="card-body">
							<table class="table table-borderless">
								<tr><td class="label">Hackathon ID</td><td>${hackathon.hackathonId}</td></tr>
								<tr><td class="label">Title</td><td>${hackathon.title}</td></tr>
								<tr><td class="label">Status</td><td>${hackathon.status}</td></tr>
								<tr><td class="label">Description</td><td>${hackathon.description}</td></tr>
								<tr><td class="label">Event Type</td><td>${hackathon.eventType}</td></tr>
								<tr><td class="label">Payment</td><td>${hackathon.payment}</td></tr>
								<tr><td class="label">Team Size</td><td>${hackathon.minTeamSize} - ${hackathon.maxTeamSize}</td></tr>
								<tr><td class="label">Location</td><td>${hackathon.location}</td></tr>
								<tr><td class="label">User Type ID</td><td>${hackathon.userTypeId}</td></tr>
								<tr><td class="label">Registration Start</td><td>${hackathon.registrationStartDate}</td></tr>
								<tr><td class="label">Registration End</td><td>${hackathon.registrationEndDate}</td></tr>
								<tr><td class="label">Leaderboard</td><td>${hackathon.leaderboardPublished ? 'Published' : 'Draft'}</td></tr>
							</table>
							<hr />
							<h5>Hackathon Details (HTML)</h5>
							<div class="html-box">
								<c:choose>
									<c:when test="${not empty hackathonDescription}">
										<c:out value="${hackathonDescription.hackathonDetails}" escapeXml="false" />
									</c:when>
									<c:otherwise>
										<span class="text-muted">No detailed description added.</span>
									</c:otherwise>
								</c:choose>
							</div>
							<hr />
							<h5>Assigned Judges</h5>
							<c:choose>
								<c:when test="${empty judgeUsers}">
									<p class="text-muted">No judges assigned.</p>
								</c:when>
								<c:otherwise>
									<div class="judge-grid">
										<c:forEach items="${judgeUsers}" var="j">
											<div class="judge-card">
												<c:choose>
													<c:when test="${not empty j.profilePicURL}">
														<img src="${j.profilePicURL}" class="judge-avatar" alt="judge">
													</c:when>
													<c:otherwise>
														<img src="assets/images/faces/dummy.jpg" class="judge-avatar" alt="judge">
													</c:otherwise>
												</c:choose>
												<div>
													<div class="judge-name">${j.firstName} ${j.lastName}</div>
													<div class="judge-email">${j.email}</div>
													<c:if test="${not empty j.designation}">
														<div class="judge-meta">${j.designation}</div>
													</c:if>
													<c:if test="${not empty j.qualification}">
														<div class="judge-meta">${j.qualification}</div>
													</c:if>
													<c:if test="${not empty j.organization}">
														<div class="judge-meta">${j.organization}</div>
													</c:if>
												</div>
											</div>
										</c:forEach>
									</div>
								</c:otherwise>
							</c:choose>
							<hr />
							<h5>Prize Details</h5>
							<c:choose>
								<c:when test="${empty prizeList}">
									<p class="text-muted">No prize details added.</p>
								</c:when>
								<c:otherwise>
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead class="table-light">
												<tr>
													<th>#</th>
													<th>Prize Title</th>
													<th>Prize Description</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="p" items="${prizeList}" varStatus="i">
													<tr>
														<td>${i.count}</td>
														<td>${p.prizeTitle}</td>
														<td>${p.prizeDescription}</td>
													</tr>
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
			</div>
		</div>
	</div>
</body>
</html>