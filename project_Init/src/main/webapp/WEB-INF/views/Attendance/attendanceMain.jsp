<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="javax.servlet.http.HttpSession" %>
    <%@ page import="java.text.SimpleDateFormat" %>
	<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8">
<head>
 <!-- 한글 인코딩 추가 -->
 <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/attendance.css" />
<!--QR 라이브러리  -->

    
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
     
       <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
      
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
        }
        
    </style>
    
    
    
    
    
 
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
  
 
  <div class="col-md-12">
                <div class="card">
                  <div class="card-body">
                 <div class="card-title">근태관리</div>




<!-- 결재요청용 모달  -->
	      <div
	      class="modal fade"
	      id="addRowModal"
	      tabindex="-1"
	      role="dialog"
	      aria-hidden="true"
	      >
	        <div class="modal-dialog" role="document" style="max-width: 1100px; margin-top: 100px;">
	          <div class="modal-content" style="width: 1100px;">
	            <div style="display: flex; justify-content: space-between;">
	              <div class="col-6">
	                <div class="modal-header border-0">
	                  <h5 class="modal-title">
	                    <span class="fw-mediumbold"> 직원정보</span>
	                  </h5>
	                </div>
	                <div class="modal-body">
	                  <p class="small">추가하기를 누르면 오른쪽 결재요청 페이지에 추가됩니다.</p>
	                <div id="modalNextContent">
			          <table class="table table-bordered" id="modalTable">
					    <thead>
					      <tr>
					        <th id="topText" colspan="5"></th>
					      </tr>
					      <tr>
	                        <th>사번</th>
	                        <th>직급</th>
	                        <th>이름</th>
	                        <th>선택</th>
					      </tr>
					    </thead>
					    <tbody>
					    </tbody>
				      </table>
	                </div>
	              </div>
	            </div>
	            <div>
	              <div class="modal-header border-0">
	                <h5 class="modal-title">
	                  <span class="fw-mediumbold"> 결재요청</span>
	                </h5>
	                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
	                   <span aria-hidden="true">×</span>
	                </button>
	              </div>
	              <div class="modal-body">
	                <p class="small">결재자와 결재유형을 선택하여 결재요청을 할 수 있습니다.</p>
	                <table class="table table-bordered" id="signTable">
					  <thead>
					    <tr>
	                      <th>직급</th>
	                      <th>이름</th>
	                      <th>결재유형</th>
	                      <th>삭제</th>
					    </tr>
					  </thead>
					  <tbody>
					  </tbody>
				    </table>
				    <div class="form-group" style="padding:0px;">
				      <div class="input-group mb-3">
				        <span class="input-group-text">결재요청명</span>
				        <input id="signTitle" name="wf_title" type="text" class="form-control" placeholder="결재요청명을 작성하세요" aria-label="Username" aria-describedby="basic-addon1">
				      </div>
				      <textarea class="form-control" id="signContent" rows="3" name="wf_content"
				                placeholder="결재요청 내용을 입력하세요"></textarea>
				    </div>
	              </div>
	              <div class="modal-footer border-0" style="justify-content: center;">
	                <button type="button" id="signRequestBtn" class="btn btn-primary">결재요청</button>
	                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
				<script>
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
                    "background:none'>X</button></td>" +
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
      	            	//전달정보 (edu_id, 결재요청자 및 1~3차 결재자의 사번 )
      	             	var signData = {
    	             			edu_id: $('input[name="attendance_id"]:checked').val(),
    	             			wf_sender: $('select option[name="wf_receiver"]:selected').closest('tr').find('input').val(),
    	             			wf_receiver_1st: $('select option[name="wf_receiver_1st"]:selected').closest('tr').find('input').val(),
    	             			wf_receiver_2nd: $('select option[name="wf_receiver_2nd"]:selected').closest('tr').find('input').val(),
    	             			wf_receiver_3rd: $('select option[name="wf_receiver_3rd"]:selected').closest('tr').find('input').val(),
    	             			wf_title: $('input[name="wf_title"]').val(),
    	             			wf_content: $('textarea[name="wf_content"]').val()
      	             	};
      	             	$.ajax({
      	            		url:'/edu/insertSignInfo',
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
      	                            window.location.href = "/edu/eduManage";  // 페이지 이동
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
        	
       
               
               
               
               
               
               
  </script>
  
<!-- JSP 파일에서 세션 값을 가져오는 부분 --> 
<% String empId = (String) session.getAttribute("emp_id"); %>

<%
    // 현재 날짜와 시간을 yyyy-MM-dd HH:mm:ss 형식으로 포맷
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String createdAt = sdf.format(new Date());
%>

<button class="btn1 btn-primary" data-toggle="modal"
	data-target="#overtimeModal">
	<span class="btn-label"> <i class="fa fa-bookmark"></i>
	</span> 초과/야간/특근 신청서
</button>


<!-- 모달 초과 근무 신청서 -->
<div class="modal fade" id="overtimeModal" tabindex="-1" role="dialog" aria-labelledby="overtimeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="overtimeModalLabel">초과/야간/특근 신청서</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="overtimeForm" onsubmit="event.preventDefault(); submitOvertimeForm();">
                  
                    <div class="form-group">
                        <label for="emp_id">사원 ID</label>
                        <input type="text" class="form-control" id="emp_id" name="emp_id" value="<%= empId %>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="employee_name">직원 이름</label>
                        <input type="text" class="form-control" id="employee_name" value="${emp_name}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="workform_status">근태 상태</label>
                        <select class="form-control" id="workform_status" name="workform_status" required>
                            <option value="초과근무">초과근무</option>
                            <option value="야간근무">야간근무</option>
                            <option value="특근근무">특근근무</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="created_at">신청 날짜 및 시간:</label>
                        <input type="text" class="form-control" id="created_at" name="created_at" placeholder="yyyy-MM-dd HH:mm:ss" value="<%= createdAt %>" required readonly>
                    </div>

                    <div class="form-group">
                        <label for="overtime">초과 시간</label>
                        <input type="number" class="form-control" id="overtime" name="overtime" placeholder="초과 시간을 입력하세요" required>
                    </div>

                    <div class="form-group">
                        <label for="night_work_time">야간 시간</label>
                        <input type="number" class="form-control" id="night_work_time" name="night_work_time" placeholder="야간근무한 시간을 입력하세요" required>
                    </div>

                    <div class="form-group">
                        <label for="special_working_time">특근 시간</label>
                        <input type="number" class="form-control" id="special_working_time" name="special_working_time" placeholder="특근한 시간을 입력하세요" required>
                    </div>

                    <div class="form-group">
                        <label for="status">상태</label>
                        <select class="form-control" id="status" name="status" required>
                            <option value="0">진행 중</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="modified_reason">신청 이유</label>
                        <textarea class="form-control" id="modified_reason" name="modified_reason" rows="3" placeholder="신청 이유를 입력하세요" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitOvertimeForm()">제출</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>
// 폼 유효성 검사 함수 (필요시 구현)
function validateForm() {
    // 입력 필드 값 가져오기 (유효성 검사 추가 가능)
     const createdAt = document.getElementById('created_at').value;
    const overtime = document.getElementById('overtime').value;
    const nightWorkTime = document.getElementById('night_work_time').value;
    const specialWorkingTime = document.getElementById('special_working_time').value;

 // 날짜 입력 여부 확인
    if (!createdAt) {
        alert("날짜를 입력해 주세요.");
        return false;
    }

    // 초과시간, 야간시간, 특근시간 중 하나라도 입력해야 함
    if (!overtime && !nightWorkTime && !specialWorkingTime) {
        alert("초과시간, 야간시간, 또는 특근시간 중 하나를 입력해 주세요.");
        return false;
    }

    // 유효성 검사를 모두 통과한 경우
    return true;
}

// 서버에 폼 데이터를 제출하는 함수
function submitOvertimeForm() {
    // 폼 유효성 검사 실행
    if (!validateForm()) {
        return;
    }

    // 모달을 표시
    $('#addRowModal').modal('show');

    // 폼 요소 가져오기
    const form = document.getElementById('overtimeForm');
    const formData = new FormData(form);

    // FormData를 JSON으로 변환
    const data = {};
    formData.forEach(function(value, key) {
        data[key] = value;
    });

    // AJAX 요청 생성
    fetch('overtimeSubmit', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json', // JSON 형식으로 전송
        },
        body: JSON.stringify(data), // JSON 문자열로 변환
    })
    .then(function(response) {
        if (response.ok) {
            return response.json(); // 서버에서 JSON 형식으로 응답을 받을 경우
        } else {
            throw new Error('서버 응답에 문제가 있습니다.');
        }
    })
    .then(function(data) {
        // 서버 응답 처리
        alert('신청서가 성공적으로 제출되었습니다.');
        $('#addRowModal').modal('hide'); // 모달 닫기
        form.reset(); // 폼 초기화
    })
    .catch(function(error) {
        console.error('오류 발생:', error);
        alert('서버 응답에 문제가 발생했습니다.');
        $('#addRowModal').modal('hide'); // 모달 닫기
        form.reset(); // 폼 초기화
    });
}
</script>
  
 <!-- 근태 신청 현황 버튼 -->
