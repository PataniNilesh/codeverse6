<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Verify OTP | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#f0f2f8;--surface:#fff;--border:#e4e8f2;--border2:#cdd4e8;--accent:#4f46e5;--text:#1c2340;--text2:#4a5578;--muted:#8a94b0;--red:#b91c1c;--red-pale:#fef2f2}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
.page{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:32px 16px}
.card{width:min(440px,100%);background:var(--surface);border:1px solid var(--border);border-radius:18px;overflow:hidden;box-shadow:0 4px 24px rgba(28,35,64,.09)}
.card-accent{height:4px;background:linear-gradient(90deg,#4f46e5,#0ea5e9)}
.card-body{padding:36px 32px}
.card-icon{width:48px;height:48px;border-radius:13px;background:#f0f9ff;display:flex;align-items:center;justify-content:center;margin-bottom:18px}
h4{font-size:22px;font-weight:800;color:var(--text);margin-bottom:6px}
.sub{font-size:14px;color:var(--muted);margin-bottom:24px;line-height:1.6}
.alert-d{padding:11px 14px;background:var(--red-pale);border:1px solid #fca5a5;border-radius:9px;color:var(--red);font-size:13px;margin-bottom:16px}
.field{margin-bottom:16px}
.field label{display:block;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:.5px;color:var(--text2);margin-bottom:7px}
.field input{width:100%;height:52px;padding:0 14px;border:1px solid var(--border2);border-radius:10px;font-size:22px;font-family:'Space Mono',monospace;color:var(--text);background:var(--bg);transition:border-color .2s,box-shadow .2s;outline:none;letter-spacing:8px;text-align:center}
.field input:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(79,70,229,.12);background:#fff}
.field input::placeholder{font-size:14px;letter-spacing:0;font-family:'Syne',sans-serif;color:var(--muted)}
.btn-submit{width:100%;height:46px;border:none;border-radius:11px;background:var(--accent);color:#fff;font-family:'Syne',sans-serif;font-size:15px;font-weight:700;cursor:pointer;transition:all .2s;box-shadow:0 4px 14px rgba(79,70,229,.3)}
.btn-submit:hover{background:#4338ca;transform:translateY(-1px)}
.back-link{display:block;text-align:center;margin-top:16px;font-size:13px;font-weight:700;color:var(--accent);text-decoration:none;font-family:'Space Mono',monospace}
.back-link:hover{color:#4338ca}
</style>
</head>
<body>
<div class="page">
  <div class="card">
    <div class="card-accent"></div>
    <div class="card-body">
      <div class="card-icon">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#0369a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2A19.79 19.79 0 0 1 11.69 19 19.5 19.5 0 0 1 4.69 12 19.79 19.79 0 0 1 1.62 2.52 2 2 0 0 1 3.62.5h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 7.91a16 16 0 0 0 6 6"/></svg>
      </div>
      <h4>Verify OTP</h4>
      <p class="sub">Enter the one-time password sent to your registered email address.</p>
      <c:if test="${not empty error}"><div class="alert-d">${error}</div></c:if>
      <form action="verify-otp" method="post">
        <input type="hidden" name="email" value="${email}"/>
        <div class="field">
          <label>OTP Code</label>
          <input type="text" name="otp" placeholder="Enter OTP" maxlength="8" required>
        </div>
        <button type="submit" class="btn-submit">Verify OTP</button>
      </form>
      <a href="forgetpassword" class="back-link">&larr; Change Email</a>
    </div>
  </div>
</div>
</body>
</html>
