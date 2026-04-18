
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--green:#4ade80;--red:#f87171}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.page{position:relative;z-index:1;max-width:900px;margin:0 auto;padding:24px 20px 40px}
.top{display:flex;justify-content:space-between;align-items:flex-end;gap:12px;flex-wrap:wrap;margin-bottom:20px}
.back{color:var(--muted);text-decoration:none;font-weight:700;font-size:14px}
.back:hover{color:var(--text)}
.page-title{font-size:26px;font-weight:800;margin-top:6px}
.page-sub{font-size:14px;color:var(--muted);margin-top:4px}
.msg{padding:12px 14px;border-radius:10px;font-size:14px;margin-bottom:16px}
.ok{background:rgba(74,222,128,.12);border:1px solid rgba(74,222,128,.3);color:var(--green)}
.err{background:rgba(248,113,113,.1);border:1px solid rgba(248,113,113,.28);color:var(--red)}
.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:22px}
.card-section{margin-bottom:24px;padding-bottom:24px;border-bottom:1px solid var(--border)}
.card-section:last-child{margin-bottom:0;padding-bottom:0;border-bottom:none}
.section-title{font-size:12px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:1.2px;text-transform:uppercase;color:var(--muted);margin-bottom:16px}
.grid-2{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.col-full{grid-column:1/-1}
.field{display:flex;flex-direction:column;gap:6px}
.field label{font-size:11px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:#8a9ab0}
.field input,.field select{height:44px;padding:0 13px;background:var(--surface2);border:1px solid var(--border);border-radius:10px;color:var(--text);font-size:14px;font-family:'Syne',sans-serif;outline:none;transition:border-color .2s,box-shadow .2s;appearance:none}
.field input:focus,.field select:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(124,58,237,.15)}
.field input[readonly]{opacity:.65;cursor:default}
.field input::placeholder{color:var(--muted)}
.field select option{background:var(--surface2)}
.btn-save{height:44px;padding:0 22px;border:none;border-radius:11px;background:var(--accent);color:#fff;font-family:'Syne',sans-serif;font-weight:700;font-size:14px;cursor:pointer;transition:all .2s;box-shadow:0 4px 16px rgba(124,58,237,.3)}
.btn-save:hover{background:#6d28d9;transform:translateY(-1px)}
@media(max-width:680px){.grid-2{grid-template-columns:1fr}.col-full{grid-column:1}}
</style>
</head>
<body>
<%@ include file="ParticipantTopNav.jsp"%>
<div class="page">
  <div class="top">
    <div>
      <a href="/participant/home" class="back">&larr; Back to Home</a>
      <h1 class="page-title">My Profile</h1>
      <p class="page-sub">View and update your participant profile details.</p>
    </div>
  </div>

  <!-- EL kept: ${success} ${error} -->
  <c:if test="${success == 'updated'}"><div class="msg ok">Profile updated successfully.</div></c:if>
  <c:if test="${error == 'invalidName'}"><div class="msg err">First name and last name are required.</div></c:if>

  <div class="card">
    <form action="/participant/profile/save" method="post">
      <div class="card-section">
        <div class="section-title">Personal Information</div>
        <div class="grid-2">
          <div class="field"><label>First Name</label><input type="text" name="firstName" value="${user.firstName}" required></div>
          <div class="field"><label>Last Name</label><input type="text" name="lastName" value="${user.lastName}" required></div>
          <div class="field"><label>Email</label><input type="email" value="${user.email}" readonly></div>
          <div class="field"><label>Contact Number</label><input type="text" name="contactNum" value="${user.contactNum}"></div>
          <div class="field"><label>Gender</label>
            <select name="gender">
              <option value="">Select gender</option>
              <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
              <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
              <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
            </select>
          </div>
          <div class="field"><label>Birth Year</label><input type="number" name="birthYear" min="1950" max="2100" value="${user.birthYear}"></div>
        </div>
      </div>
      <div class="card-section">
        <div class="section-title">Professional Details</div>
        <div class="grid-2">
          <div class="field"><label>Qualification</label><input type="text" name="qualification" value="${user.qualification}"></div>
          <div class="field"><label>Designation</label><input type="text" name="designation" value="${user.designation}"></div>
          <div class="field col-full"><label>Organization</label><input type="text" name="organization" value="${user.organization}"></div>
        </div>
      </div>
      <div class="card-section">
        <div class="section-title">Location</div>
        <div class="grid-2">
          <div class="field"><label>City</label><input type="text" name="city" value="${userDetail.city}"></div>
          <div class="field"><label>State</label><input type="text" name="state" value="${userDetail.state}"></div>
          <div class="field col-full"><label>Country</label><input type="text" name="country" value="${userDetail.country}"></div>
        </div>
      </div>
      <div>
        <button class="btn-save" type="submit">Save Profile</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>
