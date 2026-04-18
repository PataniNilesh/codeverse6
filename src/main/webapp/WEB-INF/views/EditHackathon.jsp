
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>Edit Hackathon | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>
textarea.form-control{height:auto !important;padding:12px 14px !important;resize:vertical}
.form-row-2{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.section-hr{border-color:var(--border, #e4e8f2);margin:20px 0}
</style>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<div class="container-scroller"><jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="container-fluid page-body-wrapper">
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<div class="main-panel"><div class="content-wrapper">

  <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;">
    <h3 style="font-size:22px;font-weight:800;">Edit Hackathon</h3>
    <a href="listHackathon" class="text-info">View all</a>
  </div>

  <div style="max-width:760px;">
    <div class="card">
      <div class="card-body">
        <form action="updateHackathon" method="post">

          <!-- EL kept exactly -->
          <input type="hidden" name="hackathonId" value="${hackathon.hackathonId}"/>
          <input type="hidden" name="userId" value="${hackathon.userId}"/>
          <input type="hidden" name="leaderboardPublished" value="${hackathon.leaderboardPublished}"/>

          <div class="form-group">
            <label>Hackathon Title</label>
            <input type="text" class="form-control" name="title" value="${hackathon.title}" required>
          </div>
          <div class="form-group">
            <label>Description</label>
            <textarea class="form-control" name="description" rows="4">${hackathon.description}</textarea>
          </div>
          <div class="form-group">
            <label>Hackathon Details (HTML)</label>
            <textarea class="form-control" name="hackathonDetails" rows="6" required>${hackathonDescription.hackathonDetails}</textarea>
          </div>

          <div class="form-row-2">
            <div class="form-group">
              <label>Status</label>
              <select name="status" required class="form-control">
                <option value="UPCOMING" ${hackathon.status == 'UPCOMING' ? 'selected' : ''}>Upcoming</option>
                <option value="ONGOING"  ${hackathon.status == 'ONGOING'  ? 'selected' : ''}>Ongoing</option>
                <option value="COMPLETED"${hackathon.status == 'COMPLETED'? 'selected' : ''}>Completed</option>
              </select>
            </div>
            <div class="form-group">
              <label>Event Type</label>
              <select name="eventType" class="form-control" required>
                <option value="ONLINE"  ${hackathon.eventType == 'ONLINE'  ? 'selected' : ''}>Online</option>
                <option value="OFFLINE" ${hackathon.eventType == 'OFFLINE' ? 'selected' : ''}>Offline</option>
                <option value="HYBRID"  ${hackathon.eventType == 'HYBRID'  ? 'selected' : ''}>Hybrid</option>
              </select>
            </div>
          </div>

          <div class="form-row-2">
            <div class="form-group">
              <label>Payment</label>
              <select name="payment" class="form-control" required>
                <option value="FREE" ${hackathon.payment == 'FREE' ? 'selected' : ''}>Free</option>
                <option value="PAID" ${hackathon.payment == 'PAID' ? 'selected' : ''}>Paid</option>
              </select>
            </div>
            <div class="form-group">
              <label>Location</label>
              <input type="text" class="form-control" name="location" value="${hackathon.location}">
            </div>
          </div>

          <div class="form-row-2">
            <div class="form-group">
              <label>Minimum Team Size</label>
              <input class="form-control" type="number" name="minTeamSize" min="1" value="${hackathon.minTeamSize}" required>
            </div>
            <div class="form-group">
              <label>Maximum Team Size</label>
              <input class="form-control" type="number" name="maxTeamSize" min="1" value="${hackathon.maxTeamSize}" required>
            </div>
          </div>

          <div class="form-group">
            <label>User Type</label>
            <select class="form-control" name="userTypeId" required>
              <c:forEach var="u" items="${allUserType}">
                <option value="${u.userTypeId}" ${hackathon.userTypeId == u.userTypeId ? 'selected' : ''}>${u.userType}</option>
              </c:forEach>
            </select>
          </div>

          <div class="form-row-2">
            <div class="form-group">
              <label>Registration Start Date</label>
              <input class="form-control" type="date" name="registrationStartDate" value="${hackathon.registrationStartDate}" required>
            </div>
            <div class="form-group">
              <label>Registration End Date</label>
              <input class="form-control" type="date" name="registrationEndDate" value="${hackathon.registrationEndDate}" required>
            </div>
          </div>

          <div class="form-row-2">
            <div class="form-group">
              <label>Hackathon Start Date</label>
              <input class="form-control" type="date" name="hackathonStartDate" value="${hackathon.hackathonStartDate}" required>
            </div>
            <div class="form-group">
              <label>Hackathon End Date</label>
              <input class="form-control" type="date" name="hackathonEndDate" value="${hackathon.hackathonEndDate}" required>
            </div>
          </div>

          <div class="form-group">
            <label>Submission Deadline</label>
            <input class="form-control" type="date" name="submissionDeadline" value="${hackathon.submissionDeadline}" required>
          </div>
          <div class="form-group">
            <label>Banner Image URL</label>
            <input type="url" class="form-control" name="bannerImageUrl" value="${hackathon.bannerImageUrl}">
          </div>
          <div class="form-group">
            <label>Contact Email</label>
            <input type="email" class="form-control" name="contactEmail" value="${hackathon.contactEmail}">
          </div>
          <div class="form-group">
            <label>Rules URL</label>
            <input type="url" class="form-control" name="rulesUrl" value="${hackathon.rulesUrl}">
          </div>

          <hr class="section-hr">
          <h5 style="margin-bottom:16px;">Prize Details</h5>

          <input type="hidden" name="prizeId1" value="${prize1.hackathonPrizeId}"/>
          <input type="hidden" name="prizeId2" value="${prize2.hackathonPrizeId}"/>
          <input type="hidden" name="prizeId3" value="${prize3.hackathonPrizeId}"/>

          <div class="form-row-2">
            <div class="form-group">
              <label>Prize 1 Title</label>
              <input type="text" class="form-control" name="prizeTitle1" value="${prize1.prizeTitle}" required>
            </div>
            <div class="form-group">
              <label>Prize 1 Description</label>
              <textarea class="form-control" name="prizeDescription1" rows="2" required>${prize1.prizeDescription}</textarea>
            </div>
          </div>
          <div class="form-row-2">
            <div class="form-group">
              <label>Prize 2 Title (Optional)</label>
              <input type="text" class="form-control" name="prizeTitle2" value="${prize2.prizeTitle}">
            </div>
            <div class="form-group">
              <label>Prize 2 Description (Optional)</label>
              <textarea class="form-control" name="prizeDescription2" rows="2">${prize2.prizeDescription}</textarea>
            </div>
          </div>
          <div class="form-row-2">
            <div class="form-group">
              <label>Prize 3 Title (Optional)</label>
              <input type="text" class="form-control" name="prizeTitle3" value="${prize3.prizeTitle}">
            </div>
            <div class="form-group">
              <label>Prize 3 Description (Optional)</label>
              <textarea class="form-control" name="prizeDescription3" rows="2">${prize3.prizeDescription}</textarea>
            </div>
          </div>

          <div style="display:flex;gap:10px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">Update Hackathon</button>
            <a href="listHackathon" class="btn btn-secondary">Cancel</a>
          </div>

        </form>
      </div>
    </div>
  </div>

</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body></html>
