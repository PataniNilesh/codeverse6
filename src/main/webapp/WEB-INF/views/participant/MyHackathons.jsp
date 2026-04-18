<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Hackathons | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--green:#4ade80;--amber:#fbbf24;--glow:rgba(124,58,237,.3)}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.page{position:relative;z-index:1;max-width:1120px;margin:0 auto;padding:24px 20px 40px}
.top{display:flex;justify-content:space-between;align-items:flex-end;gap:14px;flex-wrap:wrap;margin-bottom:20px}
.back{color:var(--muted);text-decoration:none;font-weight:700;font-size:14px}
.back:hover{color:var(--text)}
.page-title{font-size:28px;font-weight:800;margin-top:6px}
.page-sub{font-size:14px;color:var(--muted);margin-top:4px}
.count-chip{display:inline-flex;padding:6px 12px;border-radius:100px;background:var(--surface2);border:1px solid var(--border);font-family:'Space Mono',monospace;font-size:12px;color:var(--muted)}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(320px,1fr));gap:16px}
.card{
  background:var(--surface);border:1px solid var(--border);
  border-radius:16px;padding:18px;
  display:flex;flex-direction:column;gap:12px;
  transition:border-color .2s,box-shadow .2s;position:relative;overflow:hidden;
}
.card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,var(--accent),var(--accent2));opacity:0;transition:opacity .2s}
.card:hover{border-color:rgba(124,58,237,.4);box-shadow:0 8px 30px rgba(0,0,0,.25)}
.card:hover::before{opacity:1}
.card h3{font-size:18px;font-weight:800;line-height:1.3;color:var(--text)}
.meta{display:flex;flex-wrap:wrap;gap:6px}
.chip{font-family:'Space Mono',monospace;font-size:11px;padding:4px 9px;border-radius:100px;background:var(--surface2);border:1px solid var(--border);color:var(--muted)}
.chip.leader{color:#67e8f9;border-color:rgba(6,182,212,.3);background:rgba(6,182,212,.08)}
.chip.member{color:#c4b5fd;border-color:rgba(124,58,237,.3);background:rgba(124,58,237,.08)}
.chip.live{color:var(--green);border-color:rgba(74,222,128,.3);background:rgba(74,222,128,.08)}
.chip.soon{color:var(--amber);border-color:rgba(251,191,36,.3);background:rgba(251,191,36,.08)}
.desc{color:#a6b6c8;font-size:14px;line-height:1.6;flex:1}
.actions{display:flex;gap:8px;margin-top:auto;flex-wrap:wrap}
.btn{
  flex:1;min-width:120px;text-align:center;text-decoration:none;
  padding:10px;border-radius:10px;font-weight:700;font-size:13px;
  transition:all .2s;border:none;cursor:pointer;font-family:'Syne',sans-serif;
}
.btn-primary{background:var(--accent);color:#fff;box-shadow:0 2px 10px rgba(124,58,237,.3)}
.btn-primary:hover{background:#6d28d9;transform:translateY(-1px)}
.btn-secondary{background:var(--surface2);color:#cbd5e1;border:1px solid var(--border)}
.btn-secondary:hover{border-color:var(--accent);color:var(--text)}
.btn-teal{background:#0f766e;color:#fff}
.btn-teal:hover{background:#0d6460}
.btn-blue{background:#1d4ed8;color:#fff}
.btn-blue:hover{background:#1e40af}
.btn-disabled{background:var(--surface2);color:#475569;cursor:not-allowed;opacity:.7;pointer-events:none;border:1px solid var(--border)}
.empty-state{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:48px 24px;text-align:center;color:var(--muted)}
.empty-state p{margin-top:10px;font-size:14px}
.empty-state a{display:inline-block;margin-top:14px;color:#a78bfa;font-weight:700;text-decoration:none}
@media(max-width:520px){.btn{flex:1 1 100%;min-width:0}}
</style>
</head>
<body>
<%@ include file="ParticipantTopNav.jsp"%>
<div class="page">
  <div class="top">
    <div>
      <a class="back" href="/participant/home">&larr; Back to Home</a>
      <h1 class="page-title">My Hackathons</h1>
      <p class="page-sub">Manage all hackathons where you are part of a team.</p>
    </div>
    <!-- EL kept: ${totalCount} -->
    <div class="count-chip">Total: ${totalCount}</div>
  </div>

  <!-- EL/JSTL kept exactly -->
  <c:choose>
    <c:when test="${empty myHackathons}">
      <div class="empty-state">
        <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="opacity:.35;margin-bottom:8px"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg>
        <h3 style="font-size:18px;font-weight:800;color:#e2e8f0">No joined hackathons yet</h3>
        <p>Join a hackathon from the home page and it will appear here.</p>
        <a href="/participant/home">Browse hackathons &rarr;</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="grid">
        <c:forEach items="${myHackathons}" var="m">
          <article class="card">
            <h3>${m.hackathon.title}</h3>
            <div class="meta">
              <span class="chip ${m.hackathon.status == 'ONGOING' ? 'live' : m.hackathon.status == 'UPCOMING' ? 'soon' : ''}">${m.hackathon.status}</span>
              <span class="chip">${m.hackathon.eventType}</span>
              <span class="chip">${m.teamSize} members</span>
              <span class="chip">${m.pendingInvites} pending</span>
              <span class="chip ${m.leader ? 'leader' : 'member'}">${m.leader ? 'Team Leader' : m.roleTitle}</span>
            </div>
            <p class="desc">${m.hackathon.description}</p>
            <div class="actions">
              <a class="btn btn-secondary" href="/participant/hackathon/${m.hackathon.hackathonId}">View Details</a>
              <a class="btn btn-primary" href="/participant/hackathon/${m.hackathon.hackathonId}/team">Manage Team</a>
              <c:if test="${not empty m.teamId}">
                <c:choose>
                  <c:when test="${m.submissionEnabled}">
                    <a class="btn btn-teal" href="/participant/hackathon/${m.hackathon.hackathonId}/submission">Submission</a>
                  </c:when>
                  <c:otherwise>
                    <span class="btn btn-disabled" title="Submission opens after registration end">Submission</span>
                  </c:otherwise>
                </c:choose>
              </c:if>
              <c:if test="${m.hackathon.leaderboardPublished}">
                <a class="btn btn-blue" href="/participant/leaderboard/${m.hackathon.hackathonId}">Leaderboard</a>
              </c:if>
            </div>
          </article>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>
