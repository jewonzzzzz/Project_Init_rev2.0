<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<!-- 한글 인코딩 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


  <title>INIT</title>
	  <link
	      rel="icon"
	      href="${pageContext.request.contextPath }/resources/assets/img/project/favicon_black.png"
	      style="border-radius: 50%;"
	      type="image/x-icon"
	    />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/leaveMain.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/leaveStyle.css" />
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">







<script
	src="${pageContext.request.contextPath }/resources/assets/js/plugin/webfont/webfont.min.js"></script>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />

</head>
<body>
	<div class="wrapper">
		<%@ include file="/resources/assets/inc/sidebar.jsp"%>
		<!-- sidebar -->
		<div class="main-panel">
			<div class="main-header">
				<%@ include file="/resources/assets/inc/logo_header.jsp"%>
				<!-- Logo Header -->
				<%@ include file="/resources/assets/inc/navbar.jsp"%>
				<!-- Navbar Header -->
			</div>
			<div class="container">
				<div class="page-inner">

					<!-- page-inner -->
<!------------------------------------------------------------------------------------------------------------------>

					<div class="col-md-12">
						<div class="card">

							<div class="card-header">
								<h4 class="card-title">휴가관리</h4>
							</div>




							<div class="card-body">
								<%
									// 세션에서 값 가져오기
									String empId = (String) session.getAttribute("emp_id"); // 세션에서 사원 번호 가져오기
									Integer remainingAnnualLeave = (Integer) session.getAttribute("remainingAnnualLeave"); // 세션에서 잔여 연차 가져오기
									Integer totalAnnualLeave = (Integer) session.getAttribute("totalAnnualLeave"); // 총 연차 가져오기
									Integer usedAnnualLeave = (Integer) session.getAttribute("usedAnnualLeave"); // 사용한 연차 가져오기
									Integer lgrant = (Integer) session.getAttribute("lgrant"); // 연차 부여 값 가져오기
									Integer expiry = (Integer) session.getAttribute("expiry"); // 연차 소멸 값 가져오기
									Integer adjustment = (Integer) session.getAttribute("adjustment"); // 연차 조정 값 가져오기

									// 세션에 값이 없을 경우 기본값 설정
									if (remainingAnnualLeave == null) {
										remainingAnnualLeave = 0; // 기본값 설정 (예: 0일)
									}
									if (totalAnnualLeave == null) {
										totalAnnualLeave = 0; // 기본값 설정
									}
									if (usedAnnualLeave == null) {
										usedAnnualLeave = 0; // 기본값 설정
									}
									if (lgrant == null) {
										lgrant = 0; // 기본값 설정
									}
									if (expiry == null) {
										expiry = 0; // 기본값 설정
									}
									if (adjustment == null) {
										adjustment = 0; // 기본값 설정
									}
								%>

								<%
									// 현재 날짜와 시간을 yyyy-MM-dd HH:mm:ss 형식으로 포맷
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									String requestedAt = sdf.format(new Date());
								%>

								<button class="btn1 btn-primary" onclick="openLeaveModal()">
									<span class="btn-label"> <i class="fas fa-calendar-minus"></i>
									</span> 연차 신청서
								</button>
								<!-- 연차 신청 모달 -->

								<div class="modal fade" id="leaveModal" tabindex="-1"
									role="dialog" aria-labelledby="leaveModalLabel"
									aria-hidden="true">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="leaveModalLabel">연차 신청서</h5>
												<button type="button" class="close"
													onclick="closeLeaveModal()" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<form id="leaveForm">
													<!-- 폼 추가 -->
													<div class="form-group">
														<label for="empId">사원 번호:</label> <input type="text"
															id="empId" name="emp_id" class="form-control"
															value="<%=empId%>" readonly required>
													</div>

													<div class="form-group">
														<label for="employee_name">직원 이름</label> <input
															type="text" class="form-control" id="employee_name"
															value="${emp_name}" readonly>
													</div>

													<div class="form-group">
														<label for="annualLeaveStartDate">연차 시작일:</label> <input
															type="date" id="annualLeaveStartDate"
															name="annual_leave_start_date" class="form-control"
															required>
													</div>
													<div class="form-group">
														<label for="endAnnualLeave">연차 종료일:</label> <input
															type="date" id="endAnnualLeave" name="end_annual_leave"
															class="form-control" required>
													</div>
													<div class="form-group">
														<label for="usedLeave">사용 연차:</label> <input type="number"
															id="usedLeave" name="used_annual_leave"
															class="form-control" placeholder="사용할 연차 일수를 입력하세요."
															readonly required>
													</div>
													<div class="form-group">
														<label for="totalLeave">총 연차:</label> <input type="number"
															id="totalLeave" name="total_annual_leave"
															class="form-control" value="15" readonly required>
													</div>
													<div class="form-group">
														<label for="remainingLeave">잔여 연차:</label> <input
															type="number" id="remainingLeave"
															name="remaining_annual_leave" class="form-control"
															value="15" readonly required>
													</div>
													<div class="form-group">
														<label for="lgrant">연차 부여:</label> <input type="number"
															id="lgrant" name="lgrant" class="form-control" value="0"
															readonly required>
													</div>
													<div class="form-group">
														<label for="expiry">연차 소멸:</label> <input type="number"
															id="expiry" name="expiry" class="form-control" value="0"
															readonly required>
													</div>
													<div class="form-group">
														<label for="adjustment">연차 조정:</label> <input
															type="number" id="adjustment" name="adjustment"
															class="form-control" readonly required>
													</div>
													<div class="form-group">
														<label for="leaveType">휴가 종류:</label> <select
															id="leaveType" name="leave_type" class="form-control"
															required>
															<option value="연차">연차</option>
														</select>
													</div>
													<div class="form-group">
														<label for="leaveStatus">결재 상태:</label> <select
															id="leaveStatus" name="leave_status" class="form-control"
															required>
															<option value="-1">결재 진행중</option>
														</select>
													</div>
													<div class="form-group">
														<label for="requested_at">신청 날짜 및 시간:</label> <input
															type="text" class="form-control" id="requested_at"
															name="requested_at" placeholder="yyyy-MM-dd HH:mm:ss"
															value="<%=requestedAt%>" required readonly>
													</div>
													<div class="form-group">
														<label for="reason">신청 사유:</label>
														<textarea id="reason" name="reason" class="form-control"
															rows="4" required></textarea>
													</div>
												</form>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-primary" onclick="submitLeaveForm()">신청</button>
												<button type="button" class="btn btn-secondary"
													onclick="closeLeaveModal()">닫기</button>
											</div>
										</div>
									</div>
								</div>

								<script>