<button type="button" class="btn1 btn-primary" onclick="openAttendanceModal()">
    <span class="btn-label">
        <i class="fa fa-bookmark"></i>
    </span> 근태 신청 현황
</button>

<!-- 나의 근태 신청 현황 모달 -->
<div class="modal fade" id="attendanceModal" tabindex="-1" role="dialog" aria-labelledby="attendanceModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="attendanceModalLabel">나의 근태 신청 현황</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div style="overflow-x: auto;">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>근태 번호</th>
                                <th>사원 번호</th>
                                <th>출근 시간</th>
                                <th>퇴근 시간</th>
                                <th>수정 요청 출근 시간</th>
                                <th>수정 요청 퇴근 시간</th>
                                <th>근무 상태</th>
                                <th>초과 시간</th>
                                <th>신청일</th>
                                <th>야근 시간</th>
                                <th>특근 시간</th>
                                <th>신청  이유</th>
                                <th>출장 시작 날짜</th>
                                <th>출장 종료 날짜</th>
                                <th>교육 시작 날짜</th>
                                <th>교육 종료 날짜</th>                      
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody id="attendanceInfoTableBody">
                            <!-- AJAX로 불러온 정보를 여기에 표시합니다 -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeAttendanceModal()">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>
// 모달 닫기 함수
function closeAttendanceModal() {
    $('#attendanceModal').modal('hide'); // 모달 닫기
}



