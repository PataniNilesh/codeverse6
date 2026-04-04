<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Hackathons</title>
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
/* Replace this block with: <%@ include file="ParticipantTopNav.jsp" %> */
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
.topnav-links a.active { color: #a78bfa; background: rgba(124,58,237,.15); }
/* ── END TOP NAV ─────────────────────────────────────────── */

/* ── Page shell ─────────────────────────────────────────── */
.page {
  position: relative; z-index: 1;
  max-width: 1200px;
  margin: 0 auto;
  padding: 28px 32px 60px;
}

/* ── Breadcrumb ─────────────────────────────────────────── */
.back-row {
  display: flex; align-items: center; gap: 8px;
  margin-bottom: 28px;
  font-family: 'Space Mono', monospace;
  font-size: 12px; color: var(--muted);
  animation: fadeUp .4s ease both;
}
.back-row a { color: var(--muted); text-decoration: none; transition: color .2s; }
.back-row a:hover { color: var(--text); }
.back-row span { color: var(--accent2); }

/* ── Page header ────────────────────────────────────────── */
.page-header {
  display: flex; align-items: flex-end;
  justify-content: space-between; gap: 16px;
  flex-wrap: wrap;
  margin-bottom: 28px;
  animation: fadeUp .5s .05s ease both;
}

.header-left {}
.page-title {
  font-size: 30px; font-weight: 800;
  letter-spacing: -.5px; line-height: 1.1;
}
.page-sub {
  font-size: 14px; color: var(--muted); margin-top: 6px;
}

/* Total count pill */
.count-pill {
  display: inline-flex; align-items: center; gap: 8px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 12px;
  padding: 10px 18px;
  font-family: 'Space Mono', monospace;
  font-size: 13px;
  color: var(--muted);
  flex-shrink: 0;
}
.count-pill strong {
  font-size: 22px; font-weight: 700;
  font-family: 'Space Mono', monospace;
  background: linear-gradient(135deg, var(--accent2), var(--accent));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* ── Cards grid ─────────────────────────────────────────── */
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 18px;
}

/* ── Hackathon Card ─────────────────────────────────────── */
.card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 18px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  gap: 0;
  position: relative;
  overflow: hidden;
  transition: transform .3s cubic-bezier(.4,0,.2,1), border-color .3s, box-shadow .3s;
  animation: fadeUp .5s ease both;
}

/* stagger animation delays */
.card:nth-child(1) { animation-delay: .08s; }
.card:nth-child(2) { animation-delay: .13s; }
.card:nth-child(3) { animation-delay: .18s; }
.card:nth-child(4) { animation-delay: .23s; }
.card:nth-child(5) { animation-delay: .28s; }
.card:nth-child(6) { animation-delay: .33s; }

/* Top accent line on hover */
.card::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0;
  height: 2px;
  background: linear-gradient(90deg, var(--accent), var(--accent2));
  opacity: 0;
  transition: opacity .3s;
}
.card:hover { transform: translateY(-5px); border-color: rgba(124,58,237,.4); box-shadow: 0 18px 48px rgba(0,0,0,.4); }
.card:hover::before { opacity: 1; }

/* Card top row: title + role badge */
.card-top {
  display: flex; align-items: flex-start;
  justify-content: space-between; gap: 12px;
  margin-bottom: 14px;
}

.card-title {
  font-size: 19px; font-weight: 800;
  line-height: 1.25;
  flex: 1; min-width: 0;
}

/* Role badge */
.role-badge {
  font-family: 'Space Mono', monospace;
  font-size: 10px; font-weight: 700;
  letter-spacing: 1px;
  padding: 4px 10px; border-radius: 100px;
  white-space: nowrap; flex-shrink: 0;
}
.role-leader {
  background: rgba(6,182,212,.12);
  color: #67e8f9;
  border: 1px solid rgba(6,182,212,.25);
}
.role-member {
  background: rgba(167,139,250,.12);
  color: #c4b5fd;
  border: 1px solid rgba(167,139,250,.25);
}

