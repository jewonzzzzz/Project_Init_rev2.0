<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
<meta charset="UTF-8"> <!-- 한글 인코딩 추가 -->
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
   <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
   <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
   
   
   
   
 
  
  <style>
    .container {
        margin-left: 0; /* 왼쪽 여백 제거 */
        padding-left: 0; /* 왼쪽 패딩 제거 (필요한 경우) */
        max-width: 100%; /* 최대 너비를 100%로 설정 */
    }

   
	
.btn-wide {
    width: 150px; /* 원하는 너비로 조정 */
}
	
 
</style>
   
   
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

  <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">휴가관리</div>
               
               


<div class="card-body">
    <div class="table-responsive">
        <div id="basic-datatables_wrapper" class="dataTables_wrapper container-fluid dt-bootstrap4">
            <div class="row">
                <div class="col-sm-12">
                    <!-- 새로운 사원 휴가 관리 테이블 -->
                    <div class="mt-5" style="margin: 0; padding: 0;">
                        <h1>사원 휴가 관리(관리자)</h1>
                        
                        
                        <br>
                        <br>
                        
 <div class="d-flex align-items-center">
  
			<label class="me-2">사원 ID: </label>
			<input type="text" class="form-control me-2" id="emp_id" placeholder="사원 ID를 입력하세요" required style="width: 200px;">
			
			<label class="me-2">휴가 시작 날짜별(선택):</label>
			<input type="date" class="form-control me-2" id="leave_start_date" style="width: 200px;">
			
			<label class="me-2">연차 시작 날짜별(선택):</label>
			<input type="date" class="form-control me-2" id="annual_leave_start_date" style="width: 200px;">
			
			<button id="checkLeavesButton" class="btn btn-info">사원 휴가 조회</button>
   
   		   
   			
