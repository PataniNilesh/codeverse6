<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${hackathon.title} | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--green:#4ade80;--amber:#fbbf24;--red:#f87171;--glow:rgba(124,58,237,.3)}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.page{position:relative;z-index:1;max-width:1100px;margin:0 auto;padding:24px 20px 48px}
.back{color:var(--muted);text-decoration:none;font-weight:700;font-size:14px}
.back:hover{color:var(--text)}
.hero{background:linear-gradient(140deg,rgba(124,58,237,.22),rgba(6,182,212,.18));border:1px solid var(--border);border-radius:18px;padding:26px;margin:14px 0 20px;position:relative;overflow:hidden}
.hero-banner{width:100%;max-height:280px;object-fit:cover;border-radius:14px;border:1px solid var(--border);margin-bottom:18px}
.hero-title{font-size:clamp(22px,4vw,36px);font-weight:800;line-height:1.15;margin-bottom:8px}
.hero-desc{font-size:15px;color:var(--muted);line-height:1.7;margin-bottom:14px}
.meta-chips{display:flex;flex-wrap:wrap;gap:8px;margin-bottom:16px}
.chip{padding:6px 11px;border-radius:100px;border:1px solid var(--border);background:var(--surface2);font-size:12px;font-family:'Space Mono',monospace;color:var(--muted)}
.chip.live{color:var(--green);border-color:rgba(74,222,128,.3);background:rgba(74,222,128,.08)}
.chip.soon{color:var(--amber);border-color:rgba(251,191,36,.3);background:rgba(251,191,36,.08)}
/* Messages */
.msg{margin:0 0 14px;padding:11px 14px;border-radius:10px;font-size:14px}
.ok{background:rgba(74,222,128,.12);border:1px solid rgba(74,222,128,.3);color:var(--green)}
.err{background:rgba(248,113,113,.1);border:1px solid rgba(248,113,113,.28);color:var(--red)}
/* Join panel */
.join-panel{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;border-top:1px solid rgba(255,255,255,.08);padding-top:16px;margin-top:12px}
.join-info{font-size:13px;color:var(--muted)}
.btn{display:inline-flex;align-items:center;gap:7px;padding:10px 18px;border-radius:10px;font-family:'Syne',sans-serif;font-weight:700;font-size:14px;text-decoration:none;border:none;cursor:pointer;transition:all .2s}
.btn-primary{background:var(--accent);color:#fff;box-shadow:0 3px 12px var(--glow)}
.btn-primary:hover{background:#6d28d9;transform:translateY(-1px)}
.btn-danger-fill{background:#7f1d1d;color:#fff}
.btn-danger-fill:hover{background:#991b1b}
.btn-ghost{display:inline-block;text-decoration:none;padding:10px 16px;border-radius:10px;border:1px solid var(--border);background:var(--surface2);color:var(--text);font-weight:700;font-size:14px;font-family:'Syne',sans-serif}
.btn-ghost:hover{border-color:var(--accent);color:var(--text)}
.btn[disabled]{opacity:.6;cursor:not-allowed;pointer-events:none}
.btn-row{display:flex;gap:8px;flex-wrap:wrap}
/* Grid */
.grid{display:grid;grid-template-columns:1.4fr 0.8fr;gap:18px;margin-bottom:18px}
.card{background:var(--surface);border:1px solid var(--border);border-radius:14px;padding:18px}
.card h2{font-size:18px;font-weight:800;margin-bottom:12px}
.desc-content{color:#c2cfdd;line-height:1.8;font-size:14px}
.desc-content p,.desc-content ul,.desc-content ol{margin-bottom:10px}
.kitem{padding:11px 12px;border:1px solid var(--border);border-radius:11px;background:var(--surface2);margin-bottom:8px}
.kitem:last-child{margin-bottom:0}
.klabel{font-size:10px;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:var(--muted);margin-bottom:5px}
.kval{font-size:14px;font-weight:700;color:var(--text)}
.kval a{color:#93c5fd;text-decoration:none}
.prize-card{background:var(--surface2);border:1px solid var(--border);border-radius:12px;padding:14px;margin-bottom:10px}
.prize-card:last-child{margin-bottom:0}
.prize-card h3{font-size:15px;font-weight:800;margin-bottom:6px}
.prize-card p{font-size:13px;color:#a6b6c8;line-height:1.6}
.empty-note{font-size:14px;color:var(--muted)}
@media(max-width:900px){.grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<%@ include file="ParticipantTopNav.jsp"%>
<div class="page">
  <a href="/participant/home" class="back">&larr; Back to Hackathons</a>

  <section class="hero">
    <!-- EL kept exactly -->
    <c:if test="${not empty hackathon.bannerImageUrl}">
      <img src="${hackathon.bannerImageUrl}" alt="${hackathon.title}" class="hero-banner">
    </c:if>
    <h1 class="hero-title">${hackathon.title}</h1>
    <p class="hero-desc">${hackathon.description}</p>
    <div class="meta-chips">
      <span class="chip ${hackathon.status == 'ONGOING' ? 'live' : hackathon.status == 'UPCOMING' ? 'soon' : ''}">${hackathon.status}</span>
      <span class="chip">${hackathon.eventType}</span>
      <span class="chip">${hackathon.payment}</span>
      <span class="chip">Team ${hackathon.minTeamSize}&ndash;${hackathon.maxTeamSize}</span>
      <span class="chip ${registrationOpen ? 'live' : 'soon'}">${registrationOpen ? 'Registration Open' : 'Registration Closed'}</span>
      <span class="chip">${teamCount} Teams Joined</span>
    </div>

    <!-- Success/error messages — EL kept -->
    <c:if test="${joined == 'true'}"><div class="msg ok">You have successfully joined this hackathon.</div></c:if>
    <c:if test="${success == 'inviteAccepted'}"><div class="msg ok">Invitation accepted. You are now part of this team.</div></c:if>
    <c:if test="${success == 'inviteRejected'}"><div class="msg ok">Invitation rejected.</div></c:if>
    <c:if test="${error == 'alreadyRegistered'}"><div class="msg err">You are already registered in this hackathon.</div></c:if>
    <c:if test="${error == 'registrationClosed'}"><div class="msg err">Registration is currently closed for this hackathon.</div></c:if>
    <c:if test="${error == 'inviteNotFound' || error == 'inviteInvalid'}"><div class="msg err">Invitation is invalid or no longer available.</div></c:if>
    <c:if test="${error == 'teamFull'}"><div class="msg err">This team is full, so invite cannot be accepted.</div></c:if>
    <c:if test="${error == 'alreadyInHackathon'}"><div class="msg err">You are already part of another team in this hackathon.</div></c:if>
    <c:if test="${error == 'leaderboardNotReady'}"><div class="msg err">Leaderboard is not published yet.</div></c:if>

    <!-- Join panel — all form actions kept -->
    <div class="join-panel">
      <div class="join-info">
        <c:choose>
          <c:when test="${alreadyRegistered}">You are already part of this hackathon.</c:when>
          <c:when test="${not empty pendingInvite}">You have a pending team invitation for this hackathon.</c:when>
          <c:when test="${registrationOpen}">Registration is open. Join now to participate.</c:when>
          <c:otherwise>You can join only during the registration period.</c:otherwise>
        </c:choose>
      </div>
      <div class="btn-row">
        <c:choose>
          <c:when test="${alreadyRegistered}">
            <a href="/participant/hackathon/${hackathon.hackathonId}/team" class="btn btn-primary">Manage Team</a>
          </c:when>
          <c:when test="${not empty pendingInvite}">
            <form action="/participant/hackathon/${hackathon.hackathonId}/invite/${pendingInvite.hackathonTeamInviteId}/accept" method="post" style="display:inline">
              <button type="submit" class="btn btn-primary">Accept Invitation</button>
            </form>
            <form action="/participant/hackathon/${hackathon.hackathonId}/invite/${pendingInvite.hackathonTeamInviteId}/reject" method="post" style="display:inline">
              <button type="submit" class="btn btn-danger-fill">Reject</button>
            </form>
          </c:when>
          <c:when test="${canJoin}">
            <form action="/participant/hackathon/${hackathon.hackathonId}/join" method="post" style="display:inline">
              <button type="submit" class="btn btn-primary">Join Hackathon</button>
            </form>
          </c:when>
          <c:otherwise>
            <button type="button" class="btn btn-primary" disabled>Join Hackathon</button>
          </c:otherwise>
        </c:choose>
        <c:if test="${leaderboardAvailable}">
          <a class="btn-ghost" href="/participant/leaderboard/${hackathon.hackathonId}">View Leaderboard</a>
        </c:if>
      </div>
    </div>
  </section>

  <!-- Two-col grid -->
  <div class="grid">
    <section class="card">
      <h2>About This Hackathon</h2>
      <div class="desc-content">
        <c:choose>
          <c:when test="${not empty hackathonDescription}">
            <c:out value="${hackathonDescription.hackathonDetails}" escapeXml="false"/>
          </c:when>
          <c:otherwise><p class="empty-note">Detailed description is not available yet.</p></c:otherwise>
        </c:choose>
      </div>
    </section>
    <section class="card">
      <h2>Quick Info</h2>
      <div class="kitem"><div class="klabel">Registration Start</div><div class="kval">${hackathon.registrationStartDate}</div></div>
      <div class="kitem"><div class="klabel">Registration End</div><div class="kval">${hackathon.registrationEndDate}</div></div>
      <div class="kitem"><div class="klabel">Location</div><div class="kval">${hackathon.location}</div></div>
      <div class="kitem"><div class="klabel">Hackathon Dates</div><div class="kval">${hackathon.hackathonStartDate} to ${hackathon.hackathonEndDate}</div></div>
      <div class="kitem"><div class="klabel">Submission Deadline</div><div class="kval">${hackathon.submissionDeadline}</div></div>
      <div class="kitem"><div class="klabel">Contact Email</div><div class="kval">${hackathon.contactEmail}</div></div>
      <div class="kitem"><div class="klabel">Rules</div><div class="kval">
        <c:choose>
          <c:when test="${not empty hackathon.rulesUrl}"><a href="${hackathon.rulesUrl}" target="_blank">Open Rules</a></c:when>
          <c:otherwise>Not Provided</c:otherwise>
        </c:choose>
      </div></div>
    </section>
  </div>

  <!-- Prizes -->
  <section class="card">
    <h2>Prizes</h2>
    <c:choose>
      <c:when test="${empty prizeList}">
        <p class="empty-note" style="margin-top:6px">Prize details are not published yet.</p>
      </c:when>
      <c:otherwise>
        <div style="margin-top:12px">
          <c:forEach items="${prizeList}" var="p" varStatus="i">
            <div class="prize-card">
              <h3>${i.count}. ${p.prizeTitle}</h3>
              <p>${p.prizeDescription}</p>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </section>
</div>
</body>
</html>
