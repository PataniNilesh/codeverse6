
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Submission | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--text:#e2e8f0;--muted:#64748b;--green:#4ade80;--red:#f87171}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.page{position:relative;z-index:1;max-width:760px;margin:0 auto;padding:28px 20px 40px}
.back{color:var(--muted);text-decoration:none;font-weight:700;font-size:14px}
.back:hover{color:var(--text)}
.page-title{font-size:26px;font-weight:800;margin-top:8px}
.page-sub{font-size:14px;color:var(--muted);margin-top:5px;margin-bottom:18px}
.msg{padding:12px 14px;border-radius:10px;font-size:14px;margin-bottom:16px}
.ok{background:rgba(74,222,128,.12);border:1px solid rgba(74,222,128,.3);color:var(--green)}
.err{background:rgba(248,113,113,.1);border:1px solid rgba(248,113,113,.28);color:var(--red)}
.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:22px}
.field{margin-bottom:16px}
.field label{display:block;font-size:11px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:#8a9ab0;margin-bottom:8px}
.field-wrap{position:relative}
.field-icon{position:absolute;left:13px;top:50%;transform:translateY(-50%);color:var(--muted);pointer-events:none}
.field input{width:100%;height:46px;padding:0 14px 0 40px;background:var(--surface2);border:1px solid var(--border);border-radius:10px;color:var(--text);font-size:14px;font-family:'Syne',sans-serif;outline:none;transition:border-color .2s,box-shadow .2s}
.field input:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(124,58,237,.15)}
.field input::placeholder{color:var(--muted)}
.btn-save{height:46px;padding:0 24px;border:none;border-radius:11px;background:var(--accent);color:#fff;font-family:'Syne',sans-serif;font-weight:700;font-size:14px;cursor:pointer;transition:all .2s;box-shadow:0 4px 14px rgba(124,58,237,.3)}
.btn-save:hover{background:#6d28d9;transform:translateY(-1px)}
.last-submit{margin-top:12px;font-size:13px;color:var(--muted)}
</style>
</head>
<body>
<%@ include file="ParticipantTopNav.jsp"%>
<div class="page">
  <a href="/participant/my-hackathons" class="back">&larr; Back to My Hackathons</a>
  <h1 class="page-title">Submission</h1>
  <!-- EL kept: ${hackathon.title} -->
  <p class="page-sub">${hackathon.title}</p>

  <!-- EL kept: ${success} ${error} -->
  <c:if test="${success == 'saved'}"><div class="msg ok">Submission saved successfully.</div></c:if>
  <c:if test="${error == 'submissionClosed'}"><div class="msg err">Submission deadline has passed for this hackathon.</div></c:if>
  <c:if test="${not empty error and error != 'submissionClosed'}"><div class="msg err">${error}</div></c:if>

  <div class="card">
    <form action="/participant/hackathon/${hackathon.hackathonId}/submission/save" method="post">
      <input type="hidden" name="hackathonSubmissionId" value="${submission.hackathonSubmissionId}">
      <div class="field">
        <label>Code Base URL</label>
        <div class="field-wrap">
          <span class="field-icon">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg>
          </span>
          <input type="url" name="codeBaseUrl" value="${submission.codeBaseUrl}" placeholder="https://github.com/your-repo" required>
        </div>
      </div>
      <div class="field">
        <label>Documentation URL</label>
        <div class="field-wrap">
          <span class="field-icon">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
          </span>
          <input type="url" name="documentationUrl" value="${submission.documentationUrl}" placeholder="https://docs.google.com/..." required>
        </div>
      </div>
      <button class="btn-save" type="submit">Save Submission</button>
    </form>
    <c:if test="${not empty submission.submitedDate}">
      <p class="last-submit">Last submitted: ${submission.submitedDate}</p>
    </c:if>
  </div>
</div>
</body>
</html>
