<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Leaderboard | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--gold:#fbbf24;--silver:#94a3b8;--bronze:#cd7c3a}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.page{position:relative;z-index:1;max-width:960px;margin:0 auto;padding:28px 20px 40px}
.back{color:var(--muted);text-decoration:none;font-weight:700;font-size:14px}
.back:hover{color:var(--text)}
.hero{margin-top:12px;padding:22px 24px;border:1px solid var(--border);border-radius:18px;background:linear-gradient(135deg,rgba(124,58,237,.18),rgba(6,182,212,.14));margin-bottom:20px}
.hero-label{font-size:11px;font-family:'Space Mono',monospace;letter-spacing:1.5px;text-transform:uppercase;color:var(--accent2);margin-bottom:8px;display:flex;align-items:center;gap:8px}
.live-dot{width:7px;height:7px;background:var(--accent2);border-radius:50%;animation:pulse 1.5s infinite}
@keyframes pulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.4;transform:scale(1.5)}}
.hero-title{font-size:28px;font-weight:800;margin-bottom:6px}
.hero-sub{font-size:14px;color:var(--muted);margin-bottom:14px}
.meta-chips{display:flex;flex-wrap:wrap;gap:8px}
.chip{padding:5px 10px;border-radius:100px;border:1px solid var(--border);background:var(--surface2);font-family:'Space Mono',monospace;font-size:11px;color:var(--muted)}
.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;overflow:hidden}
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse;min-width:600px}
th{font-size:10px;font-family:'Space Mono',monospace;letter-spacing:1px;text-transform:uppercase;color:var(--muted);padding:12px 14px;border-bottom:1px solid var(--border);background:var(--surface2);text-align:left}
td{padding:13px 14px;border-bottom:1px solid var(--border);font-size:14px;color:#b8c7d8;text-align:left}
tbody tr:last-child td{border-bottom:none}
tbody tr:hover td{background:rgba(124,58,237,.04)}
.rank-cell{font-family:'Space Mono',monospace;font-weight:700;font-size:15px}
.rank-1{color:var(--gold)}
.rank-2{color:var(--silver)}
.rank-3{color:var(--bronze)}
.rank-other{color:var(--muted)}
.team-name{font-weight:700;color:var(--text)}
.score-val{font-family:'Space Mono',monospace;font-weight:700;color:var(--text)}
.avg-val{font-family:'Space Mono',monospace;color:#a78bfa;font-weight:700}
.empty-note{text-align:center;padding:36px;color:var(--muted);font-size:14px}
.footer-note{margin-top:12px;font-size:12px;color:var(--muted);padding:0 4px;font-family:'Space Mono',monospace}
</style>
</head>
<body>
<%@ include file="ParticipantTopNav.jsp"%>
<div class="page">
  <!-- EL kept: ${hackathon.hackathonId} -->
  <a class="back" href="/participant/hackathon/${hackathon.hackathonId}">&larr; Back to Hackathon</a>

  <div class="hero">
    <div class="hero-label">
      <span class="live-dot"></span>
      Live Rankings
    </div>
    <!-- EL kept: ${hackathon.title} ${hackathon.status} ${totalTeams} ${totalEvaluations} -->
    <h1 class="hero-title">Leaderboard</h1>
    <p class="hero-sub">${hackathon.title}</p>
    <div class="meta-chips">
      <span class="chip">Status: ${hackathon.status}</span>
      <span class="chip">Teams: ${totalTeams}</span>
      <span class="chip">Reviews: ${totalEvaluations}</span>
    </div>
  </div>

  <div class="card">
    <!-- EL/JSTL kept: ${leaderboardRows} -->
    <c:choose>
      <c:when test="${empty leaderboardRows}">
        <div class="empty-note">No scores available yet. Check back after review.</div>
      </c:when>
      <c:otherwise>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Rank</th>
                <th>Team</th>
                <th>Total Score</th>
                <th>Reviews</th>
                <th>Avg. Score</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${leaderboardRows}" var="r">
                <tr>
                  <td>
                    <span class="rank-cell ${r.rank == 1 ? 'rank-1' : r.rank == 2 ? 'rank-2' : r.rank == 3 ? 'rank-3' : 'rank-other'}">
                      ${r.rank == 1 ? '&#127881;' : r.rank == 2 ? '&#129352;' : r.rank == 3 ? '&#129353;' : ''}
                      #${r.rank}
                    </span>
                  </td>
                  <td class="team-name">${r.teamName}</td>
                  <td class="score-val">${r.totalScore}</td>
                  <td>${r.evaluationCount}</td>
                  <!-- fmt:formatNumber kept exactly -->
                  <td class="avg-val"><fmt:formatNumber value="${r.averageScore}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <p class="footer-note">Ranking based on highest average score, then total score.</p>
      </c:otherwise>
    </c:choose>
  </div>
</div>
</body>
</html>
