<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#f0f2f8;--surface:#fff;--border:#e4e8f2;--border2:#cdd4e8;--accent:#4f46e5;--text:#1c2340;--text2:#4a5578;--muted:#8a94b0;--red:#b91c1c;--red-pale:#fef2f2}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
.page{min-height:100vh;display:grid;grid-template-columns:1fr 1.3fr}
.brand-panel{background:linear-gradient(145deg,#4f46e5 0%,#0ea5e9 100%);display:flex;flex-direction:column;justify-content:center;padding:60px 48px;color:#fff;position:relative;overflow:hidden}
.brand-panel::before{content:'';position:absolute;right:-80px;top:-80px;width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,.06)}
.brand-panel::after{content:'';position:absolute;left:-60px;bottom:-60px;width:250px;height:250px;border-radius:50%;background:rgba(255,255,255,.08)}
.brand-logo{display:flex;align-items:center;gap:12px;margin-bottom:40px;position:relative;z-index:1}
.brand-logo-icon{width:38px;height:38px;background:rgba(255,255,255,.2);border:1px solid rgba(255,255,255,.35);border-radius:11px;display:flex;align-items:center;justify-content:center}
.brand-logo-text{font-size:16px;font-weight:800}
.brand-title{font-size:30px;font-weight:800;line-height:1.2;margin-bottom:12px;position:relative;z-index:1}
.brand-sub{font-size:14px;opacity:.85;line-height:1.7;position:relative;z-index:1}
.brand-points{margin-top:32px;display:flex;flex-direction:column;gap:10px;position:relative;z-index:1}
.brand-point{display:flex;align-items:center;gap:10px;background:rgba(255,255,255,.12);border:1px solid rgba(255,255,255,.2);border-radius:10px;padding:10px 14px;font-size:13px}
.form-panel{overflow-y:auto;padding:40px;background:var(--surface)}
.form-inner{max-width:560px;margin:0 auto}
.form-header{margin-bottom:24px}
.form-header h2{font-size:24px;font-weight:800;color:var(--text);margin-bottom:6px}
.form-header p{font-size:14px;color:var(--muted)}
.error-box{padding:11px 14px;background:var(--red-pale);border:1px solid #fca5a5;border-radius:9px;color:var(--red);font-size:13px;margin-bottom:16px}
.grid-2{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.col-full{grid-column:1/-1}
.field{margin-bottom:0}
.field label{display:block;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:.5px;color:var(--text2);margin-bottom:7px}
.field input,.field select{width:100%;height:44px;padding:0 13px;border:1px solid var(--border2);border-radius:10px;font-size:13px;font-family:'Syne',sans-serif;color:var(--text);background:var(--bg);transition:border-color .2s,box-shadow .2s;outline:none;appearance:none}
.field input:focus,.field select:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(79,70,229,.12);background:#fff}
.field input::placeholder{color:var(--muted)}
.field input[type="file"]{height:auto;padding:10px 13px;cursor:pointer;color:var(--muted)}
.gender-row{display:flex;gap:10px;flex-wrap:wrap}
.gender-opt{display:flex;align-items:center;gap:7px;padding:9px 14px;border:1px solid var(--border2);border-radius:9px;cursor:pointer;font-size:13px;color:var(--text2);transition:border-color .2s,background .2s;background:var(--bg)}
.gender-opt input[type="radio"]{accent-color:var(--accent);flex-shrink:0}
.gender-opt:focus-within{border-color:var(--accent);background:#fff}
.section-divider{grid-column:1/-1;height:1px;background:var(--border);margin:8px 0}
.section-label{grid-column:1/-1;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:1px;color:var(--muted);margin-bottom:4px;margin-top:4px}
.btn-submit{width:100%;height:46px;border:none;border-radius:11px;background:var(--accent);color:#fff;font-family:'Syne',sans-serif;font-size:15px;font-weight:700;cursor:pointer;transition:all .2s;box-shadow:0 4px 14px rgba(79,70,229,.3);margin-top:4px}
.btn-submit:hover{background:#4338ca;transform:translateY(-1px)}
.login-line{text-align:center;margin-top:16px;font-size:13px;color:var(--muted)}
.login-line a{color:var(--accent);font-weight:700;text-decoration:none}
@media(max-width:900px){.page{grid-template-columns:1fr}.brand-panel{display:none}.form-panel{padding:28px 20px}}
@media(max-width:520px){.grid-2{grid-template-columns:1fr}.col-full{grid-column:1}}
</style>
</head>
<body>
<div class="page">
  <div class="brand-panel">
    <div class="brand-logo">
      <div class="brand-logo-icon">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
      </div>
      <div class="brand-logo-text">ICH</div>
    </div>
    <h1 class="brand-title">Join Interns<br>Coding for Hackathon</h1>
    <p class="brand-sub">Create your profile to participate in hackathons, join teams, and showcase your skills.</p>
    <div class="brand-points">
      <div class="brand-point"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Discover &amp; join hackathons</div>
      <div class="brand-point"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Build and manage teams</div>
      <div class="brand-point"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Submit projects &amp; win prizes</div>
    </div>
  </div>

  <div class="form-panel">
    <div class="form-inner">
      <div class="form-header">
        <h2>Create Account</h2>
        <p>Join the ICH hackathon community today.</p>
      </div>
      <!-- EL kept: ${error} -->
      <c:if test="${not empty error}"><div class="error-box">${error}</div></c:if>

      <form action="register" method="post" enctype="multipart/form-data">
        <div class="grid-2">
          <div class="field"><label>First Name</label><input type="text" name="firstName" placeholder="First name" required></div>
          <div class="field"><label>Last Name</label><input type="text" name="lastName" placeholder="Last name" required></div>
          <div class="field"><label>Email</label><input type="email" name="email" placeholder="Email address" required></div>
          <div class="field"><label>Password</label><input type="password" name="password" placeholder="Create password" required></div>

          <div class="field col-full">
            <label>Gender</label>
            <div class="gender-row">
              <label class="gender-opt"><input type="radio" name="gender" value="MALE" required> Male</label>
              <label class="gender-opt"><input type="radio" name="gender" value="FEMALE"> Female</label>
              <label class="gender-opt"><input type="radio" name="gender" value="OTHER"> Other</label>
            </div>
          </div>

          <div class="field"><label>Birth Year</label><input type="number" name="birthYear" min="1900" max="2100" placeholder="e.g. 2000" required></div>
          <div class="field"><label>Contact Number</label><input type="text" name="contactNum" placeholder="+91 98765 43210" required></div>
          <div class="field"><label>Qualification</label><input type="text" name="qualification" placeholder="e.g. B.Tech, MCA" required></div>
          <div class="field">
            <label>User Type</label>
            <!-- EL kept: ${allUserType} -->
            <select name="userTypeId">
              <option value="-1">--- Select User Type ---</option>
              <c:forEach items="${allUserType}" var="ut">
                <option value="${ut.userTypeId}">${ut.userType}</option>
              </c:forEach>
            </select>
          </div>

          <div class="section-divider"></div>
          <div class="section-label">Location Details</div>

          <div class="field"><label>City</label><input type="text" name="city" placeholder="Enter city" required></div>
          <div class="field"><label>State</label><input type="text" name="state" placeholder="Enter state" required></div>
          <div class="field"><label>Country</label><input type="text" name="country" value="India" required></div>
          <div class="field"><label>Profile Picture</label><input type="file" name="profilePic" accept="image/*"></div>

          <div class="col-full">
            <button type="submit" class="btn-submit">Create My Account</button>
            <div class="login-line">Already have an account? <a href="login">Sign in</a></div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