function openLeaveModal() {
    $('#leaveModal').modal('show'); // 모달 ID 수정
}

function closeLeaveModal() {
    $('#leaveModal').modal('hide'); // 모달 ID 수정
}

//연차 시작일 및 종료일 변경 시 사용 연차 자동 계산
document.getElementById("annualLeaveStartDate").addEventListener("change", calculateUsedLeave);
document.getElementById("endAnnualLeave").addEventListener("change", calculateUsedLeave);

function calculateUsedLeave() {
    const startDate = new Date(document.getElementById("annualLeaveStartDate").value);
    const endDate = new Date(document.getElementById("endAnnualLeave").value);

    // 시작일과 종료일 모두 입력되었는지 확인
    if (!isNaN(startDate) && !isNaN(endDate) && endDate >= startDate) {
        let usedDays = 0;

        // 날짜 계산
        for (let d = new Date(startDate); d <= endDate; d.setDate(d.getDate() + 1)) {
            // 0: 일요일, 6: 토요일
            if (d.getDay() !== 0 && d.getDay() !== 6) { 
                usedDays++;
            }
        }

        // 사용 연차 입력란에 계산된 사용 일수 설정
        document.getElementById("usedLeave").value = usedDays;

        // 잔여 연차 업데이트
        const totalLeave = parseInt(document.getElementById("totalLeave").value) || 0;
        const remainingLeave = totalLeave - usedDays;

        document.getElementById("remainingLeave").value = remainingLeave < 0 ? 0 : remainingLeave;

        // 조정 연차 계산 (조정 연차는 사용 연차와 같고 음수로 설정)
        const adjustedLeave = -usedDays; // 사용 연차를 음수로 변환
        document.getElementById("adjustment").value = adjustedLeave; // 조정 연차 업데이트
    }
}

