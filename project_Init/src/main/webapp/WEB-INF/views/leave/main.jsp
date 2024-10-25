<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ page import="java.text.SimpleDateFormat" %>
	<%@ page import="java.util.Date" %>
    
<!DOCTYPE html>
<html> <!-- html 태그 추가 -->
<head>
<meta charset="UTF-8"> <!-- 한글 인코딩 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
   
    	
   
  
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/leaveMain.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/leaveStyle.css" />
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    
   
    
    
    <style>
    .custom-modal {
        max-width: 95%; /* 너비를 95%로 설정하여 큰 화면에서도 충분한 크기 유지 */
    }

    @media (min-width: 992px) { /* 중간 이상 화면에서 적용 */
        .custom-modal {
            max-width: 100%; /* 너비를 90%로 설정 */
        }
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
                
                <!-- page-inner -->
<!------------------------------------------------------------------------------------------------------------------>
                    
  <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                 <div class="card-title">휴가 관리</div>

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
    <span class="btn-label">
        <i class="fa fa-bookmark"></i>
    </span> 연차 신청서
</button>

<!-- 연차 신청 모달 -->
<div id="leaveModal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close" onclick="closeLeaveModal()">&times;</span>
        <h2>연차 신청서</h2>
        <form id="leaveForm">
            <div class="form-group">
                <label for="empId">사원 번호:</label>
                <input type="text" id="empId" name="emp_id" class="form-control" 
                       value="<%= empId %>" readonly required>
            </div>
              
              <div class="form-group">
					    <label for="employee_name">직원 이름</label>
					    <input type="text" class="form-control" id="employee_name" value="${emp_name}" readonly>
					</div>
            
            <div class="form-group">
                <label for="annualLeaveStartDate">연차 시작일:</label>
                <input type="date" id="annualLeaveStartDate" name="annual_leave_start_date" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="endAnnualLeave">연차 종료일:</label>
                <input type="date" id="endAnnualLeave" name="end_annual_leave" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="usedLeave">사용 연차:</label>
                <input type="number" id="usedLeave" name="used_annual_leave" class="form-control" 
                       placeholder="사용할 연차 일수를 입력하세요." required>
            </div>
			           <div class="form-group">
			    <label for="totalLeave">총 연차:</label>
			    <input type="number" id="totalLeave" name="total_annual_leave" class="form-control" 
			           value="15" readonly required> <!-- 기본값 예시로 20일 설정 -->
			</div>
			<div class="form-group">
			    <label for="remainingLeave">잔여 연차:</label>
			    <input type="number" id="remainingLeave" name="remaining_annual_leave" class="form-control" 
			           value="15" readonly required> <!-- 초기 잔여 연차 설정 -->
			</div>
			<div class="form-group">
			    <label for="lgrant">연차 부여:</label>
			    <input type="number" id="lgrant" name="lgrant" class="form-control" 
			           value="0" readonly required> <!-- 기본값 설정 -->
			</div>
			<div class="form-group">
			    <label for="expiry">연차 소멸:</label>
			    <input type="number" id="expiry" name="expiry" class="form-control" 
			           value="0" readonly required> <!-- 기본값 설정 -->
			</div>
			<div class="form-group">
			    <label for="adjustment">연차 조정:</label>
			    <input type="number" id="adjustment" name="adjustment" class="form-control" 
			           readonly required> <!-- 기본값 설정 -->
			</div>
            <div class="form-group">
                <label for="leaveType">휴가 종류:</label>
                <select id="leaveType" name="leave_type" class="form-control" required>
                    <option value="연차">연차</option>
                </select>
            </div>
            <div class="form-group">
                <label for="leaveStatus">결재 상태:</label>
                <select id="leaveStatus" name="leave_status" class="form-control" required>
                    <option value="0">진행중</option>
                </select>
            </div>
            
             <div>
    <label for="requested_at">신청 날짜 및 시간:</label>
    <input
        type="text" class="form-control" id="requested_at"
        name="requested_at" placeholder="yyyy-MM-dd HH:mm:ss"
        value="<%= requestedAt %>" required readonly>
</div>
            
            <div class="form-group">
                <label for="reason">신청 사유:</label>
                <textarea id="reason" name="reason" class="form-control" rows="4" required></textarea>
            </div>
        </form>
        <div class="modal-footer">
            <button type="submit" class="btn btn-primary" onclick="submitLeaveForm()">신청</button>
            <button type="button" class="btn btn-secondary" onclick="closeLeaveModal()">닫기</button>
        </div>
    </div>
</div>

<script>
function openLeaveModal() {
    document.getElementById("leaveModal").style.display = "block";
}

function closeLeaveModal() {
    document.getElementById("leaveModal").style.display = "none";
}

// 사용 연차 입력 시 잔여 연차 및 조정 연차 자동 계산
document.getElementById("usedLeave").addEventListener("input", function() {
    const totalLeave = parseInt(document.getElementById("totalLeave").value) || 0;
    const usedLeave = parseInt(this.value) || 0; // 현재 입력된 값 또는 0
    const remainingLeave = totalLeave - usedLeave;

    // 잔여 연차 업데이트
    document.getElementById("remainingLeave").value = remainingLeave < 0 ? 0 : remainingLeave;

    // 조정 연차 계산 (조정 연차는 사용 연차와 같고 음수로 설정)
    const adjustedLeave = -usedLeave; // 사용 연차를 음수로 변환
    document.getElementById("adjustment").value = adjustedLeave; // 조정 연차 업데이트
});

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
            console.log("연차 신청이 완료되었습니다:", response);
            alert("연차 신청이 완료되었습니다");
            closeLeaveModal();
        },
        error: function(xhr, status, error) {
            console.error("신청 실패:", error);
            alert("신청 실패: " + error);
        }
    });
}
</script>
				
				
				
				
				
				
				
