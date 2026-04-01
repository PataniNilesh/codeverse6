<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile</title>
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
/* Replace this entire block with: <%@ include file="ParticipantTopNav.jsp" %> */
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
/* ── END TOP NAV ────────────────────────────────────────── */

/* ── Page shell ─────────────────────────────────────────── */
.page {
  position: relative; z-index: 1;
  max-width: 980px;
  margin: 0 auto;
  padding: 28px 32px 60px;
}

/* ── Breadcrumb / back ──────────────────────────────────── */
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
  display: flex; align-items: center; gap: 20px;
  margin-bottom: 28px;
  animation: fadeUp .5s .05s ease both;
}

.avatar {
  width: 72px; height: 72px; flex-shrink: 0;
  border-radius: 18px;
  background: linear-gradient(135deg, var(--accent), var(--accent2));
  display: flex; align-items: center; justify-content: center;
  font-size: 28px; font-weight: 800; color: #fff;
  border: 2px solid rgba(124,58,237,.4);
  box-shadow: 0 0 24px var(--glow);
  /* Replace "JD" with the user's initials dynamically */
  font-family: 'Space Mono', monospace;
}

.header-text {}
.header-title {
  font-size: 28px; font-weight: 800;
  letter-spacing: -.5px; line-height: 1.1;
}
.header-sub {
  font-size: 14px; color: var(--muted);
  margin-top: 5px;
}

/* ── Alert messages ─────────────────────────────────────── */
.alert {
  padding: 13px 16px;
  border-radius: 12px;
  font-size: 14px; line-height: 1.5;
  margin-bottom: 20px;
  display: flex; align-items: center; gap: 10px;
  animation: fadeUp .4s ease both;
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

/*
  ALERT USAGE — replace the static alerts above with JSTL:

  <c:if test="${success == 'updated'}">
    <div class="alert alert-success">
      <svg .../>  ✓ Profile updated successfully.
    </div>
  </c:if>
  <c:if test="${error == 'invalidName'}">
    <div class="alert alert-error">
      <svg .../>  ✕ First name and last name are required.
    </div>
  </c:if>
*/

/* ── Form card ──────────────────────────────────────────── */
.form-card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 20px;
  overflow: hidden;
  animation: fadeUp .5s .1s ease both;
}

/* Section within the form card */
.form-section {
  padding: 26px 30px;
  border-bottom: 1px solid var(--border);
}
.form-section:last-of-type { border-bottom: none; }

.section-label {
  display: flex; align-items: center; gap: 9px;
  font-size: 11px; font-weight: 700;
  letter-spacing: 2px; text-transform: uppercase;
  font-family: 'Space Mono', monospace;
  color: var(--muted);
  margin-bottom: 20px;
  padding-bottom: 14px;
  border-bottom: 1px solid var(--border);
}

/* ── Grid ────────────────────────────────────────────────── */
.grid-2 {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}
.grid-3 {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 16px;
}
.col-full { grid-column: 1 / -1; }

/* ── Field group ─────────────────────────────────────────── */
.field {
  display: flex; flex-direction: column; gap: 7px;
}

.field label {
  font-size: 12px; font-weight: 700;
  color: #8a9ab0;
  font-family: 'Space Mono', monospace;
  letter-spacing: .5px;
  text-transform: uppercase;
}

.field input,
.field select {
  width: 100%;
  height: 44px;
  padding: 0 14px;
  background: var(--surface2);
  border: 1px solid var(--border);
  border-radius: 10px;
  color: var(--text);
  font-size: 14px;
  font-family: 'Syne', sans-serif;
  outline: none;
  transition: border-color .2s, box-shadow .2s;
  appearance: none;
}

.field input:focus,
.field select:focus {
  border-color: var(--accent);
  box-shadow: 0 0 0 3px rgba(124,58,237,.18);
}

.field input::placeholder { color: var(--muted); }

/* Read-only field */
.field input[readonly] {
  opacity: .6;
  cursor: not-allowed;
  background: rgba(10,10,15,.6);
}

/* Select arrow */
.field select {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%2364748b' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 14px center;
  padding-right: 36px;
}
.field select option { background: var(--surface2); }

