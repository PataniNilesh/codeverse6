<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hackathon Details | ICH Judge</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--green:#4ade80;--amber:#fbbf24;--red:#f87171}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.judge-nav{position:sticky;top:0;z-index:100;background:rgba(10,10,15,.92);backdrop-filter:blur(20px);border-bottom:1px solid var(--border);padding:0 28px;height:62px;display:flex;align-items:center;justify-content:space-between;gap:12px}
.nav-brand{display:flex;align-items:center;gap:10px;text-decoration:none;color:var(--text)}
.nav-brand-icon{width:32px;height:32px;background:var(--accent);border-radius:9px;display:flex;align-items:center;justify-content:center}
.nav-brand-text{font-weight:800;font-size:14px;font-family:'Space Mono',monospace}
.nav-back{color:var(--muted);text-decoration:none;font-weight:700;font-size:13px;display:flex;align-items:center;gap:6px}
.nav-back:hover{color:var(--text)}
.page{position:relative;z-index:1;max-width:1050px;margin:0 auto;padding:28px 20px 40px}
.hero-block{background:linear-gradient(135deg,rgba(124,58,237,.2),rgba(6,182,212,.15));border:1px solid var(--border);border-radius:18px;padding:24px;margin-bottom:18px;position:relative;overflow:hidden}
.hero-banner{width:100%;max-height:240px;object-fit:cover;border-radius:12px;border:1px solid var(--border);margin-bottom:16px}
.hero-title{font-size:28px;font-weight:800;margin-bottom:8px;line-height:1.15}
.hero-sub{font-size:14px;color:var(--muted)}
.back-link{display:inline-flex;align-items:center;gap:6px;color:var(--muted);text-decoration:none;font-weight:700;font-size:13px;border:1px solid var(--border);padding:7px 12px;border-radius:9px;background:rgba(255,255,255,.05);margin-bottom:14px;transition:all .18s}
.back-link:hover{color:var(--text);border-color:var(--accent)}
.meta-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:10px;margin-top:14px}
.meta-item{background:var(--surface2);border:1px solid var(--border);border-radius:10px;padding:12px}
.meta-label{font-size:10px;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:var(--muted);margin-bottom:5px}
.meta-val{font-size:14px;font-weight:700;color:var(--text)}
.meta-val a{color:#67e8f9;text-decoration:none}
.card{background:var(--surface);border:1px solid var(--border);border-radius:14px;overflow:hidden;margin-bottom:18px}
.card-head{display:flex;align-items:center;justify-content:space-between;padding:14px 18px;border-bottom:1px solid var(--border)}
.card-head h3{font-size:14px;font-weight:800;color:var(--text)}
.card-body{padding:16px 18px}
.html-box{background:var(--surface2);border:1px solid var(--border);border-radius:10px;padding:14px;color:#c2cfdd;line-height:1.8}
.judge-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:10px}
.judge-card{background:var(--surface2);border:1px solid var(--border);border-radius:12px;padding:12px;display:flex;align-items:center;gap:10px;transition:border-color .2s}
.judge-card:hover{border-color:rgba(124,58,237,.35)}
.j-avatar{width:42px;height:42px;border-radius:10px;object-fit:cover;border:1px solid var(--border);flex-shrink:0}
.j-name{font-size:14px;font-weight:700}
.j-email,.j-meta{font-size:12px;color:var(--muted);margin-top:2px}
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse}
th,td{padding:11px 10px;border-bottom:1px solid var(--border);text-align:left;font-size:13px}
th{font-size:10px;font-family:'Space Mono',monospace;letter-spacing:1px;text-transform:uppercase;color:var(--muted)}
td{color:#b8c7d8}
tbody tr:last-child td{border-bottom:none}
tbody tr:hover td{background:rgba(124,58,237,.04)}
.badge{display:inline-flex;padding:3px 8px;border-radius:100px;font-family:'Space Mono',monospace;font-size:10px;font-weight:700}
.badge-amber{background:rgba(251,191,36,.1);color:var(--amber);border:1px solid rgba(251,191,36,.25)}
.badge-green{background:rgba(74,222,128,.12);color:var(--green);border:1px solid rgba(74,222,128,.25)}
.btn-sm{padding:6px 10px;font-size:12px;border-radius:8px;background:rgba(124,58,237,.15);color:#a78bfa;border:1px solid rgba(124,58,237,.25);text-decoration:none;font-weight:700;display:inline-block;transition:background .2s}
.btn-sm:hover{background:rgba(124,58,237,.25)}
.empty-note{font-size:14px;color:var(--muted);padding:10px 0}
</style>
</head>
<body>
<nav class="judge-nav">
  <a class="nav-brand" href="/judge-dashboard">
    <div class="nav-brand-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg></div>
    <div class="nav-brand-text">ICH Judge</div>
  </a>
  <a href="/judge-dashboard" class="nav-back">&larr; Dashboard</a>
</nav>

<div class="page">
  <a href="/judge-dashboard" class="back-link">&larr; Back to Dashboard</a>

  <!-- Hero -->
  <div class="hero-block">
    <!-- EL kept exactly -->
    <c:if test="${not empty hackathon.bannerImageUrl}">
      <img src="${hackathon.bannerImageUrl}" alt="${hackathon.title}" class="hero-banner">
    </c:if>
    <h1 class="hero-title">${hackathon.title}</h1>
    <p class="hero-sub">Judge view for this assigned hackathon.</p>
    <div class="meta-grid">
      <div class="meta-item"><div class="meta-label">Status</div><div class="meta-val">${hackathon.status}</div></div>
      <div class="meta-item"><div class="meta-label">Event Type</div><div class="meta-val">${hackathon.eventType}</div></div>
      <div class="meta-item"><div class="meta-label">Payment</div><div class="meta-val">${hackathon.payment}</div></div>
      <div class="meta-item"><div class="meta-label">Team Size</div><div class="meta-val">${hackathon.minTeamSize} &ndash; ${hackathon.maxTeamSize}</div></div>
      <div class="meta-item"><div class="meta-label">Location</div><div class="meta-val">${hackathon.location}</div></div>
      <div class="meta-item"><div class="meta-label">Registration</div><div class="meta-val">${hackathon.registrationStartDate} &mdash; ${hackathon.registrationEndDate}</div></div>
      <div class="meta-item"><div class="meta-label">Hackathon Dates</div><div class="meta-val">${hackathon.hackathonStartDate} &mdash; ${hackathon.hackathonEndDate}</div></div>
      <div class="meta-item"><div class="meta-label">Submission Deadline</div><div class="meta-val">${hackathon.submissionDeadline}</div></div>
      <div class="meta-item"><div class="meta-label">Contact</div><div class="meta-val">${hackathon.contactEmail}</div></div>
      <div class="meta-item"><div class="meta-label">Rules</div><div class="meta-val">
        <c:choose>
          <c:when test="${not empty hackathon.rulesUrl}"><a href="${hackathon.rulesUrl}" target="_blank">Open Rules</a></c:when>
          <c:otherwise>Not Provided</c:otherwise>
        </c:choose>
      </div></div>
    </div>
  </div>

  <!-- Overview -->
  <div class="card">
    <div class="card-head"><h3>Overview</h3></div>
    <div class="card-body">
      <p style="color:#a6b6c8;font-size:14px;line-height:1.7;margin-bottom:10px">${hackathon.description}</p>
      <div class="html-box">
        <c:choose>
          <c:when test="${not empty hackathonDescription}">
            <c:out value="${hackathonDescription.hackathonDetails}" escapeXml="false"/>
          </c:when>
          <c:otherwise><span style="color:var(--muted)">No detailed description provided.</span></c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>

  <!-- Assigned Judges -->
  <div class="card">
    <div class="card-head"><h3>Assigned Judges</h3></div>
    <div class="card-body">
      <c:choose>
        <c:when test="${empty judgeUsers}"><p class="empty-note">No judges assigned.</p></c:when>
        <c:otherwise>
          <div class="judge-grid">
            <c:forEach items="${judgeUsers}" var="j">
              <div class="judge-card">
                <c:choose>
                  <c:when test="${not empty j.profilePicUrl}"><img src="${j.profilePicUrl}" class="j-avatar" alt="judge"></c:when>
                  <c:otherwise><img src="/assets/images/faces/dummy.jpg" class="j-avatar" alt="judge"></c:otherwise>
                </c:choose>
                <div>
                  <div class="j-name">${j.firstName} ${j.lastName}</div>
                  <div class="j-email">${j.email}</div>
                  <c:if test="${not empty j.designation}"><div class="j-meta">${j.designation}</div></c:if>
                  <c:if test="${not empty j.organization}"><div class="j-meta">${j.organization}</div></c:if>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- Prize Details -->
  <div class="card">
    <div class="card-head"><h3>Prize Details</h3></div>
    <div class="card-body">
      <c:choose>
        <c:when test="${empty prizeList}"><p class="empty-note">No prize details available.</p></c:when>
        <c:otherwise>
          <div class="table-wrap">
            <table>
              <thead><tr><th>#</th><th>Prize Title</th><th>Description</th></tr></thead>
              <tbody>
                <c:forEach items="${prizeList}" var="p" varStatus="i">
                  <tr><td>${i.count}</td><td>${p.prizeTitle}</td><td>${p.prizeDescription}</td></tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- Pending Submissions -->
  <div class="card">
    <div class="card-head"><h3>Pending Submissions</h3></div>
    <div class="card-body">
      <c:choose>
        <c:when test="${empty pendingSubmissionList}"><p class="empty-note">No pending submissions for this hackathon.</p></c:when>
        <c:otherwise>
          <div class="table-wrap">
            <table>
              <thead><tr><th>#</th><th>Team</th><th>Submitted</th><th>Status</th><th>Action</th></tr></thead>
              <tbody>
                <c:forEach items="${pendingSubmissionList}" var="s" varStatus="i">
                  <tr>
                    <td>${i.count}</td>
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
    <div class="card-head"><h3>Reviewed Submissions</h3></div>
    <div class="card-body">
      <c:choose>
        <c:when test="${empty reviewedSubmissionList}"><p class="empty-note">No reviewed submissions yet.</p></c:when>
        <c:otherwise>
          <div class="table-wrap">
            <table>
              <thead><tr><th>#</th><th>Team</th><th>Submitted</th><th>Status</th><th>Action</th></tr></thead>
              <tbody>
                <c:forEach items="${reviewedSubmissionList}" var="s" varStatus="i">
                  <tr>
                    <td>${i.count}</td>
                    <td>${submissionTeamMap[s.teamId].teamName}</td>
                    <td>${s.submitedDate}</td>
                    <td><span class="badge badge-green">Reviewed</span></td>
                    <td><a class="btn-sm" href="/judge/submissions/review?submissionId=${s.hackathonSubmissionId}">Update Review</a></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
</body>
</html>
