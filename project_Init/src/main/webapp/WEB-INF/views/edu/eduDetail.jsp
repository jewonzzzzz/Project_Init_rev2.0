<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Kaiadmin - Bootstrap 5 Admin Dashboard</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="${pageContext.request.contextPath }/resources/assets/img/kaiadmin/favicon.ico"
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
        },
      });
    </script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />

  </head>
  <body>
    <div class="wrapper">
      <%@ include file="/resources/assets/inc/sidebar.jsp" %> <!-- sidebar -->
      <div class="main-panel">
        <div class="main-header">
          <%@ include file="/resources/assets/inc/logo_header.jsp" %> <!-- Logo Header -->
          <%@ include file="/resources/assets/inc/navbar.jsp" %> <!-- Navbar Header -->
        </div>
        <div class="container">
          <div class="page-inner">
<!------------------------------------------------------------------------------------------------------------------>

	      <div class="page-header" style="margin-bottom: 0px;">
              <h3 class="fw-bold mb-3">교육조회</h3>
              <ul class="breadcrumbs mb-3">
                <li class="nav-home">
                  <a href="/salary/main">
                    <i class="icon-home"></i>
                  </a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="/salary/salaryBasicInfo">교육</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">교육조회</a>
                </li>
              </ul>
            </div>
            
          <form id="eduApplyForm" action="/edu/eduApply" method="post" enctype="multipart/form-data">
            <div class="row">
              <div class="col-md-11">
                <div class="card">
                  <div class="card-header" style="display: flex; justify-content:space-between; margin-right: 10px;">
                    <div class="card-title">교육 상세조회</div>
                    <div>
		              <button type="submit" id="eduApplyBtn" class="btn btn-primary">신청하기</button>
		              <button type="button" class="btn btn-primary" onclick="history.back()">목록으로</button>
		            </div>
                    </div>
                  <div class="card-body">
                    <div class="row"> 
                      <div class="col-md-3">
                         <div style="width: 100%; height: 100%; overflow: hidden; position: relative;">
					        <img src="${eduInfo.edu_thumbnail_src }" id="thumbnail" style="width: 100%; height: auto; 
					        position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); border-radius: 15px;" />
					    </div>
                      </div>
                      
                      <div class="col-md-9">
                      	<div class="form-group" style="display: flex; gap:10px;">
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육구분</b></label>
                          <select class="form-select form-control" id="defaultSelect" name="edu_type" disabled>
                            <option value="사내교육" <c:if test="${eduInfo.edu_type == '사내교육'}">selected</c:if>>사내교육</option>
                            <option value="외부교육" <c:if test="${eduInfo.edu_type == '외부교육'}">selected</c:if>>외부교육</option>
                          </select>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>강사명</b></label>
                          <input name="edu_teacher" type="text" class="form-control" value="${eduInfo.edu_teacher }" readonly>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육장소</b></label>
                          <input name="edu_place" type="text" class="form-control" value="${eduInfo.edu_place }" readonly>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육인원</b></label>
                          <input name="edu_personnel" type="number" class="form-control" value="${eduInfo.edu_personnel }" readonly>
                        </div>
                      </div>
	                    <div class="form-group">
                          <label class="mb-2" style="font-size:16px !important"><b>교육명</b></label>
                          <input name="edu_name" type="text" class="form-control"  value="${eduInfo.edu_name }" readonly>
                        </div>
	                    <div class="form-group">
	                          <label class="mb-2" style="font-size:16px !important"><b>교육 상세내용</b></label>
                          <textarea name="edu_content" class="form-control" id="comment" rows="5" readonly>${eduInfo.edu_content } 
                          </textarea>
                        </div>
                      <div class="form-group" style="display: flex; gap:10px; width:100%;">
                      <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 시작일</b></label>
                          <input name="edu_start_date" type="date" class="form-control" value="${eduInfo.edu_start_date }" readonly>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 종료일</b></label>
                          <input name="edu_end_date"type="date" class="form-control" value="${eduInfo.edu_end_date }" readonly>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 접수마감일</b></label>
                          <input name="edu_apply_end" type="date" class="form-control" value="${eduInfo.edu_apply_end }" readonly>
                        </div>
                      </div>
                      
                      </div>
                  	</div>
                    </div>
                  </div>
                </div>
              </div>
              <input name="edu_id" type="hidden" value="${eduInfo.edu_id }">
          </form>     
                 
        <script>
        $(document).ready(function (){
        	
        	//신청하기 버튼 클릭 시 submit하기(썸네일 없을 시 swal)
            $('#eduApplyBtn').click(function(event){
            	event.preventDefault();
	            	swal({
	   	              title: "교육을 신청하시겠습니까?",
	   	              text: "교육신청정보는 교육이력관리에서 확인할 수 있습니다.",
	   	              type: "warning",
	   	              buttons: {
	   	                cancel: {
	   	                  visible: true,
	   	                  text: "취소하기",
	   	                  className: "btn btn-danger",
	   	                },
	   	                confirm: {
	   	                  text: "교육신청",
	   	                  className: "btn btn-success",
	   	                },
	   	              },
	   	            }).then(function(willDelete) {
	   	             if (willDelete) {
	   	            	swal({
	   	            	    title: "Success!",
	   	            	    text: "교육신청 완료",
	   	            	    icon: "success",
	   	            	    buttons: "OK", 
	   	            	}).then(function() {
	   	            		$('#eduApplyForm').submit();
	                      });
	 	             	}
	                  });
        	});
        
        }); //ready
        </script>
                 
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
    
    <!--   Core JS Files   -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>

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

    <script>
      $("#lineChart").sparkline([102, 109, 120, 99, 110, 105, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#177dff",
        fillColor: "rgba(23, 125, 255, 0.14)",
      });

      $("#lineChart2").sparkline([99, 125, 122, 105, 110, 124, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#f3545d",
        fillColor: "rgba(243, 84, 93, .14)",
      });

      $("#lineChart3").sparkline([105, 103, 123, 100, 95, 105, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#ffa534",
        fillColor: "rgba(255, 165, 52, .14)",
      });
    </script>
  </body>
</html>
