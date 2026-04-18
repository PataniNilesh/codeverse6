<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>View User | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--glow:rgba(124,58,237,.35)}
body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh;padding:32px 20px}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.04) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.04) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.wrap{position:relative;z-index:1;max-width:860px;margin:0 auto}
.card{background:var(--surface);border:1px solid var(--border);border-radius:18px;overflow:hidden}
.card-header{background:var(--surface2);border-bottom:1px solid var(--border);padding:18px 24px;position:relative}
.card-header::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,var(--accent),var(--accent2))}
.card-header h4{font-size:16px;font-weight:800;margin:0;color:var(--text)}
.card-body{padding:28px 24px}
.user-layout{display:flex;gap:32px;align-items:flex-start;flex-wrap:wrap}
.avatar-col{text-align:center;flex-shrink:0}
.profile-pic{width:110px;height:110px;border-radius:18px;object-fit:cover;border:2px solid var(--border);box-shadow:0 0 20px var(--glow)}
.badge-role{display:inline-flex;align-items:center;padding:5px 14px;border-radius:100px;font-family:'Space Mono',monospace;font-size:11px;font-weight:700;letter-spacing:.8px;background:rgba(6,182,212,.12);color:#67e8f9;border:1px solid rgba(6,182,212,.25);margin-top:12px}
.info-col{flex:1;min-width:0}
.info-row{display:flex;align-items:flex-start;padding:11px 0;border-bottom:1px solid var(--border);gap:16px}
.info-row:last-child{border-bottom:none}
.info-key{font-size:11px;font-family:'Space Mono',monospace;letter-spacing:.5px;color:var(--muted);text-transform:uppercase;flex-shrink:0;width:140px;padding-top:1px}
.info-val{font-size:14px;font-weight:600;color:var(--text)}
.badge-active{display:inline-flex;padding:3px 10px;border-radius:100px;font-family:'Space Mono',monospace;font-size:10px;font-weight:700;letter-spacing:.8px}
.badge-green{background:rgba(74,222,128,.12);color:#4ade80;border:1px solid rgba(74,222,128,.25)}
.badge-red{background:rgba(248,113,113,.1);color:#f87171;border:1px solid rgba(248,113,113,.25)}
.card-footer{padding:14px 24px;border-top:1px solid var(--border);display:flex;justify-content:flex-end;gap:8px;background:rgba(10,10,15,.4)}
.btn{display:inline-flex;align-items:center;gap:7px;padding:10px 20px;border-radius:10px;font-family:'Syne',sans-serif;font-weight:700;font-size:13px;text-decoration:none;border:none;cursor:pointer;transition:all .2s}
.btn-secondary{background:var(--surface2);color:var(--muted);border:1px solid var(--border)}.btn-secondary:hover{color:var(--text);border-color:var(--accent)}
.btn-warning{background:rgba(245,158,11,.15);color:#fbbf24;border:1px solid rgba(245,158,11,.3)}.btn-warning:hover{background:rgba(245,158,11,.25)}
</style>
</head>
<body>
<div class="wrap">
  <div class="card">
    <div class="card-header"><h4>User Details</h4></div>
    <div class="card-body">
      <div class="user-layout">
        <div class="avatar-col">
          <!-- EL/JSTL kept exactly -->
          <c:choose>
            <c:when test="${not empty user.profilePicUrl}">
              <img src="${user.profilePicUrl}" class="profile-pic">
            </c:when>
            <c:otherwise>
              <img src="https://via.placeholder.com/120" class="profile-pic">
            </c:otherwise>
          </c:choose>
          <div><span class="badge-role">${user.role}</span></div>
        </div>
        <div class="info-col">
          <div class="info-row"><span class="info-key">User ID</span><span class="info-val">${user.userId}</span></div>
          <div class="info-row"><span class="info-key">Full Name</span><span class="info-val">${user.firstName} ${user.lastName}</span></div>
          <div class="info-row"><span class="info-key">Email</span><span class="info-val">${user.email}</span></div>
          <div class="info-row"><span class="info-key">Gender</span><span class="info-val">${user.gender}</span></div>
          <div class="info-row"><span class="info-key">Birth Year</span><span class="info-val">${user.birthYear}</span></div>
          <div class="info-row"><span class="info-key">Contact</span><span class="info-val">${user.contactNum}</span></div>
          <div class="info-row"><span class="info-key">Created At</span><span class="info-val">${user.createdAt}</span></div>
          <div class="info-row">
            <span class="info-key">Status</span>
            <span class="info-val">
              <c:choose>
                <c:when test="${user.active}"><span class="badge-active badge-green">Active</span></c:when>
                <c:otherwise><span class="badge-active badge-red">Inactive</span></c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="info-row"><span class="info-key">Country</span><span class="info-val">${userDetail.country}</span></div>
          <div class="info-row"><span class="info-key">State</span><span class="info-val">${userDetail.state}</span></div>
          <div class="info-row"><span class="info-key">City</span><span class="info-val">${userDetail.city}</span></div>
        </div>
      </div>
    </div>
    <div class="card-footer">
      <a href="listuser" class="btn btn-secondary">Back</a>
      <a href="editUser?userId=${user.userId}" class="btn btn-warning">Edit</a>
    </div>
  </div>
</div>
</body>
</html>
