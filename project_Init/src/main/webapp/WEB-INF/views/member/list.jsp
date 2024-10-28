<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Kaiadmin - Bootstrap 5 Admin Dashboard</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/assets/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

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

footer {
	flex-shrink: 0;
}

/* 카드 스타일 */
.card {
	border-radius: 8px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	background: #fff;
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

/* 테이블 스타일 */
.table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 0;
}

.table th, .table td {
	padding: 10px;
	border: 1px solid #ddd;
	text-align: left;
	vertical-align: middle;
}

.table th {
	background-color: #f8f9fa;
	border-top: none;
	width: 20%;
}

.table-responsive {
	overflow-x: auto;
	max-width: 100%;
}

#memberTable {
	flex: 1 0 auto;
	overflow-y: auto;
}

#infoDetail {
	width: max-content;
	min-width: 100%;
}

#infoDetail th, #infoDetail td {
	white-space: nowrap;
	padding: 8px;
}

/* 컨트롤 영역 스타일 */
.controls-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 1rem;
	flex-wrap: wrap;
	margin-bottom: 1.5rem;
}

#filterForm, #searchForm {
	display: flex;
	align-items: center;
	width: 40%;
}

#filterForm select, #searchForm select, #searchForm input, .btn {
	margin-right: 5px;
	height: 38px;
}

#filterType, #filterValue, #searchType {
	width: auto;
	flex-grow: 1;
}

#keyword {
	width: auto;
	flex-grow: 2;
}

/* 버튼 스타일 */
.btn {
	padding: 0.375rem 0.75rem;
}

.btn-info {
	padding: 4px 8px;
	font-size: 12px;
}

/* 이미지 스타일 */
.img-fluid {
	max-width: 100%;
	height: auto;
}

.rounded-circle {
	border-radius: 50%;
}

/* 페이지네이션 */
.pagination {
	margin-top: 1.5rem;
	justify-content: center;
}

.pagination ul {
	list-style: none;
	display: flex;
	justify-content: center;
	padding: 0;
	margin: 0;
	gap: 0.5rem;
}

