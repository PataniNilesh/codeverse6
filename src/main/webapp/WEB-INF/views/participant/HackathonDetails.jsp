<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hackathon Title | Details</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
/* ── Reset & Root ───────────────────────────────────────── */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  --bg:       #0a0a0f;
  --surface:  #13131a;
  --surface2: #1c1c27;
  --border:   #2a2a3d;
  --accent:   #7c3aed;
  --accent2:  #06b6d4;
  --text:     #e2e8f0;
  --muted:    #64748b;
  --green:    #4ade80;
  --amber:    #fbbf24;
  --red:      #f87171;
  --glow:     rgba(124,58,237,.35);
}

body {
  font-family: 'Syne', sans-serif;
  background: var(--bg);
  color: var(--text);
  min-height: 100vh;
  overflow-x: hidden;
}

/* grid overlay */
body::before {
  content: '';
  position: fixed; inset: 0;
  background-image:
    linear-gradient(rgba(124,58,237,.04) 1px, transparent 1px),
    linear-gradient(90deg, rgba(124,58,237,.04) 1px, transparent 1px);
  background-size: 40px 40px;
  pointer-events: none;
  z-index: 0;
}

/* ── Top Nav placeholder ───────────────────────────────── */
/* Replace this section with your <%@ include file="ParticipantTopNav.jsp" %> */
.topnav {
  position: sticky; top: 0; z-index: 100;
  background: rgba(10,10,15,.9);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--border);
  height: 64px;
  display: flex; align-items: center;
  padding: 0 40px;
  justify-content: space-between;
}
.topnav-logo {
  display: flex; align-items: center; gap: 10px;
  font-family: 'Space Mono', monospace;
  font-size: 16px; font-weight: 700;
  color: var(--text); text-decoration: none;
}
.logo-box {
  width: 34px; height: 34px;
  background: linear-gradient(135deg, var(--accent), var(--accent2));
  border-radius: 8px;
  display: flex; align-items: center; justify-content: center;
}
.topnav-links { display: flex; gap: 6px; align-items: center; }
.topnav-links a {
  color: var(--muted); text-decoration: none;
  font-size: 14px; font-weight: 600;
  padding: 8px 16px; border-radius: 8px;
  transition: all .2s;
}
.topnav-links a:hover { color: var(--text); background: var(--surface2); }
.topnav-links a.active {
  color: #a78bfa;
  background: rgba(124,58,237,.15);
}

/* ── Page shell ────────────────────────────────────────── */
.page {
  position: relative; z-index: 1;
  max-width: 1200px;
  margin: 0 auto;
  padding: 28px 32px 60px;
}

/* ── Breadcrumb / back row ─────────────────────────────── */
.back-row {
  display: flex; align-items: center; gap: 8px;
  margin-bottom: 24px;
  font-family: 'Space Mono', monospace;
  font-size: 12px; color: var(--muted);
  animation: fadeUp .4s ease both;
}
.back-row a { color: var(--muted); text-decoration: none; transition: color .2s; }
.back-row a:hover { color: var(--text); }
.back-row span { color: var(--accent2); }

/* ── Hero card ─────────────────────────────────────────── */
.hero {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 20px;
  padding: 36px 40px;
  position: relative;
  overflow: hidden;
  margin-bottom: 24px;
  animation: fadeUp .5s .05s ease both;
}
/* top accent stripe */
.hero::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--accent), var(--accent2));
}
/* glow blobs */
.hero::after {
  content: '';
  position: absolute; top: -80px; right: -80px;
  width: 340px; height: 340px;
  background: radial-gradient(circle, rgba(124,58,237,.14) 0%, transparent 70%);
  pointer-events: none;
}

.hero-head {
  display: flex; align-items: flex-start;
  justify-content: space-between; gap: 24px;
  flex-wrap: wrap;
  margin-bottom: 24px;
}

.hero-left { flex: 1; min-width: 0; }

.badge-row {
  display: flex; flex-wrap: wrap; gap: 8px;
  margin-bottom: 14px;
}

/* status / info badges */
.badge {
  font-family: 'Space Mono', monospace;
  font-size: 10px; font-weight: 700;
  letter-spacing: 1px;
  padding: 4px 12px; border-radius: 100px;
  display: inline-flex; align-items: center; gap: 5px;
  white-space: nowrap;
}
.badge-dot {
  width: 6px; height: 6px;
  border-radius: 50%; flex-shrink: 0;
}

