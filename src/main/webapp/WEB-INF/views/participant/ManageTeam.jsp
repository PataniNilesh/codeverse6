<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Team | Hackathon Title</title>
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

body::before {
  content: '';
  position: fixed; inset: 0;
  background-image:
    linear-gradient(rgba(124,58,237,.04) 1px, transparent 1px),
    linear-gradient(90deg, rgba(124,58,237,.04) 1px, transparent 1px);
  background-size: 40px 40px;
  pointer-events: none; z-index: 0;
}

/* ── Top Nav placeholder ─────────────────────────────────
   Replace this block with: <%@ include file="ParticipantTopNav.jsp" %>  */
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
.topnav-links { display: flex; gap: 6px; }
.topnav-links a {
  color: var(--muted); text-decoration: none;
  font-size: 14px; font-weight: 600;
  padding: 8px 16px; border-radius: 8px; transition: all .2s;
}
.topnav-links a:hover { color: var(--text); background: var(--surface2); }
.topnav-links a.active { color: #a78bfa; background: rgba(124,58,237,.15); }
/* ── END TOP NAV ─────────────────────────────────────────── */

/* ── Page shell ─────────────────────────────────────────── */
.page {
  position: relative; z-index: 1;
  max-width: 1100px;
  margin: 0 auto;
  padding: 28px 32px 60px;
}

/* ── Breadcrumb ─────────────────────────────────────────── */
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

/* ── Page header ────────────────────────────────────────── */
.page-header {
  display: flex; align-items: flex-end;
  justify-content: space-between; gap: 16px;
  flex-wrap: wrap;
  margin-bottom: 24px;
  animation: fadeUp .5s .05s ease both;
}
.page-title  { font-size: 28px; font-weight: 800; letter-spacing: -.5px; }
.page-sub    { font-size: 14px; color: var(--muted); margin-top: 5px; }

/* Member capacity pill */
.capacity-pill {
  display: inline-flex; align-items: center; gap: 10px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 14px; padding: 10px 20px;
  font-family: 'Space Mono', monospace;
  font-size: 12px; color: var(--muted);
  flex-shrink: 0;
}
.capacity-pill strong {
  font-size: 20px; font-weight: 700;
  background: linear-gradient(135deg, var(--accent2), var(--accent));
  -webkit-background-clip: text; -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* ── Alert messages ─────────────────────────────────────── */
.alerts { margin-bottom: 20px; display: flex; flex-direction: column; gap: 8px; }
.alert {
  padding: 12px 16px;
  border-radius: 10px;
  font-size: 14px; line-height: 1.5;
  display: flex; align-items: center; gap: 10px;
}
.alert-success {
  background: rgba(34,197,94,.12);
  border: 1px solid rgba(34,197,94,.35); color: #86efac;
}
.alert-error {
  background: rgba(239,68,68,.1);
  border: 1px solid rgba(239,68,68,.3); color: #fca5a5;
}
/*
  Replace each static alert with a JSTL c:if, e.g.:
  <c:if test="${success == 'memberInvited'}">
    <div class="alert alert-success">✓ Invitation sent. They must accept to join.</div>
  </c:if>

  Full list of success keys:  memberInvited | externalInvited | memberRemoved |
                               teamCreated | teamJoined | inviteAccepted | inviteRejected
  Full list of error keys:    teamFull | invalidUser | alreadyInHackathon | invalidTeamName |
                               invalidTeam | invalidEmail | inviteExists | inviteNotFound |
                               inviteInvalid | submissionClosed | inviteClosed |
                               notLeader | cannotRemoveLeader | memberNotFound
*/

/* ── Layout grid ────────────────────────────────────────── */
.layout {
  display: grid;
  grid-template-columns: 1.2fr .8fr;
  gap: 18px;
  align-items: start;
}
.col-left  { display: flex; flex-direction: column; gap: 18px; }
.col-right { display: flex; flex-direction: column; gap: 18px; }

/* ── Generic card ───────────────────────────────────────── */
.card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 18px;
  padding: 24px 26px;
  animation: fadeUp .5s ease both;
}
.card:nth-child(1) { animation-delay: .08s; }
.card:nth-child(2) { animation-delay: .13s; }
.card:nth-child(3) { animation-delay: .18s; }
.card:nth-child(4) { animation-delay: .23s; }

.card-title {
  display: flex; align-items: center; gap: 9px;
  font-size: 12px; font-weight: 700;
  letter-spacing: 2px; text-transform: uppercase;
  font-family: 'Space Mono', monospace; color: var(--muted);
  padding-bottom: 16px; border-bottom: 1px solid var(--border);
  margin-bottom: 18px;
}

/* ── Table ──────────────────────────────────────────────── */
.tbl-wrap { overflow-x: auto; }
table {
  width: 100%; border-collapse: collapse;
}
thead th {
  font-family: 'Space Mono', monospace;
  font-size: 10px; font-weight: 700;
  letter-spacing: 1.2px; text-transform: uppercase;
  color: var(--muted);
  padding: 0 10px 10px;
  border-bottom: 1px solid var(--border);
  text-align: left; white-space: nowrap;
}
tbody td {
  padding: 12px 10px;
  border-bottom: 1px solid var(--border);
  font-size: 14px; color: var(--text);
  vertical-align: middle;
}
tbody tr:last-child td { border-bottom: none; }
tbody tr:hover td { background: rgba(124,58,237,.04); }

/* member avatar */
.member-cell { display: flex; align-items: center; gap: 10px; }
.mini-avatar {
  width: 32px; height: 32px; border-radius: 8px; flex-shrink: 0;
  background: linear-gradient(135deg, var(--accent), var(--accent2));
  display: flex; align-items: center; justify-content: center;
  font-size: 11px; font-weight: 700; color: #fff;
  font-family: 'Space Mono', monospace;
}
.member-name  { font-weight: 700; font-size: 14px; }
.member-email { font-size: 12px; color: var(--muted); }

/* role pill */
.role-pill {
  font-family: 'Space Mono', monospace;
  font-size: 10px; font-weight: 700; letter-spacing: .8px;
  padding: 3px 10px; border-radius: 100px;
}
.role-leader {
  background: rgba(6,182,212,.12); color: #67e8f9;
  border: 1px solid rgba(6,182,212,.25);
}
.role-member {
  background: rgba(167,139,250,.12); color: #c4b5fd;
  border: 1px solid rgba(167,139,250,.25);
}

/* invite status pill */
.status-pill {
  font-family: 'Space Mono', monospace;
  font-size: 10px; font-weight: 700; letter-spacing: .8px;
  padding: 3px 10px; border-radius: 100px;
}
.status-pending  { background: rgba(251,191,36,.1);  color: #fbbf24; border: 1px solid rgba(251,191,36,.25); }
.status-accepted { background: rgba(74,222,128,.1);  color: #4ade80; border: 1px solid rgba(74,222,128,.25); }
.status-rejected { background: rgba(248,113,113,.1); color: #f87171; border: 1px solid rgba(248,113,113,.25); }

/* empty table row */
.empty-row td {
  color: var(--muted); font-size: 13px;
  font-style: italic; text-align: center;
  padding: 20px 10px;
}

/* ── Form fields ─────────────────────────────────────────── */
.field { display: flex; flex-direction: column; gap: 7px; margin-bottom: 14px; }
.field:last-of-type { margin-bottom: 0; }
.field label {
  font-size: 11px; font-weight: 700;
  font-family: 'Space Mono', monospace;
  letter-spacing: .5px; text-transform: uppercase; color: #8a9ab0;
}
.field input,
.field select {
  width: 100%; height: 44px; padding: 0 14px;
  background: var(--surface2);
  border: 1px solid var(--border);
  border-radius: 10px; color: var(--text);
  font-size: 14px; font-family: 'Syne', sans-serif;
  outline: none; transition: border-color .2s, box-shadow .2s;
  appearance: none;
}
.field input:focus,
.field select:focus {
  border-color: var(--accent);
  box-shadow: 0 0 0 3px rgba(124,58,237,.18);
}
.field input::placeholder { color: var(--muted); }
.field select {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%2364748b' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
  background-repeat: no-repeat; background-position: right 14px center;
  padding-right: 36px; cursor: pointer;
}
.field select option { background: var(--surface2); }

.hint {
  font-size: 12px; color: var(--muted);
  line-height: 1.5; margin-top: 10px;
}

/* ── Buttons ─────────────────────────────────────────────── */
.btn-row { display: flex; gap: 10px; flex-wrap: wrap; margin-top: 14px; }

.btn {
  display: inline-flex; align-items: center; justify-content: center; gap: 7px;
  padding: 11px 20px;
  border: none; border-radius: 10px;
  font-family: 'Syne', sans-serif; font-size: 13px; font-weight: 700;
  cursor: pointer; transition: all .2s; text-decoration: none; white-space: nowrap;
}
.btn-primary {
  background: var(--accent); color: #fff;
  box-shadow: 0 3px 14px var(--glow);
}
.btn-primary:hover { background: #6d28d9; transform: translateY(-1px); box-shadow: 0 6px 20px var(--glow); }

.btn-danger {
  background: rgba(127,29,29,.8); color: #fca5a5;
  border: 1px solid rgba(239,68,68,.3);
}
.btn-danger:hover { background: #991b1b; }

.btn-ghost {
  background: var(--surface2); color: var(--muted);
  border: 1px solid var(--border);
}
.btn-ghost:hover { color: var(--text); border-color: var(--accent); }

/* remove button inside table */
.btn-remove {
  padding: 6px 14px; font-size: 12px;
  background: rgba(127,29,29,.7); color: #fca5a5;
  border: 1px solid rgba(239,68,68,.25);
  border-radius: 8px;
  font-family: 'Syne', sans-serif; font-weight: 700;
  cursor: pointer; transition: all .2s;
}
.btn-remove:hover { background: #991b1b; }

/* ── Invitation card (pending invite) ───────────────────── */
.invite-banner {
  background: linear-gradient(135deg, rgba(124,58,237,.15), rgba(6,182,212,.1));
  border: 1px solid rgba(124,58,237,.35);
  border-radius: 18px; padding: 24px 26px;
  animation: fadeUp .5s .05s ease both;
}
.invite-banner .card-title { border-color: rgba(124,58,237,.25); }
.invite-team-name {
  font-size: 18px; font-weight: 800; color: var(--text);
  margin-bottom: 6px;
}
.invite-sub { font-size: 14px; color: var(--muted); margin-bottom: 16px; }

/* ── Disabled / info card ───────────────────────────────── */
.card-disabled {
  background: rgba(19,19,26,.6);
  border: 1px dashed var(--border);
  border-radius: 18px; padding: 24px 26px;
  text-align: center;
  animation: fadeUp .5s ease both;
}
.card-disabled p { font-size: 14px; color: var(--muted); line-height: 1.6; }

/* ── Animations ─────────────────────────────────────────── */
@keyframes fadeUp {
  from { opacity:0; transform:translateY(16px); }
  to   { opacity:1; transform:translateY(0); }
}

/* ── Responsive ─────────────────────────────────────────── */
@media (max-width: 900px) {
  .layout { grid-template-columns: 1fr; }
  .page { padding: 20px 16px 48px; }
  .topnav { padding: 0 20px; }
}
</style>
</head>
<body>

<!-- ═══════════════════════════════════════════════════════
     TOP NAV
     Replace with: <%@ include file="ParticipantTopNav.jsp" %>
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
    <a href="/participant/my-hackathons">My Hackathons</a>
    <a href="#" class="active">Team</a>
  </div>
</nav>
<!-- ═══ END TOP NAV ══════════════════════════════════════ -->


<div class="page">

  <!-- Breadcrumb -->
  <div class="back-row">
    <a href="/participant/home">Home</a>
    <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor"
      stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
    <!--
      Replace href with: /participant/hackathon/${hackathon.hackathonId}
      Replace link text with: ${hackathon.title}
    -->
    <a href="/participant/hackathon/1">Hackathon Title</a>
    <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor"
      stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
    <span>Manage Team</span>
  </div>

  <!-- Page header -->
  <div class="page-header">
    <div>
      <h1 class="page-title">Manage Team</h1>
      <!-- Replace static text with: ${hackathon.title} -->
      <p class="page-sub">Global AI Hackathon 2025</p>
    </div>
    <!-- Replace 3 with: ${teamSizeCount}   Replace 4 with: ${teamMaxSize} -->
    <div class="capacity-pill">
      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor"
        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
        <circle cx="9" cy="7" r="4"/>
        <path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
      </svg>
      <strong>3</strong> / 4 Members
    </div>
  </div>

  <!-- ─────────────────────────────────────────────────────
       ALERT MESSAGES
       Replace each static alert with a JSTL c:if block.

       SUCCESS keys: memberInvited | externalInvited | memberRemoved |
                     teamCreated | teamJoined | inviteAccepted | inviteRejected
       ERROR keys:   teamFull | invalidUser | alreadyInHackathon | invalidTeamName |
                     invalidTeam | invalidEmail | inviteExists | inviteNotFound |
                     inviteInvalid | submissionClosed | inviteClosed |
                     notLeader | cannotRemoveLeader | memberNotFound

       Example:
       <c:if test="${success == 'teamCreated'}">
         <div class="alert alert-success">✓ Team created. You are now team leader.</div>
       </c:if>
       ───────────────────────────────────────────────────── -->
  <div class="alerts">
    <div class="alert alert-success">✓ Invitation sent to participant. They must accept to join.</div>
    <!-- <div class="alert alert-error">✕ Your team is full. You cannot add more members.</div> -->
  </div>


  <!-- ═══════════════════════════════════════════════════════════════
       SCENARIO A — hasTeam is FALSE
       Wrap the two cards below with: <c:if test="${not hasTeam}">

       SCENARIO A1 — pending invite exists
       Wrap invite-banner with: <c:if test="${not empty pendingInvite}">
       ═══════════════════════════════════════════════════════════════ -->

  <!-- Pending invite banner -->
  <!--
  <div class="invite-banner">
    <div class="card-title">
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#a78bfa"
        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 10.23 19.79 19.79 0 0 1 1.62 1.67 2 2 0 0 1 3.62 0h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 7.91a16 16 0 0 0 6 6l.91-.91a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 15z"/>
      </svg>
      Pending Team Invitation
    </div>
    <div class="invite-team-name">
      Team Name Here
      Replace with: ${pendingInviteTeam != null ? pendingInviteTeam.teamName : 'a team'}
    </div>
    <p class="invite-sub">You have been invited to join this team. Accept to become a member.</p>
    <div class="btn-row">
      Replace action hrefs with actual form POST actions:
      /participant/hackathon/${hackathon.hackathonId}/team/invite/${pendingInvite.hackathonTeamInviteId}/accept
      /participant/hackathon/${hackathon.hackathonId}/team/invite/${pendingInvite.hackathonTeamInviteId}/reject
      <button class="btn btn-primary">Accept Invitation</button>
      <button class="btn btn-danger">Reject Invitation</button>
    </div>
  </div>
  -->

  <!-- No-team layout: Create + Join side by side -->
  <!--
  <div class="layout" style="margin-bottom:0;">
    <div class="col-left">
  -->

      <!-- Create Team card -->
      <!--
      <div class="card">
        <div class="card-title">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#a78bfa"
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"/>
            <line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/>
          </svg>
          Create Your Team
        </div>
        <form action="/participant/hackathon/${hackathon.hackathonId}/team/create" method="post">
          <div class="field">
            <label>Team Name</label>
            <input type="text" name="teamName" placeholder="Enter a unique team name" required>
          </div>
          <div class="btn-row">
            <button type="submit" class="btn btn-primary">Create Team</button>
          </div>
        </form>
        <p class="hint">You can create only one team per hackathon.</p>
      </div>
      -->

    <!--
    </div>
    <div class="col-right">
    -->

      <!-- Join Existing Team card -->
      <!--
      <div class="card">
        <div class="card-title">
          <svg width="13" height="13" ...> ... </svg>
          Join Existing Team
        </div>
        No teams available:
        <p class="hint">No open teams available to join right now.</p>

        Teams available — wrap select in: <c:if test="${not empty availableTeams}">
        <form action="/participant/hackathon/${hackathon.hackathonId}/team/join-existing" method="post">
          <div class="field">
            <label>Select Team</label>
            <select name="joinTeamId" required>
              <option value="">Choose a team</option>
              Loop: <c:forEach items="${availableTeams}" var="t">
                <option value="${t.hackathonTeamId}">${t.teamName}</option>
              </c:forEach>
            </select>
          </div>
          <div class="btn-row">
            <button type="submit" class="btn btn-primary">Join Team</button>
          </div>
        </form>
        <p class="hint">After joining, you cannot create another team in this hackathon.</p>
      </div>
      -->

    <!--
    </div>
  </div>
  -->
  <!-- ═══ END SCENARIO A ═══════════════════════════════════ -->


  <!-- ═══════════════════════════════════════════════════════════════
       SCENARIO B — hasTeam is TRUE
       Wrap the layout below with: <c:if test="${hasTeam}">
       ═══════════════════════════════════════════════════════════════ -->
  <div class="layout">

    <!-- ── LEFT: Team members table ── -->
    <div class="col-left">

      <div class="card">
        <div class="card-title">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b"
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
            <circle cx="9" cy="7" r="4"/>
            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
          </svg>
          Team Members
        </div>

        <div class="tbl-wrap">
          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>Member</th>
                <th>Role</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <!--
                Replace static rows with a JSTL forEach:
                <c:forEach items="${teamMembers}" var="m" varStatus="i">
                  <tr>
                    <td>${i.count}</td>
                    <td>
                      <div class="member-cell">
                        <div class="mini-avatar">
                          First letter of name: ${fn:substring(memberMap[m.memberId].firstName,0,1)}
                        </div>
                        <div>
                          <div class="member-name">
                            ${memberMap[m.memberId].firstName} ${memberMap[m.memberId].lastName}
                          </div>
                          <div class="member-email">${memberMap[m.memberId].email}</div>
                        </div>
                      </div>
                    </td>
                    <td>
                      <span class="role-pill ${m.memberId == team.teamLeaderId ? 'role-leader' : 'role-member'}">
                        ${m.roleTitle}
                      </span>
                    </td>
                    <td>
                      Wrap with: <c:when test="${isTeamLeader and m.memberId != team.teamLeaderId}">
                      <form action="/participant/hackathon/${hackathon.hackathonId}/team/remove-member" method="post">
                        <input type="hidden" name="memberId" value="${m.memberId}">
                        <button type="submit" class="btn-remove" onclick="return confirm('Remove this member?')">
                          Remove
                        </button>
                      </form>
                      Otherwise show: -
                    </td>
                  </tr>
                </c:forEach>
              -->

              <!-- Static sample rows for UI reference -->
              <tr>
                <td>1</td>
                <td>
                  <div class="member-cell">
                    <div class="mini-avatar">JD</div>
                    <div>
                      <div class="member-name">John Doe</div>
                      <div class="member-email">john.doe@example.com</div>
                    </div>
                  </div>
                </td>
                <td><span class="role-pill role-leader">LEADER</span></td>
                <td><span style="color:var(--muted);">—</span></td>
              </tr>
              <tr>
                <td>2</td>
                <td>
                  <div class="member-cell">
                    <div class="mini-avatar">PR</div>
                    <div>
                      <div class="member-name">Priya Rao</div>
                      <div class="member-email">priya.rao@example.com</div>
                    </div>
                  </div>
                </td>
                <td><span class="role-pill role-member">MEMBER</span></td>
                <td>
                  <!--
                    Wrap with confirm dialog via onclick:
                    onclick="return confirm('Remove this member from your team?')"
                    form action="/participant/hackathon/${hackathon.hackathonId}/team/remove-member"
                    hidden input name="memberId" value="${m.memberId}"
                  -->
                  <button class="btn-remove">Remove</button>
                </td>
              </tr>
              <tr>
                <td>3</td>
                <td>
                  <div class="member-cell">
                    <div class="mini-avatar">AK</div>
                    <div>
                      <div class="member-name">Arjun Kumar</div>
                      <div class="member-email">arjun.k@example.com</div>
                    </div>
                  </div>
                </td>
                <td><span class="role-pill role-member">MEMBER</span></td>
                <td><button class="btn-remove">Remove</button></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Invite Activity -->
      <div class="card">
        <div class="card-title">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b"
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 10.23 19.79 19.79 0 0 1 1.62 1.67 2 2 0 0 1 3.62 0h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 7.91a16 16 0 0 0 6 6l.91-.91a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 15z"/>
          </svg>
          Invite Activity
        </div>

        <div class="tbl-wrap">
          <table>
            <thead>
              <tr>
                <th>Type</th>
                <th>Invitee</th>
                <th>Status</th>
                <th>Sent On</th>
              </tr>
            </thead>
            <tbody>
              <!--
                Replace with JSTL c:choose:
                <c:when test="${empty inviteList}">
                  <tr class="empty-row"><td colspan="4">No invites sent yet.</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach items="${inviteList}" var="i">
                    <tr>
                      <td>${i.inviteType}</td>
                      <td>
                        <c:choose>
                          <c:when test="${not empty i.invitedEmail}">${i.invitedEmail}</c:when>
                          <c:otherwise>User #${i.invitedUserId}</c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <span class="status-pill status-${fn:toLowerCase(i.inviteStatus)}">
                          ${i.inviteStatus}
                        </span>
                      </td>
                      <td>${i.createdAt}</td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              -->

              <!-- Static sample rows -->
              <tr>
                <td>REGISTERED</td>
                <td>priya.rao@example.com</td>
                <td><span class="status-pill status-accepted">ACCEPTED</span></td>
                <td>20 Apr 2025</td>
              </tr>
              <tr>
                <td>EXTERNAL</td>
                <td>new.dev@gmail.com</td>
                <td><span class="status-pill status-pending">PENDING</span></td>
                <td>21 Apr 2025</td>
              </tr>
              <tr>
                <td>REGISTERED</td>
                <td>User #42</td>
                <td><span class="status-pill status-rejected">REJECTED</span></td>
                <td>21 Apr 2025</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

    </div>
    <!-- ── END LEFT ──────────────────────────────────────── -->


    <!-- ── RIGHT: Invite forms ── -->
    <div class="col-right">

      <!--
        SCENARIO B1 — isTeamLeader AND inviteAllowed
        Wrap both invite cards with:
        <c:if test="${hasTeam and isTeamLeader and inviteAllowed}">

        SCENARIO B2 — isTeamLeader AND NOT inviteAllowed
        <c:if test="${hasTeam and isTeamLeader and not inviteAllowed}">
          Show disabled card below.

        SCENARIO B3 — NOT isTeamLeader
        <c:if test="${hasTeam and not isTeamLeader}">
          Show disabled card below.
      -->

      <!-- Invite Registered Participant -->
      <div class="card">
        <div class="card-title">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b"
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
            <circle cx="12" cy="7" r="4"/>
            <line x1="19" y1="8" x2="19" y2="14"/><line x1="22" y1="11" x2="16" y2="11"/>
          </svg>
          Invite Registered Participant
        </div>

        <!--
          form action="/participant/hackathon/${hackathon.hackathonId}/team/invite-member"
          method="post"
        -->
        <form action="/participant/hackathon/1/team/invite-member" method="post">
          <div class="field">
            <label>Select Participant</label>
            <select name="invitedUserId" required>
              <option value="">Choose participant</option>
              <!--
                Replace options with JSTL forEach:
                <c:forEach items="${participantUsers}" var="u">
                  <option value="${u.userId}">
                    ${u.firstName} ${u.lastName} — ${u.email}
                  </option>
                </c:forEach>
              -->
              <option value="5">Rohit Sharma — rohit.s@example.com</option>
              <option value="6">Sneha Patel — sneha.p@example.com</option>
              <option value="7">Dev Mehta — dev.m@example.com</option>
            </select>
          </div>
          <div class="btn-row">
            <button type="submit" class="btn btn-primary">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="white"
                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="22" y1="2" x2="11" y2="13"/>
                <polygon points="22 2 15 22 11 13 2 9 22 2"/>
              </svg>
              Send Invite
            </button>
          </div>
        </form>
        <p class="hint">Invite goes to pending state until the participant accepts it.</p>
      </div>

      <!-- Invite External User -->
      <div class="card">
        <div class="card-title">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b"
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
            <polyline points="22,6 12,13 2,6"/>
          </svg>
          Invite External User
        </div>

        <!--
          form action="/participant/hackathon/${hackathon.hackathonId}/team/invite-external"
          method="post"
        -->
        <form action="/participant/hackathon/1/team/invite-external" method="post">
          <div class="field">
            <label>External Email</label>
            <input type="email" name="externalEmail" placeholder="name@example.com" required>
          </div>
          <div class="field">
            <label>Role Title</label>
            <input type="text" name="roleTitle" placeholder="MEMBER">
          </div>
          <div class="btn-row">
            <button type="submit" class="btn btn-primary">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="white"
                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="22" y1="2" x2="11" y2="13"/>
                <polygon points="22 2 15 22 11 13 2 9 22 2"/>
              </svg>
              Send External Invite
            </button>
          </div>
        </form>
        <p class="hint">External invite is stored as pending until accepted manually.</p>
      </div>

      <!-- Disabled invite card — show when inviteAllowed=false OR not leader -->
      <!--
      <div class="card-disabled">
        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#64748b"
          stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
          style="margin:0 auto 10px;display:block;">
          <rect x="3" y="11" width="18" height="11" rx="2"/>
          <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
        </svg>
        Use one of:
        <p>Invitations are disabled because registration has ended.</p>
        <p>Only the team leader can send invitations.</p>
      </div>
      -->

    </div>
    <!-- ── END RIGHT ─────────────────────────────────────── -->

  </div>
  <!-- ═══ END SCENARIO B ═══════════════════════════════════ -->

</div><!-- /page -->

</body>
</html>