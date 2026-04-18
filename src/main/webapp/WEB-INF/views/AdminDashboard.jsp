<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin Dashboard | ICH</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>
.stat-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px}
.stat-card{
  background:#fff;border:1px solid #e4e8f2;border-radius:14px;
  padding:20px;position:relative;overflow:hidden;
  transition:box-shadow .2s,transform .2s;
}
.stat-card:hover{box-shadow:0 6px 24px rgba(28,35,64,.1);transform:translateY(-2px)}
.stat-card::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;border-radius:14px 14px 0 0}
.stat-card.c1::before{background:#4f46e5}
.stat-card.c2::before{background:#0ea5e9}
.stat-card.c3::before{background:#16a34a}
.stat-card.c4::before{background:#f59e0b}
.stat-icon{
  width:42px;height:42px;border-radius:10px;
  display:flex;align-items:center;justify-content:center;
  margin-bottom:14px;flex-shrink:0;
}
.si1{background:#eef2ff;color:#4f46e5}
.si2{background:#f0f9ff;color:#0369a1}
.si3{background:#f0fdf4;color:#16a34a}
.si4{background:#fffbeb;color:#b45309}
.stat-label{font-size:11px;font-family:'Space Mono',monospace;letter-spacing:.8px;text-transform:uppercase;color:#8a94b0;margin-bottom:6px}
.stat-value{font-size:28px;font-weight:800;color:#1c2340;line-height:1;font-family:'Syne',sans-serif}
.stat-note{font-size:12px;color:#8a94b0;margin-top:6px}
.chart-card{background:#fff;border:1px solid #e4e8f2;border-radius:14px;padding:20px;margin-bottom:20px}
.chart-card-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;flex-wrap:wrap;gap:8px}
.chart-card-title{font-size:15px;font-weight:800;color:#1c2340}
.chart-card-sub{font-size:13px;color:#8a94b0;margin-top:2px}
.chart-link{font-size:12px;font-weight:700;color:#4f46e5;text-decoration:none;font-family:'Space Mono',monospace}
@media(max-width:900px){.stat-grid{grid-template-columns:repeat(2,1fr)}}
@media(max-width:480px){.stat-grid{grid-template-columns:1fr}}
</style>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<jsp:include page="AdminHeader.jsp"></jsp:include>

<div class="pc-container">
  <div class="pc-content">

    <!-- Welcome -->
    <div style="margin-bottom:24px;">
      <h3 style="font-size:22px;font-weight:800;color:#1c2340;">
        Welcome back, ${sessionScope.user.firstName} &#128075;
      </h3>
      <p style="color:#8a94b0;font-size:14px;margin-top:4px;">Here&#8217;s your platform overview for today.</p>
    </div>

    <!-- Stat cards — EL kept: ${totalHackathon} ${totalUpcoming} ${totalCompleted} ${totalParticipant} -->
    <div class="stat-grid">
      <div class="stat-card c1">
        <div class="stat-icon si1">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
        </div>
        <div class="stat-label">Total Hackathons</div>
        <div class="stat-value">${totalHackathon}</div>
        <div class="stat-note">All time hackathons</div>
      </div>
      <div class="stat-card c2">
        <div class="stat-icon si2">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        </div>
        <div class="stat-label">Upcoming</div>
        <div class="stat-value">${totalUpcoming}</div>
        <div class="stat-note">Scheduled hackathons</div>
      </div>
      <div class="stat-card c3">
        <div class="stat-icon si3">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
        </div>
        <div class="stat-label">Completed</div>
        <div class="stat-value">${totalCompleted}</div>
        <div class="stat-note">Finished hackathons</div>
      </div>
      <div class="stat-card c4">
        <div class="stat-icon si4">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
        </div>
        <div class="stat-label">Participants</div>
        <div class="stat-value">${totalParticipant}</div>
        <div class="stat-note">Registered users</div>
      </div>
    </div>

   
    <div class="chart-card">
      <div class="chart-card-head">
        <div>
          <div class="chart-card-title">Enrollment Report</div>
          <div class="chart-card-sub">Total registrations in past months</div>
        </div>
        <a href="listuser" class="chart-link">View all &rarr;</a>
      </div>
      <div id="sales-chart-legend" class="chartjs-legend mt-4 mb-2"></div>
      <canvas id="myChart" style="max-height:300px;"></canvas>
    </div>

  </div>
</div>

<jsp:include page="AdminFooter.jsp"></jsp:include>

 
<script>

// ✅ Labels (months)
const labels = [
<c:forEach var="m" items="${months}" varStatus="loop">
    "${m}"<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

// ✅ Data (counts)
const dataValues = [
<c:forEach var="c" items="${counts}" varStatus="loop">
    ${c}<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

// ✅ Chart
new Chart(document.getElementById('myChart'), {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: 'User Registrations',
            data: dataValues,
            backgroundColor: 'rgba(79,70,229,0.2)',
            borderColor: '#4f46e5',
            borderWidth: 2,
            borderRadius: 5
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { display: true }
        },
        scales: {
            x: {
                ticks: { color: '#8a94b0' }
            },
            y: {
                ticks: { color: '#8a94b0' }
            }
        }
    }
});

</script>

</body>
</html>