/* ONGOING / LIVE */
.badge-live {
  background: rgba(74,222,128,.12);
  color: #4ade80;
  border: 1px solid rgba(74,222,128,.3);
}
.badge-live .badge-dot { background: #4ade80; animation: pulse 1.5s infinite; }

/* UPCOMING */
.badge-soon {
  background: rgba(251,191,36,.12);
  color: #fbbf24;
  border: 1px solid rgba(251,191,36,.3);
}
.badge-soon .badge-dot { background: #fbbf24; }

/* COMPLETED */
.badge-ended {
  background: rgba(100,116,139,.12);
  color: #94a3b8;
  border: 1px solid rgba(100,116,139,.3);
}

/* generic tinted badges */
.badge-purple {
  background: rgba(124,58,237,.15);
  color: #a78bfa;
  border: 1px solid rgba(124,58,237,.25);
}
.badge-cyan {
  background: rgba(6,182,212,.12);
  color: #67e8f9;
  border: 1px solid rgba(6,182,212,.2);
}
.badge-green {
  background: rgba(74,222,128,.12);
  color: #4ade80;
  border: 1px solid rgba(74,222,128,.25);
}
.badge-amber {
  background: rgba(245,158,11,.12);
  color: #fbbf24;
  border: 1px solid rgba(245,158,11,.25);
}

@keyframes pulse {
  0%,100% { opacity:1; transform:scale(1); }
  50%      { opacity:.4; transform:scale(1.5); }
}

.hero-title {
  font-size: clamp(26px, 4vw, 44px);
  font-weight: 800;
  letter-spacing: -1px;
  line-height: 1.1;
  margin-bottom: 10px;
}
.hero-desc {
  color: var(--muted);
  font-size: 15px; line-height: 1.7;
}

/* Action buttons */
.hero-actions {
  display: flex; flex-direction: column;
  gap: 10px; flex-shrink: 0;
  min-width: 160px;
}
.btn-primary {
  display: inline-flex; align-items: center;
  justify-content: center; gap: 8px;
  background: var(--accent); color: #fff;
  border: none; border-radius: 12px;
  padding: 13px 24px;
  font-family: 'Syne', sans-serif;
  font-size: 14px; font-weight: 700;
  cursor: pointer; transition: all .25s;
  box-shadow: 0 4px 20px var(--glow);
  text-decoration: none; white-space: nowrap;
}
.btn-primary:hover {
  background: #6d28d9;
  transform: translateY(-2px);
  box-shadow: 0 8px 30px var(--glow);
}
.btn-primary:disabled {
  opacity: .5; cursor: not-allowed; transform: none;
}
.btn-danger {
  background: rgba(185,28,28,.8);
  box-shadow: none;
}
.btn-danger:hover { background: #991b1b; }

.btn-ghost {
  display: inline-flex; align-items: center;
  justify-content: center; gap: 8px;
  background: transparent; color: var(--muted);
  border: 1px solid var(--border); border-radius: 12px;
  padding: 12px 24px;
  font-family: 'Syne', sans-serif;
  font-size: 14px; font-weight: 600;
  cursor: pointer; transition: all .2s;
  text-decoration: none; white-space: nowrap;
}
.btn-ghost:hover {
  color: var(--text);
  background: var(--surface2);
  border-color: var(--accent);
}

/* Stat chips row */
.stat-row {
  display: flex; flex-wrap: wrap; gap: 10px;
  padding-top: 20px;
  border-top: 1px solid var(--border);
}
.stat-chip {
  display: inline-flex; align-items: center; gap: 8px;
  background: var(--surface2);
  border: 1px solid var(--border);
  border-radius: 10px; padding: 9px 14px;
  font-size: 13px; font-weight: 600;
  transition: border-color .2s;
}
.stat-chip:hover { border-color: var(--accent); }
.stat-chip-label {
  font-size: 10px;
  font-family: 'Space Mono', monospace;
  letter-spacing: .8px;
  color: var(--muted);
  display: block; margin-bottom: 1px;
}

/* ── Alert messages ────────────────────────────────────── */
.alert {
  margin-top: 18px;
  padding: 12px 16px;
  border-radius: 10px;
  font-size: 14px; line-height: 1.5;
}
.alert-success {
  background: rgba(34,197,94,.12);
  border: 1px solid rgba(34,197,94,.35);
  color: #86efac;
}
.alert-error {
  background: rgba(239,68,68,.1);
  border: 1px solid rgba(239,68,68,.3);
  color: #fca5a5;
}

/* ── Two-column body ───────────────────────────────────── */
.body-grid {
  display: grid;
  grid-template-columns: 1fr 320px;
  gap: 20px;
  align-items: start;
}

/* ── Generic section card ──────────────────────────────── */
.card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 16px;
  padding: 26px 28px;
  animation: fadeUp .5s ease both;
}
.card + .card { margin-top: 20px; }
.card:nth-child(1) { animation-delay: .10s; }
.card:nth-child(2) { animation-delay: .15s; }
.card:nth-child(3) { animation-delay: .20s; }

.card-title {
  display: flex; align-items: center; gap: 10px;
  font-size: 12px; font-weight: 700;
  letter-spacing: 2px; text-transform: uppercase;
  color: var(--muted);
  font-family: 'Space Mono', monospace;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border);
  margin-bottom: 20px;
}

/* About / description text */
.desc-body {
  color: #c2cfdd;
  font-size: 15px; line-height: 1.8;
}
.desc-body p + p { margin-top: 12px; }
.empty-note {
  color: var(--muted); font-size: 14px;
  font-style: italic;
}

/* ── Quick Info list ───────────────────────────────────── */
.info-list { display: flex; flex-direction: column; gap: 0; }
.info-row {
  display: flex; align-items: flex-start;
  justify-content: space-between; gap: 12px;
  padding: 12px 0;
  border-bottom: 1px solid var(--border);
}
.info-row:last-child { border-bottom: none; }
.info-key {
  font-size: 11px; font-family: 'Space Mono', monospace;
  letter-spacing: .5px; color: var(--muted);
  flex-shrink: 0;
}
.info-val {
  font-size: 13px; font-weight: 700;
  color: var(--text); text-align: right;
}
.info-val.green  { color: var(--green); }
.info-val.amber  { color: var(--amber); }
.info-val.purple { color: #a78bfa; }
.info-val.cyan   { color: #67e8f9; }

/* ── Prizes ─────────────────────────────────────────────── */
.prize-list { display: flex; flex-direction: column; gap: 12px; }
.prize-item {
  display: flex; align-items: flex-start; gap: 14px;
  background: var(--surface2);
  border: 1px solid var(--border);
  border-radius: 12px; padding: 16px;
  transition: border-color .2s;
}
.prize-item:hover { border-color: rgba(124,58,237,.4); }
.prize-medal {
  font-size: 26px; flex-shrink: 0;
  margin-top: 2px;
}
.prize-body {}
.prize-title {
  font-size: 15px; font-weight: 800;
  margin-bottom: 4px;
}
.prize-desc {
  color: #b7c7d8; font-size: 14px; line-height: 1.6;
}

/* ── Timeline ──────────────────────────────────────────── */
.timeline { display: flex; flex-direction: column; gap: 0; }
.tl-row {
  display: flex; align-items: flex-start; gap: 14px;
  padding-bottom: 22px; position: relative;
}
.tl-row:last-child { padding-bottom: 0; }
.tl-left {
  display: flex; flex-direction: column;
  align-items: center; flex-shrink: 0; width: 18px;
}
.tl-dot {
  width: 12px; height: 12px; border-radius: 50%;
  border: 2px solid var(--accent);
  background: var(--bg); margin-top: 3px; z-index: 1;
}
.tl-dot.filled {
  background: var(--accent);
  box-shadow: 0 0 8px var(--glow);
}
.tl-line {
  width: 2px; flex: 1; min-height: 24px;
  background: linear-gradient(to bottom, var(--accent), var(--border));
  margin-top: 3px;
}
.tl-row:last-child .tl-line { display: none; }
.tl-info {}
.tl-label {
  font-size: 10px; font-family: 'Space Mono', monospace;
  letter-spacing: 1.2px; text-transform: uppercase;
  color: var(--muted); margin-bottom: 2px;
}
.tl-value { font-size: 14px; font-weight: 700; color: var(--text); }

/* ── Leaderboard button strip ──────────────────────────── */
.lb-strip {
  margin-top: 16px;
  padding: 14px 16px;
  background: linear-gradient(135deg, rgba(124,58,237,.12), rgba(6,182,212,.08));
  border: 1px solid rgba(124,58,237,.3);
  border-radius: 12px;
  display: flex; align-items: center; justify-content: space-between; gap: 12px;
}
.lb-strip-text {
  font-size: 14px; color: var(--text); font-weight: 600;
}
.lb-strip-text small {
  display: block; font-size: 12px;
  color: var(--muted); font-weight: 400;
}

/* ── Animations ────────────────────────────────────────── */
@keyframes fadeUp {
  from { opacity:0; transform:translateY(18px); }
  to   { opacity:1; transform:translateY(0); }
}

/* ── Responsive ────────────────────────────────────────── */
@media (max-width: 900px) {
  .body-grid { grid-template-columns: 1fr; }
  .page { padding: 20px 16px 48px; }
  .hero { padding: 24px 20px; }
  .hero-head { flex-direction: column; }
  .hero-actions { flex-direction: row; width: 100%; }
  .topnav { padding: 0 20px; }
}
@media (max-width: 500px) {
  .hero-actions { flex-direction: column; }
  .btn-primary, .btn-ghost { width: 100%; }
}
</style>
</head>
<body>

<!-- ═══════════════════════════════════════════════════════
     TOP NAV
     Replace the entire block below with:
     <%@ include file="ParticipantTopNav.jsp" %>
     ═══════════════════════════════════════════════════════ -->
<nav class="topnav">
  <a href="/participant/home" class="topnav-logo">
    <div class="logo-box">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
        stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
      </svg>
    </div>
    INTERNS HACK
  </a>
  <div class="topnav-links">
    <a href="/participant/home">Explore</a>
    <a href="#" class="active">Details</a>
    <a href="#">Leaderboard</a>
  </div>
</nav>
<!-- ═══ END TOP NAV ══════════════════════════════════════ -->


<div class="page">

  <!-- Breadcrumb -->
  <div class="back-row">
    <a href="/participant/home">← Back to Hackathons</a>
    <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor"
      stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <polyline points="9 18 15 12 9 6"/>
    </svg>
    <span>${hackathon.title}</span>
    <!-- Replace "Hackathon Title" with: ${hackathon.title} -->
  </div>


  <!-- ═══════════════════════════════════════════════════
       HERO CARD
       ═══════════════════════════════════════════════════ -->
  <section class="hero">

    <div class="hero-head">
      <div class="hero-left">

        <!-- ── Badge row ── -->
        <div class="badge-row">

          <!--
            STATUS BADGE — replace the static badge below with a JSTL choose block:

            <c:choose>
              <c:when test="${hackathon.status == 'ONGOING'}">
                <span class="badge badge-live"><span class="badge-dot"></span>LIVE NOW</span>
              </c:when>
              <c:when test="${hackathon.status == 'UPCOMING'}">
                <span class="badge badge-soon"><span class="badge-dot"></span>COMING SOON</span>
              </c:when>
              <c:otherwise>
                <span class="badge badge-ended">COMPLETED</span>
              </c:otherwise>
            </c:choose>
          -->
          <c:choose>
          	<c:when test="${hackathon.status == 'ONGOING'}">
          		<span class="badge badge-live"><span class="badge-dot"></span>LIVE NOW</span>
          	</c:when>
          	<c:when test="${hackathon.status == 'UPCOMING'}">
          		<span class="badge badge-soon"><span class="badge-dot"></span>COMING SOON</span>
          	</c:when>
          	<c:otherwise>
          		<span class="badge badge-ended">COMPLETED</span>
          	</c:otherwise>
          </c:choose>

          <!-- Replace static text with: ${hackathon.eventType} -->
          <span class="badge badge-purple">${hackathon.eventType}</span>

          <!-- Replace static text with: ${hackathon.payment} -->
          <span class="badge badge-green">${hackathon.payment}</span>

          <!--
            REGISTRATION OPEN/CLOSED badge:
            Replace with:
            <span class="badge ${registrationOpen ? 'badge-green' : 'badge-amber'}">
              ${registrationOpen ? 'Registration Open' : 'Registration Closed'}
            </span>
          -->
          <span class="badge ${registartionOpen ? 'badge-green' : 'badge-amber'}">
          	${registartionOpen ? 'Registration Open' : 'Registartion Closed'}
          </span>

          <!-- Replace 42 with: ${teamCount} -->
          <span class="badge badge-cyan">${teamCount} Teams Joined</span>
        </div>

        <!-- Replace static text with: ${hackathon.title} -->
        <h1 class="hero-title">${hackathon.title}</h1>

        <!-- Replace static text with: ${hackathon.description} -->
        <p class="hero-desc">
          ${hackathon.description}
        </p>
      </div>

      <!-- ── Action buttons ── -->
      <div class="hero-actions">
          Replace the buttons below with a JSTL choose block:

          <c:choose>
            <c:when test="${alreadyRegistered}">
              <a href="/participant/hackathon/${hackathon.hackathonId}/team" class="btn-primary">Manage Team</a>
            </c:when>
            <c:when test="${not empty pendingInvite}">
              <form action="/participant/hackathon/${hackathon.hackathonId}/invite/${pendingInvite.hackathonTeamInviteId}/accept" method="post">
                <button type="submit" class="btn-primary">Accept Invitation</button>
              </form>
              <form action="/participant/hackathon/${hackathon.hackathonId}/invite/${pendingInvite.hackathonTeamInviteId}/reject" method="post">
                <button type="submit" class="btn-primary btn-danger">Reject</button>
              </form>
            </c:when>
            <c:when test="${canJoin}">
              <form action="/participant/hackathon/${hackathon.hackathonId}/join" method="post">
                <button type="submit" class="btn-primary">Join Hackathon
               		<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="white"
			            stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
			            <line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>
		        	</svg>
                </button>
              </form>
            </c:when>
            <c:otherwise>
              <button type="button" class="btn-primary" disabled>Join Hackathon</button>
            </c:otherwise>
          </c:choose>
        
        <!-- 
        <button class="btn-primary">
          Join Hackathon
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="white"
            stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>
          </svg>
        </button>
        <button class="btn-ghost">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="18" cy="5" r="3"/><circle cx="6" cy="12" r="3"/>
            <circle cx="18" cy="19" r="3"/>
            <line x1="8.59" y1="13.51" x2="15.42" y2="17.49"/>
            <line x1="15.41" y1="6.51" x2="8.59" y2="10.49"/>
          </svg>
          Share
        </button>  -->
      </div>
    </div>

    <!-- ── Quick stat chips ── -->
    <div class="stat-row">
      <!-- Replace the static values below with EL expressions from hackathon object -->
      <div class="stat-chip">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#a78bfa"
          stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
          <circle cx="9" cy="7" r="4"/>
          <path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
        </svg>
        <div>
          <span class="stat-chip-label">TEAM SIZE</span>
          <!-- Replace with: ${hackathon.minTeamSize} – ${hackathon.maxTeamSize} members -->
          ${hackathon.minTeamSize} - ${hackathon.maxTeamSize}
        </div>
      </div>

      <div class="stat-chip">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#67e8f9"
          stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/>
          <line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>
        </svg>
        <div>
          <span class="stat-chip-label">REG. OPENS</span>
          <!-- Replace with: ${hackathon.registrationStartDate} -->
          ${hackathon.registrationStartDate}
        </div>
      </div>

      <div class="stat-chip">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fcd34d"
          stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/>
        </svg>
        <div>
          <span class="stat-chip-label">REG. CLOSES</span>
          <!-- Replace with: ${hackathon.registrationEndDate} -->
          ${hackathon.registrationEndDate}
        </div>
      </div>

      <div class="stat-chip">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#4ade80"
          stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
          <circle cx="12" cy="10" r="3"/>
        </svg>
        <div>
          <span class="stat-chip-label">LOCATION</span>
          <!-- Replace with: ${hackathon.location} -->
          ${hackathon.location}
        </div>
      </div>
    </div>

    <!-- ── Alert messages ──────────────────────────────────
         Replace the static alerts below with JSTL conditions, e.g.:
         <c:if test="${joined == 'true'}"> ... </c:if>
         ─────────────────────────────────────────────────── -->

    <!-- SUCCESS ALERTS — show the appropriate one via JSTL c:if -->
    
	<!-- Example: You have successfully joined this hackathon. -->
	<!-- Example: Invitation accepted. You are now part of this team. -->
	<!-- Example: Invitation rejected. -->
	<c:if test="${joined == 'true'}">
		<div class=" alert alert-success" style="margin-top:18px;">You have successfully joined this hackathon.</div>
	</c:if>
	<c:if test="${success == 'inviteAccepted'}">
		<div class="alert alert-success" style="margin-top:18px;">Invitation accepted. You are now part of this team.</div>
	</c:if>
	<c:if test="${success == 'inviteRejected'}">
		<div class="alert alert-success" style="margin-top:18px;">Invitation Rejected.</div>
	</c:if>

    <!-- ERROR ALERTS — show the appropriate one via JSTL c:if -->
    <c:if test="${error == 'alreadyRegistered'}">
    	<div class="alert alert-error" style="margin-top:18px;">You are already registered in this hackathon.</div>
    </c:if>
    <c:if test="${error = 'registrationClosed'}">
    	<div class="alert alert-error" style="margin-top:18px;">Registration is currently closed for this hackathon.</div>
    </c:if>
    <c:if test="${error == 'inviteNotFound' || error == 'inviteInvalid'}">
    	<div class="alert alert-error" style="margin-top:18px;">Invitation is invalid or no longer available.</div>
    </c:if>
    <c:if test="${error = 'teamFull'}">
    	<div class="alert alert-error" style="margin-top:18px;">The team is full, so invitation cannot be accepted.</div>
    </c:if>
    <c:if test="${error == 'alreadyInHackathon'}">
    	<div class="alert alert-error" style="margin-top:18px;">You are already part of another team in this hackathon.</div>
    </c:if>
    <c:if test="${error = 'leaderBoardNotReady'}">
    	<div class="alert alert-error" style="margin-top:18px;">Leaderboard will be available only after hackathon is marked complete.</div>
    </c:if>
    
    

    <!-- ── Leaderboard strip (show only when leaderboardAvailable) ──
         Wrap with: <c:if test="${leaderboardAvailable}"> ... </c:if>  -->
    <c:if test="${leaderboardAvailable}">
	    <div class="lb-strip" style="margin-top:16px;">
	      <div class="lb-strip-text">
	        🏆 Leaderboard is Live
	        <small>See how your team ranks among all participants</small>
	      </div>
	      <!-- Replace hackathonId with: ${hackathon.hackathonId} -->
	      <a href="/participant/hackathon/${hackathon.hackathonId}/leaderboard" class="btn-ghost" style="flex-shrink:0;">
	        View Leaderboard →
	      </a>
	    </div>
    </c:if>
    

  </section>
  <!-- ═══ END HERO ════════════════════════════════════════ -->


  <!-- ═══════════════════════════════════════════════════
       BODY GRID
       ═══════════════════════════════════════════════════ -->
  <div class="body-grid">

    <!-- ── LEFT COLUMN ───────────────────────────────── -->
    <div>

      <!-- About -->
      <div class="card">
        <div class="card-title">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
            stroke="#a78bfa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"/>
            <line x1="12" y1="8" x2="12" y2="12"/>
            <line x1="12" y1="16" x2="12.01" y2="16"/>
          </svg>
          About This Hackathon
        </div>
        <div class="desc-body">
          <!--
            Replace the paragraph below with:
            <c:choose>
              <c:when test="${not empty hackathonDescription}">
                <c:out value="${hackathonDescription.hackathonDetails}" escapeXml="false"/>
              </c:when>
              <c:otherwise>
                <p class="empty-note">Detailed description is not available yet.</p>
              </c:otherwise>
            </c:choose>
          -->
          	<c:choose>
              <c:when test="${not empty hackathonDescription}">
                <c:out value="${hackathonDescription.hackathonDetails}" escapeXml="false"/>
              </c:when>
              <c:otherwise>
                <p class="empty-note">Detailed description is not available yet.</p>
              </c:otherwise>
            </c:choose>
        </div>
      </div>

      <!-- Prizes -->
      <div class="card">
        <div class="card-title">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
            stroke="#fcd34d" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="8" r="7"/>
            <polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"/>
          </svg>
          Prizes &amp; Rewards
        </div>

        <!--
          Replace the static prize list below with:
          <c:choose>
            <c:when test="${empty prizeList}">
              <p class="empty-note">Prize details are not published yet.</p>
            </c:when>
            <c:otherwise>
              <div class="prize-list">
                <c:forEach items="${prizeList}" var="p" varStatus="i">
                  <div class="prize-item">
                    <div class="prize-medal">
                      <c:choose>
                        <c:when test="${i.count == 1}">🥇</c:when>
                        <c:when test="${i.count == 2}">🥈</c:when>
                        <c:when test="${i.count == 3}">🥉</c:when>
                        <c:otherwise>⭐</c:otherwise>
                      </c:choose>
                    </div>
                    <div class="prize-body">
                      <div class="prize-title">${i.count}. ${p.prizeTitle}</div>
                      <div class="prize-desc">${p.prizeDescription}</div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
        -->
        <c:choose>
	        <c:when test="${empty prizeList}">
	          <p class="empty-note">Prize details are not published yet.</p>
	        </c:when>
	        <c:otherwise>
	          <div class="prize-list">
	            <c:forEach items="${prizeList}" var="p" varStatus="i">
	              <div class="prize-item">
	                <div class="prize-medal">
	                  <c:choose>
	                    <c:when test="${i.count == 1}">🥇</c:when>
	                    <c:when test="${i.count == 2}">🥈</c:when>
	                    <c:when test="${i.count == 3}">🥉</c:when>
	                    <c:otherwise>⭐</c:otherwise>
	                  </c:choose>
	                </div>
	                <div class="prize-body">
	                  <div class="prize-title">${i.count}. ${p.prizeTitle}</div>
	                  <div class="prize-desc">${p.prizeDescription}</div>
	                </div>
	              </div>
	            </c:forEach>
	          </div>
	        </c:otherwise>
	    </c:choose>
      </div>

      <!-- Timeline -->
      <div class="card">
        <div class="card-title">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
            stroke="#67e8f9" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/>
          </svg>
          Event Timeline
        </div>
        <div class="timeline">
          <!-- Replace static dates with EL: ${hackathon.registrationStartDate}, etc. -->
          <div class="tl-row">
            <div class="tl-left">
              <div class="tl-dot filled"></div>
              <div class="tl-line"></div>
            </div>
            <div class="tl-info">
              <div class="tl-label">Registration Opens</div>
              <div class="tl-value">${hackathon.registrationStartDate}</div>
            </div>
          </div>
          <div class="tl-row">
            <div class="tl-left">
              <div class="tl-dot filled"></div>
              <div class="tl-line"></div>
            </div>
            <div class="tl-info">
              <div class="tl-label">Registration Closes</div>
              <div class="tl-value">${hackathon.registrationEndDate}</div>
            </div>
          </div>
          <div class="tl-row">
            <div class="tl-left">
              <div class="tl-dot"></div>
              <div class="tl-line"></div>
            </div>
            <div class="tl-info">
              <div class="tl-label">Hackathon Begins</div> 
              <div class="tl-value">20 Apr 2025 · 09:00 AM</div>
            </div>
          </div>
          <div class="tl-row">
            <div class="tl-left">
              <div class="tl-dot"></div>
              <div class="tl-line"></div>
            </div>
            <div class="tl-info">
              <div class="tl-label">Submission Deadline</div>
              <div class="tl-value">22 Apr 2025 · 09:00 AM</div>
            </div>
          </div>
          <div class="tl-row">
            <div class="tl-left">
              <div class="tl-dot"></div>
            </div>
            <div class="tl-info">
              <div class="tl-label">Results Announced</div>
              <div class="tl-value">25 Apr 2025</div>
            </div>
          </div>
        </div>
      </div>

    </div>
    <!-- ── END LEFT COLUMN ──────────────────────────── -->


    <!-- ── RIGHT SIDEBAR ─────────────────────────────── -->
    <div>

      <!-- Quick Info -->
      <div class="card">
        <div class="card-title">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none"
            stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"/>
            <line x1="12" y1="8" x2="12" y2="12"/>
            <line x1="12" y1="16" x2="12.01" y2="16"/>
          </svg>
          Quick Info
        </div>
        <div class="info-list">
          <!--
            Replace static values with EL expressions, e.g.:
            ${hackathon.status}, ${hackathon.eventType}, ${hackathon.payment},
            ${hackathon.minTeamSize}, ${hackathon.maxTeamSize},
            ${hackathon.registrationStartDate}, ${hackathon.registrationEndDate},
            ${hackathon.location}
          -->
          <div class="info-row">
            <span class="info-key">Status</span>
            <!-- Replace with dynamic badge from c:choose on hackathon.status -->
            <span class="info-val green">${hackathon.status}</span>
          </div>
          <div class="info-row">
            <span class="info-key">Type</span>
            <span class="info-val purple">${hackathon.eventType}</span>
          </div>
          <div class="info-row">
            <span class="info-key">Entry</span>
            <span class="info-val green">${hackathon.payment}</span>
          </div>
          <div class="info-row">
            <span class="info-key">Team Size</span>
            <span class="info-val cyan"> ${hackathon.minTeamSize} – ${hackathon.maxTeamSize}</span>
          </div>
          <div class="info-row">
            <span class="info-key">Reg. Opens</span>
            <span class="info-val">${hackathon.registrationStartDate}</span>
          </div>
          <div class="info-row">
            <span class="info-key">Reg. Closes</span>
            <span class="info-val">1${hackathon.registrationEndDate}</span>
          </div>
          <div class="info-row">
            <span class="info-key">Location</span>
            <span class="info-val">${hackathon.location}</span>
          </div>
          <div class="info-row">
            <span class="info-key">Teams Joined</span>
            <!-- Replace 42 with: ${teamCount} -->
            <span class="info-val amber">${teamCount}</span>
          </div>
        </div>
      </div>

      <!-- Sticky CTA repeat -->
      <div class="card" style="margin-top:20px; text-align:center;">
        <div class="card-title" style="justify-content:center; border:none; padding-bottom:12px; margin-bottom:12px;">
          Ready to compete?
        </div>
        <!--
          Same JSTL choose block as hero buttons — paste your dynamic version here
          so this sidebar CTA also responds to alreadyRegistered / pendingInvite / canJoin
        -->
        <div class="hero-actions">
          <c:choose>
            <c:when test="${alreadyRegistered}">
              <a href="/participant/hackathon/${hackathon.hackathonId}/team" class="btn-primary">Manage Team</a>
            </c:when>
            <c:when test="${not empty pendingInvite}">
              <form action="/participant/hackathon/${hackathon.hackathonId}/invite/${pendingInvite.hackathonTeamInviteId}/accept" method="post">
                <button type="submit" class="btn-primary">Accept Invitation</button>
              </form>
              <form action="/participant/hackathon/${hackathon.hackathonId}/invite/${pendingInvite.hackathonTeamInviteId}/reject" method="post">
                <button type="submit" class="btn-primary btn-danger">Reject</button>
              </form>
            </c:when>
            <c:when test="${canJoin}">
              <form action="/participant/hackathon/${hackathon.hackathonId}/join" method="post">
                <button type="submit" class="btn-primary">Join Hackathon
               		<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="white"
			            stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
			            <line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>
		        	</svg>
                </button>
              </form>
            </c:when>
            <c:otherwise>
              <button type="button" class="btn-primary" disabled>Join Hackathon</button>
            </c:otherwise>
          </c:choose>
      	</div>
        
        <button class="btn-primary" style="width:100%;">
          Join Hackathon
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="white"
            stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>
          </svg>
        </button>
        <p style="font-size:12px; color:var(--muted); margin-top:10px; line-height:1.5;">
          <!-- Replace: ${registrationOpen ? 'Registration is open.' : 'Registration is closed.'} -->
          ${registrationOpen ? 'Registration is open.' : 'Registration is closed.'}
        </p>
      </div>

    </div>
    <!-- ── END SIDEBAR ───────────────────────────────── -->

  </div>
  <!-- ═══ END BODY GRID ═══════════════════════════════════ -->

</div><!-- /page -->

<script>
// Subtle share button
document.querySelectorAll('.btn-ghost').forEach(function(btn) {
  btn.addEventListener('click', function() {
    if (navigator.share) {
      navigator.share({ title: document.title, url: window.location.href });
    } else {
      navigator.clipboard.writeText(window.location.href).then(function() {
        btn.textContent = '✓ Copied!';
        btn.style.color = '#4ade80';
        setTimeout(function() {
          btn.textContent = 'Share';
          btn.style.color = '';
        }, 2000);
      });
    }
  });
});
</script>

</body>
</html>