// 연차 신청서 제출 함수
function submitLeaveForm() {
    // 입력된 값 가져오기
    const empId = document.getElementById("empId").value;
    const annualLeaveStartDate = document.getElementById("annualLeaveStartDate").value;
    const endAnnualLeave = document.getElementById("endAnnualLeave").value;
    const usedLeave = parseInt(document.getElementById("usedLeave").value);
    const totalLeave = parseInt(document.getElementById("totalLeave").value);
    const remainingLeave = parseInt(document.getElementById("remainingLeave").value);
    const lgrant = parseInt(document.getElementById("lgrant").value);
    const expiry = parseInt(document.getElementById("expiry").value);
    const adjustment = parseInt(document.getElementById("adjustment").value);
    const leaveType = document.getElementById("leaveType").value;
    const leaveStatus = document.getElementById("leaveStatus").value;
    const reason = document.getElementById("reason").value;
    const requestedAt = document.getElementById("requested_at").value; // 신청 날짜 및 시간 가져오기

    // 유효성 검사
    if (!annualLeaveStartDate || !endAnnualLeave) {
        alert("연차 시작일과 종료일을 모두 입력해야 합니다.");
        return;
    }

    if (new Date(endAnnualLeave) < new Date(annualLeaveStartDate)) {
        alert("연차 종료일은 시작일 이후여야 합니다.");
        return;
    }

    if (usedLeave <= 0) {
        alert("사용 연차는 1일 이상이어야 합니다.");
        return;
    }
    
    
    // SweetAlert2로 확인 모달 표시
    Swal.fire({
        title: '연차 신청',
        text: '정말로 연차를 신청하시겠습니까?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: '네, 신청합니다',
        cancelButtonText: '아니오',
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33'
    }).then((result) => {
        if (result.isConfirmed) {
            // AJAX 요청
            $.ajax({
                type: "POST",
                url: "use",
                contentType: "application/json",
                data: JSON.stringify({
                    emp_id: empId,
                    annual_leave_start_date: annualLeaveStartDate,
                    end_annual_leave: endAnnualLeave,
                    used_annual_leave: usedLeave,
                    total_annual_leave: totalLeave,
                    remaining_annual_leave: remainingLeave,
                    lgrant: lgrant,
                    expiry: expiry,
                    adjustment: adjustment,
                    leave_type: leaveType,
                    leave_status: leaveStatus,
                    reason: reason,
                    requested_at: requestedAt
                }),
                success: function(response) {
                	  // 성공 메시지 표시
                    Swal.fire({
                        title: '신청 완료',
                        text: '연차 신청이 완료되었습니다.',
                        icon: 'success',
                        confirmButtonColor: '#3085d6',
                        showConfirmButton: true, // 확인 버튼 표시
                        timer: 3000 // 3초 후 자동으로 닫힘
                    }).then(() => {
                        // 성공 메시지 후에 필요한 추가 동작을 여기에 작성
                        document.getElementById('leaveForm').reset(); // 폼 초기화
                        closeLeaveModal(); // 모달 닫기
                    });
                },
                error: function(xhr, status, error) {
                    console.error("신청 실패:", error);
                    alert("신청 실패: " + error);
                }
            });
        }
    });
}
</script>







								<!-- 버튼 -->
								<button class="btn1 btn-primary"
									onclick="openLeaveRequestModal()">
									<span class="btn-label"><i class="fas fa-plane-departure"></i></span>
									휴가 신청서
								</button>

								<!-- 모달 -->
								<div class="modal fade" id="leaveRequestModal" tabindex="-1"
									role="dialog" aria-labelledby="leaveRequestModalLabel"
									aria-hidden="true">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="leaveRequestModalLabel">휴가
													신청서</h5>
												<button type="button" class="close"
													onclick="closeLeaveRequestModal()">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>

											<div class="modal-body">
												<div class="form-group">
													<label for="empId">사원 번호:</label> <input type="text"
														id="empId" name="emp_id" class="form-control"
														value="<%=empId%>" readonly required>
												</div>

												<div class="form-group">
													<label for="employee_name">직원 이름</label> <input type="text"
														class="form-control" id="employee_name"
														value="${emp_name}" readonly>
												</div>

												<div class="form-group">
													<label for="leave_type">휴가 유형</label> <select
														class="form-control" id="leave_type" name="leave_type"
														required>														
														<option value=""></option>
														<option value="출산휴가">출산 휴가</option>
														<option value="병가휴가">병가</option>
														<option value="특별휴가">특별휴가</option>
														<option value="여름휴가">하계휴가</option>
														<option value="기타휴가">기타</option>
													</select>
												</div>
												<div class="form-group">
													<label for="leave_start_date">휴가 시작일</label> <input
														type="date" class="form-control" id="leave_start_date"
														name="leave_start_date" required>
												</div>
												<div class="form-group">
													<label for="end_leave_date">휴가 종료일</label> <input
														type="date" class="form-control" id="end_leave_date"
														name="end_leave_date" required>
												</div>
												<div class="form-group">
													<label for="total_leave_days">총 휴가 일수</label> <input
														type="number" class="form-control" id="total_leave_days"
														name="total_leave_days" required>
												</div>
												<div class="form-group">
													<label for="leave_status">결재 상태</label> <select
														class="form-control" id="leave_status" name="leave_status"
														required>
														<option value="-1">결재 진행중</option>
													</select>
												</div>


												<div class="form-group">
													<label for="reason">신청 사유</label>
													<textarea class="form-control" id="reason" name="reason"
														rows="3" required></textarea>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-primary" id="signBtn"
													data-bs-toggle="modal" data-bs-target="#addRowModal">신청</button>
												<button type="button" class="btn btn-secondary"
													onclick="closeLeaveRequestModal()">닫기</button>
											</div>

										</div>
									</div>
								</div>

								<script>







function openLeaveRequestModal() {
    $('#leaveRequestModal').modal('show'); // Bootstrap의 모달을 수동으로 열기
}

