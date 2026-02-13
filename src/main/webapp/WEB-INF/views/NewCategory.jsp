<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Category</title>

    <jsp:include page="AdminCSS.jsp"></jsp:include>
    
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    <h4>Add New Category</h4>
                </div>

                <div class="card-body">
                    <form action="saveCategory" method="post">

                        <div class="mb-3">
                            <label class="form-label">Category Name</label>
                            <input type="text" 
                                   name="categoryName" 
                                   class="form-control" 
                                   placeholder="Enter category name"
                                   required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-success">
                                Add Category
                            </button>
                            
                            <a href="admin-dashboard" class="btn btn-secondary">
                            	Cancel
                            </a>
                        </div>

                    </form>
                </div>

            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