/* ── Form footer ─────────────────────────────────────────── */
.form-footer {
  padding: 20px 30px;
  display: flex; align-items: center;
  justify-content: space-between; gap: 12px;
  flex-wrap: wrap;
  background: rgba(10,10,15,.4);
  border-top: 1px solid var(--border);
}

.footer-note {
  font-size: 12px; color: var(--muted);
  font-family: 'Space Mono', monospace;
}

.btn-save {
  display: inline-flex; align-items: center; gap: 8px;
  background: var(--accent);
  color: #fff;
  border: none; border-radius: 10px;
  padding: 12px 28px;
  font-family: 'Syne', sans-serif;
  font-size: 14px; font-weight: 700;
  cursor: pointer;
  transition: all .25s;
  box-shadow: 0 4px 20px var(--glow);
}
.btn-save:hover {
  background: #6d28d9;
  transform: translateY(-2px);
  box-shadow: 0 8px 28px var(--glow);
}

/* ── Animations ─────────────────────────────────────────── */
@keyframes fadeUp {
  from { opacity:0; transform:translateY(16px); }
  to   { opacity:1; transform:translateY(0); }
}

/* ── Responsive ─────────────────────────────────────────── */
@media (max-width: 760px) {
  .page { padding: 20px 16px 48px; }
  .grid-2, .grid-3 { grid-template-columns: 1fr; }
  .col-full { grid-column: 1; }
  .topnav { padding: 0 20px; }
  .form-section { padding: 20px; }
  .form-footer { flex-direction: column; align-items: stretch; text-align: center; }
  .btn-save { width: 100%; justify-content: center; }
  .header-title { font-size: 22px; }
}
</style>
</head>
<body>