// AJAX 요청을 통해 근태 신청 현황을 가져오는 함수
function openAttendanceModal() {
    const empId = '<%= session.getAttribute("emp_id") %>'; // 세션에서 emp_id 가져오기
    console.log("empId:", empId); // empId 값 확인

    
    
    // AJAX 요청
    $.ajax({
        type: "GET",
        url: "attendanceDataA", // 서버의 엔드포인트 설정
        data: { emp_id: empId },
        dataType: "json", // 응답 형식 지정
        success: function(response) {
            displayAttendanceInfo(response);
            $('#attendanceModal').modal('show'); // 모달 열기
        },
        error: function(xhr, status, error) {
            console.error("근태 신청 현황 조회 실패:", error);
            $('#attendanceInfoTableBody').html("<tr><td colspan='14'>근태 신청 현황을 불러오는 데 실패했습니다.</td></tr>");
        }
    });
}


//상태를 문자열로 변환하는 함수
function getAttendanceStatusDisplay(status) {
    switch (status) {
        case 0:
            return '진행중'; // 0: 진행중
        case 1:
            return '승인';   // 1: 승인
        case -1:
            return '반려';   // -1: 반려
        default:
            return '없음'; // null 또는 정의되지 않은 값
    }
}

// 근태 정보를 화면에 표시하는 함수
function displayAttendanceInfo(data) {
    const attendanceInfoTableBody = document.getElementById("attendanceInfoTableBody");
    attendanceInfoTableBody.innerHTML = ""; // 기존 데이터 초기화
    
    data.forEach(attendance => {
        attendanceInfoTableBody.innerHTML +=
        	"<tr>" +
            "<td>" + (attendance.attendance_id || "-") + "</td>" +
            "<td>" + (attendance.emp_id || "-") + "</td>" +
            "<td>" + (attendance.check_in || "-") + "</td>" +
            "<td>" + (attendance.check_out || "-") + "</td>" +
            "<td>" + (attendance.new_check_in || "-") + "</td>" +
            "<td>" + (attendance.new_check_out || "-") + "</td>" +
            "<td>" + (attendance.workform_status || "-") + "</td>" +
            "<td>" + (attendance.overtime || "-") + "</td>" +
            "<td>" + (attendance.created_at || "-") + "</td>" +
            "<td>" + (attendance.night_work_time || "-") + "</td>" +
            "<td>" + (attendance.special_working_time || "-") + "</td>" +
            "<td>" + (attendance.modified_reason || "-") + "</td>" +
            "<td>" + (attendance.businessDate || "-") + "</td>" +
            "<td>" + (attendance.business_endDate || "-") + "</td>" +
            "<td>" + (attendance.educationDate || "-") + "</td>" +
            "<td>" + (attendance.education_endDate || "-") + "</td>" +
            "<td>" + getAttendanceStatusDisplay(attendance.status) + "</td>" + // 상태를 변환하여 표시
        "</tr>"; // 행을 닫음
    });
}
</script>
	
				
				