/* Chips row */
.chip-row {
  display: flex; flex-wrap: wrap; gap: 7px;
  margin-bottom: 14px;
}
.chip {
  font-family: 'Space Mono', monospace;
  font-size: 10px; font-weight: 700;
  letter-spacing: .5px;
  padding: 4px 10px; border-radius: 100px;
  background: var(--surface2);
  border: 1px solid var(--border);
  color: var(--muted);
}
/* status tints */
.chip-ongoing  { color: #4ade80; border-color: rgba(74,222,128,.25); background: rgba(74,222,128,.08); }
.chip-upcoming { color: #fbbf24; border-color: rgba(251,191,36,.25); background: rgba(251,191,36,.08); }
.chip-completed{ color: #94a3b8; border-color: rgba(148,163,184,.25); background: rgba(148,163,184,.08); }

/* Description */
.card-desc {
  color: #a6b6c8;
  font-size: 14px; line-height: 1.7;
  flex: 1;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  margin-bottom: 20px;
}

/* Divider */
.card-divider {
  height: 1px;
  background: var(--border);
  margin-bottom: 16px;
}

/* Action buttons */
.actions {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8px;
}

.btn {
  display: inline-flex; align-items: center; justify-content: center;
  gap: 6px;
  padding: 10px 12px;
  border-radius: 10px;
  font-family: 'Syne', sans-serif;
  font-size: 13px; font-weight: 700;
  text-decoration: none;
  border: none; cursor: pointer;
  transition: all .2s;
  white-space: nowrap;
}

.btn-details {
  background: var(--surface2);
  color: #cbd5e1;
  border: 1px solid var(--border);
}
.btn-details:hover { background: var(--border); color: var(--text); }

.btn-team {
  background: var(--accent);
  color: #fff;
  box-shadow: 0 2px 12px var(--glow);
}
.btn-team:hover { background: #6d28d9; transform: translateY(-1px); box-shadow: 0 6px 20px var(--glow); }

.btn-submission {
  background: rgba(15,118,110,.8);
  color: #5eead4;
  border: 1px solid rgba(15,118,110,.5);
}
.btn-submission:hover { background: #0f766e; color: #fff; }

.btn-leaderboard {
  background: rgba(29,78,216,.7);
  color: #93c5fd;
  border: 1px solid rgba(29,78,216,.4);
}
.btn-leaderboard:hover { background: #1d4ed8; color: #fff; }

.btn-disabled {
  background: rgba(51,65,85,.5);
  color: #64748b;
  cursor: not-allowed;
  pointer-events: none;
  border: 1px solid var(--border);
}

/* wide button (spans full grid width) */
.btn-wide { grid-column: 1 / -1; }

/* ── Empty state ─────────────────────────────────────────── */
.empty-state {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 20px;
  padding: 60px 32px;
  text-align: center;
  animation: fadeUp .5s .1s ease both;
}
.empty-icon {
  width: 72px; height: 72px;
  background: var(--surface2);
  border: 1px solid var(--border);
  border-radius: 20px;
  display: flex; align-items: center; justify-content: center;
  margin: 0 auto 20px;
}
.empty-title {
  font-size: 20px; font-weight: 800;
  margin-bottom: 8px;
}
.empty-sub {
  font-size: 14px; color: var(--muted); line-height: 1.6;
}
.empty-cta {
  display: inline-flex; align-items: center; gap: 8px;
  margin-top: 24px;
  background: var(--accent);
  color: #fff;
  border-radius: 12px;
  padding: 12px 28px;
  font-size: 14px; font-weight: 700;
  text-decoration: none;
  box-shadow: 0 4px 20px var(--glow);
  transition: all .25s;
}
.empty-cta:hover { background: #6d28d9; transform: translateY(-2px); }

/* ── Animations ─────────────────────────────────────────── */
@keyframes fadeUp {
  from { opacity:0; transform:translateY(18px); }
  to   { opacity:1; transform:translateY(0); }
}

/* ── Responsive ─────────────────────────────────────────── */
@media (max-width: 760px) {
  .page { padding: 20px 16px 48px; }
  .topnav { padding: 0 20px; }
  .grid { grid-template-columns: 1fr; }
  .page-title { font-size: 24px; }
}
@media (max-width: 480px) {
  .actions { grid-template-columns: 1fr; }
  .btn-wide { grid-column: 1; }
}
</style>
</head>
<body>

<!-- ═══════════════════════════════════════════════════════
     TOP NAV
     Replace this entire block with:
     <%@ include file="ParticipantTopNav.jsp" %>
     ═══════════════════════════════════════════════════════ -->
 <%@ include file="ParticipantTopNav.jsp" %>
<!-- ═══ END TOP NAV ══════════════════════════════════════ -->


<div class="page">

  <!-- Breadcrumb -->
  <div class="back-row">
    <a href="/participant/home">← Home</a>
    <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor"
      stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <polyline points="9 18 15 12 9 6"/>
    </svg>
    <span>My Hackathons</span>
  </div>

  <!-- Page header -->
  <div class="page-header">
    <div class="header-left">
      <h1 class="page-title">My Hackathons</h1>
      <p class="page-sub">All hackathons where you are part of a team.</p>
    </div>

    <!-- Total count pill -->
    <!-- Replace the static "4" with: ${totalCount} -->
    <div class="count-pill">
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
      </svg>
      <strong>${totalCount}</strong> Joined
    </div>
  </div>


  <!-- ═══════════════════════════════════════════════════
       CARD GRID
       Replace this static block with a JSTL c:choose:

       <c:choose>
         <c:when test="${empty myHackathons}">
           ... empty state div ...
         </c:when>
         <c:otherwise>
           <div class="grid">
             <c:forEach items="${myHackathons}" var="m">
               ... card article ...
             </c:forEach>
           </div>
         </c:otherwise>
       </c:choose>
       ═══════════════════════════════════════════════════ -->
	<c:choose>
		<!-- EMPTY STATE -->
		<c:when test="${empty myHackathons}">
			<div class="empty-state">
			    <div class="empty-icon">
			      <svg width="28" height="28" viewBox="0 0 24 24" fill="none"
			        stroke="#64748b" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
			        <polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/>
			      </svg>
			    </div>
			    <div class="empty-title">No joined hackathons yet</div>
			    <div class="empty-sub">
			      Join a hackathon from the home page<br>and it will appear here.
			    </div>
			    <a href="/participant/home" class="empty-cta">
			      Browse Hackathons
			      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="white"
			        stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
			        <line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>
			      </svg>
			    </a>
		  	</div>
		</c:when>
		
		<!-- GRID -->
		<c:otherwise>
           <div class="grid">
             <c:forEach items="${myHackathons}" var="m">
             	<article class="card">
             		<div class="card-top">
             			<div class="card-title">
             				${m.hackathon.title}
             			</div>
             			<span class="role-badge ${m.leader ? 'role-leader' : 'role-member'}">
				            ${m.leader ? 'Team Leader' : m.roleTitle}
			          	</span>
             		</div>
             		
             		<!-- CHIPS -->
             		<div class="chip-row">
             			<span class="chip chip-${fn:toLowerCase(m.hackathon.status)}">${m.hackathon.status}</span>
			          	<span class="chip">${m.hackathon.eventType}</span>
			          	<span class="chip">${m.teamSize} members</span>
			          	<span class="chip">${m.pendingInvites} pending invites</span>
             		</div>
             		
             		<!-- DESCRIPTION -->
             		<p class="card-desc">
		        		${m.hackathon.description}
			      	</p>
			      	
			      	<div class="card-divider"></div>
			      	
			      	<!-- ACTIONS -->
			      	<div class="actions">
			      	
			      		<!-- VIEW DETAILS -->
			      		<a class="btn btn-details" href="/participant/hackathon/${m.hackathon.hackathonId}">
				          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor"
				            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
				            <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
				          </svg>
				          View Details
				        </a>
				        
				        <!-- TEAM -->
				        <a class="btn btn-team" href="/participant/hackathon/${m.hackathon.hackathonId}/team">
				          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="white"
				            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
				            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
				            <circle cx="9" cy="7" r="4"/>
				            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
				            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
				          </svg>
				          Manage Team
				        </a>
				        
				        <!-- SUBMISSION -->
				        <c:if test="${not empty m.teamId}">
				        	<c:choose>
		        				<c:when test="${m.submissionEnabled}">
		        					<a class="btn btn-submission" href="/participant/hackathon/${m.hackathon.hackathonId}/submission">
							          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor"
							            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
							            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
							            <polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/>
							          </svg>
							          Submission
							        </a>
			              		</c:when>
				              	
				              	<c:otherwise>
				                	<span class="btn btn-disabled" title="Submission opens after registration end date">Submission</span>
		              			</c:otherwise>
				        	</c:choose>
				        </c:if>
				        
				        <!-- LEADERBOARD -->
				        <c:if test="${m.hackathon.leaderboardPublished}">
			            	<a class="btn btn-leaderboard" href="/participant/leaderboard/${m.hackathon.hackathonId}">
					          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor"
					            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					            <line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/>
					            <line x1="6" y1="20" x2="6" y2="14"/>
					          </svg>
					          Leaderboard
					        </a>
			          	</c:if>
			          </div>	
             	</article>
             </c:forEach>
           </div>
       	</c:otherwise>    
	</c:choose>
	
  <!-- ═══ END CARD GRID ════════════════════════════════════ -->



</div><!-- /page -->

</body>
</html>