function closeLeaveRequestModal() {
    $('#leaveRequestModal').modal('hide'); // Bootstrap의 모달을 수동으로 닫기
}





 function calculateLeaveDays() {
    const startDate = new Date(document.getElementById("leave_start_date").value);
     const endDate = new Date(document.getElementById("end_leave_date").value);
    
     // 시작일과 종료일 모두 입력되었는지 확인
    if (!isNaN(startDate) && !isNaN(endDate) && endDate >= startDate) {
         let totalDays = 0;
         let currentDate = new Date(startDate);

         // 주말 제외하고 날짜 계산
        while (currentDate <= endDate) {
            const dayOfWeek = currentDate.getDay();
             if (dayOfWeek !== 0 && dayOfWeek !== 6) { // 일요일(0)과 토요일(6)을 제외
                totalDays++;
            }
            currentDate.setDate(currentDate.getDate() + 1);
         }
        
         document.getElementById("total_leave_days").value = totalDays;
    } else {
        document.getElementById("total_leave_days").value = ""; // 유효하지 않은 경우 비워줌
     }
    
     validateForm();
 }

 function validateForm() {
     const leaveStartDate = document.getElementById("leave_start_date").value;
     const endLeaveDate = document.getElementById("end_leave_date").value;
     const reason = document.getElementById("reason").value;
     const signBtn = document.getElementById("signBtn");
    
    // 유효성 검사: 모든 필드가 입력되었는지 확인
     if (leaveStartDate && endLeaveDate && reason) {
         const startDate = new Date(leaveStartDate);
        const endDate = new Date(endLeaveDate);
        
         if (endDate >= startDate) {
            signBtn.disabled = false; // 모든 조건을 만족하면 버튼 활성화
         } else {
             signBtn.disabled = true; // 종료일이 시작일보다 이전이면 비활성화
        }
     } else {
         signBtn.disabled = true; // 필드 비어있을 경우 비활성화
     }
 }

 // 휴가 시작일 및 종료일 변경 시 사용 연차 자동 계산
// document.getElementById("leave_start_date").addEventListener("change", function() {
//     calculateLeaveDays();
// });
// document.getElementById("end_leave_date").addEventListener("change", function() {
//     calculateLeaveDays();
// });

// // 신청 사유 입력 시 유효성 검사
// document.getElementById("reason").addEventListener("input", validateForm);



// 	// 총 휴가 일수 계산 
// 	 function calculateTotalLeaveDays() { 
// 	    const startDate = new Date(document.getElementById("leave_start_date").value); 
// 	    const endDate = new Date(document.getElementById("end_leave_date").value); 

// 	     if (startDate && endDate && startDate <= endDate) { 
// 	         const totalDays = (endDate - startDate) / (1000 * 3600 * 24) + 1; // 시작일 포함 
// 	         document.getElementById("total_leave_days").value = totalDays; 
// 	     } 
// 	 } 

// 	 // 폼 제출 시 처리 
// 	 document.getElementById("leaveRequestForm").addEventListener("submit", function(event) { 
// 	     event.preventDefault(); // 폼 기본 동작 막기

// 	     // 날짜 유효성 검사 -->
// 	     if (!validateDates()) { 
// 	         return; // 유효성 검사 실패 시 종료 -->
// 	     } 


	</script>









								<!-- 휴직 신청서 버튼 -->
								<button class="btn1 btn-primary"
									onclick="openLeaveApplicationModal()">
									<span class="btn-label"><i class="fas fa-hourglass-start"></i></span>
									휴직 신청서
								</button>

								<!-- 휴직 신청 모달 -->
								<div class="modal fade" id="leaveApplicationModal" tabindex="-1"
									role="dialog" aria-labelledby="leaveApplicationModalLabel"
									aria-hidden="true">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="leaveApplicationModalLabel">휴직
													신청서</h5>
												<button type="button" class="close"
													onclick="closeLeaveApplicationModal()">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>

											<div class="modal-body">
<!-- 												<form id="leaveApplicationForm"> -->
													<div class="form-group">
														<label for="empIdLeave">사원 번호:</label> <input type="text"
															id="empIdLeave" name="emp_id" class="form-control"
															value="<%=empId%>" readonly required>
													</div>

													<div class="form-group">
														<label for="employee_name">직원 이름</label> <input
															type="text" class="form-control" id="employee_name"
															value="${emp_name}" readonly>
													</div>

													<div class="form-group">
														<label for="leave_type_leave">휴직 유형</label> <select
															class="form-control" id="leave_type_leave"
															name="leave_typeB" required>
															<option value=""></option>
															<option value="육아휴직">육아휴직</option>
															<option value="병가휴직">병가휴직</option>
															<option value="기타휴직">기타휴직</option>
														</select>
													</div>
													<div class="form-group">
														<label for="leave_start_date_leave">휴직 시작일</label> <input
															type="date" class="form-control"
															id="leave_start_date_leave" name="leave_start_date"
															required>
													</div>
													<div class="form-group">
														<label for="end_leave_date_leave">휴직 종료일</label> <input
															type="date" class="form-control"
															id="end_leave_date_leave" name="end_leave_date" required>
													</div>
													<div class="form-group">
														<label for="total_leave_days_leave">총 휴직 일수</label> <input
															type="number" class="form-control"
															id="total_leave_days_leave" name="total_leave_days"
															readonly required>
													</div>
													<div class="form-group">
														<label for="leave_status_leave">결재 상태</label> <select
															class="form-control" id="leave_status_leave"
															name="leave_status" required>
															<option value="-1">결재 진행중</option>
														</select>
													</div>
													<div class="form-group">
														<label for="reason_leave">신청 사유</label>
														<textarea class="form-control" id="reason_leave"
															name="reason" rows="3" required></textarea>
													</div>
													<div class="modal-footer">
														
														<button type="button" class="btn btn-primary" id="signBtn"
													data-bs-toggle="modal" data-bs-target="#addRowModal">신청</button>
														
														
														
														<button type="button" class="btn btn-secondary"
															onclick="closeLeaveApplicationModal()">닫기</button>
													</div>
