<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>User List</title>

    <!-- Common Admin CSS -->
    <jsp:include page="AdminCSS.jsp"></jsp:include>
</head>

<body>

<!-- ================= HEADER ================= -->
<jsp:include page="AdminHeader.jsp"></jsp:include>

<!-- ================= BODY ================= -->
<div class="container-fluid">
    <div class="row">

        <!-- ================= SIDEBAR ================= -->
        <jsp:include page="AdminSidebar.jsp"></jsp:include>

        <!-- ================= MAIN CONTENT ================= -->
        <div class="col-md-10 p-4">

            <div class="card shadow">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">User List</h4>
                </div>

                <div class="card-body table-responsive">

                    <table class="table table-bordered table-hover text-center align-middle">
                        <thead class="table-secondary">
                            <tr>
                                <th>#</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Gender</th>
                                <th>Birth Year</th>
                                <th>Contact</th>
                                <th>Profile Pic</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="u" items="${userList}">
                                <tr>
                                    <td>${u.userId}</td>
                                    <td>${u.firstName}</td>
                                    <td>${u.lastName}</td>
                                    <td>${u.email}</td>

                                    <td>
                                        <span class="badge bg-info text-dark">
                                            ${u.role}
                                        </span>
                                    </td>

                                    <td>${u.gender}</td>
                                    <td>${u.birthYear}</td>
                                    <td>${u.contactNum}</td>

                                    <td>
                                        <img src="${u.profilePicUrl}"
                                             width="40"
                                             height="40"
                                             class="rounded-circle">
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${u.active}">
                                                <span class="badge bg-success">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    
                                    <td><a href="editUser?userId=${u.userId }"
                                    	class="btn btn-sm btn-warning">Edit</a> <a
                                    	href="deleteUser?userId=${u.userId }"
                                    	class="btn btn-sm btn-danger"
                                    	onclick="return confirm('Are you sure?');"> Delete</a>
                                    
                                    	<a class="btn btn-secondary" href="viewuser?userId=${u.userId}">View</a>
                                   	</td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>

                </div>
            </div>

        </div>
    </div>
</div>

<!-- ================= FOOTER ================= -->
<jsp:include page="AdminFooter.jsp"></jsp:include>

</body>
</html>