<!-- 모달 버튼 -->
<button class="btn1 btn-primary" data-toggle="modal" data-target="#updateModal">
    <span class="btn-label">
        <i class="fa fa-bookmark"></i>
    </span>
    근태 수정 신청서
</button>



<!-- 근태 수정 신청서 모달 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalLabel">근태 수정 신청서</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="attendanceForm" >
                    <div class="form-group">
                        <label for="attendance_id">근태 번호</label>
                        <input type="text" class="form-control" id="attendance_idA" name="attendance_idA" placeholder="수정하고싶은 해당 날짜의 근태번호를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label for="emp_id">사원 ID</label>
                        <input type="text" class="form-control" id="emp_id" name="emp_id" value="<%= empId %>" readonly>
                    </div>
                    <div class="form-group">
					    <label for="employee_name">직원 이름</label>
					    <input type="text" class="form-control" id="employee_name" value="${emp_name}" readonly>
					</div>
                    
                    
					            <div class="form-group">
							    <label for="check_in_time">출근 시간</label>
							    <input type="text" class="form-control" id="check_in_time" name="check_in" placeholder="yyyy-MM-dd HH:mm:ss" required>
							</div>
							<div class="form-group">
							    <label for="check_out_time">퇴근 시간</label>
							    <input type="text" class="form-control" id="check_out_time" name="check_out" placeholder="yyyy-MM-dd HH:mm:ss" required>
							</div>
                    <div class="form-group">
                        <label for="new_check_in">수정할 출근 시간</label>
                        <input type="text" class="form-control" id="new_check_in" placeholder="yyyy-MM-dd HH:mm:ss" required>
                    </div>
                    <div class="form-group">
                        <label for="new_check_out">수정할 퇴근 시간</label>
                        <input type="text" class="form-control" id="new_check_out" placeholder="yyyy-MM-dd HH:mm:ss" required>
                    </div>
                    <div class="form-group">
                        <label for="new_WorkingOutside_time">수정할 외근 시간</label>
                        <input type="text" class="form-control" id="new_WorkingOutside_time" placeholder="yyyy-MM-dd HH:mm:ss">
                    </div>
                  <label for="created_at">신청 날짜 및 시간:</label>
						    <input
						        type="text" class="form-control" id="created_at"
						        name="created_at" placeholder="yyyy-MM-dd HH:mm:ss"
						        value="<%= createdAt %>" required readonly>

                    <div class="form-group">
                        <label for="modified_reason">신청 이유</label>
                        <textarea class="form-control" id="modified_reasonA" rows="3" placeholder="신청 이유를 입력하세요." required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="status">상태</label>
                        <select class="form-control" id="status" name="status" required>
                            <option value="0">진행 중</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitAttendanceForm2()">신청</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#updateModal').on('show.bs.modal', function (event) {
        // 모달 오픈 시 필드 초기화
        $('#check_in').val(''); // 출근 시간 초기화
        $('#check_out').val(''); // 퇴근 시간 초기화
    });
});







function submitAttendanceForm2() {
    // 필드 값 초기화 및 명확한 변수명 사용
    const attendanceId = $('#attendance_idA').val(); // 사용자가 입력한 근태 번호
    const empId = $('#emp_id').val(); // 사원 ID (readonly)
    const currentCheckIn = $('#check_in_time').val(); // 기존 출근 시간
    const currentCheckOut = $('#check_out_time').val(); // 기존 퇴근 시간
    const updatedCheckIn = $('#new_check_in').val(); // 수정할 출근 시간
    const updatedCheckOut = $('#new_check_out').val(); // 수정할 퇴근 시간
    const workingOutsideTime = $('#new_WorkingOutside_time').val() || null; // 외근 시간 (Null 가능)
    const requestDateTime = $('#created_at').val(); // 신청 날짜 및 시간
    const reasonForModification = $('#modified_reasonA').val(); // 신청 이유
    const attendanceStatus = $('#status').val(); // 상태

    // 유효성 검사 및 기본값 설정
    if (!attendanceId) {
        alert("근태 번호를 입력해주세요.");
        return; // 근태 번호가 없으면 함수 종료
    }
    
    if (!currentCheckIn) {
        alert("출근 시간을 입력해주세요.");
        return; // 
    }

    if (!currentCheckOut) {
        alert("퇴근 시간을 입력해주세요.");
        return; // 
    }

    // 기본값 설정 (필요한 경우)
    const finalCurrentCheckIn = currentCheckIn || "기본값"; // 예: 빈 문자열이나 "기본값"
    const finalCurrentCheckOut = currentCheckOut || "기본값"; // 예: 빈 문자열이나 "기본값"

    const formData = {
        attendance_id: attendanceId,
        emp_id: empId,
        check_in: finalCurrentCheckIn ,
        check_out: finalCurrentCheckOut,
        new_check_in: updatedCheckIn,
        new_check_out: updatedCheckOut,
        new_WorkingOutside_time: workingOutsideTime,
        created_at: requestDateTime,
        modified_reason: reasonForModification,
        status: attendanceStatus
    };

    console.log(formData); // 디버깅을 위한 로그 확인

    $.ajax({
        type: "POST",
        url: "updateAttendanceA", // 서버로 요청할 URL
        contentType: "application/json",
        data: JSON.stringify(formData), // 데이터를 JSON 문자열로 변환하여 전송
        success: function(response) {
            alert("신청서가 제출되었습니다 ");
            // 폼 전체 초기화
            $('#attendanceForm')[0].reset();

            $('#updateModal').modal('hide'); // 모달 닫기
            
        },
        error: function(xhr, status, error) {
            console.error("Error:", error); // 디버깅을 위한 로그 확인
            form.reset(); // 폼 초기화
            alert("신청서 제출에 실패했습니다: " + xhr.responseText);
        }
    });
}
</script>
				
				
				
				
				
				
				
				
				