<!-- 												</form> -->
											</div>
										</div>
									</div>
								</div>

								<script>

								// 휴직 모달 열기 함수
								function openLeaveApplicationModal() {
								    $('#leaveApplicationModal').modal('show'); // Bootstrap의 모달을 수동으로 열기
								}

								// 휴직 모달 닫기 함수
								function closeLeaveApplicationModal() {
								    $('#leaveApplicationModal').modal('hide'); // Bootstrap의 모달을 수동으로 닫기
								}

								// 휴직 시작일과 종료일 간의 유효성 검사
								function validateLeaveDates() {
								    const startDate = new Date(document.getElementById("leave_start_date_leave").value);
								    const endDate = new Date(document.getElementById("end_leave_date_leave").value);
								    if (endDate < startDate) {
								        alert("휴직 종료일은 시작일보다 이후여야 합니다.");
								        return false;
								    }
								    return true;
								}

								// 총 휴직 일수 자동 계산 (주말 제외)
								function calculateTotalLeaveDays() {
								    const startDate = new Date(document.getElementById("leave_start_date_leave").value);
								    const endDate = new Date(document.getElementById("end_leave_date_leave").value);
								    
								    if (!isNaN(startDate) && !isNaN(endDate) && endDate >= startDate) {
								        let totalDays = 0;
								        let currentDate = new Date(startDate);
								        
								        // 주말 제외하고 날짜 계산
								        while (currentDate <= endDate) {
								            const dayOfWeek = currentDate.getDay();
								            if (dayOfWeek !== 0 && dayOfWeek !== 6) { // 일요일(0)과 토요일(6)을 제외
								                totalDays++;
								            }
								            currentDate.setDate(currentDate.getDate() + 1);
								        }
								        
								        document.getElementById("total_leave_days_leave").value = totalDays;
								    } else {
								        document.getElementById("total_leave_days_leave").value = ""; // 유효하지 않은 경우 비워줌
								    }
								}

								// 휴직 폼 제출 시 처리
								function submitLeaveApplication() {
								    // 날짜 유효성 검사
								    if (!validateLeaveDates()) {
								        return; // 유효성 검사 실패 시 제출 중단
								    }

								    // 총 휴직 일수 계산
								    calculateTotalLeaveDays();

								    // 입력된 값 가져오기
								    const empId = document.getElementById("empIdLeave").value;
								    const leaveType = document.getElementById("leave_type_leave").value;
								    const leaveStartDate = document.getElementById("leave_start_date_leave").value;
								    const endLeaveDate = document.getElementById("end_leave_date_leave").value;
								    const totalLeaveDays = document.getElementById("total_leave_days_leave").value;
								    const leaveStatus = document.getElementById("leave_status_leave").value;
								    const reason = document.getElementById("reason_leave").value;

								    // SweetAlert2로 확인 메시지 표시
								    Swal.fire({
								        title: '휴직 신청',
								        text: '정말로 연차를 신청하시겠습니까?',
								        icon: 'question',
								        showCancelButton: true,
								        confirmButtonText: '네, 신청합니다',
								        cancelButtonText: '아니오',
								        confirmButtonColor: '#3085d6',
								        cancelButtonColor: '#d33'
								    }).then((result) => {
								        if (result.isConfirmed) {
								            // 서버에 데이터 전송하는 로직 추가 (AJAX 사용)
								            $.ajax({
								                type: "POST",
								                url: "leavesubmit", // 서버의 API 엔드포인트
								                contentType: "application/json", // JSON 형태로 전송
								                data: JSON.stringify({
								                    emp_id: empId,
								                    leave_type: leaveType,
								                    leave_start_date: leaveStartDate,
								                    end_leave_date: endLeaveDate,
								                    reason: reason,
								                    total_leave_days: totalLeaveDays,
								                    leave_status: leaveStatus
								                }),
								                success: function(response) {
								                    // 성공 메시지 표시
								                    Swal.fire({
								                        title: '신청 완료',
								                        text: '휴직 신청이 완료되었습니다.',
								                        icon: 'success',
								                        confirmButtonColor: '#3085d6'
								                    }).then(() => {
								                    	if (result.isConfirmed) {
								                            // 사용자가 확인 버튼을 클릭했을 때
								                            document.getElementById('leaveApplicationForm').reset(); // 폼 초기화
								                            // 추가 동작을 여기에 작성
								                        }
								                    });
								                },
								                error: function(xhr, status, error) {
								                    // 요청이 실패했을 때의 처리
								                    console.error("휴직 신청 실패:", error);
								                    alert("휴직 신청 실패: " + error); // 에러 메시지 보여주기
								                }
								            });
								        }
								    });
								}

								// 날짜 선택 시 총 휴직 일수 계산
								document.getElementById("leave_start_date_leave").addEventListener("change", calculateTotalLeaveDays);
								document.getElementById("end_leave_date_leave").addEventListener("change", calculateTotalLeaveDays);