.pagination ul li a {
	display: block;
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

.pagination ul li.disabled a {
	background-color: #ebedf2;
	color: #6c757d;
	cursor: not-allowed;
	pointer-events: none;
}

/* 모달 */
.modal-dialog {
	max-width: 800px;
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
							<h4 class="card-title">사원 목록</h4>
						</div>
						<div class="card-body">
							<!-- 컨트롤 영역 (검색, 필터, 조직도 버튼) -->
							<div class="controls-container mb-4">
								<!-- 필터 폼 -->
								<form id="filterForm" class="form-inline">
									<select name="filterType" id="filterType" class="form-control">
										<option value="">필터 선택</option>
										<option value="emp_dnum">부서</option>
										<option value="emp_bnum">근무지</option>
										<option value="emp_position">직급</option>
										<option value="emp_job">직책</option>
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
									<select name="searchType" id="searchType" class="form-control">
										<option value="emp_id">사원번호</option>
										<option value="emp_name">사원명</option>
										<option value="emp_dnum">부서명</option>
										<option value="emp_position">직급</option>
										<option value="emp_job">직책</option>
									</select> <input type="text" name="keyword" id="keyword"
										class="form-control" placeholder="검색어 입력">
									<button type="button" id="searchBtn" class="btn btn-primary">검색</button>
								</form>

							</div>

						</div>


						<!-- 사원 목록 테이블 -->
						<div class="table-responsive">
							<table class="table table-striped" id="memberTable">
								<thead class="bg-light">
									<tr>
										<th>사원번호</th>
										<th>이름</th>
										<th>직급</th>
										<th>부서</th>
										<th>상세정보</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="member" items="${members}">
										<c:if
											test="${member.emp_status ne '퇴직' and member.emp_id ne 'system'}">
											<tr>
												<td>${member.emp_id}</td>
												<td>${member.emp_name}</td>
												<td>${member.emp_position}</td>
												<td>${member.dept_name}</td>
												<td>
													<button class="btn btn-info btn-sm"
														onclick="showDetail('${member.emp_id}')">상세보기</button>
												</td>
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
					</div>
				</div>

				<!-- Modal -->
				<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">회원 상세 정보</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body" id="modalBody">
								<div class="row">
									<div
										class="col-md-3 d-flex align-items-center justify-content-center">
										<!-- 프로필 사진 표시 영역 -->
										<img id="emp_photo" src="${memberVO.emp_profile }"
											alt="프로필 사진" class="img-fluid rounded-circle"
											style="width: 150px; height: 150px;">
									</div>
									<div class="col-md-9">
										<!-- 사원 정보를 4행 2열 테이블 형식으로 출력 -->
										<div class="table-responsive">
											<table id="infoDetail" class="table table-bordered">
												<tr>
													<th>사원번호</th>
													<td id="emp_id"></td>
													<th>이름</th>
													<td id="emp_name"></td>
												</tr>
												<tr>
													<th>직급</th>
													<td id="emp_position"></td>
													<th>직책</th>
													<td id="emp_job"></td>
												</tr>
												<tr>
													<th>부서</th>
													<td id="dept_name"></td>
													<th>근무지</th>
													<td id="emp_bnum"></td>
												</tr>
												<tr>
													<th>이메일</th>
													<td id="emp_email"></td>
													<th>연락처</th>
													<td id="emp_tel"></td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- page-inner -->
					</div>
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
      
      function showDetail(emp_id) {
    	    $.ajax({
    	        url: '${pageContext.request.contextPath}/member/detail/' + emp_id,
    	        type: 'GET',
    	        dataType: 'json',
    	        success: function(member) {
    	            if (member) {
    	                // 서버에서 받은 데이터를 모달에 출력
    	                $('#emp_photo').attr('src', member.emp_profile || '${pageContext.request.contextPath}/resources/assets/img/profile-default.png');
    	                $('#emp_id').text(member.emp_id);
    	                $('#emp_name').text(member.emp_name);
    	                $('#emp_position').text(member.emp_position);
    	                $('#emp_job').text(member.emp_job);
    	                $('#dept_name').text(member.dept_name);
    	                $('#emp_bnum').text(member.emp_bnum);
    	                $('#emp_email').text(member.emp_email);
    	                $('#emp_tel').text(member.emp_tel);

    	                // 모달을 띄우기
    	                $('#detailModal').modal('show');
    	            } else {
    	                alert('데이터를 불러오는데 실패했습니다.');
    	            }
    	        },
    	        error: function(jqXHR, textStatus, errorThrown) {
    	            console.error("AJAX error:", textStatus, errorThrown);
    	        }
    	    });
    	}
	    // 전역 변수 추가
	    var currentState = 'list'; 
		var currentSearchType = '';
		var currentKeyword = '';
		var currentFilterType = '';
		var currentFilterValue = '';
      
        // 검색기능
        $(document).ready(function() {
        // 페이지 로드 시 사원 목록 불러오기
        loadMembers(1);

        // 검색 버튼 클릭 이벤트
        $('#searchBtn').click(function() {
	    currentSearchType = $('#searchType').val();
	    currentKeyword = $('#keyword').val();
	    searchMembers(1);
		});

        // 엔터 키 이벤트
        $('#keyword').keypress(function(e) {
          if (e.which == 13) {
            e.preventDefault();
            searchMembers(1);
	        }
	      });
	    });
        
        // 검색 타입 변경 시 검색어 필드 초기화 및 포커스
        $('#searchType').change(function() {
            $('#keyword').val('').focus();
        });

        function loadMembers(page) {
        $.ajax({
          url: '${pageContext.request.contextPath}/member/list',
          type: 'GET',
          data: { page: page },
          success: function(response) {
            updateTable(response);
            setTimeout(() => {
                updateTable(response);
            }, 100);
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
    	    
    	    // 페이지네이션 이벤트 다시 바인딩
    	    $('.pagination a').click(function(e) {
    	        e.preventDefault();
    	        var page = $(this).attr('href').split('page=')[1];
    	        
    	        switch(currentState) {
    	            case 'list':
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
	    currentState = 'list';
	    currentFilterType = '';
	    currentFilterValue = '';
	    currentKeyword = '';
	    $('#filterType').val('');
	    $('#filterValue').empty().append('<option value="">선택하세요</option>');
	    $('#keyword').val('');
	    loadMembers(1);
		}

        

      
    </script>
</body>
</html>