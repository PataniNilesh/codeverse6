<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Team | ICH</title>
<link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c27;--border:#2a2a3d;--accent:#7c3aed;--accent2:#06b6d4;--text:#e2e8f0;--muted:#64748b;--green:#4ade80;--red:#f87171;--amber:#fbbf24;--glow:rgba(124,58,237,.3)}
html,body{font-family:'Syne',sans-serif;background:var(--bg);color:var(--text);min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(124,58,237,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(124,58,237,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
.page{position:relative;z-index:1;max-width:1100px;margin:0 auto;padding:24px 20px 40px}
.page-top{display:flex;align-items:flex-end;justify-content:space-between;gap:12px;flex-wrap:wrap;margin-bottom:18px}
.back{color:var(--muted);text-decoration:none;font-weight:700;font-size:14px;display:block;margin-bottom:6px}
.back:hover{color:var(--text)}
.page-title{font-size:24px;font-weight:800}
.page-sub{font-size:14px;color:var(--muted);margin-top:4px}
.meta-chip{display:inline-flex;padding:6px 12px;border-radius:100px;background:var(--surface2);border:1px solid var(--border);font-family:'Space Mono',monospace;font-size:12px;color:var(--muted)}
.msg{padding:11px 14px;border-radius:10px;font-size:14px;margin-bottom:14px}
.ok{background:rgba(74,222,128,.12);border:1px solid rgba(74,222,128,.3);color:var(--green)}
.err{background:rgba(248,113,113,.1);border:1px solid rgba(248,113,113,.28);color:var(--red)}
.grid{display:grid;grid-template-columns:1.2fr 0.8fr;gap:16px}
.card{background:var(--surface);border:1px solid var(--border);border-radius:14px;padding:18px;margin-bottom:0}
.card h3{font-size:15px;font-weight:800;margin-bottom:14px}
.form-group{margin-bottom:14px}
.form-group label{display:block;font-size:11px;font-weight:700;font-family:'Space Mono',monospace;letter-spacing:.5px;text-transform:uppercase;color:#8a9ab0;margin-bottom:7px}
.form-group input,.form-group select{width:100%;height:44px;border-radius:10px;border:1px solid var(--border);background:var(--surface2);color:var(--text);padding:0 13px;font-family:'Syne',sans-serif;font-size:14px;outline:none;transition:border-color .2s,box-shadow .2s;appearance:none}
.form-group input:focus,.form-group select:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(124,58,237,.15)}
.form-group input::placeholder{color:var(--muted)}
.form-group select option{background:var(--surface2)}
.hint{font-size:12px;color:var(--muted);margin-top:7px;line-height:1.5}
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse}
th,td{padding:10px 10px;border-bottom:1px solid var(--border);text-align:left;font-size:13px}
th{font-size:10px;font-family:'Space Mono',monospace;letter-spacing:1px;text-transform:uppercase;color:var(--muted)}
td{color:#b8c7d8}
tbody tr:last-child td{border-bottom:none}
.btn{border:none;border-radius:10px;height:40px;padding:0 16px;color:#fff;font-weight:700;font-size:13px;cursor:pointer;transition:all .2s;font-family:'Syne',sans-serif}
.btn-primary{background:linear-gradient(135deg,var(--accent),#5b27bd);box-shadow:0 2px 10px var(--glow)}
.btn-primary:hover{background:#6d28d9;transform:translateY(-1px)}
.btn-danger{background:rgba(248,113,113,.15);color:var(--red);border:1px solid rgba(248,113,113,.3)}
.btn-danger:hover{background:rgba(248,113,113,.25)}
.btn-sm{height:34px;padding:0 12px;font-size:12px;border-radius:9px}
.btn-row{display:flex;gap:8px;flex-wrap:wrap}
.badge{display:inline-flex;padding:3px 8px;border-radius:100px;font-family:'Space Mono',monospace;font-size:10px;font-weight:700}
.badge-amber{background:rgba(251,191,36,.1);color:var(--amber);border:1px solid rgba(251,191,36,.25)}
.badge-green{background:rgba(74,222,128,.12);color:var(--green);border:1px solid rgba(74,222,128,.25)}
@media(max-width:900px){.grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<%@ include file="ParticipantTopNav.jsp"%>
<div class="page">
  <div class="page-top">
    <div>
      <!-- EL kept: ${hackathon.hackathonId} ${hackathon.title} -->
      <a href="/participant/hackathon/${hackathon.hackathonId}" class="back">&larr; Back to Details</a>
      <h1 class="page-title">Manage Team</h1>
      <p class="page-sub">${hackathon.title}</p>
    </div>
    <!-- EL kept: ${teamSizeCount} ${teamMaxSize} -->
    <div class="meta-chip">Members: ${teamSizeCount}/${teamMaxSize}</div>
  </div>

  <!-- All success/error EL kept exactly -->
  <c:if test="${success == 'memberInvited'}"><div class="msg ok">Invitation sent to participant. They must accept to join.</div></c:if>
  <c:if test="${success == 'externalInvited'}"><div class="msg ok">External invite saved successfully.</div></c:if>
  <c:if test="${success == 'memberRemoved'}"><div class="msg ok">Member removed from team successfully.</div></c:if>
  <c:if test="${success == 'teamCreated'}"><div class="msg ok">Team created successfully. You are now team leader.</div></c:if>
  <c:if test="${success == 'teamJoined'}"><div class="msg ok">You joined team successfully.</div></c:if>
  <c:if test="${success == 'inviteAccepted'}"><div class="msg ok">Invitation accepted. You are now part of that team.</div></c:if>
  <c:if test="${success == 'inviteRejected'}"><div class="msg ok">Invitation rejected.</div></c:if>
  <c:if test="${error == 'teamFull'}"><div class="msg err">Your team is full. You cannot add more members.</div></c:if>
  <c:if test="${error == 'invalidUser'}"><div class="msg err">Selected user is invalid for team invite.</div></c:if>
  <c:if test="${error == 'alreadyInHackathon'}"><div class="msg err">This participant is already part of a team in this hackathon.</div></c:if>
  <c:if test="${error == 'invalidTeamName'}"><div class="msg err">Please enter a valid team name.</div></c:if>
  <c:if test="${error == 'invalidTeam'}"><div class="msg err">Selected team is invalid for this hackathon.</div></c:if>
  <c:if test="${error == 'invalidEmail'}"><div class="msg err">Please enter a valid external email.</div></c:if>
  <c:if test="${error == 'inviteExists'}"><div class="msg err">Pending invite already exists for this email.</div></c:if>
  <c:if test="${error == 'inviteNotFound' || error == 'inviteInvalid'}"><div class="msg err">Invitation is invalid or no longer available.</div></c:if>
  <c:if test="${error == 'submissionClosed'}"><div class="msg err">Submission deadline has passed for this hackathon.</div></c:if>
  <c:if test="${error == 'inviteClosed'}"><div class="msg err">Invitations are closed after registration end date.</div></c:if>
  <c:if test="${error == 'notLeader'}"><div class="msg err">Only team leader can remove participants.</div></c:if>
  <c:if test="${error == 'cannotRemoveLeader'}"><div class="msg err">Team leader cannot be removed from team.</div></c:if>
  <c:if test="${error == 'memberNotFound'}"><div class="msg err">Selected member was not found in this team.</div></c:if>

  <!-- No team yet -->
  <c:if test="${not hasTeam}">
    <div class="grid">
      <!-- Pending invite -->
      <c:if test="${not empty pendingInvite}">
        <div class="card">
          <h3>&#128276; Pending Team Invitation</h3>
          <p style="color:var(--muted);font-size:14px;margin-bottom:14px">You have been invited to join <b style="color:var(--text)"><c:out value="${pendingInviteTeam != null ? pendingInviteTeam.teamName : 'a team'}"/></b>.</p>
          <div class="btn-row">
            <form action="/participant/hackathon/${hackathon.hackathonId}/team/invite/${pendingInvite.hackathonTeamInviteId}/accept" method="post">
              <button type="submit" class="btn btn-primary btn-sm">Accept Invitation</button>
            </form>
            <form action="/participant/hackathon/${hackathon.hackathonId}/team/invite/${pendingInvite.hackathonTeamInviteId}/reject" method="post">
              <button type="submit" class="btn btn-danger btn-sm">Reject</button>
            </form>
          </div>
        </div>
      </c:if>

      <!-- Create team -->
      <div class="card">
        <h3>Create Your Team</h3>
        <form action="/participant/hackathon/${hackathon.hackathonId}/team/create" method="post">
          <div class="form-group">
            <label>Team Name</label>
            <input type="text" name="teamName" placeholder="Enter team name" required>
          </div>
          <button type="submit" class="btn btn-primary btn-sm">Create Team</button>
        </form>
        <p class="hint" style="margin-top:10px">You can create only one team per hackathon.</p>
      </div>

      <!-- Join existing -->
      <div class="card">
        <h3>Join Existing Team</h3>
        <c:choose>
          <c:when test="${empty availableTeams}">
            <p style="color:var(--muted);font-size:14px">No open teams available to join right now.</p>
          </c:when>
          <c:otherwise>
            <form action="/participant/hackathon/${hackathon.hackathonId}/team/join-existing" method="post">
              <div class="form-group">
                <label>Select Team</label>
                <select name="joinTeamId" required>
                  <option value="">Choose team</option>
                  <c:forEach items="${availableTeams}" var="t">
                    <option value="${t.hackathonTeamId}">${t.teamName}</option>
                  </c:forEach>
                </select>
              </div>
              <button type="submit" class="btn btn-primary btn-sm">Join Team</button>
            </form>
          </c:otherwise>
        </c:choose>
        <p class="hint" style="margin-top:10px">After joining, you cannot create another team in this hackathon.</p>
      </div>
    </div>
  </c:if>

  <!-- Has team -->
  <c:if test="${hasTeam}">
    <div class="grid">
      <!-- Team members -->
      <div class="card">
        <h3>Team Members</h3>
        <div class="table-wrap">
          <table>
            <thead><tr><th>#</th><th>Name</th><th>Email</th><th>Role</th><th>Action</th></tr></thead>
            <tbody>
              <c:forEach items="${teamMembers}" var="m" varStatus="i">
                <tr>
                  <td>${i.count}</td>
                  <td>${memberMap[m.memberId].firstName} ${memberMap[m.memberId].lastName}</td>
                  <td>${memberMap[m.memberId].email}</td>
                  <td>${m.roleTitle}</td>
                  <td>
                    <c:choose>
                      <c:when test="${isTeamLeader and m.memberId != team.teamLeaderId}">
                        <form action="/participant/hackathon/${hackathon.hackathonId}/team/remove-member" method="post" style="display:inline">
                          <input type="hidden" name="memberId" value="${m.memberId}">
                          <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Remove this member?')">Remove</button>
                        </form>
                      </c:when>
                      <c:otherwise><span style="color:var(--muted);font-size:12px">&mdash;</span></c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Right panel -->
      <div style="display:flex;flex-direction:column;gap:14px">

        <!-- Invite registered -->
        <c:if test="${hasTeam and isTeamLeader and inviteAllowed}">
          <div class="card">
            <h3>Invite Registered Participant</h3>
            <form action="/participant/hackathon/${hackathon.hackathonId}/team/invite-member" method="post">
              <div class="form-group">
                <label>Select Participant</label>
                <select name="invitedUserId" required>
                  <option value="">Choose participant</option>
                  <c:forEach items="${participantUsers}" var="u">
                    <option value="${u.userId}">${u.firstName} ${u.lastName} &mdash; ${u.email}</option>
                  </c:forEach>
                </select>
              </div>
              <button type="submit" class="btn btn-primary btn-sm">Send Invite</button>
            </form>
            <p class="hint" style="margin-top:8px">Invite goes to pending until participant accepts.</p>
          </div>
        </c:if>

        <!-- Invite external -->
        <c:if test="${hasTeam and isTeamLeader and inviteAllowed}">
          <div class="card">
            <h3>Invite External User</h3>
            <form action="/participant/hackathon/${hackathon.hackathonId}/team/invite-external" method="post">
              <div class="form-group"><label>External Email</label><input type="email" name="externalEmail" placeholder="name@example.com" required></div>
              <div class="form-group"><label>Role Title</label><input type="text" name="roleTitle" placeholder="MEMBER"></div>
              <button type="submit" class="btn btn-primary btn-sm">Send External Invite</button>
            </form>
          </div>
        </c:if>

        <!-- Invites closed -->
        <c:if test="${hasTeam and isTeamLeader and not inviteAllowed}">
          <div class="card"><h3>Invite Members</h3><p class="hint">Invitations are disabled because registration has ended.</p></div>
        </c:if>
        <c:if test="${hasTeam and not isTeamLeader}">
          <div class="card"><h3>Invite Members</h3><p class="hint">Only the team leader can send invitations.</p></div>
        </c:if>

        <!-- Invite activity -->
        <c:if test="${hasTeam}">
          <div class="card">
            <h3>Invite Activity</h3>
            <div class="table-wrap">
              <table>
                <thead><tr><th>Type</th><th>Invitee</th><th>Status</th><th>Date</th></tr></thead>
                <tbody>
                  <c:if test="${empty inviteList}"><tr><td colspan="4" style="color:var(--muted)">No invites yet.</td></tr></c:if>
                  <c:forEach items="${inviteList}" var="inv">
                    <tr>
                      <td>${inv.inviteType}</td>
                      <td><c:choose><c:when test="${not empty inv.invitedEmail}">${inv.invitedEmail}</c:when><c:otherwise>User #${inv.invitedUserId}</c:otherwise></c:choose></td>
                      <td><span class="badge ${inv.inviteStatus == 'PENDING' ? 'badge-amber' : 'badge-green'}">${inv.inviteStatus}</span></td>
                      <td>${inv.createdAt}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </c:if>
      </div>
    </div>
  </c:if>
</div>
</body>
</html>