</div>         
                        <br>
                        <br>
            <div class="row">
                <div class="col-sm-12 col-md-6">
                    <div class="dataTables_length" id="basic-datatables_length">
                        <label>Show
                            <select name="basic-datatables_length" aria-controls="basic-datatables" class="form-control form-control-sm">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select>
                            entries
                        </label>
                    </div>
                </div>
                <div class="col-sm-12 col-md-6">
                    <div id="basic-datatables_filter" class="dataTables_filter">
                        <label>Search:<input type="search" class="form-control form-control-sm" placeholder="" aria-controls="basic-datatables"></label>
                    </div>
                </div>
            </div>

                        <!-- 사원 휴가 데이터 테이블 -->
                        <div id="leaveData">
                            <table id="checkLeaveTable" class="table mt-3">
                                <thead>
                                    <tr>
                                        <th>휴가 ID</th>
                                        <th>사원 ID</th>
                                        <th>휴가 유형</th>
                                        <th>휴가 시작일</th>
                                        <th>휴가 종료일</th>                                                                  
                                 		<th>총 휴가 일수</th>                                	
                                  		<th>연차 시작일</th>
                                        <th>연차 종료일</th>
                                        <th>총 연차 일수</th>
                                        <th>사용된 연차 일수</th>
                                        <th>잔여 연차 일수</th>
                                        <th>상태</th>
                                        <th>신청 사유</th>
                                        <th>신청 날짜</th>
                                        <th>수정</th>
                                        <th>삭제</th>
                                    </tr>
                                </thead>
                                <tbody id="checkLeaveList">
                                    <!-- 조회된 데이터가 여기에 삽입됩니다 -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 col-md-5">
                    <div class="dataTables_info" id="basic-datatables_info" role="status" aria-live="polite">
                        Showing 1 to 10 of 57 entries
                    </div>
                </div>
                <div class="col-sm-12 col-md-7">
                    <div class="dataTables_paginate paging_simple_numbers" id="basic-datatables_paginate">
                        <ul class="pagination">
                            <li class="paginate_button page-item previous disabled" id="basic-datatables_previous">
                                <a href="#" aria-controls="basic-datatables" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
                            </li>
                            <li class="paginate_button page-item active">
                                <a href="#" aria-controls="basic-datatables" data-dt-idx="1" tabindex="0" class="page-link">1</a>
                            </li>
                            <li class="paginate_button page-item ">
                                <a href="#" aria-controls="basic-datatables" data-dt-idx="2" tabindex="0" class="page-link">2</a>
                            </li>
                            <li class="paginate_button page-item ">
                                <a href="#" aria-controls="basic-datatables" data-dt-idx="3" tabindex="0" class="page-link">3</a>
                            </li>
                            <li class="paginate_button page-item ">
                                <a href="#" aria-controls="basic-datatables" data-dt-idx="4" tabindex="0" class="page-link">4</a>
                            </li>
                            <li class="paginate_button page-item ">
                                <a href="#" aria-controls="basic-datatables" data-dt-idx="5" tabindex="0" class="page-link">5</a>
                            </li>
                            <li class="paginate_button page-item ">
                                <a href="#" aria-controls="basic-datatables" data-dt-idx="6" tabindex="0" class="page-link">6</a>
                            </li>
                            <li class="paginate_button page-item next" id="basic-datatables_next">
                                <a href="#" aria-controls="basic-datatables" data-dt-idx="7" tabindex="0" class="page-link">Next</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

	
 
    <!-- 성공 메시지 -->
    <div id="successMessage" class="alert alert-success" style="display:none;">수정이 완료되었습니다.</div>

    <!-- 수정 모달 -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">휴가 수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="modalLeaveId">
                    
                       <div class="form-group">
                        <label for="modalLeaveTypeInput">휴가 유형</label>
                        <select id="modalLeaveTypeInput" class="form-control" name="leaveType" required>
                            <option value="" disabled selected>휴가 유형 선택</option>
                            <option value="연차">연차</option>
                            <option value="병가">병가</option>
                            <option value="출산휴가">출산휴가</option>
                            <option value="특별휴가">특별휴가</option>
                            <option value="하계휴가">하계휴가</option>
                            <option value="육아휴직">육아휴직</option>
                            <option value="병가휴직">병가휴직</option>
                            <option value="기타사유">기타사유</option>
                        </select>
                    </div>
                    
                    
                    
						                  <div class="form-group">
						    <label for="modalLeaveStartDateInput">휴가 시작일</label>
						    <input type="date" id="modalLeaveStartDateInput" class="form-control">
						</div>
						<div class="form-group">
						    <label for="modalEndLeaveDateInput">휴가 종료일</label>
						    <input type="date" id="modalEndLeaveDateInput" class="form-control">
						</div>
				
						<div class="form-group">
						    <label for="modalTotalLeaveDaysInput">휴가일</label>
						    <input type="number" id="modalTotalLeaveDaysInput" class="form-control">
						</div>
					
						<div class="form-group">
						    <label for="modalAnnualLeaveStartDateInput">연차 시작일</label>
						    <input type="date" id="modalAnnualLeaveStartDateInput" class="form-control">
						</div>
						<div class="form-group">
						    <label for="modalEndAnnualLeaveInput">연차 종료일</label>
						    <input type="date" id="modalEndAnnualLeaveInput" class="form-control">
						</div>
						<div class="form-group">
						    <label for="modalTotalAnnualLeaveInput">총 연차 일수</label>
						    <input type="number" id="modalTotalAnnualLeaveInput" class="form-control">
						</div>
						<div class="form-group">
						    <label for="modalUsedAnnualLeaveInput">사용된 연차 일수</label>
						    <input type="number" id="modalUsedAnnualLeaveInput" class="form-control">
						</div>
						<div class="form-group">
						    <label for="modalRemainingAnnualLeaveInput">잔여 연차 일수</label>
						    <input type="number" id="modalRemainingAnnualLeaveInput" class="form-control">
						</div>
						
                    
                        <div class="form-group">
                        <label for="modalLeaveStatusInput">상태</label>
                        <select class="form-control" id="modalLeaveStatusInput" name="status">
                            <option value="1">승인</option>
                            <option value="0">진행중</option>
                            <option value="-1">반려</option>
                        </select>
                    </div>
                     
                     <div class="form-group">
							  <label for="modalRequestedAtInput">신청 일자</label>
							  <input type="date" class="form-control" id="modalRequestedAtInput" placeholder="yyyy-MM-dd" required>
							</div>
                    
                    
                    <div class="form-group">
                        <label for="modalReasonInput">신청 사유</label>
                        <input type="text" id="modalReasonInput" class="form-control">
                    </div>
                                   
                    
                </div>
                <div class="modal-footer">
                    
                    <button id="saveChangesButton" type="button" class="btn btn-primary">변경 저장</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