</script>







								<!-- 나의 휴가 현황 버튼 -->
								<button class="btn1 btn-primary"
									onclick="openLeaveStatusModal()">
									<span class="btn-label"> <i class="fas fa-check-double"></i>
									</span> 나의 휴가 현황
								</button>

								<!-- 나의 휴가 현황 모달 -->
								<div class="modal fade" id="leaveStatusModal" tabindex="-1"
									role="dialog" aria-labelledby="leaveStatusModalLabel"
									aria-hidden="true">
									<div class="modal-dialog modal-xl" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="leaveStatusModalLabel">나의
													휴가 현황</h5>
												<button type="button" class="close"
													onclick="closeLeaveStatusModal()">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body ">
												<div style="overflow-x: auto;">
													<!-- 가로 스크롤을 위한 div -->
													<table class="table">
														<thead>
															<tr>
																<th>사원 번호</th>
																<th>총 연차 일수</th>
																<th>사용 연차</th>
																<th>잔여 연차</th>
																<th>총 휴가 일수</th>
																<th>휴가 유형</th>
																<th>휴가 시작일</th>
																<th>휴가 종료일</th>
																<th>신청일</th>
																<th>승인 상태</th>
															</tr>
														</thead>
														<tbody id="leaveInfoTableBody">
															<!-- AJAX로 불러온 정보를 여기에 표시합니다 -->
														</tbody>
													</table>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													onclick="closeLeaveStatusModal()">닫기</button>
											</div>
										</div>
									</div>
								</div>

								<script>
function closeLeaveStatusModal() {
    $('#leaveStatusModal').modal('hide');
}
function getAttendanceStatusDisplay(leave_status) {
    switch (leave_status) { // 매개변수 이름을 leave_status로 변경
        case 0:
            return '현황';      
        case -1:
            return '결재 진행 중';   
        default:
            return '과거이력'; 
    }
}


    // 나의 휴가 현황 모달 열기 함수
    function openLeaveStatusModal() {
        const empId = '<%=empId%>'; // 세션에서 emp_id 가져오기
        $('#leaveStatusModal').modal('show');
        
        // 휴가 현황을 조회하는 AJAX 요청
        $.ajax({
            type: "GET",
            url: "getLeaveStatus", // 서버의 엔드포인트 설정
            data: { emp_id: empId },
            success: function(response) {
                // 요청이 성공했을 때 데이터를 화면에 출력
                displayLeaveInfo(response);
            },
            error: function(xhr, status, error) {
                console.error("휴가 현황 조회 실패:", error);
                $('#leaveInfoTableBody').html("<tr><td colspan='11'>휴가 현황을 불러오는 데 실패했습니다.</td></tr>");
            }
        });
    }

    // 휴가 정보를 화면에 표시하는 함수
    function displayLeaveInfo(data) {
        const leaveInfoTableBody = document.getElementById("leaveInfoTableBody");
        leaveInfoTableBody.innerHTML = ""; // 기존 데이터 초기화
        
        
        
        
        // 테이블에 한 행 추가
        data.forEach(leave => {
            leaveInfoTableBody.innerHTML +=
            	"<tr>" + // 각 leave 정보를 새로운 행으로 시작
                "<td>" + (leave.emp_id || "-") + "</td>" +  // emp_id가 null일 경우 "없음" 표시
                "<td>" + (leave.total_annual_leave || "-") + "</td>" +  // total_annual_leave가 null일 경우 "없음" 표시
                "<td>" + (leave.used_annual_leave || "-") + "</td>" +  // used_annual_leave가 null일 경우 "없음" 표시
                "<td>" + (leave.remaining_annual_leave || "-") + "</td>" +  // remaining_annual_leave가 null일 경우 "없음" 표시
                "<td>" + (leave.total_leave_days || "-") + "</td>" +  // total_leave_days가 null일 경우 "없음" 표시           
                "<td>" + (leave.leave_type || "-") + "</td>" +  // leave_type가 null일 경우 "없음" 표시
                "<td>" + (leave.leave_start_date || "-") + "</td>" +  // leave_start_date가 null일 경우 "없음" 표시
                "<td>" + (leave.end_leave_date || "-") + "</td>" +  // end_leave_date가 null일 경우 "없음" 표시
                "<td>" + (leave.requested_at || "-") + "</td>" + // requested_at이 null일 경우 "없음" 표시
                "<td>" + (getAttendanceStatusDisplay(leave.leave_status) || "-") + "</td>" + // leave_status에 따른 상태 표시
            "</tr>"; // 행을 닫음
        });
    }