<!-- 버튼 -->
<button class="btn1 btn-primary" onclick="openLeaveRequestModal()">
    <span class="btn-label"><i class="fa fa-bookmark"></i></span> 휴가 신청서
</button>

<!-- 모달 -->
<div class="modal fade" id="leaveRequestModal" tabindex="-1" role="dialog" aria-labelledby="leaveRequestModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="leaveRequestModalLabel">휴가 신청서</h5>
                <button type="button" class="close" onclick="closeLeaveRequestModal()">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="leaveRequestForm">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="empId">사원 번호:</label>
                        <input type="text" id="empId" name="emp_id" class="form-control" value="<%= empId %>" readonly required>
                    </div>
                    
                      <div class="form-group">
					    <label for="employee_name">직원 이름</label>
					    <input type="text" class="form-control" id="employee_name" value="${emp_name}" readonly>
					</div>
                    
                    <div class="form-group">
                        <label for="leave_type">휴가 유형</label>
                        <select class="form-control" id="leave_type" name="leave_type" required>
                            <option value="출산 휴가">출산 휴가</option>
                            <option value="병가">병가</option>
                            <option value="특별휴가">특별휴가</option>
                            <option value="여름휴가">하계휴가</option>
                            <option value="기타">기타</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="leave_start_date">휴가 시작일</label>
                        <input type="date" class="form-control" id="leave_start_date" name="leave_start_date" required>
                    </div>
                    <div class="form-group">
                        <label for="end_leave_date">휴가 종료일</label>
                        <input type="date" class="form-control" id="end_leave_date" name="end_leave_date" required>
                    </div>
                    <div class="form-group">
                        <label for="total_leave_days">총 휴가 일수</label>
                        <input type="number" class="form-control" id="total_leave_days" name="total_leave_days" readonly required>
                    </div>
                    <div class="form-group">
                        <label for="leave_status">결재 상태</label>
                        <select class="form-control" id="leave_status" name="leave_status" required>
                            <option value="0">진행중</option>
                        </select>
                    </div>
                    
                              <div>
				    <label for="requested_at">신청 날짜 및 시간:</label>
				    <input
				        type="text" class="form-control" id="requested_at"
				        name="requested_at" placeholder="yyyy-MM-dd HH:mm:ss"
				        value="<%= requestedAt %>" required readonly>
				</div>
                    
                    <div class="form-group">
                        <label for="reason">신청 사유</label>
                        <textarea class="form-control" id="reason" name="reason" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">신청</button>
                    <button type="button" class="btn btn-secondary" onclick="closeLeaveRequestModal()">닫기</button>
                </div>
            </form>
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

// 휴가 시작일과 종료일 비교
function validateDates() {
    const startDate = new Date(document.getElementById("leave_start_date").value);
    const endDate = new Date(document.getElementById("end_leave_date").value);

    if (startDate > endDate) {
        alert("휴가 시작일은 종료일보다 늦을 수 없습니다."); // 에러 메시지
        return false;
    }
    return true;
}