<!-- ═══════════════════════════════════════════════════════
     TOP NAV
     Replace the entire block below with:
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
    <span>My Profile</span>
  </div>

  <!-- Page header with avatar -->
  <div class="page-header">
    <div class="avatar" id="avatarEl">
      <!--
        Replace "JD" with user initials dynamically.
        Example JS (after adding EL values):
          const first = "${user.firstName}".charAt(0);
          const last  = "${user.lastName}".charAt(0);
          document.getElementById('avatarEl').textContent = first + last;

        Or just use a JSTL expression here:
          ${fn:substring(user.firstName,0,1)}${fn:substring(user.lastName,0,1)}
      -->
      ${fn:substring(user.firstName,0,1)}${fn:substring(user.lastName,0,1)}
    </div>
    <div class="header-text">
      <!--
        Replace static name with: ${user.firstName} ${user.lastName}
        Replace static email with: ${user.email}
      -->
      <div class="header-title">${user.firstName} ${user.lastName}</div>
      <div class="header-sub">${user.email} &nbsp;·&nbsp; Participant</div>
    </div>
  </div>

  <!-- ─────────────────────────────────────────────────────
       ALERT MESSAGES
       Replace these static divs with JSTL c:if blocks:

       <c:if test="${success == 'updated'}">
         <div class="alert alert-success">
           ✓ &nbsp; Profile updated successfully.
         </div>
       </c:if>

       <c:if test="${error == 'invalidName'}">
         <div class="alert alert-error">
           ✕ &nbsp; First name and last name are required.
         </div>
       </c:if>
       ───────────────────────────────────────────────────── -->
       
  <c:if test="${success == 'updated'}">
    <div class="alert alert-success">
      ✓ &nbsp; Profile updated successfully.
    </div>
  </c:if>

  <c:if test="${error == 'invalidName'}">
    <div class="alert alert-error">
      ✕ &nbsp; First name and last name are required.
    </div>
  </c:if>
  <!-- <div class="alert alert-error">✕ &nbsp; First name and last name are required.</div> -->


  <!-- ═══════════════════════════════════════════════════
       PROFILE FORM
       action="/participant/profile/save"  method="post"
       ═══════════════════════════════════════════════════ -->
  <div class="form-card">
    <form action="/participant/profile/save" method="post">

      <!-- ── Section 1: Personal Info ── -->
      <div class="form-section">
        <div class="section-label">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none"
            stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
            <circle cx="12" cy="7" r="4"/>
          </svg>
          Personal Information
        </div>

        <div class="grid-2">

          <div class="field">
            <label>First Name</label>
            <!--
              Add EL value: value="${user.firstName}"
            -->
            <input type="text"  name="firstName" value="${user.firstName}" placeholder="John" required>
          </div>

          <div class="field">
            <label>Last Name</label>
            <!--
              Add EL value: value="${user.lastName}"
            -->
            <input type="text"  name="lastName" value="${user.lastName}" placeholder="Doe" required>
          </div>

          <div class="field">
            <label>Email (read only)</label>
            <!--
              Add EL value: value="${user.email}"
            -->
            <input type="email" value="${user.email}" readonly>
          </div>

          <div class="field">
            <label>Contact Number</label>
            <!--
              Add EL value: value="${user.contactNum}"
            -->
            <input type="text" name="contactNum" value="${user.contactNum}" placeholder="+91 98765 43210">
          </div>

          <div class="field">
            <label>Gender</label>
            <!--
              Add selected attribute dynamically:
              <option value="Male"   ${user.gender == 'Male'   ? 'selected' : ''}>Male</option>
              <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
              <option value="Other"  ${user.gender == 'Other'  ? 'selected' : ''}>Other</option>
            -->
            <select name="gender">
              <option value="">Select gender</option>
              <option value="Male"   ${user.gender == 'Male'   ? 'selected' : ''}>Male</option>
              <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
              <option value="Other"  ${user.gender == 'Other'  ? 'selected' : ''}>Other</option>
            </select>
          </div>

          <div class="field">
            <label>Birth Year</label>
            <!--
              Add EL value: value="${user.birthYear}"
            -->
            <input type="number" name="birthYear" value="${user.birthYear}" min="1950" max="2100" placeholder="2000">
          </div>

        </div>
      </div>

      <!-- ── Section 2: Professional Info ── -->
      <div class="form-section">
        <div class="section-label">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none"
            stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="2" y="7" width="20" height="14" rx="2"/>
            <path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/>
          </svg>
          Professional Details
        </div>

        <div class="grid-2">

          <div class="field">
            <label>Qualification</label>
            <!--
              Add EL value: value="${user.qualification}"
            -->
            <input type="text" name="qualification" value="${user.qualification}" placeholder="B.Tech Computer Science">
          </div>

          <div class="field">
            <label>Designation</label>
            <!--
              Add EL value: value="${user.designation}"
            -->
            <input type="text" name="designation" value="${user.designation}" placeholder="Software Engineer Intern">
          </div>

          <div class="field col-full">
            <label>Organization</label>
            <!--
              Add EL value: value="${user.organization}"
            -->
            <input type="text" name="organization" value="${user.organization}" placeholder="Acme Technologies Pvt. Ltd.">
          </div>

        </div>
      </div>

      <!-- ── Section 3: Location ── -->
      <div class="form-section">
        <div class="section-label">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none"
            stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/>
            <circle cx="12" cy="10" r="3"/>
          </svg>
          Location
        </div>

        <div class="grid-3">

          <div class="field">
            <label>City</label>
            <!--
              Add EL value: value="${userDetail.city}"
            -->
            <input type="text" name="city" value="${userDetail.city}" placeholder="Ahmedabad">
          </div>

          <div class="field">
            <label>State</label>
            <!--
              Add EL value: value="${userDetail.state}"
            -->
            <input type="text" name="state" value="${userDetail.state}" placeholder="Gujarat">
          </div>

          <div class="field">
            <label>Country</label>
            <!--
              Add EL value: value="${userDetail.country}"
            -->
            <input type="text" name="country" value="${userDetail.country}" placeholder="India">
          </div>

        </div>
      </div>

      <!-- ── Form footer / submit ── -->
      <div class="form-footer">
        <span class="footer-note">* Email cannot be changed</span>
        <button type="submit" class="btn-save">
          Save Profile
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
            stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="20 6 9 17 4 12"/>
          </svg>
        </button>
      </div>

    </form>
  </div>
  <!-- ═══ END FORM CARD ════════════════════════════════════ -->

</div><!-- /page -->

</body>
</html>