<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>INIT</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link
      rel="icon"
      href="${pageContext.request.contextPath }/resources/assets/img/project/favicon_black.png"
      style="border-radius: 50%;"
      type="image/x-icon"
    />

<!-- Fonts and icons -->
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



<style>
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 10px;
}

th, td {
	border: 1px solid #ddd;
	padding: 6px;
	text-align: left;
	white-space: nowrap; /* 줄바꿈 방지 */
	word-wrap: normal; /* 단어가 넘치면 줄바꿈 하지 않고 계속 이어짐 */
}

.btn-info {
	padding: 4px 8px;
	font-size: 12px;
}

.modal-dialog {
	max-width: 800px;
}

.pagination-container {
	display: flex;
	justify-content: space-between; /* 양 끝에 배치 */
	align-items: center; /* 세로 정렬 */
	width: 100%;
}

.pagination ul {
	list-style: none;
	display: flex;
	padding: 0;
}

.pagination ul li {
	margin: 0 5px;
}

.pagination ul li a {
	display: block;
	padding: 5px 10px;
	background-color: #f1f1f1;
	border-radius: 3px;
	text-decoration: none;
	color: #333;
}

.pagination ul li.active a {
	background-color: #007bff;
	color: white;
}

.pagination ul li.disabled a {
	pointer-events: none;
	background-color: #ddd;
}

#register {
	padding: 10px 20px;
	font-size: 14px;
}

.img-fluid {
	max-width: 100%;
	height: auto;
}

.rounded-circle {
	border-radius: 50%;
}

.table-bordered th {
	width: 20%;
}

.table-bordered th, .table-bordered td {
	padding: 10px;
	vertical-align: middle;
}

.table-bordered th {
	background-color: #f2f2f2;
	width: 30%;
}

.btn {
	padding: 0.375rem 0.75rem;
}

#keyword {
	width: auto;
	flex-grow: 2;
}

html, body {
	height: 100%;
	margin: 0;
}

body {
	display: flex;
	flex-direction: column;
}

.main-panel {
	flex: 1 0 auto;
	display: flex;
	flex-direction: column;
}

.container {
	flex: 1 0 auto;
}

.page-inner {
	flex: 1 0 auto;
	display: flex;
	flex-direction: column;
}

#memberTable {
	flex: 1 0 auto;
	overflow-x: auto;
}

footer {
	flex-shrink: 0;
}

.table-responsive {
	overflow-x: auto;
	max-width: 100%;
}

#infoDetail {
	width: max-content;
	min-width: 100%;
}

#infoDetail th, #infoDetail td {
	white-space: nowrap;
	padding: 8px;
}

.controls-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 10px;
	flex-wrap: nowrap;
}

#filterForm, #searchForm {
	display: flex;
	align-items: center;
	justify-content: space-between;
	width: 100%; /* width 조정 */
	margin-bottom: 10px;
}

#filterForm select, #searchForm select, #searchForm input, .btn {
	margin-right: 5px;
	height: 38px; /* 높이 통일 */
}

#filterForm {
	width: 40%;
}

#searchForm {
	width: 40%;
}

#filterType, #filterValue, #searchType {
	width: auto;
	flex-grow: 1;
}

#keyword {
	width: auto;
	flex-grow: 2;
}

.card {
	border-radius: 8px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
}

.card-header {
	background-color: #f8f9fa;
	border-bottom: 1px solid #ebedf2;
	padding: 1.5rem;
}

.card-title {
	margin-bottom: 0;
	color: #1a2035;
	font-size: 1.25rem;
}

.card-body {
	padding: 1.5rem;
}

.controls-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 1rem;
	margin-bottom: 1.5rem;
}

#filterForm, #searchForm {
	display: flex;
	align-items: center;
	gap: 0.5rem;
}

.table {
	margin-bottom: 0;
	width: 100%;
	white-space: nowrap;
}

.table th {
	background-color: #f8f9fa;
	font-weight: 600;
}

.table td, .table th {
	padding: 0.75rem;
	vertical-align: middle;
	border: 1px solid #ebedf2;
}

.pagination {
	margin: 0;
}

.pagination ul {
	display: flex;
	list-style: none;
	padding: 0;
	margin: 0;
	gap: 0.5rem;
}

.pagination ul li a {
	padding: 0.5rem 1rem;
	background-color: #f8f9fa;
	border-radius: 4px;
	text-decoration: none;
	color: #1a2035;
	transition: all 0.3s ease;
}

.pagination ul li.active a {
	background-color: #0055FF;
	color: white;
}

.btn {
	padding: 0.5rem 1rem;
	border-radius: 4px;
	transition: all 0.3s ease;
}

.btn-primary {
	background-color: #0055FF;
	border-color: #0055FF;
}

.btn-secondary {
	background-color: #6c757d;
	border-color: #6c757d;
}

.table-responsive {
	overflow-x: auto;
	margin-bottom: 1.5rem;
}

/* 모달 스타일 */
.modal-content {
	border-radius: 8px;
}

.modal-header {
	background-color: #f8f9fa;
	border-bottom: 1px solid #ebedf2;
}

