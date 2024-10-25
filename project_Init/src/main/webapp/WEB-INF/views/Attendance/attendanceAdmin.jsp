<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
<meta charset="UTF-8"> <!-- 한글 인코딩 추가 -->
<!--QR 라이브러리  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.qrcode/1.0/jquery.qrcode.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Fonts and icons -->
    
     <style>
        #qrFrame {
            width: 200px;
            height: 200px;
            border: none;
            overflow: hidden; /* 스크롤바 숨기기 */
        }
    </style>
    
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
    <!--qr코드 숨김 스타일  -->
    <style>
        #qrcode {
            margin-top: 20px;
            display: none; /* 처음에는 QR 코드 숨김 */
        }
        
        
        #qrFrame {
            width: 200px;
            height: 200px;
            border: none;
            overflow: hidden; /* 스크롤바 숨기기 */
        }
    
        
    </style>
    
    <!-- 사원 테이블 -->
      <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        
        .btn-wide {
    width: 150px; /* 원하는 너비로 조정 */
}
    </style>
    
    
    
    
     <title>Attendance Admin</title>
    
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

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



<h1>사원 근태 관리</h1>
  
  <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">근태관리</div>
<br>
<br>
<br>
<br>
                        <h1>사원 근태 관리(관리자)</h1>
   <form>
    <div class="d-flex align-items-center">
        <label class="me-2">사원번호 :</label>
        <input type="text" class="form-control me-2" id="emp_id" name="emp_id" placeholder="사원 ID를 입력하세요" required style="width: 200px;">
        
        <label class="me-2">출근 날짜별(선택) :</label>
        <input type="date" class="form-control me-2" id="selectedDate" name="leave_start_date" required style="width: 200px;">
        
        <button type="submit" id="checkTimeButton" class="btn btn-info">사원 근태 조회</button>
    </div>