</script>


								<div class="card-header">
									<h1 class="card-title">나의 연차 현황표</h1>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<div id="basic-datatables_wrapper"
											class="dataTables_wrapper container-fluid dt-bootstrap4">
											<div class="row">
												<div class="col-sm-12 col-md-6">
													<div class="dataTables_length" id="basic-datatables_length">
														<label>Show <select name="basic-datatables_length"
															aria-controls="basic-datatables"
															class="form-control form-control-sm"><option
																	value="10">10</option>
																<option value="25">25</option>
																<option value="50">50</option>
																<option value="100">100</option></select> entries
														</label>
													</div>
												</div>
												<div class="col-sm-12 col-md-6">
													<div id="basic-datatables_filter" class="dataTables_filter">
														<label>Search:<input type="search"
															class="form-control form-control-sm" placeholder=""
															aria-controls="basic-datatables"></label>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-12">
													<table id="basic-datatables"
														class="display table table-striped table-hover dataTable"
														role="grid" aria-describedby="basic-datatables_info">
														<thead>
															<tr role="row">
																<th class="sorting_asc" tabindex="0"
																	aria-controls="basic-datatables" rowspan="1"
																	colspan="1" aria-sort="ascending"
																	aria-label="Name: activate to sort column descending"
																	style="width: 242.312px;">날짜</th>
																<th class="sorting" tabindex="0"
																	aria-controls="basic-datatables" rowspan="1"
																	colspan="1"
																	aria-label="Position: activate to sort column ascending"
																	style="width: 366.031px;">부여</th>
																<th class="sorting" tabindex="0"
																	aria-controls="basic-datatables" rowspan="1"
																	colspan="1"
																	aria-label="Office: activate to sort column ascending"
																	style="width: 187.375px;">총연차</th>
																<th class="sorting" tabindex="0"
																	aria-controls="basic-datatables" rowspan="1"
																	colspan="1"
																	aria-label="Office: activate to sort column ascending"
																	style="width: 187.375px;">소멸</th>

																<th class="sorting" tabindex="0"
																	aria-controls="basic-datatables" rowspan="1"
																	colspan="1"
																	aria-label="Age: activate to sort column ascending"
																	style="width: 84.3125px;">조정</th>
																<th class="sorting" tabindex="0"
																	aria-controls="basic-datatables" rowspan="1"
																	colspan="1"
																	aria-label="Start date: activate to sort column ascending"
																	style="width: 183.922px;">사용</th>
																<th class="sorting" tabindex="0"
																	aria-controls="basic-datatables" rowspan="1"
																	colspan="1"
																	aria-label="Salary: activate to sort column ascending"
																	style="width: 156.047px;">잔여</th>
															</tr>
														</thead>




														<tbody id="leaveTableBody">



														</tbody>




													</table>




												</div>
											</div>
											<div class="row">
												<div class="col-sm-12 col-md-5">
													<div class="dataTables_info" id="basic-datatables_info"
														role="status" aria-live="polite">Showing 1 to 10 of
														57 entries</div>
												</div>
												<div class="col-sm-12 col-md-7">
													<div class="dataTables_paginate paging_simple_numbers"
														id="basic-datatables_paginate">
														<ul class="pagination">
															<li class="paginate_button page-item previous disabled"
																id="basic-datatables_previous"><a href="#"
																aria-controls="basic-datatables" data-dt-idx="0"
																tabindex="0" class="page-link">Previous</a></li>
															<li class="paginate_button page-item active"><a
																href="#" aria-controls="basic-datatables"
																data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
															<li class="paginate_button page-item "><a href="#"
																aria-controls="basic-datatables" data-dt-idx="2"
																tabindex="0" class="page-link">2</a></li>
															<li class="paginate_button page-item "><a href="#"
																aria-controls="basic-datatables" data-dt-idx="3"
																tabindex="0" class="page-link">3</a></li>
															<li class="paginate_button page-item "><a href="#"
																aria-controls="basic-datatables" data-dt-idx="4"
																tabindex="0" class="page-link">4</a></li>
															<li class="paginate_button page-item "><a href="#"
																aria-controls="basic-datatables" data-dt-idx="5"
																tabindex="0" class="page-link">5</a></li>
															<li class="paginate_button page-item "><a href="#"
																aria-controls="basic-datatables" data-dt-idx="6"
																tabindex="0" class="page-link">6</a></li>
															<li class="paginate_button page-item next"
																id="basic-datatables_next"><a href="#"
																aria-controls="basic-datatables" data-dt-idx="7"
																tabindex="0" class="page-link">Next</a></li>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>


								<script>
    $(document).ready(function() {
        // 페이지가 로드될 때 연차 정보를 가져오는 AJAX 요청
        $.ajax({
            url: 'getLeaveInfo', // API 경로
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                console.log(data); // 데이터를 확인하기 위한 로깅
                $('#leaveTableBody').empty(); // 기존 내용을 지우고 새로운 내용을 추가

                // 데이터가 없을 경우
                if (data.length === 0) {
                    $('#leaveTableBody').append('<tr><td colspan="7">연차 정보가 없습니다. 로그인 상태를 확인해주세요.</td></tr>');
                } else {
                    // 데이터가 있을 경우			   
				let hasValidData = false; // 유효한 데이터가 있는지 체크하는 플래그
				data.forEach(function(leave) {
				    // 연차 시작 날짜가 있는 경우에만 데이터를 체크
				    if (leave.total_annual_leave) {
				        // 각 leave 정보의 필드를 체크하여 유효한 데이터인지 확인
				        if (leave.lgrant || leave.total_annual_leave || 
				            leave.expiry || leave.adjustment || leave.used_annual_leave || 
				            leave.remaining_annual_leave) {
				            hasValidData = true; // 유효한 데이터가 있는 경우 플래그를 true로 변경
				            $('#leaveTableBody').append(
				                '<tr>' +
				                    '<td>' + (leave.annual_leave_start_date || '-') + '</td>' +
				                    '<td>' + (leave.lgrant || '-') + '</td>' +
				                    '<td>' + (leave.total_annual_leave || '-') + '</td>' +
				                    '<td>' + (leave.expiry || '-') + '</td>' +
				                    '<td>' + (leave.adjustment || '-') + '</td>' +
				                    '<td>' + (leave.used_annual_leave || '-') + '</td>' +
				                    '<td>' + (leave.remaining_annual_leave || '-') + '</td>' +
				                '</tr>'
				            );
				        }
				    }
				});

                    // 유효한 데이터가 없을 경우 메시지 표시
                    if (!hasValidData) {
                        $('#leaveTableBody').append('<tr><td colspan="7">유효한 연차 정보가 없습니다.</td></tr>');
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
                $('#leaveTableBody').html('<tr><td colspan="7">데이터를 가져오는 중 오류가 발생했습니다.</td></tr>');
            }
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
                "<td style='text-align: center;'> <select class='form-select input-fixed modalSelector'" +
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
     	
     	// 결재요청 시 급여내역리스트 업데이트 및 워크플로우에 INSERT 후 페이지 리로딩 d
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
	                    $('.modalSelector option:selected').each(function () {
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
	             			emp_id: $('#empId').val(),
	             			wf_sender: $('select option[name="wf_receiver"]:selected').closest('tr').find('input').val(),
	             			wf_receiver_1st: $('select option[name="wf_receiver_1st"]:selected').closest('tr').find('input').val(),
	             			wf_receiver_2nd: $('select option[name="wf_receiver_2nd"]:selected').closest('tr').find('input').val(),
	             			wf_receiver_3rd: $('select option[name="wf_receiver_3rd"]:selected').closest('tr').find('input').val(),
	             			wf_title: $('input[name="wf_title"]').val(),
	             			wf_content: $('textarea[name="wf_content"]').val(),	             			
	             			
	             			// 휴가
	             			leave_type: $('#leave_type').val(),  // 휴가 유형
	             		    leave_start_date: $('#leave_start_date').val(),  // 휴가 시작일
	             		    end_leave_date: $('#end_leave_date').val(),  // 휴가 종료일
	             		    total_leave_days: $('#total_leave_days').val(),  // 총 휴가 일수
	             		    leave_status: $('#leave_status').val(),  // 결재 상태
	             		   	reason: $('#reason').val(),  // 신청 사유		             		    
	             		   	
	             		   	//휴직
	             		   	leave_start_dateA: $('#leave_start_date_leave').val(),	             		   
	             			end_leave_dateA: $('#end_leave_date_leave').val(),
	             			leave_typeA: $('#leave_type_leave').val(),
	             			total_leave_daysA: $('#total_leave_days_leave').val(),
	             			reasonA: $('#reason_leave').val(),
	             			
	             			
	             			
	             			
	
	             		    

  	            	};
	             			
	                     
	     			
  	             	$.ajax({
  	            		url:'/leave/insertSignInfoForLeave',
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
  	                            window.location.href = "/leave/main";  // 페이지 이동
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
	
	});
        
      
    
</script>




							</div>
						</div>
					</div>
					<%@ include file="../inc/signModal.jsp"%>



<!------------------------------------------------------------------------------------------------------------------>
				</div>
				<!-- page-inner -->
			</div>
			<!-- container -->
			<%--         <%@ include file="/resources/assets/inc/footer.jsp" %> --%>
		</div>
		<!-- main-panel -->
	</div>
	<!-- main-wrapper -->

	<!--   Core JS Files   -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>

	<!-- jQuery Scrollbar -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

	<!-- Chart JS -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart.js/chart.min.js"></script>

	<!-- jQuery Sparkline -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

	<!-- Chart Circle -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/chart-circle/circles.min.js"></script>

	<!-- Datatables -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/datatables/datatables.min.js"></script>

	<!-- Bootstrap Notify -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

	<!-- jQuery Vector Maps -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/jsvectormap/world.js"></script>

	<!-- Sweet Alert -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/plugin/sweetalert/sweetalert.min.js"></script>

	<!-- Kaiadmin JS -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/kaiadmin.min.js"></script>

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
        lineWidth: "2",A
        lineColor: "#ffa534",
        fillColor: "rgba(255, 165, 52, .14)",
      });
    </script>

</body>
</html>
