<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Save User Type</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    <h4>Add New User Type</h4>
                </div>

                <div class="card-body">
                    <form action="saveUserType" method="post">

                        <div class="mb-3">
                            <label class="form-label">User Type</label>
                            <input type="text"
                                   name="userType"
                                   class="form-control"
                                   placeholder="Enter user type"
                                   required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-success">
                                Save User Type
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