<button type="button" class="btn1 btn-primary" data-toggle="modal" data-target="#businessTripModal">
    <span class="btn-label"> <i class="fa fa-bookmark"></i> </span> 교육/출장 신청서
</button>

<!-- 출장/교육 신청서 모달 -->
<div class="modal fade" id="businessTripModal" tabindex="-1" role="dialog" aria-labelledby="businessTripModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="businessTripModalLabel">교육/출장 신청서</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="businessTripForm" onsubmit="event.preventDefault(); validateDates();" >
                    <div class="form-group">
                        <label for="emp_id">사원 ID</label>
                        <input type="text" class="form-control" id="emp_id" name="emp_id" value="<%= empId %>" readonly>
                    </div>
                    
                       <div class="form-group">
					    <label for="employee_name">직원 이름</label>
					    <input type="text" class="form-control" id="employee_name" value="${emp_name}" readonly>
					</div>
                    
                    <div class="form-group">
                        <label for="businessDate">출장 시작 날짜</label>
                        <input type="date" class="form-control" id="businessDate" name="businessDateA"required>
                    </div>
                    <div class="form-group">
                        <label for="businessEndDate">출장 종료 날짜</label>
                        <input type="date" class="form-control" id="businessEndDate" name="businessEndDateB" required>
                    </div>
                    <div class="form-group">
                        <label for="educationDate">교육 시작 날짜</label>
                        <input type="date" class="form-control" id="educationDate"name="educationDateA" required>
                    </div>
                    <div class="form-group">
                        <label for="educationEndDate">교육 종료 날짜</label>
                        <input type="date" class="form-control" id="educationEndDate" name="educationEndDateB" required>
                    </div>
                    <div class="form-group">
                        <label for="workformStatus">근무 형태</label>
                        <select class="form-control" id="workformStatus" name="workform_status" required>
                            <option value="출장">출장</option>
                            <option value="교육">교육</option>
                        </select>
                    </div>
                      <label for="created_at">신청 날짜 및 시간:</label>
						    <input
						        type="text" class="form-control" id="created_at"
						        name="created_at" placeholder="yyyy-MM-dd HH:mm:ss"
						        value="<%= createdAt %>"  required readonly>

                    <div class="form-group">
                        <label for="reason">신청 이유</label>
                        <textarea class="form-control" id="reason" name="modified_reason" rows="3" placeholder="신청 이유 입력"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="status">상태</label>
                        <select class="form-control" id="status" name="status" required>
                            <option value="0">진행 중</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitBusinessTrip()">신청하기</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>
