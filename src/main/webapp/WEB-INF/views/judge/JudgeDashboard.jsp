<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Judge Dashboard | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{
  --bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;
  --border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;
  --text:#e2e8f0;--muted:#64748b;
  --green:#4ade80;--amber:#fbbf24;--red:#f87171;--glow:rgba(124,58,237,.3);
}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
/* ── Nav ── */
.judge-nav{
  position:sticky;top:0;z-index:100;
  background:rgba(10,10,15,.92);backdrop-filter:blur(20px);
  border-bottom:1px solid var(--border);
  padding:0 28px;height:62px;
  display:flex;align-items:center;justify-content:space-between;gap:12px;
}
.nav-brand{display:flex;align-items:center;gap:10px;text-decoration:none;color:var(--text)}
.nav-brand-icon{width:34px;height:34px;background:var(--accent);border-radius:9px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.nav-brand-text{font-weight:800;font-size:15px;font-family:'Space Mono',monospace}
.nav-links{display:flex;align-items:center;gap:6px;flex-wrap:wrap}
.nav-link{color:var(--muted);text-decoration:none;font-size:13px;font-weight:600;padding:8px 14px;border-radius:9px;transition:all .18s}
.nav-link:hover{color:var(--text);background:var(--surface2)}
.nav-link.primary{background:var(--accent);color:#fff;box-shadow:0 2px 10px var(--glow)}
.nav-link.primary:hover{background:#6d28d9}
/* ── Layout ── */
.page{position:relative;z-index:1;max-width:1120px;margin:0 auto;padding:28px 20px 48px}
/* ── Hero ── */
.hero{
  background:linear-gradient(135deg,rgba(124,58,237,.2),rgba(6,182,212,.15));
  border:1px solid var(--border);border-radius:18px;padding:26px 28px;
  display:flex;align-items:flex-start;justify-content:space-between;gap:16px;
  flex-wrap:wrap;margin-bottom:22px;position:relative;overflow:hidden;
}
.hero::before{content:'';position:absolute;right:-60px;top:-60px;width:200px;height:200px;background:radial-gradient(circle,rgba(124,58,237,.15),transparent 70%);pointer-events:none}
.hero-title{font-size:26px;font-weight:800;line-height:1.2;margin-bottom:6px}
.hero-sub{font-size:14px;color:var(--muted);line-height:1.6}
.hero-actions{display:flex;gap:8px;flex-wrap:wrap;margin-top:14px}
.btn{display:inline-flex;align-items:center;gap:6px;padding:9px 16px;border-radius:10px;font-family:'Syne',sans-serif;font-weight:700;font-size:13px;text-decoration:none;border:none;cursor:pointer;transition:all .2s}
.btn-primary{background:var(--accent);color:#fff;box-shadow:0 2px 10px var(--glow)}
.btn-primary:hover{background:#6d28d9;transform:translateY(-1px)}
.btn-ghost{background:rgba(255,255,255,.08);color:var(--text);border:1px solid var(--border)}
.btn-ghost:hover{background:rgba(255,255,255,.12)}
/* ── Stat row ── */
.stat-row{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:22px}
.stat-card{
  background:var(--surface);border:1px solid var(--border);
  border-radius:14px;padding:18px 20px;
  position:relative;overflow:hidden;transition:box-shadow .2s;
}
.stat-card:hover{box-shadow:0 6px 24px rgba(0,0,0,.3)}
.stat-card::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;border-radius:14px 14px 0 0}
.sc1::before{background:var(--accent)}
.sc2::before{background:#0ea5e9}
.sc3::before{background:var(--green)}
.sc4::before{background:var(--amber)}
.stat-label{font-size:11px;font-family:'Space Mono',monospace;letter-spacing:.8px;text-transform:uppercase;color:var(--muted);margin-bottom:8px}
.stat-value{font-size:30px;font-weight:800;color:var(--text);line-height:1}
.stat-note{font-size:12px;color:var(--muted);margin-top:6px}
/* ── Cards ── */
.card{background:var(--surface);border:1px solid var(--border);border-radius:14px;overflow:hidden;margin-bottom:18px}
.card-head{display:flex;align-items:center;justify-content:space-between;padding:14px 18px;border-bottom:1px solid var(--border)}
.card-head-title{font-size:13px;font-weight:800;color:var(--text)}
.card-head-link{font-size:12px;font-weight:700;color:#a78bfa;text-decoration:none;font-family:'Space Mono',monospace}
.card-head-link:hover{color:var(--accent)}
.card-body{padding:16px 18px}
/* ── Table ── */
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse}
th,td{padding:11px 10px;border-bottom:1px solid var(--border);text-align:left;font-size:13px}
th{font-size:10px;font-family:'Space Mono',monospace;letter-spacing:1px;text-transform:uppercase;color:var(--muted);padding-bottom:10px}
td{color:#b8c7d8}
tbody tr:hover td{background:rgba(124,58,237,.04)}
tbody tr:last-child td{border-bottom:none}
/* ── Hackathon grid ── */
.hack-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:12px}
.hack-card{background:var(--surface2);border:1px solid var(--border);border-radius:12px;padding:14px;transition:border-color .2s}
.hack-card:hover{border-color:rgba(124,58,237,.4)}
.hack-title{font-size:16px;font-weight:700;margin-bottom:6px;line-height:1.3}
.hack-meta{font-size:12px;color:var(--muted);margin-bottom:10px}
.badge{display:inline-flex;padding:3px 8px;border-radius:100px;font-family:'Space Mono',monospace;font-size:10px;font-weight:700;letter-spacing:.5px}
.badge-green{background:rgba(74,222,128,.12);color:var(--green);border:1px solid rgba(74,222,128,.25)}
.badge-amber{background:rgba(251,191,36,.1);color:var(--amber);border:1px solid rgba(251,191,36,.25)}
.badge-red{background:rgba(248,113,113,.1);color:var(--red);border:1px solid rgba(248,113,113,.25)}
.badge-blue{background:rgba(6,182,212,.1);color:#67e8f9;border:1px solid rgba(6,182,212,.25)}
.badge-grey{background:var(--surface2);color:var(--muted);border:1px solid var(--border)}
.btn-sm{padding:6px 10px;font-size:12px;border-radius:8px;background:rgba(124,58,237,.15);color:#a78bfa;border:1px solid rgba(124,58,237,.25);text-decoration:none;font-weight:700;display:inline-block;transition:background .2s}
.btn-sm:hover{background:rgba(124,58,237,.25)}
.empty-note{font-size:14px;color:var(--muted);padding:16px 0}
.judge-footer{margin-top:28px;padding-top:16px;border-top:1px solid var(--border);text-align:center;font-size:12px;color:var(--muted);font-family:'Space Mono',monospace}
@media(max-width:900px){.stat-row{grid-template-columns:repeat(2,1fr)}}
@media(max-width:520px){.stat-row{grid-template-columns:1fr}.judge-nav{padding:0 14px}}
</style>
</head>
<body>
<!-- Nav -->
<nav class="judge-nav">
  <a class="nav-brand" href="/judge-dashboard">
    <div class="nav-brand-icon">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
    </div>
    <div class="nav-brand-text">ICH</div>
  </a>
  <div class="nav-links">
    <a href="/judge/submissions" class="nav-link">Submissions</a>
    <a href="judge/profile" class="nav-link">My Profile</a>
    <a href="/judge/change-password" class="nav-link">Change Password</a>
    <a href="/logout" class="nav-link">Logout</a>
  </div>
</nav>

<div class="page">
  <!-- Hero -->
  <div class="hero">
    <div>
      <!-- EL kept: ${sessionScope.user.firstName} -->
      <h1 class="hero-title">Welcome, Judge ${sessionScope.user.firstName} &#128075;</h1>
      <p class="hero-sub">Review hackathon submissions and manage your judging tasks from one place.</p>
      <div class="hero-actions">
        <a class="btn btn-primary" href="/judge/submissions">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
          Review Submissions
        </a>
        <a class="btn btn-ghost" href="judge/profile">My Profile</a>
      </div>
    </div>
  </div>

  <!-- Stats — EL kept: ${totalHackathon} ${upcomingHackathon} ${ongoingHackathon} ${pendingReviewSubmission} -->
  <div class="stat-row">
    <div class="stat-card sc1">
      <div class="stat-label">Total Hackathons</div>
      <div class="stat-value">${totalHackathon}</div>
      <div class="stat-note">Assigned to you</div>
    </div>
    <div class="stat-card sc2">
      <div class="stat-label">Upcoming</div>
      <div class="stat-value">${upcomingHackathon}</div>
      <div class="stat-note">Starting soon</div>
    </div>
    <div class="stat-card sc3">
      <div class="stat-label">Ongoing</div>
      <div class="stat-value">${ongoingHackathon}</div>
      <div class="stat-note">Currently live</div>
    </div>
    <div class="stat-card sc4">
      <div class="stat-label">Pending Reviews</div>
      <div class="stat-value">${pendingReviewSubmission}</div>
      <div class="stat-note">Submissions to review</div>
    </div>
  </div>

  <!-- Ongoing hackathons -->
  <div class="card">
    <div class="card-head">
      <span class="card-head-title">Ongoing Hackathons Assigned To You</span>
    </div>
    <div class="card-body">
      <!-- EL/JSTL kept: ${ongoingHackathonList} -->
      <c:choose>
        <c:when test="${empty ongoingHackathonList}">
          <p class="empty-note">No ongoing hackathons assigned right now.</p>
        </c:when>
        <c:otherwise>
          <div class="hack-grid">
            <c:forEach items="${ongoingHackathonList}" var="h">
              <div class="hack-card">
                <div class="hack-title">${h.title}</div>
                <div class="hack-meta">${h.eventType} &bull; ${h.payment}</div>
                <div class="hack-meta" style="margin-bottom:10px;">${h.registrationStartDate} &mdash; ${h.registrationEndDate}</div>
                <a href="/judge/viewHackathon?hackathonId=${h.hackathonId}" class="btn-sm">View Details &rarr;</a>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- Pending Submissions -->
  <div class="card">
    <div class="card-head">
      <span class="card-head-title">Pending Submissions</span>
      <a href="/judge/submissions" class="card-head-link">View all &rarr;</a>
    </div>
    <div class="card-body">
      <!-- EL/JSTL kept: ${pendingSubmissionList} ${submissionHackathonMap} ${submissionTeamMap} -->
      <c:choose>
        <c:when test="${empty pendingSubmissionList}">
          <p class="empty-note">No pending submissions for your review.</p>
        </c:when>
        <c:otherwise>
          <div class="table-wrap">
            <table>
              <thead><tr><th>#</th><th>Hackathon</th><th>Team</th><th>Submitted</th><th>Status</th><th>Action</th></tr></thead>
              <tbody>
                <c:forEach items="${pendingSubmissionList}" var="s" varStatus="i">
                  <tr>
                    <td>${i.count}</td>
                    <td>${submissionHackathonMap[s.hackathonId].title}</td>
                    <td>${submissionTeamMap[s.teamId].teamName}</td>
                    <td>${s.submitedDate}</td>
                    <td><span class="badge badge-amber">Pending</span></td>
                    <td><a class="btn-sm" href="/judge/submissions/review?submissionId=${s.hackathonSubmissionId}">Review</a></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- Reviewed Submissions -->
  <div class="card">
    <div class="card-head">
      <span class="card-head-title">Reviewed Submissions</span>
    </div>
    <div class="card-body">
      <!-- EL/JSTL kept: ${reviewedSubmissionList} -->
      <c:choose>
        <c:when test="${empty reviewedSubmissionList}">
          <p class="empty-note">No reviewed submissions yet.</p>
        </c:when>
        <c:otherwise>
          <div class="table-wrap">
            <table>
              <thead><tr><th>#</th><th>Hackathon</th><th>Team</th><th>Submitted</th><th>Status</th><th>Action</th></tr></thead>
              <tbody>
                <c:forEach items="${reviewedSubmissionList}" var="s" varStatus="i">
                  <tr>
                    <td>${i.count}</td>
                    <td>${submissionHackathonMap[s.hackathonId].title}</td>
                    <td>${submissionTeamMap[s.teamId].teamName}</td>
                    <td>${s.submitedDate}</td>
                    <td><span class="badge badge-green">Reviewed</span></td>
                    <td><a class="btn-sm" href="/judge/submissions/review?submissionId=${s.hackathonSubmissionId}">Update</a></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div class="judge-footer">ICH &mdash; Interns Coding for Hackathon &bull; Judge Panel</div>
</div>
</body>
</html>
