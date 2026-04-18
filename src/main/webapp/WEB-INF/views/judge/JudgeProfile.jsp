<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Judge Profile | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--green:#4ade80;--red:#f87171}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.judge-nav{position:sticky;top:0;z-index:100;background:rgba(10,10,15,.92);backdrop-filter:blur(20px);border-bottom:1px solid var(--border);padding:0 28px;height:62px;display:flex;align-items:center;justify-content:space-between;gap:12px}
.nav-brand{display:flex;align-items:center;gap:10px;text-decoration:none;color:var(--text)}
.nav-brand-icon{width:32px;height:32px;background:var(--accent);border-radius:9px;display:flex;align-items:center;justify-content:center}
.nav-brand-text{font-weight:800;font-size:14px;font-family:'Space Mono',monospace}
.nav-right{display:flex;align-items:center;gap:6px}
.nav-link{color:var(--muted);text-decoration:none;font-size:13px;font-weight:600;padding:7px 12px;border-radius:9px;border:1px solid var(--border);transition:all .18s}
.nav-link:hover{color:var(--text);border-color:var(--accent)}
.page{position:relative;z-index:1;max-width:860px;margin:0 auto;padding:28px 20px 40px}
.page-top{display:flex;align-items:flex-end;justify-content:space-between;gap:12px;flex-wrap:wrap;margin-bottom:20px}
.page-title{font-size:26px;font-weight:800}
.page-sub{font-size:14px;color:var(--muted);margin-top:5px}
.msg{padding:11px 14px;border-radius:10px;font-size:14px;margin-bottom:16px}
.ok{background:rgba(74,222,128,.12);border:1px solid rgba(74,222,128,.3);color:var(--green)}
.err{background:rgba(248,113,113,.1);border:1px solid rgba(248,113,113,.28);color:var(--red)}
.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;overflow:hidden;margin-bottom:16px}
.card-head{padding:14px 20px;border-bottom:1px solid var(--border);background:var(--surface2)}
.card-head h3{font-size:12px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:1px;text-transform:uppercase;color:var(--muted);margin:0}
.card-body{padding:20px}
.avatar-row{display:flex;align-items:center;gap:16px;padding-bottom:18px;border-bottom:1px solid var(--border);margin-bottom:18px}
.avatar-img{width:80px;height:80px;border-radius:16px;object-fit:cover;border:2px solid var(--border);flex-shrink:0}
.file-label{font-size:11px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:#8a9ab0;display:block;margin-bottom:7px}
.file-input{display:block;font-size:13px;color:var(--muted);cursor:pointer}
.grid-2{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.col-full{grid-column:1/-1}
.field{display:flex;flex-direction:column;gap:6px}
.field label{font-size:11px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:#8a9ab0}
.field input{height:44px;padding:0 13px;background:var(--surface2);border:1px solid var(--border);border-radius:10px;color:var(--text);font-size:14px;font-family:'Syne',sans-serif;outline:none;transition:border-color .2s,box-shadow .2s}
.field input:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(124,58,237,.15)}
.field input[disabled]{opacity:.5;cursor:not-allowed}
.field input::placeholder{color:var(--muted)}
.btn-save{height:44px;padding:0 24px;border:none;border-radius:11px;background:var(--accent);color:#fff;font-family:'Syne',sans-serif;font-weight:700;font-size:14px;cursor:pointer;transition:all .2s;box-shadow:0 4px 14px rgba(124,58,237,.3)}
.btn-save:hover{background:#6d28d9;transform:translateY(-1px)}
.footer-note{margin-top:24px;text-align:center;font-size:12px;color:var(--muted);font-family:'Space Mono',monospace}
@media(max-width:620px){.grid-2{grid-template-columns:1fr}.col-full{grid-column:1}}
</style>
</head>
<body>
<nav class="judge-nav">
  <a class="nav-brand" href="/judge-dashboard">
    <div class="nav-brand-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg></div>
    <div class="nav-brand-text">ICH Judge</div>
  </a>
  <div class="nav-right">
    <a href="/judge/change-password" class="nav-link">Change Password</a>
    <a href="/judge-dashboard" class="nav-link">Dashboard</a>
  </div>
</nav>

<div class="page">
  <div class="page-top">
    <div>
      <h1 class="page-title">Judge Profile</h1>
      <p class="page-sub">Manage your profile details visible in assigned hackathons.</p>
    </div>
  </div>

  <c:if test="${param.updated == 'true'}"><div class="msg ok">Profile updated successfully.</div></c:if>
  <c:if test="${not empty error}"><div class="msg err">${error}</div></c:if>

  <div class="card">
    <div class="card-head"><h3>Profile Details</h3></div>
    <div class="card-body">
      <form action="/judge/profile/update" method="post" enctype="multipart/form-data">
        <!-- Avatar row -->
        <div class="avatar-row">
          <c:choose>
            <c:when test="${not empty judge.profilePicUrl}">
              <img src="${judge.profilePicUrl}" class="avatar-img" alt="profile">
            </c:when>
            <c:otherwise>
              <img src="/assets/images/faces/dummy.jpg" class="avatar-img" alt="profile">
            </c:otherwise>
          </c:choose>
          <div>
            <span class="file-label">Profile Picture</span>
            <input type="file" name="profilePic" class="file-input" accept="image/*">
          </div>
        </div>

        <div class="grid-2">
          <div class="field"><label>First Name</label><input type="text" name="firstName" value="${judge.firstName}" required></div>
          <div class="field"><label>Last Name</label><input type="text" name="lastName" value="${judge.lastName}" required></div>
          <div class="field"><label>Email</label><input type="email" value="${judge.email}" disabled></div>
          <div class="field"><label>Contact Number</label><input type="text" name="contactNum" value="${judge.contactNum}"></div>
          <div class="field"><label>Qualification</label><input type="text" name="qualification" value="${judge.qualification}" placeholder="e.g. M.Tech, PhD"></div>
          <div class="field"><label>Designation</label><input type="text" name="designation" value="${judge.designation}" placeholder="e.g. Senior Engineer"></div>
          <div class="field col-full"><label>Organization</label><input type="text" name="organization" value="${judge.organization}" placeholder="Company or Institute"></div>
        </div>
        <div style="margin-top:18px">
          <button class="btn-save" type="submit">Save Profile</button>
        </div>
      </form>
    </div>
  </div>
  <div class="footer-note">ICH &mdash; Interns Coding for Hackathon &bull; Judge Panel</div>
</div>
</body>
</html>