function submitBusinessTrip() {
    const empId = document.getElementById('emp_id').value;
    const businessDate = document.getElementById('businessDate').value;
    const businessEndDate = document.getElementById('businessEndDate').value;
    const educationDate = document.getElementById('educationDate').value;
    const educationEndDate = document.getElementById('educationEndDate').value;
    const createdAt = document.getElementById('created_at').value;
    
    const workformStatus = document.getElementById('workformStatus').value;
    const reason = document.getElementById('reason').value;

    // 유효성 검사
    if (!businessDate && !businessEndDate && !educationDate && !educationEndDate) {
        alert('출장 시작 날짜, 출장 종료 날짜, 교육 시작 날짜, 교육 종료 날짜 중 하나 이상을 입력해야 합니다.');
        return;
    }

    if (businessDate && businessEndDate && new Date(businessEndDate) < new Date(businessDate)) {
        alert('출장 종료 날짜는 출장 시작 날짜보다 이후여야 합니다.');
        return;
    }
    
    if (educationDate && educationEndDate && new Date(educationEndDate) < new Date(educationDate)) {
        alert('교육 종료 날짜는 교육 시작 날짜보다 이후여야 합니다.');
        return;
    }

    // 데이터 전송
    $.ajax({
        url: 'applyBusinessTrip', // 엔드포인트 URL 확인 필요
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            emp_id: empId,
            businessDate: businessDate,
            business_endDate: businessEndDate,
            educationDate: educationDate,
            education_endDate: educationEndDate,
            workform_status: workformStatus,
            created_at : createdAt,
            modified_reason: reason,
            status: status // 고정된 상태값
        }),
        success: function(response) {
            alert('신청이 완료되었습니다!');
            document.getElementById('businessTripForm').reset(); // 폼 ID가 'businessTripForm'일 경우
            
            $('#businessTripModal').modal('hide'); // 모달 닫기
        },
        error: function(error) {
            alert('신청 중 오류가 발생했습니다. 다시 시도해주세요.');
            console.error('Error:', error);
        }
    });
}
</script>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
     
 <div class="attendance-table-container"> <!-- 테이블을 감싸는 div -->
 	<div class="card-header">
                    <div class="card-title">일주일간 나의 근무 현황</div>
                
   <table class="table table-hover" id="attendanceTable">
    <thead>
        <tr>
            <th scope="col">출근 날짜</th>
            <th scope="col">퇴근 날짜</th>
            <th scope="col">근무 상태</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="attendance" items="${attendanceList}">
            <tr>
                <td>
                    <c:if test="${not empty attendance.checkInTime}">
                        <span>${attendance.checkInTime}</span>
                    </c:if>
                </td>  <!-- 출근 날짜 -->
                <td>${attendance.checkOutTime}</td> <!-- 퇴근 날짜 -->
                <td>${attendance.workformStatus}</td> <!-- 근무 상태 -->
            </tr>
        </c:forEach>
        <c:if test="${empty attendanceList}">
            <tr>
                <td colspan="3">근무 기록이 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>
</div>
	  </div>
	
	
	
<div class="bg-white shadow-lg rounded-lg p-8 max-w-lg ">
    <h1 class="text-3xl font-bold mb-6 text-center">사원 정보</h1>
    <div class="flex justify-center mb-6">
        <div class="w-40 h-40 bg-gray-200 rounded-md flex items-center justify-center">
            <span class="text-gray-500">${sessionScope.emp_profile}</span>
        </div>
    </div>
    <div class="space-y-4">
        <div class="flex justify-between">
            <span class="font-semibold">사원번호 :</span>
            <span>${sessionScope.emp_id}</span>
        </div>
        <div class="flex justify-between">
            <span class="font-semibold">직책 :</span>
            <span>${sessionScope.emp_job}</span>
        </div>
        <div class="flex justify-between">
            <span class="font-semibold">직위:</span>
            <span>${sessionScope.emp_position}</span>
        </div>
        <div class="flex justify-between">
            <span class="font-semibold">이름:</span>
            <span>${sessionScope.emp_name}</span>
        </div>
        <div class="flex justify-between">
        <span class="font-semibold">출근 시간:</span>
          <c:if test="${checkInTime != null}">
		    <c:if test="${not empty checkInTime}">        
		        <span>${checkInTime}</span>
		    </c:if>
		     </c:if>
		</div>
        <div class="flex justify-between">
            <span class="font-semibold">퇴근 시간:</span>
            <span id="checkoutTimeDisplay"></span>
        </div>
        <div class="flex justify-between">
            <span class="font-semibold">근무 시간:</span>
            <span id="workingTimeDisplay"></span>
        </div>
         <div class="flex justify-between">
            <span class="font-semibold">외출 시간:</span>
            <span id="outdoorTimeDisplay"></span>
        </div>
         <div class="flex justify-between">
            <span class="font-semibold">복귀 시간: </span>
            <span id="returnTimeDisplay"></span>
        </div>
        
        
		    <button id="calculateButton" class="btn btn-primary">근무한 시간</button>
		
		
		<!-- 출근 버튼  로그인 구현시 시도해보기 -->    

