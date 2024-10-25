<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="UTF-8">
    <title>INIT - HOME</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="${pageContext.request.contextPath }/resources/assets/img/project/favicon_black.png"
      style="border-radius: 50%;"
      type="image/x-icon"
    />

    <!-- Fonts and icons -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["${pageContext.request.contextPath }/resources/assets/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },      });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />
    
    <!--   Core JS Files   -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />
  </head>
  <body>
    <div class="wrapper">
      <%@ include file="/resources/assets/inc/sidebar.jsp" %> <!-- sidebar -->
      <div class="main-panel">
        <div class="main-header">
          <%@ include file="/resources/assets/inc/logo_header.jsp" %> <!-- Logo Header -->
          <%@ include file="/resources/assets/inc/navbar.jsp" %> <!-- Navbar -->
        </div>
        <div class="container">
          <div class="page-inner" style="background-color : rgba(250,250,250,0.7);">
<!------------------------------------------------------------------------------------------------------------------>
<!-- header start -->
<div style="display:flex; flex-direction:column; width: 100%; height:auto;">
	<div class="page-header">
	  <h3 class="fw-bold mb-3">HOME</h3>
	  <ul class="breadcrumbs mb-3">
	    <li class="nav-home">
	      <a href="#">
	        <i class="icon-home"></i>
	      </a>
	    </li>
	    <li class="separator">
	      <i class="icon-arrow-right"></i>
	    </li>
	    <li class="nav-item">
	      <a href="#">Something</a>
	    </li>
	    <li class="separator">
	      <i class="icon-arrow-right"></i>
	    </li>
	    <li class="nav-item">
	      <a href="#">something</a>
	    </li>
	  </ul>
	</div>
</div>
<!-- header end -->
<!-- contents start -->
<div style="display:flex; flex-direction:column; width: 100%; height:auto; ">
	<div style="display: flex; width:100%; justify-content: flex-end; padding-bottom:30px;">
			<div class="card-box button">
				<div class="card">
					<div class="card-body">
						<div><h3>즐겨찾기1</h3></div>
					</div>
				</div>
			</div>
			<div class="card-box button">
				<div class="card">
					<div class="card-body">
						<div>favorite2</div>
					</div>
				</div>
			</div>
			<div class="card-box button">
				<div class="card">
					<div class="card-body">
						<div>favorite3</div>
					</div>
				</div>
			</div>
			<div class="card-box button">
				<div class="card">
					<div class="card-body">
						<div>favorite4</div>
					</div>
				</div>
			</div>
	</div>
	
	<div style="display: flex; justify-content: center; gap: 30px; margin-top: 10px;">
		<div class="col-md-4">
			<div class="card-box md">
				<div class="card">
					<div class="card-header">
					<h4 class="card-title">WORKFLOWS</h4>
					</div>	
					<div style="display:flex; width: 100%; height:auto;">
					contents
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-4">
			<div class="card-box md">
				<div class="card">
					<div class="card-header">
					<h4 class="card-title">TITLE</h4>
					</div>	
					<div style="display:flex; width: 100%; height:auto;">
					contents
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-3">
			<div class="card-box md">
				<div class="card">
					<div class="card-header">
					<h4 class="card-title">TITLE</h4>
					</div>	
					<div style="display:flex; width: 100%; height:auto;">
					contents
					</div>
				</div>
			</div>
		</div>
	
		
	</div>
	
	
</div>
<!-- contents end -->
<!------------------------------------------------------------------------------------------------------------------>
          </div>
          <!-- page-inner -->
        </div>
		<!-- container -->
        <%@ include file="/resources/assets/inc/footer.jsp" %>
      </div>
      <!-- main-panel -->
    </div>
    <!-- main-wrapper -->
    
	<!-- jQuery Scrollbar -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
	
	<!-- Chart JS -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart.js/chart.min.js"></script>
	
	<!-- jQuery Sparkline -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>
	
	<!-- Chart Circle -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart-circle/circles.min.js"></script>
	
	<!-- Datatables -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/datatables/datatables.min.js"></script>
	
	<!-- Bootstrap Notify -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
	
	<!-- jQuery Vector Maps -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/world.js"></script>
	
	<!-- Sweet Alert -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/plugin/sweetalert/sweetalert.min.js"></script>
	
	<!-- Kaiadmin JS -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/kaiadmin.min.js"></script>
	
	<c:if test="${logined == true}">
	  	<%@ include file="/resources/assets/inc/login_alarm_modal.jsp" %>
	</c:if>
		
	
	</body>
</html>
