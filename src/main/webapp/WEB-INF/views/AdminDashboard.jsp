<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    
    <jsp:include page="AdminCSS.jsp"></jsp:include>

</head>

<body>

<!-- ================= HEADER ================= -->
<jsp:include page="AdminHeader.jsp"></jsp:include>

<!-- ================= BODY ================= -->
<div class="container-fluid">
    <div class="row">
		
		
		<!-- ===== LEFT SIDEBAR ===== -->
		<jsp:include page="AdminSidebar.jsp"></jsp:include>
		       
        

        <!-- ===== MAIN CONTENT ===== -->
        <div class="col-md-10 p-4">
            <h3>Dashboard</h3>
            <p>This is your admin dashboard main content area.</p>

            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card shadow">
                        <div class="card-body">
                            <h5>Total Categories</h5>
                            <p>10</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow">
                        <div class="card-body">
                            <h5>Total Products</h5>
                            <p>50</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow">
                        <div class="card-body">
                            <h5>Total Users</h5>
                            <p>20</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- ================= FOOTER ================= -->
<jsp:include page="AdminFooter.jsp"></jsp:include>




</body>
</html>