<%--      <form action="${pageContext.request.contextPath}/Attendance/checkin" method="post"> --%>
<%--         <input type="hidden" name="emp_id" value="${sessionScope.emp_id}" /> <!-- emp_id를 숨겨진 필드로 전달 --> --%>
<!--         <button type="submit">출근</button> -->
<!--     </form> -->


		<button id="checkoutButton" class="btn btn-primary">퇴근</button>
	    <button class="btn btn-primary" onclick="recordOutdoorTime()">외출</button>
	    <button class="btn btn-primary" onclick="recordReturnTime()">복귀</button>
		
		<%
	    // 세션에서 emp_id와 attendance_id를 가져옵니다. 
	    String attendanceId = (String) session.getAttribute("attendance_id");
		%>
			
		
    </div>
</div>
   
  <script>
  // 출근 성공 시 알림 표시
  window.onload = function() {
      <c:if test="${checkInSuccess}">
          alert('출근이 성공적으로 처리되었습니다.');
      </c:if>
  };
  
  
function recordOutdoorTime() {
    const attendanceData = {
        emp_id: "${sessionScope.emp_id}", // JSP에서 세션 값 사용
        attendance_id: "${sessionScope.attendance_id}", // JSP에서 세션 값 사용
        WorkingOutside_time: new Date().toISOString().slice(0, 19).replace('T', ' '), // 현재 시간
    };

    fetch('outdoor', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(attendanceData),
    })
    .then(response => {
        if (response.ok) {
            const outdoorTime = new Date().toLocaleString(); // 현재 시간을 로컬 포맷으로 가져옴
            document.getElementById('outdoorTimeDisplay').innerText = outdoorTime; // 외출 시간 표시
            alert('외출 시간이 기록되었습니다.');
        } else {
            alert('외출 시간 기록에 실패하였습니다.');
        }
    })
    .catch(error => console.error('Error:', error));
}

function recordReturnTime() {
    const attendanceData = {
        emp_id: "${sessionScope.emp_id}", // JSP에서 세션 값 사용
        attendance_id: "${sessionScope.attendance_id}", // JSP에서 세션 값 사용
        return_time: new Date().toISOString().slice(0, 19).replace('T', ' '), // 현재 시간
    };

    fetch('return', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(attendanceData),
    })
    .then(response => {
        if (response.ok) {
            const returnTime = new Date().toLocaleString(); // 현재 시간을 로컬 포맷으로 가져옴
            document.getElementById('returnTimeDisplay').innerText = returnTime; // 복귀 시간 표시
            alert('복귀 시간이 기록되었습니다.');
        } else {
            alert('복귀 시간 기록에 실패하였습니다.');
        }
    })
    .catch(error => console.error('Error:', error));
}
</script>
















    <!--// 출근 시간 문자열을 Date 객체로 변환
                      var checkInTime = new Date(attendance.check_in);
                      // 한국 시간 (UTC+9)으로 변환   -->
     <script>
$(document).ready(function() {
    // 페이지가 로드될 때 출근 기록을 가져오는 AJAX 요청
    $.ajax({
        url: "fetchAttendanceRecords", // 컨트롤러의 메서드 URL
        type: "GET",
        success: function(attendanceList) {
            // 테이블에 출근 기록 추가
            var tableBody = $("#attendanceTable tbody");
            tableBody.empty(); // 기존 데이터 지우기
            attendanceList.forEach(function(attendance) {
                // 출근 시간 문자열을 Date 객체로 변환
                var checkInTime = new Date(attendance.check_in);
                // 한국 시간 (UTC+9)으로 변환
               

                var checkOutTime = attendance.check_out ? new Date(attendance.check_out) : null; // 퇴근 시간이 있을 경우만 변환
             

                var workStatus = determineWorkStatus(checkInTime, checkOutTime); // 근무 상태 결정

                tableBody.append(
                    "<tr>" +
                    "<td>" + checkInTime.toLocaleString() + "</td>" + // 로컬 시간 형식으로 표시
                    "<td>" + (checkOutTime ? checkOutTime.toLocaleString() : '퇴근하지 않음') + "</td>" + // 퇴근 시간 표시
                    "<td>" + workStatus + "</td>" + // 근무 상태 표시
                    "</tr>"
                );
            });
        },
        error: function() {
            alert("출근 기록을 가져오는 데 실패했습니다.");
        }
    });
});

