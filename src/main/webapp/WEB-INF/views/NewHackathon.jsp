<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>New Hackathon | ICH Admin</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>
textarea.form-control{height:auto !important;padding:10px 13px !important;resize:vertical !important}
.form-row-2{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.section-divider{border-color:var(--border);margin:20px 0}
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
      <h3 class="font-weight-bold">New Hackathon</h3>
    </div>
  </div>

  <div class="row">
    <div class="col-md-8 grid-margin stretch-card">
      <div class="card">
        <div class="card-body">
          <div class="d-flex justify-content-between" style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px">
            <p class="card-title">Add New Hackathon</p>
            <a href="listHackathon" class="text-info">View all</a>
          </div>

          <form action="saveHackathon" method="post">
            <!-- EL kept: leaderboardPublished hidden -->
            <input type="hidden" name="leaderboardPublished" value="false"/>

            <div class="form-group">
              <label>Hackathon Title</label>
              <input type="text" class="form-control" name="title" required>
            </div>
            <div class="form-group">
              <label>Short Description</label>
              <textarea class="form-control" name="description" rows="3" placeholder="Short summary about hackathon"></textarea>
            </div>
            <div class="form-group">
              <label>Hackathon Details (HTML)</label>
              <textarea class="form-control" name="hackathonDetails" rows="6" placeholder="&lt;p&gt;Full hackathon details...&lt;/p&gt;" required></textarea>
            </div>

            <div class="form-row-2">
              <div class="form-group">
                <label>Status</label>
                <select name="status" required class="form-control">
                  <option value="">-- Select Status --</option>
                  <option value="UPCOMING">Upcoming</option>
                  <option value="ONGOING">Ongoing</option>
                  <option value="COMPLETED">Completed</option>
                </select>
              </div>
              <div class="form-group">
                <label>Event Type</label>
                <select name="eventType" class="form-control" required>
                  <option value="">-- Select Event Type --</option>
                  <option value="ONLINE">Online</option>
                  <option value="OFFLINE">Offline</option>
                  <option value="HYBRID">Hybrid</option>
                </select>
              </div>
            </div>

            <div class="form-row-2">
              <div class="form-group">
                <label>Payment</label>
                <select name="payment" class="form-control" required>
                  <option value="">-- Select Payment Type --</option>
                  <option value="FREE">Free</option>
                  <option value="PAID">Paid</option>
                </select>
              </div>
              <div class="form-group">
                <label>Location</label>
                <input type="text" class="form-control" name="location" placeholder="City / Online">
              </div>
            </div>

            <div class="form-row-2">
              <div class="form-group">
                <label>Minimum Team Size</label>
                <input class="form-control" type="number" name="minTeamSize" min="1" required>
              </div>
              <div class="form-group">
                <label>Maximum Team Size</label>
                <input class="form-control" type="number" name="maxTeamSize" min="1" required>
              </div>
            </div>

            <div class="form-group">
              <label>User Type</label>
              <!-- EL kept: ${allUserType} -->
              <select class="form-control" name="userTypeId" required>
                <option value="">-- Select User Type --</option>
                <c:forEach var="u" items="${allUserType}">
                  <option value="${u.userTypeId}">${u.userType}</option>
                </c:forEach>
              </select>
            </div>

            <div class="form-row-2">
              <div class="form-group">
                <label>Registration Start Date</label>
                <input class="form-control" type="date" name="registrationStartDate" required>
              </div>
              <div class="form-group">
                <label>Registration End Date</label>
                <input class="form-control" type="date" name="registrationEndDate" required>
              </div>
            </div>

            <div class="form-row-2">
              <div class="form-group">
                <label>Hackathon Start Date</label>
                <input class="form-control" type="date" name="hackathonStartDate" required>
              </div>
              <div class="form-group">
                <label>Hackathon End Date</label>
                <input class="form-control" type="date" name="hackathonEndDate" required>
              </div>
            </div>

            <div class="form-group">
              <label>Submission Deadline</label>
              <input class="form-control" type="date" name="submissionDeadline" required>
            </div>
            <div class="form-group">
              <label>Banner Image URL</label>
              <input type="url" class="form-control" name="bannerImageUrl" placeholder="https://example.com/banner.jpg">
            </div>
            <div class="form-group">
              <label>Contact Email</label>
              <input type="email" class="form-control" name="contactEmail" placeholder="organizer@example.com">
            </div>
            <div class="form-group">
              <label>Rules URL</label>
              <input type="url" class="form-control" name="rulesUrl" placeholder="https://example.com/rules">
            </div>

            <hr class="section-divider">
            <h5>Prize Details</h5>

            <div class="form-row-2" style="margin-top:12px">
              <div class="form-group">
                <label>Prize 1 Title</label>
                <input type="text" class="form-control" name="prizeTitle1" placeholder="First Prize" required>
              </div>
              <div class="form-group">
                <label>Prize 1 Description</label>
                <textarea class="form-control" name="prizeDescription1" rows="2" placeholder="Prize 1 details" required></textarea>
              </div>
            </div>
            <div class="form-row-2">
              <div class="form-group">
                <label>Prize 2 Title (Optional)</label>
                <input type="text" class="form-control" name="prizeTitle2" placeholder="Second Prize">
              </div>
              <div class="form-group">
                <label>Prize 2 Description (Optional)</label>
                <textarea class="form-control" name="prizeDescription2" rows="2" placeholder="Prize 2 details"></textarea>
              </div>
            </div>
            <div class="form-row-2">
              <div class="form-group">
                <label>Prize 3 Title (Optional)</label>
                <input type="text" class="form-control" name="prizeTitle3" placeholder="Third Prize">
              </div>
              <div class="form-group">
                <label>Prize 3 Description (Optional)</label>
                <textarea class="form-control" name="prizeDescription3" rows="2" placeholder="Prize 3 details"></textarea>
              </div>
            </div>

            <div style="margin-top:16px">
              <button type="submit" class="btn btn-primary">Save Hackathon</button>
              <a href="listHackathon" class="btn btn-secondary" style="margin-left:8px">Cancel</a>
            </div>

          </form>
        </div>
      </div>
    </div>
  </div>

</div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</div></div></div>
</body>
</html>
