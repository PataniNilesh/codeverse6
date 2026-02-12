<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Category List</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h4 class="mb-0">Category List</h4>
        </div>

        <div class="card-body">

            <table class="table table-bordered table-hover text-center">
                <thead class="table-secondary">
                    <tr>
                        <th>#</th>
                        <th>Category Name</th>
                        <th>Active</th>
                    </tr>
                </thead>

                <tbody>
                    	<c:if test="${empty categoryList}">
							<tr>
								<td colspan="4" class="text-center text-muted">No
									categories found</td>
							</tr>
						</c:if>
	
						<c:forEach var="cat" items="${categoryList}" varStatus="i">
							<tr>
								<td>${i.index + 1}</td>
								<td>${cat.categoryName}</td>
	
								<td><c:choose>
										<c:when test="${cat.active}">
											<span class="badge bg-success">Active</span>
										</c:when>
										<c:otherwise>
											<span class="badge bg-danger">Inactive</span>
										</c:otherwise>
									</c:choose></td>
	
								<td><a href="editCategory?id=${cat.categoryId}"
									class="btn btn-sm btn-warning">Edit</a> <a
									href="deleteCategory?id=${cat.categoryId}"
									class="btn btn-sm btn-danger"
									onclick="return confirm('Are you sure you want to delete this category?')">
										Delete </a></td>
							</tr>
						</c:forEach>>

                </tbody>
            </table>

        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