function determineWorkStatus(checkInTime, checkOutTime) {
    const checkInDate = new Date(checkInTime);
    const checkOutDate = new Date(checkOutTime);
    
    // 현재 로컬 시간 기준으로 오전 7시와 오후 6시 설정
    const sevenAM = new Date(checkInDate);
    sevenAM.setHours(7, 0, 0, 0); // 오전 7시로 설정
    
    const nineAM = new Date(checkInDate);
    nineAM.setHours(9, 0, 0, 0); // 오전 9시로 설정
    
    const sixPM = new Date(checkInDate);
    sixPM.setHours(18, 0, 0, 0); // 오후 6시로 설정
    
    const tenPM = new Date(checkInDate);
    tenPM.setHours(22, 0, 0, 0); // 오후 10시로 설정
    
    // 오전 7시부터 9시 이전 출근
    if (checkInDate >= sevenAM && checkInDate < nineAM) {
        return "정상 출근"; // 정상 출근
    }
    // 오전 9시 이후부터 오후 6시까지 출근
    else if (checkInDate >= nineAM && checkInDate <= sixPM) {
        return "지각"; // 지각
    }
    // 오후 6시부터 24시까지는 초과근무
    else if (checkInDate > sixPM && checkInDate <= new Date(checkInDate.setHours(24))) {
        return "초과 근무"; // 초과 근무
    }
    // 오후 10시부터 다음날 오전 7시까지 출근
    else if (checkInDate >= tenPM || checkInDate < sevenAM) {
        return "야간 근무"; // 야간 근무
    }
    // 기본적으로 아무 조건에도 해당하지 않을 경우
    return "근무 상태 확인 필요";
}
</script>
    
    
    
    
    
    
    



			<script>
		    $(document).ready(function() {
		        $('#checkoutButton').click(function() {
		            $.ajax({
		                url: '<c:url value="checkOut" />',
		                type: 'GET',
		                success: function(response) {
		                    if (response.status === 'success') {
		                        alert(response.message);
		
		                        // 퇴근 시간이 성공적으로 업데이트되면 현재 시간을 퇴근 시간으로 표시
		                        const now = new Date();
		                        const formattedTime = now.getFullYear() + '-' +
		                            ('0' + (now.getMonth() + 1)).slice(-2) + '-' +
		                            ('0' + now.getDate()).slice(-2) + ' ' +
		                            ('0' + now.getHours()).slice(-2) + ':' +
		                            ('0' + now.getMinutes()).slice(-2) + ':' +
		                            ('0' + now.getSeconds()).slice(-2);
		                        
		                        $('#checkoutTimeDisplay').text('' + formattedTime);
		                    } else {
		                        alert(response.message);
		                    }
		                },
		                error: function() {
		                    alert('퇴근 요청 중 오류가 발생했습니다.');
		                }
		            });
		        });
		    });
		    </script>
		    
		    
		    
		    
		    <script>
		    $(document).ready(function() {
		        $('#calculateButton').click(function() {
		            $.ajax({
		                url: '<c:url value="calculateWorkingTime" />',
		                type: 'GET',
		                success: function(response) {
		                    alert(response.message);
		                    // 계산된 근무 시간을 페이지에 표시
		                    $('#workingTimeDisplay').text('총 근무 시간: ' + formatWorkingTime(response.workingTime));
		                },
		                error: function() {
		                    alert('근무 시간 계산 중 오류가 발생했습니다.');
		                }
		            });
		        });
		    });

		    // 근무 시간을 hh:mm 형식으로 변환하는 함수
		    function formatWorkingTime(totalMinutes) {
		        var hours = Math.floor(totalMinutes / 60); // 시간 계산
		        var minutes = totalMinutes % 60; // 남은 분 계산
		        // 2자리 숫자 형식으로 변환
		        return (hours < 10 ? '0' : '') + hours + ':' + (minutes < 10 ? '0' : '') + minutes;
		    }
</script>
		   
		<!-- 출퇴근   -->
		
		
<script>
        // 퇴근 버튼 클릭 시 유효성 검증
        $('#checkoutButton').click(function() {
            // 출근 기록이 있는지 확인
            const checkinTime = $('#checkinTimeDisplay').text();
           
            if (confirm('퇴근하시겠습니까?')) {
                $.ajax({
                    url: '<c:url value="checkOut" />',
                    type: 'GET',
                    success: function(response) {
                        if (response.status === 'success') {
                           
                            $('#checkoutTimeDisplay').text('퇴근 시간: ' + response.checkOutTime);
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('퇴근 요청 중 오류가 발생했습니다.');
                    }
                });
            }
        });
  
</script>





  


                    



   </div>
                  <div class="card-body">

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
