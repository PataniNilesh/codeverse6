<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- ================= ALERTS ================= -->
<div class="alerts">

  <!-- SUCCESS -->
  <c:if test="${success == 'memberInvited'}">
    <div class="alert alert-success">✓ Invitation sent to participant.</div>
  </c:if>

  <c:if test="${success == 'externalInvited'}">
    <div class="alert alert-success">✓ External invitation sent.</div>
  </c:if>

  <c:if test="${success == 'memberRemoved'}">
    <div class="alert alert-success">✓ Member removed successfully.</div>
  </c:if>

  <c:if test="${success == 'teamCreated'}">
    <div class="alert alert-success">✓ Team created. You are now leader.</div>
  </c:if>

  <c:if test="${success == 'teamJoined'}">
    <div class="alert alert-success">✓ Joined team successfully.</div>
  </c:if>

  <c:if test="${success == 'inviteAccepted'}">
    <div class="alert alert-success">✓ Invitation accepted.</div>
  </c:if>

  <c:if test="${success == 'inviteRejected'}">
    <div class="alert alert-success">✓ Invitation rejected.</div>
  </c:if>

  <!-- ERROR -->
  <c:if test="${error == 'teamFull'}">
    <div class="alert alert-error">✕ Team is full.</div>
  </c:if>

  <c:if test="${error == 'invalidUser'}">
    <div class="alert alert-error">✕ Invalid user selected.</div>
  </c:if>

  <c:if test="${error == 'alreadyInHackathon'}">
    <div class="alert alert-error">✕ User already in hackathon.</div>
  </c:if>

</div>


<!-- ================= SCENARIO A (NO TEAM) ================= -->
<c:if test="${not hasTeam}">

  <!-- Pending Invite -->
  <c:if test="${not empty pendingInvite}">
    <div class="invite-banner">

      <div class="card-title">Pending Team Invitation</div>

      <div class="invite-team-name">
        ${pendingInviteTeam != null ? pendingInviteTeam.teamName : 'a team'}
      </div>

      <p>You have been invited to join this team.</p>

      <div class="btn-row">
        <form method="post"
          action="/participant/hackathon/${hackathon.hackathonId}/team/invite/${pendingInvite.hackathonTeamInviteId}/accept">
          <button class="btn btn-primary">Accept</button>
        </form>

        <form method="post"
          action="/participant/hackathon/${hackathon.hackathonId}/team/invite/${pendingInvite.hackathonTeamInviteId}/reject">
          <button class="btn btn-danger">Reject</button>
        </form>
      </div>

    </div>
  </c:if>

  <div class="layout">

    <!-- CREATE TEAM -->
    <div class="col-left">
      <div class="card">
        <div class="card-title">Create Team</div>

        <form method="post"
          action="/participant/hackathon/${hackathon.hackathonId}/team/create">

          <input type="text" name="teamName" required placeholder="Team name"/>

          <button class="btn btn-primary">Create</button>
        </form>

      </div>
    </div>

    <!-- JOIN TEAM -->
    <div class="col-right">
      <div class="card">
        <div class="card-title">Join Team</div>

        <c:choose>

          <c:when test="${empty availableTeams}">
            <p>No teams available.</p>
          </c:when>

          <c:otherwise>
            <form method="post"
              action="/participant/hackathon/${hackathon.hackathonId}/team/join-existing">

              <select name="joinTeamId" required>
                <option value="">Select Team</option>

                <c:forEach items="${availableTeams}" var="t">
                  <option value="${t.hackathonTeamId}">
                    ${t.teamName}
                  </option>
                </c:forEach>

              </select>

              <button class="btn btn-primary">Join</button>
            </form>
          </c:otherwise>

        </c:choose>

      </div>
    </div>

  </div>

</c:if>


<!-- ================= SCENARIO B (HAS TEAM) ================= -->
<c:if test="${hasTeam}">

