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
<%-- ${evalListInfo } --%>
<div class="page-header">
              <h3 class="fw-bold mb-3">성과관리</h3>
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
                  <a href="/salary/salaryBasicInfo">성과관리</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">성과관리(관리자)</a>
                </li>
              </ul>
            </div>
        <div class="row">
              <div class="col-md-11">
                <div class="card">
                  <div class="card-header" style="display: flex; justify-content:space-between;">
	                    <div class="card-title">성과관리(관리자)</div>
                  </div>
                  <div class="card-body" style="padding-top: 10px;">
                    <table id="basic-datatables"
                        class="display table table-striped table-hover">
                      <thead>
                        <tr>
                          <th scope="col">선택</th>
                          <th scope="col">연도</th>
                          <th scope="col">반기</th>
                          <th scope="col">평가유형</th>
                          <th scope="col">성과평가명</th>
                          <th scope="col">평가시작일</th>
                          <th scope="col">평가종료일</th>
                          <th scope="col">상태</th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="list" items="${evalListInfo }">
                      	<tr>
                      		<td><input type="checkbox" data-id="eval_id" name="eval_id" value="${list.eval_id }"></td>
                      		<td>${list.year }</td>
                      		<td>${list.branch }</td>
                      		<td>${list.eval_type }</td>
                      		<td><a href="/eval/evalDetail?eval_id=${list.eval_id }">${list.eval_name }</a></td>
                      		<td>${list.eval_start_date }</td>
                      		<td>${list.eval_end_date }</td>
                      		<td>${list.eval_status }</td>
                      	</tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
               <div style="gap:5px; display: flex; justify-content: flex-end;">
                    	<a href="/eval/evalCreate"><button class="btn btn-primary">신규등록</button></a>
                   	<form id="deleteSubmit" action="/eval/deleteEvalInfo" method="post" style="display: inline-block;">
                   		<input type="hidden" id="inputForDelete" name="eval_id">
                   		<button type="submit" class="btn btn-danger" id="deleteBtn" disabled>삭제하기</button>
                   	</form>
                   	<form id="reportEvalSubmit" action="/eval/updateEvalInfoToReport" method="post" style="display: inline-block;">
                   		<input type="hidden" id="inputReportEval" name="eval_id">
                   		<button type="submit" class="btn btn-primary" id="reportEvalBtn" disabled>성과보고</button>
                   	</form>
                   	<form id="startEvalSubmit" action="/eval/startEval" method="post" style="display: inline-block;">
                   		<input type="hidden" id="inputStartEval" name="eval_id">
                   		<button type="submit" class="btn btn-primary" id="startEvalBtn" disabled>평가시작</button>
                   	</form>
                   	<form id="endEvalSubmit" action="/eval/endEval" method="post" style="display: inline-block;">
                   		<input type="hidden" id="inputEndEval" name="eval_id">
                   		<button type="submit" class="btn btn-primary" id="endEvalBtn" disabled>평가종료</button>
                   	</form>
                 	</div>
              </div>
            </div>
            
            
            <script>
        $(document).ready(function() {
        	
        	//데이터테이블 설정
        	$("#basic-datatables").DataTable({
        		pageLength: 5,
        		drawCallback: function() { //가운대 정렬
        			$('#basic-datatables th, #basic-datatables td').css({
        	            'text-align': 'center',
        	            'vertical-align': 'middle'
        	        });
        		}
        	});
        	
        	// 체크박스 체크여부에 다른 동작 분리(다중체크방지)
        	$('#basic-datatables tbody').on('click', 'input[type="checkbox"]', function() {
                if ($(this).is(':checked')) {
                    // 하나만 체크할 수 있도록 하는 기능
                    $('input[type="checkbox"]').not(this).prop('checked', false);
                }
            });
        	
        	// 체크여부에 따라 결재요청 버튼 활성화(체크버튼 클릭 + 평가준비)
        	$('#basic-datatables tbody').on('click', 'input[type="checkbox"]', function() {
        		var tdText = $(this).closest('tr').find('td:eq(7)').text();
	        	if($(this).is(':checked') && tdText === '평가준비') {
	                $('#deleteBtn').prop('disabled', false);
	                $('#reportEvalBtn').prop('disabled', false);
	        	} else {
                    $('#deleteBtn').prop('disabled', true);
                    $('#reportEvalBtn').prop('disabled', true);
                }
        	});
        	
        	// 체크여부에 따라 결재요청 버튼 활성화(체크버튼 클릭 + 성과보고)
        	$('#basic-datatables tbody').on('click', 'input[type="checkbox"]', function() {
        		var tdText = $(this).closest('tr').find('td:eq(7)').text();
	        	if($(this).is(':checked') && tdText === '성과보고') {
	                $('#startEvalBtn').prop('disabled', false);
	        	} else {
                    $('#startEvalBtn').prop('disabled', true);
                }
        	});
        	
        	// 체크여부에 따라 결재요청 버튼 활성화(체크버튼 클릭 + 평가시작)
        	$('#basic-datatables tbody').on('click', 'input[type="checkbox"]', function() {
        		var tdText = $(this).closest('tr').find('td:eq(7)').text();
	        	if($(this).is(':checked') && tdText === '평가시작') {
	                $('#endEvalBtn').prop('disabled', false);
	        	} else {
                    $('#endEvalBtn').prop('disabled', true);
                }
        	});
        	
        	// 삭제버튼 시 리스트id 가지고 이동하기
            $('#deleteBtn').click(function(event){
            	event.preventDefault();
            	swal({
     	              title: "삭제하시겠습니까?",
     	              text: "삭제 후에는 신규등록을 통해 재등록 가능합니다.",
     	              type: "warning",
     	              buttons: {
     	                cancel: {
     	                  visible: true,
     	                  text: "취소하기",
     	                  className: "btn btn-danger",
     	                },
     	                confirm: {
     	                  text: "삭제하기",
     	                  className: "btn btn-success",
     	                },
     	              },
     	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
     	             if (willDelete) {
     	            	$('#inputForDelete').val($('input[name="eval_id"]:checked').val());
     	            	swal({
     	            	    title: "Success!",
     	            	    text: "삭제완료",
     	            	    icon: "success",
     	            	    buttons: "OK", 
     	            	}).then(function() {
     	            		$('#deleteSubmit').submit();
                        });
   	             	}
                    });
   	     	 });
        	
         // 성과보고 클릭 시 리스트id 가지고 이동하기
            $('#reportEvalBtn').click(function(event){
            	event.preventDefault();
            	swal({
     	              title: "성과보고를 시작하시겠습니까?",
     	              text: "성과보고 후에는 삭제가 불가능합니다.",
     	              type: "warning",
     	              buttons: {
     	                cancel: {
     	                  visible: true,
     	                  text: "취소하기",
     	                  className: "btn btn-danger",
     	                },
     	                confirm: {
     	                  text: "성과보고",
     	                  className: "btn btn-success",
     	                },
     	              },
     	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
     	             if (willDelete) {
     	            	$('#inputReportEval').val($('input[name="eval_id"]:checked').val());
     	            	swal({
     	            	    title: "Success!",
     	            	    text: "변경완료",
     	            	    icon: "success",
     	            	    buttons: "OK", 
     	            	}).then(function() {
     	            		$('#reportEvalSubmit').submit();
                        });
   	             	}
                    });
   	     	 });
        	
         // 평가시작 클릭 시 리스트id 가지고 이동하기
            $('#startEvalBtn').click(function(event){
            	event.preventDefault();
            	swal({
     	              title: "성과평가를 시작하시겠습니까?",
     	              text: "성과 미보고자가 없는지 확인하시기 바랍니다.",
     	              type: "warning",
     	              buttons: {
     	                cancel: {
     	                  visible: true,
     	                  text: "취소하기",
     	                  className: "btn btn-danger",
     	                },
     	                confirm: {
     	                  text: "평가시작",
     	                  className: "btn btn-success",
     	                },
     	              },
     	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
     	             if (willDelete) {
     	            	$('#inputStartEval').val($('input[name="eval_id"]:checked').val());
     	            	swal({
     	            	    title: "Success!",
     	            	    text: "변경완료",
     	            	    icon: "success",
     	            	    buttons: "OK", 
     	            	}).then(function() {
     	            		$('#startEvalSubmit').submit();
                        });
   	             	}
                    });
   	     	 });
        	
         // 평가종료 클릭 시 리스트id 가지고 이동하기
            $('#endEvalBtn').click(function(event){
            	event.preventDefault();
            	swal({
     	              title: "성과평가를 종료하시겠습니까?",
     	              text: "평가 미완료자가 없는지 확인하시기 바랍니다.",
     	              type: "warning",
     	              buttons: {
     	                cancel: {
     	                  visible: true,
     	                  text: "취소하기",
     	                  className: "btn btn-danger",
     	                },
     	                confirm: {
     	                  text: "평가종료",
     	                  className: "btn btn-success",
     	                },
     	              },
     	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
     	             if (willDelete) {
     	            	$('#inputEndEval').val($('input[name="eval_id"]:checked').val());
     	            	swal({
     	            	    title: "Success!",
     	            	    text: "변경완료",
     	            	    icon: "success",
     	            	    buttons: "OK", 
     	            	}).then(function() {
     	            		$('#endEvalSubmit').submit();
                        });
   	             	}
                    });
   	     	 });
        	
        	
        	
        	
        	
        	
        	
         	
        });
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