// 총 휴가 일수 계산
function calculateTotalLeaveDays() {
    const startDate = new Date(document.getElementById("leave_start_date").value);
    const endDate = new Date(document.getElementById("end_leave_date").value);

    if (startDate && endDate && startDate <= endDate) {
        const totalDays = (endDate - startDate) / (1000 * 3600 * 24) + 1; // 시작일 포함
        document.getElementById("total_leave_days").value = totalDays;
    }
}

// 폼 제출 시 처리
document.getElementById("leaveRequestForm").addEventListener("submit", function(event) {
    event.preventDefault(); // 폼 기본 동작 막기

    // 날짜 유효성 검사
    if (!validateDates()) {
        return; // 유효성 검사 실패 시 종료
    }

    // 입력된 값 가져오기
    const empId = document.getElementById("empId").value;
    const leaveType = document.getElementById("leave_type").value;
    const leaveStartDate = document.getElementById("leave_start_date").value;
    const endLeaveDate = document.getElementById("end_leave_date").value;
    const totalLeaveDays = document.getElementById("total_leave_days").value;
    const leaveStatus = document.getElementById("leave_status").value;
    const reason = document.getElementById("reason").value;
    const requestedAt = document.getElementById("requested_at").value; // 신청 날짜 및 시간 가져오기

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
            leave_status: leaveStatus,
            requested_at: requestedAt // 신청 날짜 및 시간 전송
        }),
        success: function(response) {
            // 요청이 성공했을 때의 처리
            console.log("휴가 신청이 완료되었습니다:", response);
            alert("휴가 신청이 완료되었습니다."); // 알림창으로 결과 보여주기
            closeLeaveRequestModal(); // 성공한 후에 모달 닫기
        },
        error: function(xhr, status, error) {
            // 요청이 실패했을 때의 처리
            console.error("휴가 신청 실패:", error);
            alert("휴가 신청 실패: " + error); // 에러 메시지 보여주기
        }
    });
});

// 이벤트 리스너 추가: 시작일 및 종료일 변경 시 총 휴가 일수 계산
document.getElementById("leave_start_date").addEventListener("change", calculateTotalLeaveDays);
document.getElementById("end_leave_date").addEventListener("change", calculateTotalLeaveDays);
</script>











<!-- 휴직 신청서 버튼 -->
<button class="btn1 btn-primary" onclick="openLeaveApplicationModal()">
    <span class="btn-label"><i class="fa fa-bookmark"></i></span> 휴직 신청서
</button>

