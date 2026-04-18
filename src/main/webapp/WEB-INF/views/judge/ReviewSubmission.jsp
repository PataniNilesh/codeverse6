<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Review Submission | ICH Judge</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--blue:#67e8f9}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.judge-nav{position:sticky;top:0;z-index:100;background:rgba(10,10,15,.92);backdrop-filter:blur(20px);border-bottom:1px solid var(--border);padding:0 28px;height:62px;display:flex;align-items:center;justify-content:space-between;gap:12px}
.nav-brand{display:flex;align-items:center;gap:10px;text-decoration:none;color:var(--text)}
.nav-brand-icon{width:32px;height:32px;background:var(--accent);border-radius:9px;display:flex;align-items:center;justify-content:center}
.nav-brand-text{font-weight:800;font-size:14px;font-family:'Space Mono',monospace}
.nav-back{color:var(--muted);text-decoration:none;font-weight:700;font-size:13px}
.nav-back:hover{color:var(--text)}
.page{position:relative;z-index:1;max-width:860px;margin:0 auto;padding:28px 20px 40px}
.page-title{font-size:26px;font-weight:800;margin-bottom:20px}
.info-card{background:var(--surface);border:1px solid var(--border);border-radius:14px;padding:20px;margin-bottom:18px}
.meta-row{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:10px;margin-bottom:14px}
.meta-item{background:var(--surface2);border:1px solid var(--border);border-radius:10px;padding:12px}
.meta-label{font-size:10px;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:var(--muted);margin-bottom:5px}
.meta-val{font-size:14px;font-weight:700;color:var(--text)}
.link-row{display:flex;gap:8px;flex-wrap:wrap}
.link-btn{display:inline-flex;align-items:center;gap:7px;padding:9px 14px;border-radius:9px;border:1px solid var(--border);background:rgba(6,182,212,.08);color:var(--blue);font-size:13px;font-weight:700;text-decoration:none;transition:all .18s;font-family:'Syne',sans-serif}
.link-btn:hover{border-color:var(--accent2);background:rgba(6,182,212,.15)}
.form-card{background:var(--surface);border:1px solid var(--border);border-radius:14px;padding:22px;margin-bottom:18px}
.score-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:14px;margin-bottom:14px}
.field{display:flex;flex-direction:column;gap:6px}
.field label{font-size:11px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:#8a9ab0}
.field-helper{font-size:11px;color:var(--muted);margin-top:3px}
.field input,.field select{height:44px;padding:0 13px;background:var(--surface2);border:1px solid var(--border);border-radius:10px;color:var(--text);font-size:15px;font-family:'Space Mono',monospace;outline:none;transition:border-color .2s,box-shadow .2s}
.field input:focus,.field select:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(124,58,237,.15)}
.field input[type="number"]{text-align:center;letter-spacing:2px}
.field select{font-family:'Syne',sans-serif;font-size:13px;appearance:none;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%2364748b' d='M6 8L1 3h10z'/%3E%3C/svg%3E");background-repeat:no-repeat;background-position:right 12px center}
.field select option{background:var(--surface2)}
.actions{display:flex;gap:10px;flex-wrap:wrap;margin-top:4px}
.btn-save{height:46px;padding:0 24px;border:none;border-radius:11px;background:var(--accent);color:#fff;font-family:'Syne',sans-serif;font-weight:700;font-size:14px;cursor:pointer;transition:all .2s;box-shadow:0 4px 14px rgba(124,58,237,.3)}
.btn-save:hover{background:#6d28d9;transform:translateY(-1px)}
.btn-cancel{height:46px;padding:0 20px;border:1px solid var(--border);border-radius:11px;background:var(--surface2);color:var(--muted);font-family:'Syne',sans-serif;font-weight:700;font-size:14px;cursor:pointer;transition:all .2s;text-decoration:none;display:inline-flex;align-items:center}
.btn-cancel:hover{color:var(--text);border-color:var(--accent)}
</style>
</head>
<body>
<nav class="judge-nav">
  <a class="nav-brand" href="/judge-dashboard">
    <div class="nav-brand-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg></div>
    <div class="nav-brand-text">ICH Judge</div>
  </a>
  <a href="/judge/submissions" class="nav-back">&larr; Back to Submissions</a>
</nav>

<div class="page">
  <h1 class="page-title">Review Team Submission</h1>

  <!-- Submission info — EL kept exactly -->
  <div class="info-card">
    <div class="meta-row">
      <div class="meta-item"><div class="meta-label">Hackathon</div><div class="meta-val">${hackathon.title}</div></div>
      <div class="meta-item"><div class="meta-label">Team</div><div class="meta-val">${team.teamName}</div></div>
      <div class="meta-item"><div class="meta-label">Submitted Date</div><div class="meta-val">${submission.submitedDate}</div></div>
    </div>
    <div class="link-row">
      <a class="link-btn" href="${submission.codeBaseUrl}" target="_blank">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg>
        Open Code Base
      </a>
      <a class="link-btn" href="${submission.documentationUrl}" target="_blank">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
        Open Documentation
      </a>
    </div>
  </div>

  <!-- Review form — all hidden inputs & EL kept exactly -->
  <div class="form-card">
    <form action="/judge/submissions/review/save" method="post">
      <input type="hidden" name="hackathonResultId" value="${result.hackathonResultId}">
      <input type="hidden" name="hackathonId" value="${submission.hackathonId}">
      <input type="hidden" name="teamId" value="${submission.teamId}">

      <div class="score-grid">
        <div class="field">
          <label>Innovation (1&ndash;10)</label>
          <input type="number" name="innovation" min="1" max="10" value="${result.innovation}" required>
          <div class="field-helper">How unique and creative is the solution?</div>
        </div>
        <div class="field">
          <label>Implementation (1&ndash;10)</label>
          <input type="number" name="implementation" min="1" max="10" value="${result.implementation}" required>
          <div class="field-helper">How complete and functional is the build?</div>
        </div>
        <div class="field">
          <label>Coding Standard (1&ndash;10)</label>
          <input type="number" name="codingStandard" min="1" max="10" value="${result.codingStandard}" required>
          <div class="field-helper">Code quality, readability, and maintainability.</div>
        </div>
        <div class="field">
          <label>Round</label>
          <!-- EL kept: ${result.round} selected states -->
          <select name="round" required>
            <option value="">Select Round</option>
            <option value="ROUND_1" ${result.round == 'ROUND_1' ? 'selected' : ''}>Round 1</option>
            <option value="ROUND_2" ${result.round == 'ROUND_2' ? 'selected' : ''}>Round 2</option>
            <option value="FINAL" ${result.round == 'FINAL' ? 'selected' : ''}>Final</option>
          </select>
        </div>
      </div>

      <div class="actions">
        <button type="submit" class="btn-save">Save Review</button>
        <a href="/judge/submissions" class="btn-cancel">Cancel</a>
      </div>
    </form>
  </div>
</div>
</body>
</html>