<div class="layout">

  <!-- TEAM MEMBERS -->
  <div class="col-left">
    <div class="card">
      <div class="card-title">
      	<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b"
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
            <circle cx="9" cy="7" r="4"/>
            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
        </svg>
      	Team Members
      </div>
		
	<div class="tbl-wrap">
	      <table>
	        <thead>
	          <tr>
	            <th>#</th>
	            <th>Member</th>
	            <th>Role</th>
	            <th>Action</th>
	          </tr>
	        </thead>
	
	        <tbody>
	
	          <c:forEach items="${teamMembers}" var="m" varStatus="i">
	            <tr>
	
	              <td>${i.count}</td>
	
	              <td>
                     <div class="member-cell">
                       <div class="mini-avatar">
                         First letter of name: ${fn:substring(memberMap[m.memberId].firstName,0,1)}
                       </div>
                       <div>
                         <div class="member-name">
                           ${memberMap[m.memberId].firstName} ${memberMap[m.memberId].lastName}
                         </div>
                         <div class="member-email">${memberMap[m.memberId].email}</div>
                       </div>
                     </div>
                   </td>
                   <td>
                     <span class="role-pill ${m.memberId == team.teamLeaderId ? 'role-leader' : 'role-member'}">
                       ${m.roleTitle}
                     </span>
                   </td>
	
	              <td>
	                <c:choose>
	
	                  <c:when test="${isTeamLeader and m.memberId != team.teamLeaderId}">
	                    <form method="post"
	                      action="/participant/hackathon/${hackathon.hackathonId}/team/remove-member">
	
	                      <input type="hidden" name="memberId" value="${m.memberId}"/>
	
	                      <button type="submit" class="btn-remove" onclick="return confirm('Remove this member?')">
                          	Remove
                          </button>
	
	                    </form>
	                  </c:when>
	
	                  <c:otherwise>—</c:otherwise>
	
	                </c:choose>
	              </td>
	
	            </tr>
	          </c:forEach>
	
	        </tbody>
	      </table>
      </div>
    </div>


    <!-- INVITE ACTIVITY -->
    <div class="card">
      <div class="card-title">
      	<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b"
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 10.23 19.79 19.79 0 0 1 1.62 1.67 2 2 0 0 1 3.62 0h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 7.91a16 16 0 0 0 6 6l.91-.91a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 15z"/>
        </svg>
      	Invite Activity
      </div>

      <div class="tbl-wrap">
	      <table>
	        <thead>
	          <tr>
	            <th>Type</th>
	            <th>Invitee</th>
	            <th>Status</th>
	            <th>Date</th>
	          </tr>
	        </thead>
	
	        <tbody>
	
	          <c:choose>
	
	            <c:when test="${empty inviteList}">
	              <tr>
	                <td colspan="4">No invites</td>
	              </tr>
	            </c:when>
	
	            <c:otherwise>
	
	              <c:forEach items="${inviteList}" var="i">
	                <tr>
	
	                  <td>${i.inviteType}</td>
	
	                  <td>
	                    <c:choose>
	                      <c:when test="${not empty i.invitedEmail}">
	                        ${i.invitedEmail}
	                      </c:when>
	                      <c:otherwise>
	                        User #${i.invitedUserId}
	                      </c:otherwise>
	                    </c:choose>
	                  </td>
	
	                  <td>
                        <span class="status-pill status-${fn:toLowerCase(i.inviteStatus)}">
                          ${i.inviteStatus}
                        </span>
                      </td>
	
	                  <td>${i.createdAt}</td>
	
	                </tr>
	              </c:forEach>
	
	            </c:otherwise>
	
	          </c:choose>
	
	        </tbody>
	      </table>
      </div>
    </div>

  </div>


  <!-- RIGHT SIDE (INVITES) -->
  <div class="col-right">

    <c:if test="${isTeamLeader and inviteAllowed}">

      <!-- REGISTERED INVITE -->
      <div class="card">
        <div class="card-title">
        	<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b"
	            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
	            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
	            <circle cx="12" cy="7" r="4"/>
	            <line x1="19" y1="8" x2="19" y2="14"/><line x1="22" y1="11" x2="16" y2="11"/>
          	</svg>
        	Invite Participant
        </div>

        <form method="post"
          action="/participant/hackathon/${hackathon.hackathonId}/team/invite-member">

          <div class="field">
            <label>Select Participant</label>
            <select name="invitedUserId" required>
              <option value="">Choose participant</option>

	            <c:forEach items="${participantUsers}" var="u">
	              <option value="${u.userId}">
	                ${u.firstName} ${u.lastName}
	              </option>
	            </c:forEach>

          	</select>
	 	  </div>
          <div class="btn-row">
            <button type="submit" class="btn btn-primary">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="white"
                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="22" y1="2" x2="11" y2="13"/>
                <polygon points="22 2 15 22 11 13 2 9 22 2"/>
              </svg>
              Send Invite
            </button>
          </div>

        </form>
        <p class="hint">Invite goes to pending state until the participant accepts it.</p>
      </div>

      <!-- EXTERNAL -->
      <div class="card">
        <div class="card-title">
        	<svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b"
	            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
	            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
	            <polyline points="22,6 12,13 2,6"/>
          	</svg>
        	Invite External
        </div>

        <form method="post"
          action="/participant/hackathon/${hackathon.hackathonId}/team/invite-external">

          <div class="field">
            <label>External Email</label>
            <input type="email" name="externalEmail" placeholder="name@example.com" required>
          </div>
          <div class="field">
            <label>Role Title</label>
            <input type="text" name="roleTitle" placeholder="MEMBER">
          </div>
          <div class="btn-row">
            <button type="submit" class="btn btn-primary">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="white"
                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="22" y1="2" x2="11" y2="13"/>
                <polygon points="22 2 15 22 11 13 2 9 22 2"/>
              </svg>
              Send External Invite
            </button>
          </div>
        </form>
        <p class="hint">External invite is stored as pending until accepted manually.</p>
      </div>

    </c:if>

    <!-- DISABLED -->
    <c:if test="${not isTeamLeader or not inviteAllowed}">
      <div class="card-disabled">
      	<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#64748b"
          stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
          style="margin:0 auto 10px;display:block;">
          <rect x="3" y="11" width="18" height="11" rx="2"/>
          <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
        </svg>
        <p>Invites not allowed.</p>
      </div>
    </c:if>

  </div>

</div>

</c:if>