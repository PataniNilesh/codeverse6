
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html><html lang="en"><head>
<title>User Management | ICH</title>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<jsp:include page="AdminCSS.jsp"></jsp:include>
<style>
.profile-thumb{width:38px;height:38px;border-radius:10px;object-fit:cover;border:1px solid #e4e8f2}
</style>
</head>
<body data-pc-preset="preset-1" data-pc-direction="ltr" data-pc-theme="light">
<div class="loader-bg"><div class="loader-track"><div class="loader-fill"></div></div></div>
<jsp:include page="AdminLeftSidebar.jsp"></jsp:include>
<jsp:include page="AdminHeader.jsp"></jsp:include>
<div class="pc-container"><div class="pc-content">

  <div class="page-header">
    <div style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;">
      <h4 class="mb-0">User Management</h4>
      <a href="newUser" class="btn btn-primary btn-sm">+ Add User</a>
    </div>
  </div>

  <div class="card">
    <div class="card-header"><h5 class="mb-0">User List</h5></div>
    <div class="card-body table-responsive">
      <table class="table table-bordered table-hover" style="text-align:center;">
        <thead class="table-secondary"><tr>
          <th>#</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Role</th><th>Gender</th><th>Birth Year</th><th>Contact</th><th>Photo</th><th>Status</th><th>Action</th>
        </tr></thead>
        <tbody>
          <c:if test="${empty userList}"><tr><td colspan="11" class="text-muted">No users found</td></tr></c:if>
          <c:forEach var="u" items="${userList}">
            <tr>
              <td>${u.userId}</td><td>${u.firstName}</td><td>${u.lastName}</td><td>${u.email}</td>
              <td><span class="badge bg-info">${u.role}</span></td>
              <td>${u.gender}</td><td>${u.birthYear}</td><td>${u.contactNum}</td>
              <td><img src="${u.profilePicUrl}" width="38" height="38" class="profile-thumb"></td>
              <td>
                <c:choose>
                  <c:when test="${u.active}"><span class="badge bg-success">Active</span></c:when>
                  <c:otherwise><span class="badge bg-danger">Inactive</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <a href="viewuser?userId=${u.userId}" class="btn btn-sm btn-info">View</a>
                <a href="editUser?userId=${u.userId}" class="btn btn-sm btn-warning">Edit</a>
                <a href="deleteuser?userId=${u.userId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

</div></div>
<jsp:include page="AdminFooter.jsp"></jsp:include>
</body></html>
