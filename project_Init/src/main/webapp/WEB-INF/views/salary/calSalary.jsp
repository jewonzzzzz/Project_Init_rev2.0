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

<div class="page-header">
              <h3 class="fw-bold mb-3">급여산출</h3>
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
                  <a href="/salary/salaryBasicInfo">급여관리</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">급여산출</a>
                </li>
              </ul>
            </div>
        <div class="row">
              <div class="col-md-11">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여산출내역</div>
                  </div>
                  	<div style="display: flex; justify-content: flex-end; margin-right: 30px;">
                  	<div style="margin-left: 15px; margin-bottom: 10px; padding-top: 10px;">
                    	<a href="/salary/calSalaryStep1"><button class="btn btn-primary">신규생성</button></a>
                    	
                    	<form id="deleteSubmit" action="/salary/deleteSalaryInfo" method="post" style="display: inline-block;">
                    		<input type="hidden" id="inputForDelete" name="sal_list_id">
                    		<button type="submit" class="btn btn-danger" id="deleteBtn" disabled>삭제하기</button>
                    	</form>
                    	
                   		<button	class="btn btn-primary"	id ="signBtn" data-bs-toggle="modal" data-bs-target="#addRowModal" disabled
	                      	>
	                        결재요청
                        </button>
                    	
                    	<form id="confirmSubmit" action="/salary/confirmSalaryList" method="post" style="display: inline-block;">
                    		<input type="hidden" id="inputForConfirm" name="sal_list_id">
                    		<button type="submit" class="btn btn-primary" id="confirmBtn" disabled>최종확정</button>
                    	</form>
                    	
                    	<form id="excelSubmit" action="/salary/excelDownload" method="get" style="display: inline-block;">
                    		<input type="hidden" id="inputForExcel" name="sal_list_id">
                    		<button type="submit" class="btn btn-success" id="excelBtn" disabled>이체자료 내려받기</button>
                    	</form>
                    	</div>
                  	</div>
                  <div class="card-body" style="padding-top: 10px;">
                    <table id="basic-datatables"
                        class="display table table-striped table-hover">
                      <thead>
                        <tr>
                          <th scope="col">구분</th>
                          <th scope="col">연도</th>
                          <th scope="col">월</th>
                          <th scope="col">급여형태</th>
                          <th scope="col">제목</th>
                          <th scope="col">상태</th>
                          <th scope="col">최종작성일</th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="list" items="${calSalaryListInfo }">
                      	<tr>
                      		<td><input type="checkbox" data-id="sal_list_id" name="sal_list_id" value="${list.sal_list_id }"></td>
                      		<td>${list.year }</td>
                      		<td>${list.month }</td>
                      		<td>${list.sal_type }</td>
                      		<td><a href="/salary/calSalaryView?sal_list_id=${list.sal_list_id }">${list.sal_list_subject }</a></td>
                      		<td>${list.sal_list_status }</td>
                      		<td>${list.sal_list_date }</td>
                      	</tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            
            <%@ include file="../inc/signModal.jsp" %> <!-- 결재요청용 모달 -->
            
            
            <script>
        $(document).ready(function() {
        	
        	// 결재요청 시 기본세팅(본부장, 관련부서 정보 업로드, 해당직원 정보 업로드)
        	$('#addRowModal').on('show.bs.modal', function() {
        		$('#modalTable tbody').empty();
        		$('#signTable tbody').empty();
        		$('#signTitle').val('');
        		$('#signContent').val('');
        		
        	    $.ajax({
        	        url: '/salary/getMemberInfoForSign',
        	        method: 'POST',
        	        success: function(response) {
        	        	console.log(response);
        	        	$('#topText').text("소속 : "+response["emp_bnum"]+" "+response["dname"]);
        	        	var row = "<tr>" +
                        "<td style='text-align: center;'>" + response["directorInfo"].emp_id + "</td>" +
                        "<td style='text-align: center;'>" + response["directorInfo"].emp_position + "</td>" +
                        "<td style='text-align: center;'>" + response["directorInfo"].emp_name + "</td>" +
                        "<td style='text-align: center;'><a href='#' class='move-row'>추가하기</a></td>" +
                        "</tr>";
                        $('#modalTable tbody').append(row);
                        
                        response["deptInfo"].forEach(function(data){
                        	var row = "<tr>" +
                        	"<td style='text-align: center;'>" + data.emp_id + "</td>" +
                            "<td style='text-align: center;'>" + data.emp_position + "</td>" +
                            "<td style='text-align: center;'>" + data.emp_name + "</td>" +
                            "<td style='text-align: center;'><a href='#' class='move-row'>추가하기</a></td>" +
                            "</tr>";
                            $('#modalTable tbody').append(row);
                        });
                        
                        var row_base = "<tr>" +
                        "<td style='text-align: center;'>" + response["memberInfo"].emp_position + "</td>" +
                        "<td style='text-align: center;'>" + response["memberInfo"].emp_name + "</td>" +
                        "<td style='text-align: center;'> <select class='form-select input-fixed' name='sign_type'>" +
                        "<option name='wf_receiver' value='결재요청자' disabled selected>결재요청자</option></select> </td>" +
                        "<td style='text-align: center;'></td>" +
                        "<input type='hidden' value='"+ response["memberInfo"].emp_id + "'>" +
                        "</tr>";
                        $('#signTable tbody').append(row_base);
        	        },
        	        error: function() {
        	            alert('데이터를 불러오는 데 실패했습니다.');
        	        }
        	    });
        	});
        	
        	// 직원조회 테이블에서 추가하기 클릭 시 결재요청 테이블로 이동
            $('#modalTable').on('click', '.move-row', function(event) {
            	event.preventDefault();
            	let signTableNames = [];
            	$('select option:selected').each(function () {
            		signTableNames.push($(this).closest('tr').find('td').eq(1).text());
               });
            	console.log(signTableNames);
            	if(signTableNames.includes($(this).closest('tr').find('td').eq(2).text())){
            		swal("Error!", "중복된 결재자가 존재합니다.", "error");
            	} else{
            		var row_move = "<tr>" +
                   "<td style='text-align: center;'>" + $(this).closest('tr').find('td').eq(1).text() + "</td>" +
                   "<td style='text-align: center;'>" + $(this).closest('tr').find('td').eq(2).text() + "</td>" +
                   "<td style='text-align: center;'> <select class='form-select input-fixed'" +
                   "name='sign_type'><option name='wf_receiver_1st' value='1차 결재자'>1차 결재자</option>" + 
                   "<option name='wf_receiver_2nd' value='2차 결재자'>2차 결재자</option>" +
                   "<option name='wf_receiver_3rd' value='3차 결재자'>3차 결재자</option></select> </td>" +
                   "<td style='text-align: center;'><button class='delete-btn' style='border:none;" +
                   "background:none; color:red; font-weight: bold;'>X</button></td>" +
                   "<input type='hidden' value='"+$(this).closest('tr').find('td').eq(0).text() +"'></tr>";
                   $('#signTable tbody').prepend(row_move);
            	}
            });
        	
        	// 결재요청 테이블 x 눌렀을 때 해당 행 삭제
        	$('#signTable').on('click', '.delete-btn', function () {
		        $(this).closest('tr').remove();
		    });
        	
        	// 결재요청 시 급여내역리스트 업데이트 및 워크플로우에 INSERT 후 페이지 리로딩
        	$('#signRequestBtn').click(function(){
        		swal({
     	              title: "결재요청 하시겠습니까?",
     	              text: "결재취소 요청은 워크플로우 화면에서 가능합니다.",
     	              type: "warning",
     	              buttons: {
     	                cancel: {
     	                  visible: true,
     	                  text: "취소하기",
     	                  className: "btn btn-danger",
     	                },
     	                confirm: {
     	                  text: "결재요청",
     	                  className: "btn btn-success",
     	                },
     	              },
     	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
     	             if (willDelete) {
 	            		 let selectedValues = [];
 	                    $('select option:selected').each(function () {
 	                    	selectedValues.push($(this).val());
 	                    });
     	            	 console.log(selectedValues);
     	            	 if($('option[name="wf_receiver_1st"]:selected').val() == null){
     	            		swal("Error!", "1차 결재자를 선택하여 주세요.", "error");
     	            	 } else if($('#signTitle').val() == '' || $('#signContent').val() == '' ){
     	            		swal("Error!", "결재요청 정보를 입력해주세요", "error");
     	            	 } else if(new Set(selectedValues).size !== selectedValues.length){
   	                    	swal("Error!", "중복된 결재유형이 존재합니다.", "error");
   	                     } else if(selectedValues.includes($('option[name="wf_receiver_3rd"]:selected').val())
   	                    		 && !selectedValues.includes($('option[name="wf_receiver_2nd"]:selected').val())){
   	                    	swal("Error!", "2차 결재자가 존재하지 않습니다.", "error");
   	                     } else {
     	            	//전달정보 (sal_list_id, 결재요청자 및 1~3차 결재자의 사번 )
     	             	var signData = {
   	             			sal_list_id: $('input[name="sal_list_id"]:checked').val(),
   	             			wf_sender: $('select option[name="wf_receiver"]:selected').closest('tr').find('input').val(),
   	             			wf_receiver_1st: $('select option[name="wf_receiver_1st"]:selected').closest('tr').find('input').val(),
   	             			wf_receiver_2nd: $('select option[name="wf_receiver_2nd"]:selected').closest('tr').find('input').val(),
   	             			wf_receiver_3rd: $('select option[name="wf_receiver_3rd"]:selected').closest('tr').find('input').val(),
   	             			wf_title: $('input[name="wf_title"]').val(),
   	             			wf_content: $('textarea[name="wf_content"]').val()
     	             	};
     	             	$.ajax({
     	            		url:'/salary/insertSignInfo',
     	            		type: 'POST',
     	            		data: JSON.stringify(signData),
     	            		contentType: 'application/json',
     	            		success: function(response) {
     	            			swal({
     	                            title: "Success!",
     	                            text: "결재요청이 완료되었습니다!",
     	                            icon: "success",
     	                            button: "OK"
     	                        }).then(function() {
     	                            window.location.href = "/salary/calSalary";  // 페이지 이동
     	                        });
     	            		},
     	            		error: function(xhr, status, error) {
     	                        swal("Error!", "정보를 가져오는데 실패하였습니다.", "error");
     	                    }
     	             		});
     	            	 }
     	             }
     	     	 });
        	});
        	
        	//데이터테이블 설정
        	$("#basic-datatables").DataTable({
        		pageLength: 6,
        		drawCallback: function() { //가운대 정렬
        			$('#basic-datatables th, #basic-datatables td').css({
        	            'text-align': 'center',
        	            'vertical-align': 'middle'
        	        });
        			$('input[type="checkbox"]').prop('checked', false);
        			$('#confirmBtn').prop('disabled', true);
 	                $('#excelBtn').prop('disabled', true);
 	                $('#signBtn').prop('disabled', true);
 	                $('#deleteBtn').prop('disabled', true);
        		}
        	});
        	
        	// 체크박스 체크여부에 다른 동작 분리(다중체크방지)
        	$('#basic-datatables tbody').on('click', 'input[type="checkbox"]', function() {
                if ($(this).is(':checked')) {
                    // 하나만 체크할 수 있도록 하는 기능
                    $('input[type="checkbox"]').not(this).prop('checked', false);
                }
            });
        	
        	// 체크여부에 따라 최종확정 버튼 활성화(체크버튼 클릭 + 결재완료)
        	$('#basic-datatables tbody').on('click', 'input[type="checkbox"]', function() {
        		var tdText = $(this).closest('tr').find('td:eq(5)').text();
	        	if($(this).is(':checked') && tdText === '결재완료') {
	                $('#confirmBtn').prop('disabled', false);
	                $('#excelBtn').prop('disabled', false);
	        	} else {
                    $('#confirmBtn').prop('disabled', true);
	                $('#excelBtn').prop('disabled', true);
                }
        	});
        		
        	// 체크여부에 따라 결재요청 버튼 활성화(체크버튼 클릭 + 임시저장)
        	$('#basic-datatables tbody').on('click', 'input[type="checkbox"]', function() {
        		var tdText = $(this).closest('tr').find('td:eq(5)').text();
	        	if($(this).is(':checked') && tdText === '임시저장') {
	                $('#signBtn').prop('disabled', false);
	        	} else {
                    $('#signBtn').prop('disabled', true);
                }
        	});
        	
        	// 체크여부에 따른 삭제버튼 활성화(체크버튼 클릭 + 임시저장/결재완료/반려)
        	$('#basic-datatables tbody').on('click', 'input[type="checkbox"]', function() {
        		var tdText = $(this).closest('tr').find('td:eq(5)').text();
	        	if(($(this).is(':checked') && tdText === '임시저장') ||
        		   ($(this).is(':checked') && tdText === '결재완료') ||
        		   ($(this).is(':checked') && tdText === '반려')) {
	                $('#deleteBtn').prop('disabled', false);
	        	} else {
                    $('#deleteBtn').prop('disabled', true);
                }
        	});
        	
        	// 삭제버튼 시 리스트id 가지고 이동하기
            $('#deleteBtn').click(function(event){
            	event.preventDefault();
            	swal({
     	              title: "삭제하시겠습니까?",
     	              text: "삭제 후에는 신규작성을 통해 다시 작성하셔야 됩니다.",
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
     	            	$('#inputForDelete').val($('input[name="sal_list_id"]:checked').val());
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
        	
         	// 최종확정버튼 시 리스트id 가지고 이동하기
        	$('#confirmBtn').click(function(event){
        		event.preventDefault();
        		swal({
   	              title: "최종확정 하시겠습니까?",
   	              text: "최종확정 후에는 재작성할 수 없습니다.",
   	              type: "warning",
   	              buttons: {
   	                cancel: {
   	                  visible: true,
   	                  text: "취소하기",
   	                  className: "btn btn-danger",
   	                },
   	                confirm: {
   	                  text: "최종확정",
   	                  className: "btn btn-success",
   	                },
   	              },
   	            }).then(function(willConfirm) {  // 일반 함수 문법으로 변경
   	             if (willConfirm) {
   	            	$('#inputForConfirm').val($('input[name="sal_list_id"]:checked').val());
   	            	swal({
   	            	    title: "Success!",
   	            	    text: "최종확정 완료",
   	            	    icon: "success",
   	            	    buttons: "OK", 
   	            	}).then(function() {
   	            		$('#confirmSubmit').submit();
                      });
 	             	}
                  });
        	});
         	
        	// 엑셀내려받기 버튼 시 리스트id 가지고 이동하기
        	$('#excelBtn').click(function(event){
        		event.preventDefault();
        		$('#inputForExcel').val($('input[name="sal_list_id"]:checked').val());
        		swal({
	            	    title: "Success!",
	            	    text: "엑셀내려받기 완료.",
	            	    icon: "success",
	            	    buttons: "OK", 
            	}).then(function() {
            		$('#excelSubmit').submit();
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
