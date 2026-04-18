
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Change Password | ICH Judge</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--red:#f87171}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.page{position:relative;z-index:1;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:32px 16px}
.card{width:min(460px,100%);background:var(--surface);border:1px solid var(--border);border-radius:18px;overflow:hidden}
.card-accent{height:3px;background:linear-gradient(90deg,var(--accent),var(--accent2))}
.card-body{padding:34px 30px}
.card-icon{width:48px;height:48px;border-radius:13px;background:rgba(124,58,237,.12);border:1px solid rgba(124,58,237,.25);display:flex;align-items:center;justify-content:center;margin-bottom:18px}
h2{font-size:22px;font-weight:800;margin-bottom:6px}
.sub{font-size:14px;color:var(--muted);margin-bottom:24px;line-height:1.6}
.field{margin-bottom:16px}
.field label{display:block;font-size:11px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:#8a9ab0;margin-bottom:8px}
.field input{width:100%;height:44px;padding:0 14px;background:var(--surface2);border:1px solid var(--border);border-radius:10px;color:var(--text);font-size:14px;font-family:'Syne',sans-serif;outline:none;transition:border-color .2s,box-shadow .2s}
.field input:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(124,58,237,.15)}
.field input::placeholder{color:var(--muted)}
.btn-submit{width:100%;height:46px;border:none;border-radius:11px;background:var(--accent);color:#fff;font-family:'Syne',sans-serif;font-size:15px;font-weight:700;cursor:pointer;transition:all .2s;box-shadow:0 4px 16px rgba(124,58,237,.3)}
.btn-submit:hover{background:#6d28d9;transform:translateY(-1px)}
.err{margin-top:12px;padding:11px 14px;background:rgba(248,113,113,.1);border:1px solid rgba(248,113,113,.3);border-radius:9px;color:var(--red);font-size:13px}
.back-link{display:block;text-align:center;margin-top:16px;font-size:13px;font-weight:700;color:#a78bfa;text-decoration:none;font-family:'Space Mono',monospace}
.back-link:hover{color:var(--accent)}
.brand-header{padding:20px 30px 0;display:flex;align-items:center;gap:10px}
.brand-icon{width:32px;height:32px;background:var(--accent);border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0}
.brand-name{font-weight:800;font-size:14px}
.brand-sub-text{font-size:10px;color:var(--muted);font-family:'Space Mono',monospace}
</style>
</head>
<body>
<div class="page">
  <div class="card">
    <div class="card-accent"></div>
    <div class="brand-header">
      <div class="brand-icon">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
      </div>
      <div>
        <div class="brand-name">ICH Judge Panel</div>
        <div class="brand-sub-text">Interns Coding for Hackathon</div>
      </div>
    </div>
    <div class="card-body">
      <div class="card-icon">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#a78bfa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
      </div>
      <h2>Change Password</h2>
      <p class="sub">For security, please set your own password before accessing the judge dashboard.</p>
      <form action="/judge/update-password" method="post">
        <div class="field"><label>New Password</label><input type="password" name="newPassword" placeholder="Enter new password" required></div>
        <div class="field"><label>Confirm Password</label><input type="password" name="confirmPassword" placeholder="Confirm new password" required></div>
        <button type="submit" class="btn-submit">Update Password</button>
        <!-- EL kept: ${error} -->
        <c:if test="${not empty error}"><div class="err">${error}</div></c:if>
      </form>
      <a href="/judge-dashboard" class="back-link">&larr; Back to Dashboard</a>
    </div>
  </div>
</div>
</body>
</html>