.modal-footer {
	background-color: #f8f9fa;
	border-top: 1px solid #ebedf2;
}
</style>


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
					<!------------------------------------------------------------------------------------------------------------------>
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">관리자 페이지</h4>
						</div>
						<div class="card-body">
							<!-- 컨트롤 영역 (필터, 검색, 조직도 버튼) -->
							<div class="controls-container mb-4">
								<!-- 필터 폼 -->
								<form id="filterForm" class="form-inline">
									<input type="hidden" name="pageType" value="manager"> <select
										name="filterType" id="filterType" class="form-control">
										<option value="">필터 선택</option>
										<option value="emp_dnum">부서</option>
										<option value="emp_bnum">근무지</option>
										<option value="emp_position">직급</option>
										<option value="emp_job">직책</option>
										<option value="emp_status">재직구분</option>
									</select> <select name="filterValue" id="filterValue"
										class="form-control">
										<option value="">선택하세요</option>
									</select>
									<button type="button" id="applyFilter" class="btn btn-primary">필터
										적용</button>
									<button type="button" id="resetFilter"
										class="btn btn-secondary">초기화</button>
								</form>

								<!-- 검색 폼 추가 -->
								<form id="searchForm" class="form-inline">
									<input type="hidden" name="pageType" value="manager"> <select
										name="searchType" id="searchType" class="form-control">
										<option value="emp_id">사원번호</option>
										<option value="emp_name">사원명</option>
										<option value="emp_dnum">부서명</option>
										<option value="emp_position">직급</option>
										<option value="emp_job">직책</option>
									</select> <input type="text" name="keyword" id="keyword"
										class="form-control" placeholder="검색어 입력">
									<button type="button" id="searchBtn" class="btn btn-primary">검색</button>
								</form>

							<!-- 사원 목록 테이블 -->
							<div class="table-responsive">
								<table class="table" id="memberTable">
									<thead>
										<tr>
											<th>사원번호</th>
											<th>이름</th>
											<th>생년월일</th>
											<th>성별</th>
											<th>연락처</th>
											<th>이메일</th>
											<th>주소</th>
											<th>지점명</th>
											<th>부서</th>
											<th>직급</th>
											<th>직책</th>
											<th>연봉</th>
											<th>근무형태</th>
											<th>예금주</th>
											<th>계좌번호</th>
											<th>은행명</th>
											<th>재직구분</th>
											<th>입사일</th>
											<th>휴직일</th>
											<th>복직일</th>
											<th>퇴사일</th>
											<th>정보수정</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="member" items="${members}">
											<c:if test="${member.emp_id ne 'system'}">
												<tr>
													<td>${member.emp_id}</td>
													<td>${member.emp_name}</td>
													<td>${member.emp_birth}</td>
													<td>${member.emp_gender}</td>
													<td>${member.emp_tel}</td>
													<td>${member.emp_email}</td>
													<td>${member.emp_addr}</td>
													<td>${member.emp_bnum}</td>
													<td>${member.dept_name}</td>
													<td>${member.emp_position}</td>
													<td>${member.emp_job}</td>
													<td class="salary-cell">${member.emp_salary}</td>
													<td>${member.emp_work_type}</td>
													<td>${member.emp_account_name}</td>
													<td>${member.emp_account_num}</td>
													<td>${member.emp_bank_name}</td>
													<td>${member.emp_status}</td>
													<td>${member.emp_start_date}</td>
													<td>${member.emp_break_date}</td>
													<td>${member.emp_restart_date}</td>
													<td>${member.emp_quit_date}</td>
													<td><button type="button"
															class="btn btn-info btn-sm edit-btn"
															data-id="${member.emp_id}">수정</button></td>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>

							<!-- 페이징  -->
							<div class="d-flex justify-content-center mt-4">
							    <div class="pagination">
							        <ul>
							            <!-- 이전 10페이지 그룹으로 이동 -->
							            <li class="${currentPage <= 10 ? 'disabled' : ''}">
							                <a href="?page=${((currentPage-1) - ((currentPage-1) % 10))}">&laquo;</a>
							            </li>
							            
							            <!-- 이전 페이지 -->
							            <li class="${currentPage == 1 ? 'disabled' : ''}">
							                <a href="?page=${currentPage - 1}">이전</a>
							            </li>
							            
							            <!-- 페이지 번호 -->
							            <c:forEach var="i" begin="1" end="${totalPages}">
							                <!-- 현재 페이지가 속한 그룹의 10페이지만 보여줌 -->
							                <c:if test="${i <= ((currentPage-1) - ((currentPage-1) % 10)) + 10 && i > ((currentPage-1) - ((currentPage-1) % 10))}">
							                    <li class="${currentPage == i ? 'active' : ''}">
							                        <a href="?page=${i}">${i}</a>
							                    </li>
							                </c:if>
							            </c:forEach>
							            
							            <!-- 다음 페이지 -->
							            <li class="${currentPage == totalPages ? 'disabled' : ''}">
							                <a href="?page=${currentPage + 1}">다음</a>
							            </li>
							            
							            <!-- 다음 10페이지 그룹으로 이동 -->
							            <li class="${((currentPage-1) - ((currentPage-1) % 10)) + 10 >= totalPages ? 'disabled' : ''}">
							                <a href="?page=${((currentPage-1) - ((currentPage-1) % 10)) + 11}">&raquo;</a>
							            </li>
							        </ul>
							    </div>
							</div>

								<button id="register" class="btn btn-primary">사원등록</button>
							</div>

							<!-- 사원 등록 모달  -->
							<div class="modal fade" id="registerModal" tabindex="-1"
								role="dialog" aria-hidden="true">
								<div class="modal-dialog modal-lg" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">사원 등록</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close"
												onclick="$('#registerModal').modal('hide');">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form id="registerForm">
												<div class="form-group">
													<label for="reg_emp_name">이름</label> <input type="text"
														class="form-control" id="reg_emp_name" name="emp_name"
														required>
												</div>
												<div class="form-group">
													<label for="reg_emp_birth">생년월일</label> <input type="date"
														class="form-control" id="reg_emp_birth" name="emp_birth"
														required>
												</div>
												<div class="form-group">
													<label for="reg_emp_gender">성별 <span
														class="text-danger">*</span></label> <select class="form-control"
														id="reg_emp_gender" name="emp_gender" required>
														<option value="">선택하세요</option>
														<option value="남자">남자</option>
														<option value="여자">여자</option>
													</select>
												</div>
												<div class="form-group">
													<label for="reg_emp_bnum">지점명 <span
														class="text-danger">*</span></label> <select class="form-control"
														id="reg_emp_bnum" name="emp_bnum" required>
														<option value="">선택하세요</option>
														<option value="서울본부">서울본부</option>
														<option value="부산본부">부산본부</option>
														<option value="대전본부">대전본부</option>
													</select>
												</div>
												<div class="form-group">
												    <label for="reg_emp_dnum">부서</label>
												    <select class="form-control" id="reg_emp_dnum" name="emp_dnum" required>
												        <option value="">선택하세요</option>
												        <!-- 동적으로 채워질 부분 -->
												    </select>
												</div>
												<div class="form-group">
													<label for="reg_emp_position">직급 <span
														class="text-danger">*</span></label> <select class="form-control"
														id="reg_emp_position" name="emp_position" required>
														<option value="">선택하세요</option>
														<option value="사원">사원</option>
														<option value="대리">대리</option>
														<option value="과장">과장</option>
														<option value="팀장">팀장</option>
														<option value="부장">부장</option>
														<option value="본부장">본부장</option>
														<option value="부사장">부사장</option>
														<option value="사장">사장</option>
													</select>
												</div>
												<div class="form-group">
													<label for="reg_emp_job">직책 <span
														class="text-danger">*</span></label> <select class="form-control"
														id="reg_emp_job" name="emp_job" required>
														<option value="">선택하세요</option>
														<option value="직무1">직무1</option>
														<option value="직무2">직무2</option>
														<option value="직무3">직무3</option>
														<option value="직무4">직무4</option>
														<option value="직무5">직무5</option>
														<option value="직무6">직무6</option>
														<option value="직무7">직무7</option>
														<option value="직무8">직무8</option>
														<option value="직무9">직무9</option>
														<option value="직무10">직무10</option>
													</select>
												</div>
												<div class="form-group">
													<label for="reg_emp_salary">연봉</label> <input type="number"
														class="form-control" id="reg_emp_salary" name="emp_salary"
														required>
												</div>
												<div class="form-group">
													<label for="reg_emp_work_type">근무형태 <span
														class="text-danger">*</span></label> <select class="form-control"
														id="reg_emp_work_type" name="emp_work_type" required>
														<option value="">선택하세요</option>
														<option value="통상근무">통상근무</option>
														<option value="교대근무">교대근무</option>
														<option value="시급제">시급제</option>
													</select>
												</div>
												<div class="form-group">
													<label for="reg_emp_status">재직구분 <span
														class="text-danger">*</span></label> <select class="form-control"
														id="reg_emp_status" name="emp_status" required>
														<option value="">선택하세요</option>
														<option value="재직">재직</option>
														<option value="휴직">휴직</option>
														<option value="퇴직">퇴직</option>
													</select>
												</div>
												<div class="form-group">
													<label for="reg_emp_start_date">입사일</label> <input
														type="date" class="form-control" id="reg_emp_start_date"
														name="emp_start_date" required>
												</div>
											</form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">취소</button>
											<button type="button" class="btn btn-primary"
												id="submitRegister">등록</button>
										</div>
									</div>
								</div>
							</div>

							<!-- 사원 정보수정 모달 -->
							<div class="modal fade" id="editModal" tabindex="-1"
								role="dialog" aria-hidden="true">
								<div class="modal-dialog modal-lg" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">사원 정보</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close" onclick="$('#editModal').modal('hide');">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form id="editForm">
												<div class="form-group">
													<label for="edit_emp_id">사원번호</label> <input type="text"
														class="form-control" id="edit_emp_id" name="emp_id">
												</div>
												<div class="form-group">
													<label for="edit_emp_name">이름</label> <input type="text"
														class="form-control" id="edit_emp_name" name="emp_name">
												</div>
												<div class="form-group">
													<label for="edit_emp_birth">생년월일</label> <input type="date"
														class="form-control" id="edit_emp_birth" name="emp_birth">
												</div>
												<div class="form-group">
													<label for="edit_emp_gender">성별</label> <select
														class="form-control" id="edit_emp_gender"
														name="emp_gender">
														<option value="남자">남자</option>
														<option value="여자">여자</option>
													</select>
												</div>
												<div class="form-group">
													<label for="edit_emp_tel">연락처</label> <input type="text"
														class="form-control" id="edit_emp_tel" name="emp_tel">
												</div>
												<div class="form-group">
													<label for="edit_emp_email">이메일</label> <input type="text"
														class="form-control" id="edit_emp_email" name="emp_email">
												</div>
												<div class="form-group">
													<label for="edit_emp_addr">주소</label> <input type="text"
														class="form-control" id="edit_emp_addr" name="emp_addr">
												</div>
												<div class="form-group">
													<label for="edit_emp_bnum">지점명</label> <select
														class="form-control" id="edit_emp_bnum" name="emp_bnum">
														<option value="서울본부">서울본부</option>
														<option value="부산본부">부산본부</option>
														<option value="대전본부">대전본부</option>
													</select>
												</div>
												<div class="form-group">
												    <label for="edit_emp_dnum">부서</label>
												    <select class="form-control" id="edit_emp_dnum" name="emp_dnum">
												        <!-- 동적삽입 -->
												    </select>
												</div>
												<div class="form-group">
													<label for="edit_emp_position">직급</label> <select
														class="form-control" id="edit_emp_position"
														name="emp_position">
														<option value="">선택하세요</option>
														<option value="사원">사원</option>
														<option value="대리">대리</option>
														<option value="과장">과장</option>
														<option value="팀장">팀장</option>
														<option value="부장">부장</option>
														<option value="본부장">본부장</option>
														<option value="부사장">부사장</option>
														<option value="사장">사장</option>
													</select>
												</div>
												<div class="form-group">
													<label for="edit_emp_job">직책</label> <select
														class="form-control" id="edit_emp_job" name="emp_job">
														<option value="">선택하세요</option>
														<option value="직무1">직무1</option>
														<option value="직무2">직무2</option>
														<option value="직무3">직무3</option>
														<option value="직무4">직무4</option>
														<option value="직무5">직무5</option>
														<option value="직무6">직무6</option>
														<option value="직무7">직무7</option>
														<option value="직무8">직무8</option>
														<option value="직무9">직무9</option>
														<option value="직무10">직무10</option>
													</select>
												</div>
												<div class="form-group">
													<label for="edit_emp_salary">연봉</label> <input type="text"
														class="form-control" id="edit_emp_salary"
														name="emp_salary">
												</div>
												<div class="form-group">
													<label for="edit_emp_work_type">근무형태</label> <select
														class="form-control" id="edit_emp_work_type"
														name="emp_work_type">
														<option value="통상근무">통상근무</option>
														<option value="교대근무">교대근무</option>
														<option value="시급제">시급제</option>
													</select>
												</div>	
												<div class="form-group">
												    <label for="edit_emp_account_name">예금주</label>
												    <input type="text" class="form-control" id="edit_emp_account_name" name="emp_account_name">
												</div>
												<div class="form-group">
												    <label for="edit_emp_account_num">계좌번호</label>
												    <input type="text" class="form-control" id="edit_emp_account_num" name="emp_account_num">
												</div>
												<div class="form-group">
												    <label for="edit_emp_bank_name">은행명</label>
												    <select class="form-control" id="edit_emp_bank_name" name="emp_bank_name">
												        <option value="">선택하세요</option>
												        <option value="KB국민은행">KB국민은행</option>
												        <option value="신한은행">신한은행</option>
												        <option value="우리은행">우리은행</option>
												        <option value="하나은행">하나은행</option>
												        <option value="NH농협은행">NH농협은행</option>
												        <option value="IBK기업은행">IBK기업은행</option>
												        <option value="카카오뱅크">카카오뱅크</option>
												    </select>
												</div>
												<div class="form-group">
													<label for="edit_emp_status">재직구분</label> <select
														class="form-control" id="edit_emp_status"
														name="emp_status">
														<option value="재직">재직</option>
														<option value="휴직">휴직</option>
														<option value="퇴직">퇴직</option>
													</select>
												</div>
												<div class="form-group">
													<label for="edit_emp_start_date">입사일</label> <input
														type="date" class="form-control" id="edit_emp_start_date"
														name="emp_start_date">
												</div>
												<div class="form-group">
													<label for="edit_emp_break_date">휴직일</label> <input
														type="date" class="form-control" id="edit_emp_break_date"
														name="emp_break_date">
												</div>
												<div class="form-group">
													<label for="edit_emp_restart_date">복직일</label> <input
														type="date" class="form-control"
														id="edit_emp_restart_date" name="emp_restart_date">
												</div>

												<div class="form-group">
													<label for="edit_emp_quit_date">퇴사일</label> <input
														type="date" class="form-control" id="edit_emp_quit_date"
														name="emp_quit_date">
												</div>
											</form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">취소</button>
											<button type="button" class="btn btn-primary"
												id="submitUpdate">저장</button>
										</div>
										<!-- page-inner -->

										<!-- container -->
										<%-- 	    <%@ include file="/resources/assets/inc/footer.jsp" %> --%>
									</div>
								</div>

								<!------------------------------------------------------------------------------------------------------------------>
							</div>
							<!-- page-inner -->
						</div>
						<!-- container -->
						<%@ include file="/resources/assets/inc/footer.jsp"%>
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

				<script
					src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
				<script
					src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
        lineWidth: "2",
        lineColor: "#ffa534",
        fillColor: "rgba(255, 165, 52, .14)",
      });
      
      var contextPath = '${pageContext.request.contextPath}';
      
      function showEditModal(emp_id) {
    	    console.log("showEditModal called with emp_id:", emp_id);
    	    
    	    $.ajax({
    	        url: '${pageContext.request.contextPath}/member/detail/' + emp_id,
    	        type: 'GET',
    	        success: function(member) {
    	            console.log("Received member data:", member);
    	            
    	            // 기본 정보 설정
    	            $('#edit_emp_id').val(member.emp_id || '');
    	            $('#edit_emp_name').val(member.emp_name || '');
    	            $('#edit_emp_gender').val(member.emp_gender || '');
    	            $('#edit_emp_tel').val(member.emp_tel || '');
    	            $('#edit_emp_email').val(member.emp_email || '');
    	            $('#edit_emp_addr').val(member.emp_addr || '');
    	            $('#edit_emp_bnum').val(member.emp_bnum || '');
    	            $('#edit_emp_dnum').val(member.emp_dnum || '');
    	            $('#edit_emp_position').val(member.emp_position || '');
    	            $('#edit_emp_job').val(member.emp_job || '');
    	            $('#edit_emp_salary').val(member.emp_salary || '');
    	            $('#edit_emp_work_type').val(member.emp_work_type || '');
    	            $('#edit_emp_account_name').val(member.emp_account_name || '');
    	            $('#edit_emp_account_num').val(member.emp_account_num || '');
    	            $('#edit_emp_bank_name').val(member.emp_bank_name || '');
    	            $('#edit_emp_status').val(member.emp_status || '');
    	            
    	         	// 계좌 정보 설정
    	            if(member.emp_account_name) {
    	                $('#edit_emp_account_name').val(member.emp_account_name);
    	            }
    	            if(member.emp_account_num) {
    	                $('#edit_emp_account_num').val(member.emp_account_num);
    	            }
    	            if(member.emp_bank_name) {
    	                $('#edit_emp_bank_name').val(member.emp_bank_name);
    	            }

    	            // 날짜 데이터 처리
    	            try {
    	                // 날짜 형식 처리
    	                if (member.emp_birth) {
					        const birthDate = typeof member.emp_birth === 'string'
					            ? member.emp_birth.split(' ')[0]
					            : new Date(new Date(member.emp_birth).getTime() - (new Date(member.emp_birth).getTimezoneOffset() * 60000))
					                .toISOString()
					                .split('T')[0];
					        $('#edit_emp_birth').val(birthDate);
					    }

    	                if (member.emp_start_date) {
    	                    const startDate = typeof member.emp_start_date === 'string'
    	                        ? member.emp_start_date.split(' ')[0]
    	                        : new Date(new Date(member.emp_start_date).getTime() - (new Date(member.emp_start_date).getTimezoneOffset() * 60000))
    	                            .toISOString()
    	                            .split('T')[0];
    	                    $('#edit_emp_start_date').val(startDate);
    	                }

    	                if (member.emp_break_date) {
    	                    const breakDate = typeof member.emp_break_date === 'string'
    	                        ? member.emp_break_date.split(' ')[0]
    	                        : new Date(new Date(member.emp_break_date).getTime() - (new Date(member.emp_break_date).getTimezoneOffset() * 60000))
    	                            .toISOString()
    	                            .split('T')[0];
    	                    $('#edit_emp_break_date').val(breakDate);
    	                }

    	                if (member.emp_restart_date) {
    	                    const restartDate = typeof member.emp_restart_date === 'string'
    	                        ? member.emp_restart_date.split(' ')[0]
    	                        : new Date(new Date(member.emp_restart_date).getTime() - (new Date(member.emp_restart_date).getTimezoneOffset() * 60000))
    	                            .toISOString()
    	                            .split('T')[0];
    	                    $('#edit_emp_restart_date').val(restartDate);
    	                }

    	                if (member.emp_quit_date) {
    	                    const quitDate = typeof member.emp_quit_date === 'string'
    	                        ? member.emp_quit_date.split(' ')[0]
    	                        : new Date(new Date(member.emp_quit_date).getTime() - (new Date(member.emp_quit_date).getTimezoneOffset() * 60000))
    	                            .toISOString()
    	                            .split('T')[0];
    	                    $('#edit_emp_quit_date').val(quitDate);
    	                }

    	                // 모달 표시
    	                $('#editModal').modal('show');
    	                
    	            } catch (error) {
    	                console.error("Error processing dates:", error);
    	                alert('날짜 정보 처리 중 오류가 발생했습니다.');
    	            }
    	        },
    	        error: function(xhr, status, error) {
    	            console.error("Error loading member details:", error);
    	            console.error("Response:", xhr.responseText);
    	            alert('사원 정보를 불러오는데 실패했습니다.');
    	        }
    	    });
    	}
      
   	  
   // 기본 유효성 검사 함수들
      function validatePhoneNumber(phoneNumber) {
          const phoneRegex = /^01[0-9]-\d{3,4}-\d{4}$/;
          return phoneRegex.test(phoneNumber);
      }

      function validateEmail(email) {
          const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
          return emailRegex.test(email);
      }

      function validateName(name) {
          const nameRegex = /^[가-힣]{2,5}$/;
          return nameRegex.test(name);
      }

      function validateBirth(birthDate) {
    	    if (!birthDate) return false;
    	    
    	    const today = new Date();
    	    const birth = new Date(birthDate);
    	    
    	    // 날짜가 유효한지 확인
    	    if (isNaN(birth.getTime())) return false;
    	    
    	    let age = today.getFullYear() - birth.getFullYear();
    	    const monthDiff = today.getMonth() - birth.getMonth();
    	    
    	    // 생일이 아직 지나지 않은 경우 나이에서 1을 빼줌
    	    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birth.getDate())) {
    	        age--;
    	    }
    	    
    	    return age >= 19 && age <= 60;
    	}

      function validateSalary(salaryStr) {
          // 문자열에서 쉼표 제거 후 숫자로 변환
          const salary = parseInt(salaryStr.replace(/,/g, ''));
          
          // NaN 체크 추가
          if (isNaN(salary)) return false;
          
          // 급여 범위 체크 (2000만원 ~ 1억원)
          return salary >= 20000000 && salary <= 100000000;
      }

      function getFieldLabel(fieldId) {
          return $('#' + fieldId).prev('label').text().replace(' *', '');
      }

      // 날짜 유효성 검사
      function validateDates(data) {
          const startDate = new Date(data.emp_start_date);
          const breakDate = data.emp_break_date ? new Date(data.emp_break_date) : null;
          const restartDate = data.emp_restart_date ? new Date(data.emp_restart_date) : null;
          const quitDate = data.emp_quit_date ? new Date(data.emp_quit_date) : null;
          const today = new Date();

          if (startDate > today) {
              return "입사일은 미래 날짜일 수 없습니다.";
          }

          if (breakDate && breakDate < startDate) {
              return "휴직일은 입사일보다 이전일 수 없습니다.";
          }

          if (restartDate) {
              if (!breakDate) {
                  return "복직일이 있다면 휴직일이 반드시 필요합니다.";
              }
              if (restartDate < breakDate) {
                  return "복직일은 휴직일보다 이전일 수 없습니다.";
              }
          }

          if (quitDate) {
              if (quitDate < startDate) {
                  return "퇴사일은 입사일보다 이전일 수 없습니다.";
              }
              if (breakDate && !restartDate && quitDate < breakDate) {
                  return "퇴사일은 휴직일보다 이전일 수 없습니다.";
              }
              if (restartDate && quitDate < restartDate) {
                  return "퇴사일은 복직일보다 이전일 수 없습니다.";
              }
          }

          return null;
      }

      // 등록 폼 유효성 검사
      function validateRegisterForm() {
          const errorMessages = [];

          // 이름 검사
          if (!validateName($('#reg_emp_name').val())) {
              errorMessages.push('이름은 2-5자의 한글만 입력 가능합니다.');
          }

          // 생년월일 검사
          const birthValue = $('#reg_emp_birth').val();
          if (!birthValue) {
              errorMessages.push('생년월일을 선택해주세요.');
          } else if (!validateBirth(birthValue)) {
              errorMessages.push('입사 가능한 나이는 19세 이상 60세 이하입니다.');
          }

          // 필수 선택 항목 검사
          const selectFields = ['reg_emp_gender', 'reg_emp_bnum', 'reg_emp_dnum', 
                               'reg_emp_position', 'reg_emp_job', 'reg_emp_work_type', 
                               'reg_emp_status'];
          selectFields.forEach(function(field) {
              if (!$('#' + field).val()) {
                  errorMessages.push(getFieldLabel(field) + '을(를) 선택해주세요.');
              }
          });

          // 급여 검사
          const salaryValue = $('#reg_emp_salary').val();
          if (!salaryValue) {
              errorMessages.push('급여를 입력해주세요.');
          } else if (!validateSalary(salaryValue)) {
              errorMessages.push('급여는 2000만원 이상 1억원 이하로 입력해주세요.');
          }

          // 입사일 검사
          if (!$('#reg_emp_start_date').val()) {
              errorMessages.push('입사일을 선택해주세요.');
          } else {
              const startDate = new Date($('#reg_emp_start_date').val());
              const today = new Date();
              if (startDate > today) {
                  errorMessages.push('입사일은 미래 날짜일 수 없습니다.');
              }
          }

          if (errorMessages.length > 0) {
              alert(errorMessages.join('\n'));
              return false;
          }
          return true;
      }

      // 수정 폼 유효성 검사
      function validateEditForm() {
          const errorMessages = [];

          // 이름 검사
          if (!validateName($('#edit_emp_name').val())) {
              errorMessages.push('이름은 2-5자의 한글만 입력 가능합니다.');
          }

          // 생년월일 검사
          const birthValue = $('#edit_emp_birth').val();
          if (!birthValue) {
              errorMessages.push('생년월일을 선택해주세요.');
          } else if (!validateBirth(birthValue)) {
              errorMessages.push('입사 가능한 나이는 19세 이상 60세 이하입니다.');
          }

          // 연락처 검사
          if ($('#edit_emp_tel').val() && !validatePhoneNumber($('#edit_emp_tel').val())) {
              errorMessages.push('올바른 전화번호 형식이 아닙니다. (예: 010-1234-5678)');
          }

          // 이메일 검사
          if ($('#edit_emp_email').val() && !validateEmail($('#edit_emp_email').val())) {
              errorMessages.push('올바른 이메일 형식이 아닙니다.');
          }

          // 필수 선택 항목 검사
          const selectFields = ['edit_emp_gender', 'edit_emp_bnum', 'edit_emp_dnum', 
                               'edit_emp_position', 'edit_emp_job', 'edit_emp_work_type', 
                               'edit_emp_status'];
          selectFields.forEach(function(field) {
              if (!$('#' + field).val()) {
                  errorMessages.push(getFieldLabel(field) + '을(를) 선택해주세요.');
              }
          });

          // 급여 검사
          const salaryValue = $('#edit_emp_salary').val();
          if (!salaryValue) {
              errorMessages.push('급여를 입력해주세요.');
          } else if (!validateSalary(salaryValue)) {
              errorMessages.push('급여는 2000만원 이상 1억원 이하로 입력해주세요.');
          }

          // 날짜 검증
          const dateValidation = validateDates({
              emp_start_date: $('#edit_emp_start_date').val(),
              emp_break_date: $('#edit_emp_break_date').val(),
              emp_restart_date: $('#edit_emp_restart_date').val(),
              emp_quit_date: $('#edit_emp_quit_date').val()
          });

          if (dateValidation) {
              errorMessages.push(dateValidation);
          }

          // 재직 상태와 날짜 정합성 검사
          const status = $('#edit_emp_status').val();
          if (status === '퇴직' && !$('#edit_emp_quit_date').val()) {
              errorMessages.push('퇴직 상태인 경우 퇴사일은 필수입니다.');
          }
          if (status === '휴직' && !$('#edit_emp_break_date').val()) {
              errorMessages.push('휴직 상태인 경우 휴직일은 필수입니다.');
          }

          if (errorMessages.length > 0) {
              alert(errorMessages.join('\n'));
              return false;
          }
          return true;
      }

      // 실시간 입력 검증을 위한 이벤트 리스너
      $(document).ready(function() {
          // 등록 폼 실시간 검증
          $('#reg_emp_name').on('input', function() {
              if (!validateName($(this).val())) {
                  $(this).addClass('is-invalid');
              } else {
                  $(this).removeClass('is-invalid');
              }
          });

          $('#reg_emp_salary').on('input', function() {
              if (!validateSalary($(this).val())) {
                  $(this).addClass('is-invalid');
              } else {
                  $(this).removeClass('is-invalid');
              }
          });

          $('#reg_emp_birth').on('change', function() {
              if (!validateBirth($(this).val())) {
                  $(this).addClass('is-invalid');
              } else {
                  $(this).removeClass('is-invalid');
              }
          });

          // 수정 폼 실시간 검증
          $('#edit_emp_name').on('input', function() {
              if (!validateName($(this).val())) {
                  $(this).addClass('is-invalid');
              } else {
                  $(this).removeClass('is-invalid');
              }
          });

          $('#edit_emp_tel').on('input', function() {
              if (!validatePhoneNumber($(this).val()) && $(this).val()) {
                  $(this).addClass('is-invalid');
              } else {
                  $(this).removeClass('is-invalid');
              }
          });

          $('#edit_emp_email').on('input', function() {
              if (!validateEmail($(this).val()) && $(this).val()) {
                  $(this).addClass('is-invalid');
              } else {
                  $(this).removeClass('is-invalid');
              }
          });

          $('#edit_emp_salary').on('input', function() {
              if (!validateSalary($(this).val())) {
                  $(this).addClass('is-invalid');
              } else {
                  $(this).removeClass('is-invalid');
              }
          });

          $('#edit_emp_birth').on('change', function() {
              if (!validateBirth($(this).val())) {
                  $(this).addClass('is-invalid');
              } else {
                  $(this).removeClass('is-invalid');
              }
          });

          // 재직 상태 변경 이벤트
          $('#edit_emp_status').on('change', function() {
              const status = $(this).val();
              if (status === '퇴직') {
                  $('#edit_emp_quit_date').prop('required', true);
              } else {
                  $('#edit_emp_quit_date').prop('required', false);
              }
              
              if (status === '휴직') {
                  $('#edit_emp_break_date').prop('required', true);
              } else {
                  $('#edit_emp_break_date').prop('required', false);
              }
          });
     
      
   // 버튼 클릭 이벤트 및 관련 함수들
   
    	  // 사원등록 모달
    	    $('#register').on('click', function() {
    	        $('#registerModal').modal('show');
    	    });

    	    // 사원등록 제출
    	    $('#submitRegister').on('click', function() {
    	        registerEmployee();
    	    });
    	    
    		// 수정 버튼 클릭 이벤트 (이벤트 위임 사용)
    	    $(document).on('click', '.edit-btn', function() {
    	        const emp_id = $(this).data('id');
    	        showEditModal(emp_id);
    	    });

    	    // 수정 모달의 저장 버튼 클릭 이벤트
    	    $('#submitUpdate').on('click', function() {
    	        console.log('Update button clicked');
    	        updateEmployee();
    	    });

    	    // 모달 닫기
    	    $('.modal .close, .modal .btn-secondary').on('click', function() {
    	        $(this).closest('.modal').modal('hide');
    	    });
    	});

   // 페이지 로드 시 부서 목록 가져오기
      $(document).ready(function() {
          // 부서 목록 로드
          loadDepartments();
          
          // 기존의 ready 함수 내용...
      });

      function loadDepartments() {
    	    $.ajax({
    	        url: '${pageContext.request.contextPath}/member/departments',
    	        type: 'GET',
    	        success: function(departments) {
    	            var reg_select = $('#reg_emp_dnum');
    	            var edit_select = $('#edit_emp_dnum');
    	            
    	            reg_select.empty().append('<option value="">선택하세요</option>');
    	            edit_select.empty().append('<option value="">선택하세요</option>');
    	            
    	            departments.forEach(function(dept) {
    	                reg_select.append($('<option></option>')
    	                    .val(dept.dnum)  // dnum을 value로 사용
    	                    .text(dept.dname));  // dname을 표시 텍스트로 사용
    	                edit_select.append($('<option></option>')
    	                    .val(dept.dnum)
    	                    .text(dept.dname));
    	            });
    	        },
    	        error: function() {
    	            alert('부서 목록을 불러오는데 실패했습니다.');
    	        }
    	    });
    	}

      
      // 사원 등록 처리
      function registerEmployee() {
	    if (!validateRegisterForm()) {
	        return;
	    }
	
	    var formData = {};
	    $('#registerForm').serializeArray().forEach(function(item) {
	        formData[item.name] = item.value;
	    });
	    
	    // emp_dnum은 선택된 부서명의 dnum 값으로 설정됨
	    formData.emp_dnum = $('#reg_emp_dnum').val();
	
	    $.ajax({
	        url: contextPath + '/member/register',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify(formData),
	        success: function(response) {
	            if (response.success) {
	                alert('사원이 성공적으로 등록되었습니다. 사원번호: ' + response.emp_id);
	                $('#registerModal').modal('hide');
	                loadMembers(1);
	            } else {
	                alert('사원 등록에 실패했습니다: ' + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("Register error:", error);
	            alert('서버 오류가 발생했습니다.');
	        }
	    });
	}


   // 사원수정 함수 수정
   function updateEmployee() {
    if (!validateEditForm()) {
        return;
    }

    var formData = {};
    $('#editForm').serializeArray().forEach(function(item) {
        // 날짜 필드에 대한 특별 처리
        if (['emp_break_date', 'emp_restart_date', 'emp_quit_date'].includes(item.name)) {
            formData[item.name] = item.value || null;  // 빈 문자열을 null로 변환
        } else {
            formData[item.name] = item.value;
        }
    });

    // 재직 상태가 '퇴직'일 때 퇴사일이 필수
    if (formData.emp_status === '퇴직' && !formData.emp_quit_date) {
        alert('퇴직 상태인 경우 퇴사일은 필수입니다.');
        return;
    }

    // 재직 상태가 '휴직'일 때 휴직일이 필수
    if (formData.emp_status === '휴직' && !formData.emp_break_date) {
        alert('휴직 상태인 경우 휴직일은 필수입니다.');
        return;
    }

    $.ajax({
        url: '${pageContext.request.contextPath}/member/mupdate',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(formData),
        success: function(response) {
            if(response.success) {
                alert('사원 정보가 성공적으로 업데이트되었습니다.');
                $('#editModal').modal('hide');
                loadMembers(1);
            } else {
                alert('사원 정보 업데이트에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("Update error:", error);
            alert('서버 오류가 발생했습니다.');
	        }
	    });
	}
	
	// 날짜 입력 필드 이벤트 핸들러 추가
    $(document).ready(function() {
       $('#edit_emp_status').on('change', function() {
           var status = $(this).val();
           
           // 퇴직 상태 선택 시
           if (status === '퇴직') {
               $('#edit_emp_quit_date').prop('required', true);
               if (!$('#edit_emp_quit_date').val()) {
                   alert('퇴직 상태 선택 시 퇴사일을 입력해주세요.');
               }
           } else {
               $('#edit_emp_quit_date').prop('required', false);
           }
           
           // 휴직 상태 선택 시
           if (status === '휴직') {
               $('#edit_emp_break_date').prop('required', true);
               if (!$('#edit_emp_break_date').val()) {
                   alert('휴직 상태 선택 시 휴직일을 입력해주세요.');
               }
           } else {
               $('#edit_emp_break_date').prop('required', false);
	           }
	       });
	   });

	    // 전역 변수 추가
	    var currentState = 'manager'; 
		var currentSearchType = '';
		var currentKeyword = '';
		var currentFilterType = '';
		var currentFilterValue = '';
      
	    // 검색 기능
        $(document).ready(function() {
            // 페이지 로드 시 사원 목록 불러오기
            loadMembers(1);
            
            // 검색 버튼 클릭 이벤트
            $(document).on('click', '#searchBtn', function() {
                searchMembers(1);
            });

            // 엔터 키 이벤트
            $(document).on('keypress', '#keyword', function(e) {
                if (e.keyCode === 13) {  // 엔터키의 keyCode는 13
                    e.preventDefault();
                    searchMembers(1);
                }
            });

            // 검색 타입 변경 시 검색어 필드 초기화
            $(document).on('change', '#searchType', function() {
                $('#keyword').val('').focus();
            });
        });
		
        function loadMembers(page) {
            $.ajax({
                url: '${pageContext.request.contextPath}/member/manager',
                type: 'GET',
                data: { page: page },
                success: function(response) {
                    updateTable(response);
                },
                error: function() {
                    alert('사원 목록을 불러오는데 실패했습니다.');
                }
            });
        }
	    
        function searchMembers(page) {
            currentState = 'search';
            var searchType = $('#searchType').val();
            var keyword = $('#keyword').val();
            var pageType = $('#searchForm input[name="pageType"]').val();
            
            $.ajax({
                url: '${pageContext.request.contextPath}/member/search',
                type: 'GET',
                data: { 
                    searchType: searchType,
                    keyword: keyword,
                    pageType: pageType,
                    page: page
                },
                success: function(response) {
                    updateTable(response);
                },
                error: function(xhr, status, error) {
                    console.error("Search error:", error);
                    alert('검색에 실패했습니다.');
                }
            });
        }

        function updateTable(response) {
            $('#memberTable tbody').empty();
            var members = $(response).find('#memberTable tbody tr');
            $('#memberTable tbody').append(members);
            
            $('.pagination').html($(response).find('.pagination').html());
            
            // 페이지네이션 이벤트 재바인딩
            bindPaginationEvents();
        }

        // 페이지네이션 이벤트 바인딩
        function bindPaginationEvents() {
            $('.pagination a').off('click').on('click', function(e) {
                e.preventDefault();
                var page = $(this).attr('href').split('page=')[1];
                
                switch(currentState) {
                    case 'manager':
                        loadMembers(page);
                        break;
                    case 'search':
                        searchMembers(page);
                        break;
                    case 'filter':
                        applyFilter(page);
                        break;
                }
            });
        }

        // 페이지 로드 시 초기화
        $(document).ready(function() {
            loadDepartments();
            loadMembers(1);
        });

      	// 필터 관련 스크립트
      	 $(document).ready(function() {
        // 필터 타입 변경 시 필터 값 옵션 업데이트
        $('#filterType').change(function() {
            var filterType = $(this).val();
            updateFilterValues(filterType);
        });

        // 필터 적용 버튼 클릭 이벤트
        $('#applyFilter').click(function() {
	    currentFilterType = $('#filterType').val();
	    currentFilterValue = $('#filterValue').val();
	    var pageType = $('input[name="pageType"]').val();
	    applyFilter(1);
		});

        // 초기화 버튼 클릭 이벤트
        $('#resetFilter').click(function() {
            resetFilter();
        });
        

	    });

        // 필터 값 옵션 업데이트 함수
        function updateFilterValues(filterType) {
            $.ajax({
                url: '${pageContext.request.contextPath}/member/filterOptions',
                type: 'GET',
                data: { filterType: filterType },
                success: function(options) {
                    var $filterValue = $('#filterValue');
                    $filterValue.empty().append('<option value="">선택하세요</option>');
                    $.each(options, function(index, option) {
                        $filterValue.append($('<option></option>').val(option).text(option));
                    });
                },
                error: function() {
                    alert('필터 옵션을 불러오는데 실패했습니다.');
                }
            });
        }
		
		function escapeHtml(unsafe) {
		    return unsafe
		         .replace(/&/g, "&amp;")
		         .replace(/</g, "&lt;")
		         .replace(/>/g, "&gt;")
		         .replace(/"/g, "&quot;")
		         .replace(/'/g, "&#039;");
		}
		
		// 필터 함수
		function applyFilter(page) {
	    currentState = 'filter';
	    var filterType = currentFilterType || $('#filterType').val();
	    var filterValue = currentFilterValue || $('#filterValue').val();
	    var pageType = $('input[name="pageType"]').val();
	    currentFilterType = filterType;
	    currentFilterValue = filterValue;
	    
	    $.ajax({
	        url: '${pageContext.request.contextPath}/member/filter',
	        type: 'GET',
	        data: { 
	            filterType: filterType,
	            filterValue: filterValue,
	            pageType: pageType,
	            page: page || 1
	        },
	        success: function(response) {
	            updateTable(response);
	        },
	        error: function() {
	            alert('필터링에 실패했습니다.');
		        }
		    });
		}

        // 필터 초기화 함수
        function resetFilter() {
	    currentState = 'manager';
	    currentFilterType = '';
	    currentFilterValue = '';
	    currentKeyword = '';
	    $('#filterType').val('');
	    $('#filterValue').empty().append('<option value="">선택하세요</option>');
	    $('#keyword').val('');
	    loadMembers(1);
		}
        
        // 연봉 표시
        function formatSalaryToKorean(number) {
		    if (!number) return '0원';
		    
		    number = parseInt(number);
		    
		    if (number >= 100000000) { // 1억 이상
		        return (number / 100000000).toFixed(1) + '억원';
		    } else if (number >= 10000) { // 1만 이상
		        return (number / 10000).toFixed(0) + '만원';
		    } else {
		        return number.toLocaleString() + '원';
		    }
		}
		
		// 테이블의 연봉 표시를 변환하는 함수
		function updateSalaryDisplay() {
		    $('.salary-cell').each(function() {
		        var salary = $(this).text();
		        $(this).text(formatSalaryToKorean(salary));
		    });
		}
		
		// 페이지 로드 및 테이블 업데이트 시 연봉 표시 변환
		$(document).ready(function() {
		    // 기존 ready 함수 내용...
		    
		    // 초기 테이블 로드 시 연봉 표시 변환
		    updateSalaryDisplay();
		});
		
		// updateTable 함수 수정
		function updateTable(response) {
		    $('#memberTable tbody').empty();
		    var members = $(response).find('#memberTable tbody tr');
		    $('#memberTable tbody').append(members);
		    
		    // 연봉 표시 변환 추가
		    updateSalaryDisplay();
		    
		    $('.pagination').html($(response).find('.pagination').html());
		    bindPaginationEvents();
		}

      
    </script>
</body>
</html>