</form>     
<br>
<br>
<br>
<!-- 사원 근태 데이터 테이블 -->
  <div id="attendanceData">
            <table id="checkTimeTable" class="table mt-3">
                <thead>
                    <tr>
                        <th>직원 ID</th>
                        <th>근태 ID</th>
                        <th>출근 시간</th>
                        <th>퇴근 시간</th>
                        <th>외출 시간</th>
                        <th>복귀 시간</th>
                        <th>근무 시간</th>
                        <th>야근 시간</th>
                        <th>특별 근무 시간</th>
                        <th>근무 상태</th>
                        <th>출근 수정 시간</th>
                        <th>퇴근 수정 시간</th>
                        <th>외출 수정 시간</th>
                        <th>결재 수정 시간</th>
                        <th>신청일</th>
                        <th>상태</th>
                        <th>초과 근무 시간</th>                        
                        <th>출장 시작 날짜</th>
                        <th>출장 종료 날짜</th>
                        <th>교육 시작 날짜</th>
                        <th>교육 종료 날짜</th>                   
                        <th>수정 이유</th>
                        <th>수정인</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody id="checkTimeList">
                    <!-- 조회된 데이터가 여기에 삽입됩니다 -->
                </tbody>
            </table>
            <!-- 페이징 버튼을 위한 공간 -->
            <ul id="pagination" class="pagination"></ul>
        </div>
        <!-- 모달 구조 -->
       <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">근태 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
               <div class="modal-body">
			                   <input type="hidden" id="modalAttendanceId" /> <!-- 근태 ID -->
		                <div class="form-group">
		                    <label for="modalEmpId">사원번호</label>
		                    <input type="text" class="form-control" id="modalEmpId" placeholder="EMP ID를 입력하세요" readonly/> <!-- EMP ID 추가 -->
		                </div>
                            <div class="form-group">
                                <label for="modalCheckInInput">출근</label>
                                <input type="text" class="form-control" id="modalCheckInInput" placeholder="yyyy-MM-dd HH:mm:ss">
                            </div>
                            <div class="form-group">
                                <label for="modalCheckOutInput">퇴근</label>
                                <input type="text" class="form-control" id="modalCheckOutInput" placeholder="yyyy-MM-dd HH:mm:ss">
                            </div>
                            <div class="form-group">
                                <label for="modalWorkingOutsideTimeInput">외출 시간</label>
                                <input type="text" class="form-control" id="modalWorkingOutsideTimeInput" placeholder="yyyy-MM-dd HH:mm:ss">
                            </div>
                            <div class="form-group">
                                <label for="modalReturnTimeInput">복귀 시간</label>
                                <input type="text" class="form-control" id="modalReturnTimeInput" placeholder="yyyy-MM-dd HH:mm:ss">
                            </div>
                            <div class="form-group">
                                <label for="modalWorkingTimeInput">근무 시간</label>
                                <input type="text" class="form-control" id="modalWorkingTimeInput" >
                            </div>
                            <div class="form-group">
                                <label for="modalNightWorkTimeInput">야간 근무 시간</label>
                                <input type="text" class="form-control" id="modalNightWorkTimeInput">
                            </div>
                            <div class="form-group">
                                <label for="modalSpecialWorkingTimeInput">특별 근무 시간</label>
                                <input type="text" class="form-control" id="modalSpecialWorkingTimeInput" >
                            </div>
                            <div class="form-group">
                                <label for="modalNewCheckInInput">출근 수정 시간</label>
                                <input type="text" class="form-control" id="modalNewCheckInInput" placeholder="yyyy-MM-dd HH:mm:ss" >
                            </div>
                            <div class="form-group">
                                <label for="modalNewCheckOutInput">퇴근 수정 시간</label>
                                <input type="text" class="form-control" id="modalNewCheckOutInput" placeholder="yyyy-MM-dd HH:mm:ss">
                            </div>
                            <div class="form-group">
                                <label for="modalNewWorkingOutsideTimeInput">외출 수정 시간</label>
                                <input type="text" class="form-control" id="modalNewWorkingOutsideTimeInput" placeholder="yyyy-MM-dd HH:mm:ss">
                            </div>
                            <div class="form-group">
                                <label for="modalModifiedTimeInput">수정 일자</label>
                                <input type="text" class="form-control" id="modalModifiedTimeInput" placeholder="yyyy-MM-dd HH:mm:ss" >
                            </div>
                           <div class="form-group">
							  <label for="modalCreatedAtInput">신청 일자</label>
							  <input type="date" class="form-control" id="modalCreatedAtInput" placeholder="yyyy-MM-dd" required>
							</div>
                            <div class="form-group">
                                <label for="modalStatusInput">상태</label>
                                <select class="form-control" id="modalStatusInput" name="status">
		                                <option value="1">승인</option>
		                            <option value="0">진행중</option>
		                            <option value="-1">반려</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="modalOvertimeInput">초과 근무</label>
                                <input type="text" class="form-control" id="modalOvertimeInput">                          
                            </div>
                            
                    <div class="form-group">
                        <label for="modalBusinessDateInput">출장 시작 날짜</label>
                        <input type="date" class="form-control" id="modalBusinessDateInput" placeholder="yyyy-MM-dd" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="modalBusinessEndDateInput">출장 종료 날짜</label>
                        <input type="date" class="form-control" id="modalBusinessEndDateInput" placeholder="yyyy-MM-dd" required>
                    </div>
                    <div class="form-group">
                        <label for="modalEducationDateInput">교육 시작 날짜</label>
                        <input type="date" class="form-control" id="modalEducationDateInput" placeholder="yyyy-MM-dd" required>
                    </div>
                    <div class="form-group">
                        <label for="modalEducationEndDateInput">교육 종료 날짜</label>
                        <input type="date" class="form-control" id="modalEducationEndDateInput" placeholder="yyyy-MM-dd" required>
                    </div>
                            
                            
                            <div class="form-group">
                                <label for="modalModifiedReasonInput">수정 사유</label>
                                <input type="text" class="form-control" id="modalModifiedReasonInput">
                            </div>
                            <div class="form-group">
                                <label for="modalModifiedPersonInput">수정인</label>
                                <input type="text" class="form-control" id="modalModifiedPersonInput">
                            </div>
                            
		                               <div class="form-group">
		                    <label for="modalWorkformStatusInput">근무 상태</label>
		                    <input type="text" class="form-control" id="modalWorkformStatusInput" placeholder="근무 상태를 입력하세요" /> <!-- 근무 상태 추가 -->
		                </div>
                            
                       
                        <div id="successMessage" class="alert alert-success" style="display: none;">수정 완료</div>
                    </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="saveChangesButton">변경 저장</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
    <script>
    $(document).ready(function() {
        var currentPage = 1; // 현재 페이지 번호
        var itemsPerPage = 10; // 페이지 당 아이템 수
		
        
        // 날짜 선택 변경 시 데이터 로드
        $("#selectedDate").change(function() {
            currentPage = 1; // 페이지를 1로 초기화
            loadAttendanceData(currentPage); // 데이터 로드
        });

        
        
        function loadAttendanceData(page) {
            var empId = $("#emp_id").val(); // 입력된 사원 ID 가져오기
            var selectedDate = $("#selectedDate").val(); // 선택된 날짜 가져오기
			
         // 상태를 문자열로 변환하는 함수
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
            // AJAX 요청
            $.ajax({
                url: '/Attendance/attendanceData', // 요청 URL
                type: 'POST',
                data: { 
                    emp_id: empId, 
                    page: page,
                    size: itemsPerPage,
                    date: selectedDate
                },
                success: function(response) {
                    var data = response.data;
                    var totalItems = response.totalItems;
                    var totalPages = Math.ceil(totalItems / itemsPerPage);

                    $("#checkTimeList").empty(); // 기존 데이터 초기화

                    // 조회된 데이터를 테이블에 추가
                    if (data.length > 0) {
                        $.each(data, function(index, attendance) {
                            $("#checkTimeList").append(
                            		"<tr>" +
                            	    "<td>" + (attendance.emp_id || "-") + "</td>" +
                            	    "<td>" + (attendance.attendance_id || "-") + "</td>" +                          	   
                            	    "<td>" + (attendance.check_in || "-") + "</td>" +
                            	    "<td>" + (attendance.check_out || "-") + "</td>" +
                            	    "<td>" + (attendance.workingoutside_time || "-") + "</td>" +
                            	    "<td>" + (attendance.return_time || "-") + "</td>" +
                            	    "<td>" + (attendance.working_time || "-") + "</td>" +
                            	    "<td>" + (attendance.night_work_time || "-") + "</td>" +
                            	    "<td>" + (attendance.special_working_time || "-") + "</td>" +
                            	    "<td>" + (attendance.workform_status || "-") + "</td>" +
                            	    "<td>" + (attendance.new_check_in || "-") + "</td>" +
                            	    "<td>" + (attendance.new_check_out || "-") + "</td>" +
                            	    "<td>" + (attendance.new_workingoutside_time || "-") + "</td>" +
                            	    "<td>" + (attendance.modified_time || "-") + "</td>" +
                            	    "<td>" + (attendance.created_at || "-") + "</td>" +
                            	    "<td>" + getAttendanceStatusDisplay(attendance.status) + "</td>" + // status를 변환하여 표시
                            	    "<td>" + (attendance.overtime || "-") + "</td>" +
                            	    "<td>" + (attendance.businessDate || "-") + "</td>" +
                            	    "<td>" + (attendance.business_endDate || "-") + "</td>" +
                            	    "<td>" + (attendance.educationDate || "-") + "</td>" +
                            	    "<td>" + (attendance.education_endDate || "-") + "</td>" +
                            	    "<td>" + (attendance.modified_reason || "-") + "</td>" +
                            	    "<td>" + (attendance.modified_person || "-") + "</td>" +
                            	    "<td>" +
                            	        "<button class='btn btn-warning edit-button' data-id='" + attendance.attendance_id + "' " +
                            	        "data-emp-id='" + attendance.emp_id + "' " +
                            	        "data-check-in='" + attendance.check_in + "' " +
                            	        "data-check-out='" + attendance.check_out + "' " +
                            	        "data-workingoutside-time='" + attendance.workingoutside_time + "' " +
                            	        "data-return-time='" + attendance.return_time + "' " +
                            	        "data-working-time='" + attendance.working_time + "' " +
                            	        "data-night-work-time='" + attendance.night_work_time + "' " +
                            	        "data-special-working-time='" + attendance.special_working_time + "' " +
                            	        "data-new-check-in='" + attendance.new_check_in + "' " +
                            	        "data-new-check-out='" + attendance.new_check_out + "' " +
                            	        "data-new-workingoutside-time='" + attendance.new_workingoutside_time + "' " +
                            	        "data-modified-time='" + attendance.modified_time + "' " +
                            	        "data-created-at='" + attendance.created_at + "' " +
                            	        "data-status='" + attendance.status + "' " +
                            	        "data-overtime='" + attendance.overtime + "' " +
                            	        "data-businessDate='" + attendance.businessDate + "' " +
                            	        "data-business-endDate='" + attendance.business_endDate + "' " +
                            	        "data-educationDate='" + attendance.educationDate + "' " +
                            	        "data-education-endDate='" + attendance.education_endDate + "' " +
                            	        "data-modified-reason='" + attendance.modified_reason + "' " +
                            	        "data-modified-person='" + attendance.modified_person + "' " +
                            	        "data-workform-status='" + attendance.workform_status + "'>" + 
                            	        "수정</button>" +
                            	    "</td>" +
                            	    "<td>" +
                            	        "<button class='btn btn-danger delete-button' data-id='" + attendance.attendance_id + "' style='margin-left: 5px;'>삭제</button>" +
                            	    "</td>" +
                            	"</tr>"
                                );
                            });

                        // 페이징 버튼 업데이트
                        updatePagination(totalPages);
                    } else {
                        $("#checkTimeList").append("<tr><td colspan='20'>조회된 시간이 없습니다.</td></tr>");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 요청 실패:", status, error);
                    $("#checkTimeList").append("<tr><td colspan='20'>시간 조회에 실패했습니다.</td></tr>");
                }
            });
        }

        function updatePagination(totalPages) {
            $("#pagination").empty(); // 기존 페이지 버튼 초기화

            for (var i = 1; i <= totalPages; i++) {
                $("#pagination").append(
                    "<li class='page-item " + (i === currentPage ? "active" : "") + "'>" +
                        "<a class='page-link' href='#'>" + i + "</a>" +
                    "</li>"
                );
            }

            // 페이지 클릭 이벤트 추가
            $(".page-link").click(function(e) {
                e.preventDefault();
                currentPage = parseInt($(this).text());
                loadAttendanceData(currentPage);
            });
        }

        $("#checkTimeButton").click(function() {
            currentPage = 1; // 페이지를 1로 초기화
            loadAttendanceData(currentPage); // 데이터 로드
        });

        // 수정 버튼 클릭 이벤트
        $(document).on('click', '.edit-button', function() {
        	
            // 모달에 기존 값 로드
        $("#modalAttendanceId").val($(this).data("id"));
        $("#modalEmpId").val($(this).data("emp-id")); // EMP ID
        $("#modalCheckInInput").val($(this).data("check-in"));
        $("#modalCheckOutInput").val($(this).data("check-out"));
        $("#modalWorkingOutsideTimeInput").val($(this).data("workingoutside-time"));
        $("#modalReturnTimeInput").val($(this).data("return-time"));
        $("#modalWorkingTimeInput").val($(this).data("working-time"));
        $("#modalNightWorkTimeInput").val($(this).data("night-work-time"));
        $("#modalSpecialWorkingTimeInput").val($(this).data("special-working-time"));
        $("#modalNewCheckInInput").val($(this).data("new-check-in"));
        $("#modalNewCheckOutInput").val($(this).data("new-check-out"));
        $("#modalNewWorkingOutsideTimeInput").val($(this).data("new-workingoutside-time"));
        $("#modalModifiedTimeInput").val($(this).data("modified-time"));
        $("#modalCreatedAtInput").val($(this).data("created-at"));
        $("#modalStatusInput").val($(this).data("status"));
        $("#modalOvertimeInput").val($(this).data("overtime"));      
        $("#modalBusinessDateInput").val($(this).data("businessDate"));
        $("#modalBusinessEndDateInput").val($(this).data("business-endDate"));
        $("#modalEducationDateInput").val($(this).data("educationDate"));
        $("#modalEducationEndDateInput").val($(this).data("education-endDate"));
        $("#modalModifiedReasonInput").val($(this).data("modified-reason"));
        $("#modalModifiedPersonInput").val($(this).data("modified-person"));
        $("#modalWorkformStatusInput").val($(this).data("workform-status")); // 근무 상태 추가
        
            $("#successMessage").hide(); // 수정 완료 메시지 숨김
            $("#editModal").modal("show"); // 모달 열기
        });
		
        // 변경 저장 버튼 클릭 이벤트
        $("#saveChangesButton").click(function() {
        	   var attendanceId = $("#modalAttendanceId").val();
        	   var empId = $("#modalEmpId").val(); // EMP ID 추가
               var checkIn = $("#modalCheckInInput").val();
               var checkOut = $("#modalCheckOutInput").val();
               var workingOutsideTime = $("#modalWorkingOutsideTimeInput").val();
               var returnTime = $("#modalReturnTimeInput").val();
               var workingTime = $("#modalWorkingTimeInput").val();
               var nightWorkTime = $("#modalNightWorkTimeInput").val();
               var specialWorkingTime = $("#modalSpecialWorkingTimeInput").val();
               var newCheckIn = $("#modalNewCheckInInput").val();
               var newCheckOut = $("#modalNewCheckOutInput").val();
               var newWorkingOutsideTime = $("#modalNewWorkingOutsideTimeInput").val();
               var modifiedTime = $("#modalModifiedTimeInput").val();
               var createdAt = $("#modalCreatedAtInput").val();
               var status = $("#modalStatusInput").val();
               var overtime = $("#modalOvertimeInput").val();
               var businessDate = $("#modalBusinessDateInput").val();
               var businessEndDate = $("#modalBusinessEndDateInput").val();
               var educationDate = $("#modalEducationDateInput").val();
               var educationEndDate = $("#modalEducationEndDateInput").val();
               var modifiedReason = $("#modalModifiedReasonInput").val();
               var modifiedPerson = $("#modalModifiedPersonInput").val();
               var workformStatus = $("#modalWorkformStatusInput").val(); // 근무 상태 추가
            // AJAX 요청
           		$.ajax({
					    url: '/Attendance/updateAttendance', // 수정 요청 URL
					    type: 'POST',
					    contentType: 'application/json', // JSON 형식으로 보낼 것을 명시
					    dataType: 'json', // 서버로부터 JSON 형식의 응답을 기대
					    data: JSON.stringify({
					        attendance_id: attendanceId,
					        emp_id: empId, // EMP ID 추가
					        check_in: checkIn,
					        check_out: checkOut,
					        WorkingOutside_time: workingOutsideTime,
					        return_time: returnTime,
					        working_time: workingTime,
					        night_work_time: nightWorkTime,
					        special_working_time: specialWorkingTime,
					        new_check_in: newCheckIn,
					        new_check_out: newCheckOut,
					        new_WorkingOutside_time: newWorkingOutsideTime,
					        modified_time: modifiedTime,
					        created_at: createdAt,
					        status: status,					        
					        overtime: overtime,  
					        businessDate : businessDate,
					        business_endDate : businessEndDate,
					        educationDate: educationDate,
					        education_endDate: educationEndDate,
					        modified_reason: modifiedReason,
					        modified_person: modifiedPerson,
					        workform_status: workformStatus // 근무 상태 추가
					    }),
                success: function(response) {
                    if (response.success) {
                        $("#successMessage").show(); // 성공 메시지 표시
                        loadAttendanceData(currentPage); // 데이터 다시 로드
                    } else {
                        alert("수정 실패: " + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 요청 실패:", status, error);
                    loadAttendanceData(currentPage); 
                    alert("근태 정보가 수정되었습니다.");
                }
            });

        });
	
     // 삭제 버튼 클릭 이벤트
        $(document).on('click', '.delete-button', function() {
            var attendanceId = $(this).data("id");

            // 삭제 확인
            if (confirm("정말로 이 항목을 삭제하시겠습니까?")) {
                // AJAX 요청
                $.ajax({
                    url: '/Attendance/deleteAttendance', // 삭제 요청 URL
                    type: 'POST',
                    data: {
                        attendance_id: attendanceId
                    },
                    success: function(response) {
                        // 삭제 성공 시
                        alert("삭제되었습니다.");
                        loadAttendanceData(currentPage); // 데이터 재로딩
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX 요청 실패:", status, error);
                        alert("삭제 중 오류가 발생했습니다.");
                    }
                });
            }
        });
     
     
     
     
        
        // 닫기 버튼 클릭 시 모달 닫기
        $('.btn-secondary').on('click', function() {
            $("#editModal").modal('hide'); // 모달을 닫는 코드
        });
     
    });
        
    
    
    
    
    
    
    
    
    
    </script>
	<br>
	<br>
	<br>
	<br>
<!-- QR 생성 -->
	<h1>사원 출/퇴근 QR카드 발급 </h1>
   <form action="${pageContext.request.contextPath}/getQR" method="get" target="qrFrame" onsubmit="showQrModal(event)">
   <div class="d-flex align-items-center">
    <label for="modal_emp_id" class="me-2">사원번호 :</label>
    <input type="text" class="form-control me-2" id="modal_emp_id" name="emp_id" placeholder="사원 ID를 입력하세요." required style="width: 200px;">
    <button type="submit" id="checkTimeButton" class="btn btn-info">사원 카드 발급</button>
</div>
</form>

<!-- QR 코드 모달 -->
<div class="modal fade" id="qrModal" tabindex="-1" role="dialog" aria-labelledby="qrModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="qrModalLabel">QR 코드</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeQrModal()">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <iframe id="qrFrame" name="qrFrame" style="width:100%; height:200px; border:none;"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeQrModal()">닫기</button>
            </div>
        </div>
    </div>
</div>
<script>
    function showQrModal(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        var form = event.target;
        var empId = document.getElementById('modal_emp_id').value; // 모달 내 입력 필드에서 emp_id 가져오기
        var actionUrl = form.action + "?emp_id=" + empId; // URL에 emp_id 추가

        // iframe에 QR 코드 URL 로드
        document.getElementById('qrFrame').src = actionUrl;

        // 모달 보여주기
        $('#qrModal').modal('show');
    }

    function closeQrModal() {
        // 모달을 닫고 원래 상태로 되돌리기
        $('#qrModal').modal('hide'); // Bootstrap 모달 닫기
        document.getElementById('qrFrame').src = ''; // iframe을 초기화하여 내용 제거
    }

    // 모달이 완전히 숨겨졌을 때 실행되는 이벤트
    $('#qrModal').on('hidden.bs.modal', function () {
        document.getElementById('qrFrame').src = ''; // 모달이 닫힐 때 iframe 초기화
    });
</script>
	<br>
	<br>
	<br>
	<br>
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
    <script src="${pageContext.request.contextPath }/resources/assets/js/validate.js"></script>
  </body>
</html>