<!-- 휴직 신청 모달 -->
<div class="modal fade" id="leaveApplicationModal" tabindex="-1" role="dialog" aria-labelledby="leaveApplicationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="leaveApplicationModalLabel">휴직 신청서</h5>
                <button type="button" class="close" onclick="closeLeaveApplicationModal()">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="leaveApplicationForm">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="empIdLeave">사원 번호:</label>
                        <input type="text" id="empIdLeave" name="emp_id" class="form-control" value="<%= empId %>" readonly required>
                    </div>
                    
                      <div class="form-group">
					    <label for="employee_name">직원 이름</label>
					    <input type="text" class="form-control" id="employee_name" value="${emp_name}" readonly>
					</div>
                    
                    <div class="form-group">
                        <label for="leave_type_leave">휴직 유형</label>
                        <select class="form-control" id="leave_type_leave" name="leave_type" required>
                            <option value="육아휴직">육아휴직</option>
                            <option value="병가휴직">병가휴직</option>
                            <option value="기타사유">기타사유</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="leave_start_date_leave">휴직 시작일</label>
                        <input type="date" class="form-control" id="leave_start_date_leave" name="leave_start_date" required>
                    </div>
                    <div class="form-group">
                        <label for="end_leave_date_leave">휴직 종료일</label>
                        <input type="date" class="form-control" id="end_leave_date_leave" name="end_leave_date" required>
                    </div>
                    <div class="form-group">
                        <label for="total_leave_days_leave">총 휴직 일수</label>
                        <input type="number" class="form-control" id="total_leave_days_leave" name="total_leave_days" required readonly>
                    </div>
                    <div class="form-group">
                        <label for="leave_status_leave">결재 상태</label>
                        <select class="form-control" id="leave_status_leave" name="leave_status" required>
                            <option value="0">진행중</option>
                        </select>
                    </div>
                    
                      <div>
				   	    <label for="requested_at">신청 날짜 및 시간:</label>
				    <input
				        type="text" class="form-control" id="requested_at"
				        name="requested_at" placeholder="yyyy-MM-dd HH:mm:ss"
				        value="<%= requestedAt %>" required readonly>
				</div>
                    
                    <div class="form-group">
                        <label for="reason_leave">신청 사유</label>
                        <textarea class="form-control" id="reason_leave" name="reason" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">신청</button>
                    <button type="button" class="btn btn-secondary" onclick="closeLeaveApplicationModal()">닫기</button>
                </div>
            </form>
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

    // 총 휴직 일수 자동 계산
    function calculateTotalLeaveDays() {
        const startDate = new Date(document.getElementById("leave_start_date_leave").value);
        const endDate = new Date(document.getElementById("end_leave_date_leave").value);
        if (!isNaN(startDate) && !isNaN(endDate)) {
            const totalDays = (endDate - startDate) / (1000 * 60 * 60 * 24) + 1; // 
            document.getElementById("total_leave_days_leave").value = totalDays;
        }
    }

    // 휴직 폼 제출 시 처리
    document.getElementById("leaveApplicationForm").addEventListener("submit", function(event) {
        event.preventDefault(); // 폼 기본 동작 막기

        // 날짜 유효성 검사
        if (!validateLeaveDates()) {
            return; // 유효성 검사 실패 시 제출 중단
        }

        // 입력된 값 가져오기
        const empId = document.getElementById("empIdLeave").value;
        const leaveType = document.getElementById("leave_type_leave").value;
        const leaveStartDate = document.getElementById("leave_start_date_leave").value;
        const endLeaveDate = document.getElementById("end_leave_date_leave").value;
        const totalLeaveDays = document.getElementById("total_leave_days_leave").value;
        const leaveStatus = document.getElementById("leave_status_leave").value;
        const reason = document.getElementById("reason_leave").value;
        const requestedAt = document.getElementById("requested_at").value; // 신청 날짜 및 시간 가져오기

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
                leave_status: leaveStatus,
                requested_at: requestedAt // 신청 날짜 및 시간 전송
            }),
            success: function(response) {
                // 요청이 성공했을 때의 처리
                console.log("휴직 신청이 완료되었습니다:", response);
                alert("휴직 신청이 완료되었습니다."); // 알림창으로 결과 보여주기
                closeLeaveApplicationModal(); // 성공한 후에 모달 닫기
            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때의 처리
                console.error("휴직 신청 실패:", error);
                alert("휴직 신청 실패: " + error); // 에러 메시지 보여주기
            }
        });
    });

    // 날짜 선택 시 총 휴직 일수 계산
    document.getElementById("leave_start_date_leave").addEventListener("change", calculateTotalLeaveDays);
    document.getElementById("end_leave_date_leave").addEventListener("change", calculateTotalLeaveDays);
</script>







<!-- 나의 휴가 현황 버튼 -->
<button class="btn1 btn-primary" onclick="openLeaveStatusModal()">
    <span class="btn-label">
        <i class="fa fa-bookmark"></i>
    </span>
    나의 휴가 현황
</button>

<!-- 나의 휴가 현황 모달 -->
<div class="modal fade" id="leaveStatusModal" tabindex="-1" role="dialog" aria-labelledby="leaveStatusModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document"> 
        <div class="modal-content" >
            <div class="modal-header">
                <h5 class="modal-title" id="leaveStatusModalLabel">나의 휴가 현황</h5>
                <button type="button" class="close" onclick="closeLeaveStatusModal()">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body ">
                <div style="overflow-x: auto;"> <!-- 가로 스크롤을 위한 div -->
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
                <button type="button" class="btn btn-secondary" onclick="closeLeaveStatusModal()">닫기</button>
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
            return '진행중'; // 0: 진행중
        case 1:
            return '승인';   // 1: 승인
        case -1:
            return '반려';   // -1: 반려
        default:
            return '없음'; // null 또는 정의되지 않은 값
    }
}


    // 나의 휴가 현황 모달 열기 함수
    function openLeaveStatusModal() {
        const empId = '<%= empId %>'; // 세션에서 emp_id 가져오기
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
                    <h4 class="card-title">나의 연차 현황표</h4>
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
    });
</script>
					
					



</div>
                  <div class="card-body">
                    
   
          				</div>	

<!------------------------------------------------------------------------------------------------------------------>
   
          <!-- page-inner -->
        </div>
		<!-- container -->
<%--         <%@ include file="/resources/assets/inc/footer.jsp" %> --%>
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
