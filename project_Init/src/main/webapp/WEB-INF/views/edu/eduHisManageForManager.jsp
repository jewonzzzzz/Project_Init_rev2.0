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
<%-- ${eduHisListInfoBase } --%>

<div class="page-header">
              <h3 class="fw-bold mb-3">교육이력관리(관리자)</h3>
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
                  <a href="#">교육이력관리(관리자)</a>
                </li>
              </ul>
            </div>
            
            <div class="row">
              <div class="col-md-11">
              <div class="form">
                      <div style="display: flex; margin-bottom: 10px; gap:5px; justify-content: flex-end;">
                          <select
                            class="form-select input-fixed"
                            id="typeSelect"
                          >
                          	<option value="edu_name">교육명</option>
                            <option value="emp_id">사원번호</option>
                            <option value="emp_name">사원이름</option>
                          </select>
                          <div style="width: 200px;">
                          <input
                              type="text"
                              class="form-control input-full"
                              id="eduInfo"
                              placeholder="필요한 정보를 입력하세요"
                            />
                           </div>
                          <button type="button" class="btn btn-primary" id="inquiryBtn"> 조회하기 </button>
                    	 <button type="button" id="checkAllBtn" class="btn btn-primary">
                            전체선택
                          </button>
                          
                          <form id="completeEduSubmit" action="/edu/completeEduInfo" method="post" style="display: inline-block;">
                    		<input type="hidden" id="inputForCompleteEdu" name="completeEudIds">
                    		<button type="submit" class="btn btn-primary" id="completeEduBtn" disabled>이수처리</button>
                    	</form>
                    	
                          <form id="nonCompleteEduSubmit" action="/edu/nonCompleteEduInfo" method="post" style="display: inline-block;">
                    		<input type="hidden" id="inputForNonCompleteEdu" name="nonCompleteEudIds">
                    		<button type="submit" class="btn btn-primary" id="nonCompleteEduBtn" disabled>미이수처리</button>
                    	</form>
                    </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">교육이력관리(관리자)</div>
                  </div>
                  
                  <div class="card-body">
                    <div class="table-responsive">
                      <table
                        id="basic-datatables"
                        class="display table table-striped table-hover"
                      >
                        <thead>
                          <tr>
                          <th>선택</th>
                          <th>사번</th>
                          <th>이름</th>
                          <th>교육명</th>
                          <th>교육시작일</th>
                          <th>교육종료일</th>
                          <th>상태</th>
                          </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="list" items="${eduHisListInfoBase }">
                        	<tr>
                       		<td><input type="checkbox" data-id="${list.edu_his_id }" name="edu_his_id" value="${list.edu_his_id }"></td>
                      		<td>${list.emp_id }</td>
                      		<td>${list.emp_name }</td>
                      		<td>${list.edu_name }</td>
                      		<td>${list.edu_start_date }</td>
                      		<td>${list.edu_end_date }</td>
                      		<td>${list.edu_status }</td>
                        	</tr>
                        </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
              
              	
            </div>
            </div>
            
            <script>
        $(document).ready(function() {
            
        	// 전체 선택하기 
        	$('#checkAllBtn').click(function(){
        		var checkStatus = $('input[type="checkbox"]').length === $('input[type="checkbox"]:checked').length;
        		$('input[type="checkbox"]').prop('checked', !checkStatus);
        		compareCheckStatus();
        	});
        	
        	// 개별 체크박스 클릭 이벤트
            $('#basic-datatables tbody').on('change', 'input[type="checkbox"]', function () {
                compareCheckStatus(); // 체크 상태 비교
            });
        	
        	// 체크박스 상태를 비교하는 함수 정의
        	function compareCheckStatus() {
                const checkedCount = $('tr').filter(function () {
                    return $(this).find('td:eq(6)').text() === '교육확정' &&
                           $(this).find('input[type="checkbox"]').is(':checked');
                }).length;

                const totalCheckedCount = $('input[type="checkbox"]:checked').length;

                // 버튼 활성화/비활성화 로직
                if (totalCheckedCount > 0 && checkedCount === totalCheckedCount) {
                    $('#completeEduBtn').prop('disabled', false); // 버튼 활성화
                    $('#nonCompleteEduBtn').prop('disabled', false); // 버튼 활성화
                } else {
                    $('#completeEduBtn').prop('disabled', true);  // 버튼 비활성화
                    $('#nonCompleteEduBtn').prop('disabled', true);  // 버튼 비활성화
                }
            }
        	
        	// 이수처리 버튼 시 교육정보 가지고 이동하기
            $('#completeEduBtn').click(function(event){
            	event.preventDefault();
            	const completeEudIds = [];
            	$('input[type="checkbox"]:checked').each(function () {
            		completeEudIds.push($(this).data('id'));
                });
            	swal({
   	              title: "이수처리 하시겠습니까?",
   	              text: "이수처리 후에는 재변경이 불가능합니다.",
   	              type: "warning",
   	              buttons: {
   	                cancel: {
   	                  visible: true,
   	                  text: "취소하기",
   	                  className: "btn btn-danger",
   	                },
   	                confirm: {
   	                  text: "이수처리",
   	                  className: "btn btn-success",
   	                },
   	              },
   	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
   	             if (willDelete) {
            		$('#inputForCompleteEdu').val(completeEudIds);
   	            	swal({
   	            	    title: "Success!",
   	            	    text: "교육이수 처리완료",
   	            	    icon: "success",
   	            	    buttons: "OK", 
   	            	}).then(function() {
            			$('#completeEduSubmit').submit(); 
                      });
 	             	}
                  });
            });
        	
        	// 미이수처리 버튼 시 교육정보 가지고 이동하기
            $('#nonCompleteEduBtn').click(function(event){
            	event.preventDefault();
            	const nonCompleteEudIds = [];
            	$('input[type="checkbox"]:checked').each(function () {
            		nonCompleteEudIds.push($(this).data('id'));
                });
            	swal({
   	              title: "미이수처리 하시겠습니까?",
   	              text: "미이수처리 후에는 재변경이 불가능합니다.",
   	              type: "warning",
   	              buttons: {
   	                cancel: {
   	                  visible: true,
   	                  text: "취소하기",
   	                  className: "btn btn-danger",
   	                },
   	                confirm: {
   	                  text: "미이수처리",
   	                  className: "btn btn-success",
   	                },
   	              },
   	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
   	             if (willDelete) {
   	            	$('#inputForNonCompleteEdu').val(nonCompleteEudIds);
   	            	swal({
   	            	    title: "Success!",
   	            	    text: "교육미이수 처리완료",
   	            	    icon: "success",
   	            	    buttons: "OK", 
   	            	}).then(function() {
   	            		$('#nonCompleteEduSubmit').submit(); 
                      });
 	             	}
                 });
            });
        	
         	// 조회 버튼 시 연/월/사번가지고 조회하기
            $('#inquiryBtn').click(function(event){
            	var checkSalaryInfo = [];
            	checkSalaryInfo.push($('#typeSelect').val());
            	checkSalaryInfo.push($('#eduInfo').val());
            	$.ajax({
            		url:'/edu/eduInquiryForManage',
            		type: 'POST',
            		data: JSON.stringify(checkSalaryInfo),
            		contentType: 'application/json',
            		success: function(response) {
            			if(response.length > 0){
            			swal("Success!", "직원 교육정보 조회완료", "success");
            			dataTable.clear();
            			response.forEach(function(data){
                            dataTable.row.add([
	                            '<input type="checkbox" data-id="edu_his_id" name="edu_his_id" value="' + data.edu_his_id + '">',
	                            data.emp_id,
	                            data.emp_name,
	                            data.edu_name,
	                            data.edu_start_date,
	                            data.edu_end_date,
	                            data.edu_status
                            ]);
                        });
            				dataTable.draw();
            			} else {
            				swal("정보없음!", "검색하신 결과가 없습니다.", "warning");
            			}
            		},
            		error: function(xhr, status, error) {
                        swal("Error!", "실패", "error");
                    }
            	});
            });
            
         	// 데이터테이블 설정
            let dataTable = $("#basic-datatables").DataTable({
            	pageLength: 6,
            	destroy: true,
            	drawCallback: function() { //가운대 정렬
        			$('#basic-datatables th, #basic-datatables td').css({
        	            'text-align': 'center',
        	            'vertical-align': 'middle'
        	        });
	                $('input[type="checkbox"]').prop('checked', false);
	                compareCheckStatus();
        		},
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
