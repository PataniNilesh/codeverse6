<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<title>Login | ICH Admin</title>
<link rel="icon" href="../assets/images/favicon.svg" type="image/x-icon">
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../assets/fonts/tabler-icons.min.css">
<link rel="stylesheet" href="../assets/css/style.css" id="main-style-link">
<link rel="stylesheet" href="../assets/css/style-preset.css">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#f0f2f8;--surface:#fff;--border:#e4e8f2;--border2:#cdd4e8;--accent:#4f46e5;--text:#1c2340;--text2:#4a5578;--muted:#8a94b0;--red:#b91c1c;--red-pale:#fef2f2}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
.page{min-height:100vh;display:grid;grid-template-columns:1fr 1fr}
.brand-panel{background:linear-gradient(145deg,#4f46e5 0%,#0ea5e9 100%);display:flex;flex-direction:column;justify-content:center;padding:60px 52px;color:#fff;position:relative;overflow:hidden}
.brand-panel::before{content:'';position:absolute;right:-80px;top:-80px;width:320px;height:320px;border-radius:50%;background:rgba(255,255,255,.06)}
.brand-panel::after{content:'';position:absolute;left:-60px;bottom:-60px;width:260px;height:260px;border-radius:50%;background:rgba(255,255,255,.08)}
.brand-logo{display:flex;align-items:center;gap:12px;margin-bottom:52px;position:relative;z-index:1}
.brand-logo-icon{width:42px;height:42px;background:rgba(255,255,255,.2);border:1px solid rgba(255,255,255,.35);border-radius:12px;display:flex;align-items:center;justify-content:center}
.brand-logo-text{font-size:18px;font-weight:800}
.brand-title{font-size:34px;font-weight:800;line-height:1.15;margin-bottom:14px;position:relative;z-index:1}
.brand-sub{font-size:15px;opacity:.85;line-height:1.7;position:relative;z-index:1}
.brand-points{margin-top:36px;display:flex;flex-direction:column;gap:12px;position:relative;z-index:1}
.brand-point{display:flex;align-items:center;gap:10px;background:rgba(255,255,255,.12);border:1px solid rgba(255,255,255,.2);border-radius:10px;padding:10px 14px;font-size:14px}
.form-panel{display:flex;flex-direction:column;justify-content:center;align-items:center;padding:48px 40px;background:var(--surface)}
.form-card{width:min(420px,100%)}
.form-header{margin-bottom:28px}
.form-header h2{font-size:26px;font-weight:800;color:var(--text);margin-bottom:6px}
.form-header p{font-size:14px;color:var(--muted)}
.field{margin-bottom:16px}
.field label{display:block;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:.5px;color:var(--text2);margin-bottom:7px}
.field input{width:100%;height:44px;padding:0 14px;border:1px solid var(--border2);border-radius:10px;font-size:14px;font-family:'Syne',sans-serif;color:var(--text);background:var(--bg);transition:border-color .2s,box-shadow .2s;outline:none}
.field input:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(79,70,229,.12);background:#fff}
.field input::placeholder{color:var(--muted)}
.row-between{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;flex-wrap:wrap;gap:8px}
.check-wrap{display:flex;align-items:center;gap:8px}
.check-wrap input[type="checkbox"]{accent-color:var(--accent);width:15px;height:15px}
.check-label{font-size:13px;color:var(--muted)}
.forgot{font-size:13px;font-weight:700;color:var(--accent);text-decoration:none;font-family:'Space Mono',monospace}
.forgot:hover{color:#4338ca}
.btn-submit{width:100%;height:46px;border:none;border-radius:11px;background:var(--accent);color:#fff;font-family:'Syne',sans-serif;font-size:15px;font-weight:700;cursor:pointer;transition:all .2s;box-shadow:0 4px 14px rgba(79,70,229,.3)}
.btn-submit:hover{background:#4338ca;transform:translateY(-1px)}
.error-box{margin-top:14px;padding:11px 14px;background:var(--red-pale);border:1px solid #fca5a5;border-radius:9px;color:var(--red);font-size:13px}
.divider{display:flex;align-items:center;gap:12px;margin:20px 0;color:var(--muted);font-size:12px;font-family:'Space Mono',monospace}
.divider::before,.divider::after{content:'';flex:1;height:1px;background:var(--border)}
.social-row{display:grid;grid-template-columns:1fr 1fr 1fr;gap:8px}
.social-btn{display:flex;align-items:center;justify-content:center;gap:7px;padding:10px;border-radius:10px;border:1px solid var(--border);background:var(--bg);color:var(--muted);font-size:12px;font-weight:600;cursor:pointer;transition:all .18s;font-family:'Syne',sans-serif}
.social-btn:hover{border-color:var(--accent);color:var(--text)}
.social-btn img{width:16px;height:16px}
.form-footer{margin-top:22px;border-top:1px solid var(--border);padding-top:14px;text-align:center;font-size:12px;color:var(--muted);font-family:'Space Mono',monospace}
.form-footer a{color:var(--accent);text-decoration:none;font-weight:700}
.loader-bg{display:none}
@media(max-width:800px){.page{grid-template-columns:1fr}.brand-panel{display:none}.form-panel{padding:32px 20px}}
</style>
</head>
<body>
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<div class="page">
  <div class="brand-panel">
    <div class="brand-logo">
      <div class="brand-logo-icon">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
      </div>
      <div class="brand-logo-text">ICH Admin</div>
    </div>
    <h1 class="brand-title">Interns Coding<br>for Hackathon</h1>
    <p class="brand-sub">The complete hackathon management platform.<br>Manage events, teams, judges, and results.</p>
    <div class="brand-points">
      <div class="brand-point"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Manage hackathons &amp; participants</div>
      <div class="brand-point"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Publish leaderboards and results</div>
      <div class="brand-point"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Track enrollment and analytics</div>
    </div>
  </div>
  <div class="form-panel">
    <div class="form-card">
      <div class="form-header">
        <h2>Welcome back</h2>
        <p>Sign in to your admin account to continue.</p>
      </div>
      <form action="authenticate" method="post">
        <div class="field"><label>Email Address</label><input type="email" name="email" placeholder="admin@example.com" required></div>
        <div class="field"><label>Password</label><input type="password" name="password" placeholder="Enter password" required></div>
        <div class="row-between">
          <div class="check-wrap">
            <input type="checkbox" id="remember" checked>
            <label class="check-label" for="remember">Keep me signed in</label>
          </div>
          <a href="forgetpassword" class="forgot">Forgot password?</a>
        </div>
        <button type="submit" class="btn-submit">Sign In to Dashboard</button>
        <c:if test="${not empty error}"><div class="error-box">${error}</div></c:if>
      </form>
      <div style="text-align:center;margin-top:18px;font-size:14px;color:var(--muted);font-family:'Syne',sans-serif">
        Need an Account?&nbsp;
        <a href="signup" style="color:var(--accent);font-weight:700;text-decoration:none">Sign Up</a>
      </div>
      <div class="divider"><span>or sign in with</span></div>
      <div class="social-row">
        <button type="button" class="social-btn"><img src="../assets/images/authentication/google.svg" alt="g"> Google</button>
        <button type="button" class="social-btn"><img src="../assets/images/authentication/twitter.svg" alt="t"> Twitter</button>
        <button type="button" class="social-btn"><img src="../assets/images/authentication/facebook.svg" alt="f"> Facebook</button>
      </div>
      <div class="form-footer">Copyright &copy; <a href="#">LAHKU16</a> &nbsp;&bull;&nbsp; <a href="#">Privacy Policy</a> &nbsp;&bull;&nbsp; <a href="#">Contact</a></div>
    </div>
  </div>
</div>
<script src="../assets/js/plugins/popper.min.js"></script>
<script src="../assets/js/plugins/simplebar.min.js"></script>
<script src="../assets/js/plugins/bootstrap.min.js"></script>
<script src="../assets/js/fonts/custom-font.js"></script>
<script src="../assets/js/pcoded.js"></script>
<script src="../assets/js/plugins/feather.min.js"></script>
<script>layout_change('light');</script>
<script>change_box_container('false');</script>
<script>layout_rtl_change('false');</script>
<script>preset_change("preset-1");</script>
<script>font_change("Public-Sans");</script>
</body>
</html>