$(document).ready(function() {
	
    // 휴가 데이터 로드 함수
    function loadLeaveData() {
    var empId = $("#emp_id").val(); // 입력된 사원 ID 가져오기
    var leaveStartDate = $("#leave_start_date").val(); // 입력된 휴가 시작 날짜 가져오기
    var annualLeaveStartDate = $("#annual_leave_start_date").val(); // 입력된 연차 시작 날짜 가져오기
	
    // 날짜 값 로그로 출력 (디버깅 용)
    console.log("사원 ID:", empId);
    console.log("휴가 시작 날짜:", leaveStartDate);
    console.log("연차 시작 날짜:", annualLeaveStartDate);
    
 // 상태를 문자열로 변환하는 함수
    function getLeaveStatusDisplay(status) {
        switch (status) {
            case 0:
                return '진행중';
            case 1:
                return '승인';
            case -1:
                return '반려';
            default:
                return '없음'; // null 또는 다른 값의 경우
        }
    }
    
    // AJAX 요청
    $.ajax({
        url: 'leaveSelect', // 요청 URL
        type: 'GET',
        data: { 
        	 emp_id: empId,
        	 leave_start_date: leaveStartDate || null, // 비어있을 경우 null로 설정
             annual_leave_start_date: annualLeaveStartDate || null // 비어있을 경우 null로 설정
        },
        success: function(response) {
            var leaves = response; // 조회된 데이터
            $("#checkLeaveList").empty(); // 기존 데이터 초기화
			
            // 조회된 데이터를 테이블에 추가
            if (leaves.length > 0) {
                $.each(leaves, function(index, leave) {
                    $("#checkLeaveList").append(
                        "<tr>" +
                        "<td>" + (leave.leave_id || "-") + "</td>" +
                        "<td>" + (leave.emp_id || "-") + "</td>" +
                        "<td>" + (leave.leave_type || "-") + "</td>" +
                        "<td>" + (leave.leave_start_date || "-") + "</td>" +
                        "<td>" + (leave.end_leave_date || "-") + "</td>" +                      
                        "<td>" + (leave.total_leave_days || "-") + "</td>" +
                        "<td>" + (leave.annual_leave_start_date || "-") + "</td>" +
                        "<td>" + (leave.end_annual_leave || "-") + "</td>" +
                        "<td>" + (leave.total_annual_leave || "-") + "</td>" +
                        "<td>" + (leave.used_annual_leave || "-") + "</td>" +
                        "<td>" + (leave.remaining_annual_leave || "-") + "</td>" +
                        "<td>" + getLeaveStatusDisplay(leave.leave_status) + "</td>" + // leave_status를 변환하여 표시
                        "<td>" + (leave.reason || "-") + "</td>" +
                        "<td>" + (leave.requested_at || "-") + "</td>" +
                        "<td>" +
                            "<button class='btn btn-warning edit-button' data-id='" + leave.leave_id + "' " +
                            "data-leave-type='" + leave.leave_type + "' " +
                            "data-leave-start-date='" + leave.leave_start_date + "' " +
                            "data-end-leave-date='" + leave.end_leave_date + "' " +
                            "data-total-leave-days='" + leave.total_leave_days + "' " +                    
                            "data-annual-leave-start-date='" + leave.annual_leave_start_date + "' " +
                            "data-end-annual-leave='" + leave.end_annual_leave + "' " +
                            "data-total-annual-leave='" + leave.total_annual_leave + "' " +
                            "data-requested-at='" + leave.requested_at + "' " +
                           
                            "data-remaining-annual-leave='" + leave.remaining_annual_leave + "' " +
                            "data-leave-status='" + leave.leave_status + "' " +
                            "data-reason='" + leave.reason + "' " +
                            ">수정</button>" +
                        "</td>" +
                        "<td>" +
                            "<button type='button' class='btn btn-danger delete-button' data-id='" + leave.leave_id + "'>삭제</button>" +
                        "</td>" +
                        "</tr>"
                    );
                });
            } else {
                $("#checkLeaveList").append("<tr><td colspan='17'>조회된 데이터가 없습니다.</td></tr>");
            }
        }
    });
}

// 버튼 클릭 시 휴가 조회
$("#checkLeavesButton").click(function() {
    loadLeaveData(); // 데이터 로드
});

    // 수정 버튼 클릭 시 모달에 데이터 설정
    $(document).on('click', '.edit-button', function() {
        $("#modalLeaveId").val($(this).data('id'));
        $("#modalLeaveTypeInput").val($(this).data('leave-type'));
        $("#modalLeaveStartDateInput").val($(this).data('leave-start-date'));
        $("#modalEndLeaveDateInput").val($(this).data('end-leave-date'));
        
       
        $("#modalTotalLeaveDaysInput").val($(this).data('total-leave-days')); // 총 휴가일수

        $("#modalRequestedAtInput").val($(this).data('requested-at'));
        $("#modalAnnualLeaveStartDateInput").val($(this).data('annual-leave-start-date'));
        $("#modalEndAnnualLeaveInput").val($(this).data('end-annual-leave'));
        $("#modalTotalAnnualLeaveInput").val($(this).data('total-annual-leave'));
        $("#modalUsedAnnualLeaveInput").val($(this).data('used-annual-leave'));
        $("#modalRemainingAnnualLeaveInput").val($(this).data('remaining-annual-leave'));
        $("#modalLeaveStatusInput").val($(this).data('leave-status'));
        $("#modalReasonInput").val($(this).data('reason'));
 
        $("#editModal").modal('show'); // 모달 열기
       
    });

    // 모달에서 변경 저장 버튼 클릭 시
    $("#saveChangesButton").click(function() {
        var leaveId = $("#modalLeaveId").val();
        var leaveData = {
            leave_id: leaveId,
            leave_type: $("#modalLeaveTypeInput").val(),
            leave_start_date: $("#modalLeaveStartDateInput").val(),
            end_leave_date: $("#modalEndLeaveDateInput").val(),
            total_leave_days: $("#modalTotalLeaveDaysInput").val(), // 총 휴가 일수          
            annual_leave_start_date: $("#modalAnnualLeaveStartDateInput").val(),
            end_annual_leave: $("#modalEndAnnualLeaveInput").val(),
            total_annual_leave: $("#modalTotalAnnualLeaveInput").val(),
            used_annual_leave: $("#modalUsedAnnualLeaveInput").val(),
            requested_at: $("#modalRequestedAtInput").val(),
            remaining_annual_leave: $("#modalRemainingAnnualLeaveInput").val(),
            leave_status: $("#modalLeaveStatusInput").val(),
            reason: $("#modalReasonInput").val()
        };

        // AJAX 요청으로 변경 저장
        $.ajax({
            url: 'leaveUpdate?leave_id=' + leaveId, // 업데이트 요청 URL
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(leaveData),
            success: function(response) {
                if (response.success) {
                    $("#successMessage").show().delay(3000).fadeOut(); // 성공 메시지 표시
                    loadLeaveData(); // 데이터 새로 고침
                   
                } else {
                    alert("수정에 실패했습니다. 다시 시도하세요.");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error details: ", xhr.responseText); // 서버에서 반환한 오류 메시지
                alert("오류가 발생했습니다. 다시 시도하세요.");
            }
        });
    });
    
    
    
    
    
    
    
    
    
    // 삭제 버튼 클릭 시 데이터 삭제
    $(document).on('click', '.delete-button', function() {
        var leaveId = $(this).data('id'); // 삭제할 휴가 ID

        // 사용자에게 확인 메시지 표시
        if (confirm("이 휴가를 정말 삭제하시겠습니까?")) {
            $.ajax({
                url: 'leaveDelete?leave_id=' + leaveId, // 삭제 요청 URL
                type: 'POST',
                success: function(response) {
                    if (response.success) {
                        $("#successMessage").show().delay(3000).fadeOut(); // 성공 메시지 표시
                        loadLeaveData(); // 데이터 새로 고침
                    } else {
                        alert("휴가 정보를 삭제 완료 했습니다.");
                        loadLeaveData(); // 데이터 새로 고침
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error details: ", xhr.responseText); // 서버에서 반환한 오류 메시지
                    alert("오류가 발생했습니다. 다시 시도하세요.");
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
