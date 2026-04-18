
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Submissions | ICH Judge</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--text:#e2e8f0;--muted:#64748b;--green:#4ade80;--amber:#fbbf24}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.judge-nav{position:sticky;top:0;z-index:100;background:rgba(10,10,15,.92);backdrop-filter:blur(20px);border-bottom:1px solid var(--border);padding:0 28px;height:62px;display:flex;align-items:center;justify-content:space-between;gap:12px}
.nav-brand{display:flex;align-items:center;gap:10px;text-decoration:none;color:var(--text)}
.nav-brand-icon{width:32px;height:32px;background:var(--accent);border-radius:9px;display:flex;align-items:center;justify-content:center}
.nav-brand-text{font-weight:800;font-size:14px;font-family:'Space Mono',monospace}
.nav-back{color:var(--muted);text-decoration:none;font-weight:700;font-size:13px}
.nav-back:hover{color:var(--text)}
.page{position:relative;z-index:1;max-width:1050px;margin:0 auto;padding:28px 20px 40px}
.page-top{margin-bottom:20px}
.page-title{font-size:26px;font-weight:800}
.page-sub{font-size:14px;color:var(--muted);margin-top:5px}
.msg-ok{padding:11px 14px;background:rgba(74,222,128,.12);border:1px solid rgba(74,222,128,.3);border-radius:10px;color:var(--green);font-size:14px;margin-bottom:16px}
.card{background:var(--surface);border:1px solid var(--border);border-radius:14px;overflow:hidden}
.card-head{display:flex;align-items:center;justify-content:space-between;padding:14px 18px;border-bottom:1px solid var(--border)}
.card-head h3{font-size:13px;font-weight:800}
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse}
th,td{padding:12px 12px;border-bottom:1px solid var(--border);text-align:left;font-size:13px}
th{font-size:10px;font-family:'Space Mono',monospace;letter-spacing:1px;text-transform:uppercase;color:var(--muted);background:var(--surface2)}
td{color:#b8c7d8}
tbody tr:last-child td{border-bottom:none}
tbody tr:hover td{background:rgba(124,58,237,.04)}
.badge{display:inline-flex;padding:3px 9px;border-radius:100px;font-family:'Space Mono',monospace;font-size:10px;font-weight:700}
.badge-amber{background:rgba(251,191,36,.1);color:var(--amber);border:1px solid rgba(251,191,36,.25)}
.badge-green{background:rgba(74,222,128,.12);color:var(--green);border:1px solid rgba(74,222,128,.25)}
.btn-sm{padding:6px 11px;font-size:12px;border-radius:8px;background:rgba(124,58,237,.15);color:#a78bfa;border:1px solid rgba(124,58,237,.25);text-decoration:none;font-weight:700;display:inline-block;transition:background .2s}
.btn-sm:hover{background:rgba(124,58,237,.25)}
.empty-row td{color:var(--muted) !important;font-style:italic}
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
  <div class="page-top">
    <h1 class="page-title">Hackathon Submissions</h1>
    <p class="page-sub">Review and score all assigned hackathon submissions.</p>
  </div>

  <!-- EL kept: ${param.saved} -->
  <c:if test="${param.saved == 'true'}"><div class="msg-ok">Review score saved successfully.</div></c:if>

  <div class="card">
    <div class="card-head"><h3>All Submissions</h3></div>
    <div class="table-wrap">
      <table>
        <thead>
          <tr><th>#</th><th>Hackathon</th><th>Team</th><th>Submitted Date</th><th>Status</th><th>Action</th></tr>
        </thead>
        <tbody>
          <!-- EL/JSTL kept: ${submissions} ${hackathonMap} ${teamMap} ${reviewedMap} -->
          <c:if test="${empty submissions}">
            <tr class="empty-row"><td colspan="6">No submissions assigned yet.</td></tr>
          </c:if>
          <c:forEach items="${submissions}" var="s" varStatus="i">
            <tr>
              <td>${i.count}</td>
              <td>${hackathonMap[s.hackathonId].title}</td>
              <td>${teamMap[s.teamId].teamName}</td>
              <td>${s.submitedDate}</td>
              <td>
                <c:choose>
                  <c:when test="${reviewedMap[s.hackathonSubmissionId]}"><span class="badge badge-green">Reviewed</span></c:when>
                  <c:otherwise><span class="badge badge-amber">Pending</span></c:otherwise>
                </c:choose>
              </td>
              <td><a class="btn-sm" href="/judge/submissions/review?submissionId=${s.hackathonSubmissionId}">Review</a></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>
