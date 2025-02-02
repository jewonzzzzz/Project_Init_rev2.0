<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSTL-core 라이브러리 추가 -->
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

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


<!------------------------------------------------------------------------------------------------------------------>

<style>
.page-title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
}

/* 테이블 공통 스타일 */
.info-table, .custom-table {
    width: 100%;
    table-layout: fixed;
    border-collapse: collapse !important;
    margin: 30px auto;
    font-size: 15px;
}

.info-table th, 
.info-table td,
.custom-table th,
.custom-table td {
    padding: 15px !important;
    border: 1px solid #ebedf2 !important;
    text-align: center;
    background-color: white;
    height: 40px;
    vertical-align: middle !important;
    line-height: 1.5;
}

.info-table th,
.custom-table th,
.table-head-bg-info th {
    background-color: #f8f9fa !important;
    font-weight: bold !important;
    text-align: center;
    width: 15%;
}

/* 프로필 관련 스타일 */
.profile-column {
    width: 180px !important;
    vertical-align: middle !important;
    text-align: center !important;
}

.profile-pic-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
    padding: 10px;
}

.profile-pic-container img,
.profile-image {
    width: 150px;
    height: 200px;
    object-fit: cover;
    border-radius: 5px;
    margin-bottom: 10px;
}

/* 탭 스타일 */
.tabs {
    display: flex;
    border-bottom: 2px solid #ebedf2;
    margin-bottom: 20px;
    margin-top: 30px;
    background-color: #fff;
    padding: 0;
}

.tabs a {
    padding: 15px 25px;
    text-decoration: none;
    color: #1a2035;
    position: relative;
    font-weight: 500;
    transition: all 0.3s ease;
    border: none;
    background: none;
    margin-right: 5px;
}

.tabs a:hover {
    color: #0055FF;
    background-color: rgba(0, 85, 255, 0.1);
}

.tabs a.active {
    color: #0055FF;
    background-color: transparent;
    border-bottom: 2px solid #0055FF;
    margin-bottom: -2px;
}

/* 탭 콘텐츠 영역 */
.tab-content {
    background: #fff;
    padding: 30px;
    border-radius: 0 0 8px 8px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    min-height: 400px;
    margin-bottom: 30px;
    display: flex;           
    flex-direction: column; 
    align-items: center;    
}

/* 버튼 스타일 */
.btn-modal, #addLicenseBtn {
    display: inline-block;
    padding: 0.65rem 1.2rem;  
    font-size: 14px;
    font-weight: 400;
    line-height: 1.5;        
    background-color: #1572e8;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
}

.btn-modal:hover, #addLicenseBtn:hover {
    background-color: #1269db;
    box-shadow: 0 2px 6px rgba(21, 114, 232, 0.4);
}

.button-container {
    text-align: right;
    margin-top: 10px;   
    margin-bottom: 25px; 
    padding-right: 0;
}

.table-button-wrapper {
    width: 100%;
    position: relative;
}

.delete-license {
    border: none;
    border-radius: 4px;
    background-color: #f44336;
    color: white;
    cursor: pointer;
}

/* 호버 효과 */
.info-table tr:hover td,
.custom-table tr:hover td {
    background-color: #f8f9fa;
    transition: background-color 0.3s ease;
}


</style>
<!------------------------------------------------------------------------------------------------------------------>

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
							<h4 class="card-title">내정보</h4>
						</div>
						<div class="card-body">
							
							<div class="info-container" style="display: grid; grid-template-columns: 180px auto; gap: 0px;">
    <!-- 프로필 사진 테이블 -->
    <table class="table table-bordered table-head-bg-info custom-table">
        <tr>
            <td class="profile-column">
                <div class="profile-pic-container">
                    <c:choose>
                        <c:when test="${empty memberVO.emp_profile || memberVO.emp_profile eq 'void'}">
                            <img src="${pageContext.request.contextPath}/resources/assets/img/profile-default.png" 
                                 alt="기본 증명사진"
                                 class="profile-image" />
                        </c:when>
                        <c:otherwise>
                            <img src="${memberVO.emp_profile}" 
                                 alt="증명사진"
                                 class="profile-image" />
                        </c:otherwise>
                    </c:choose>
                </div>
            </td>
        </tr>
    </table>

    <!-- 정보 테이블 -->
    <table class="table table-bordered table-head-bg-info custom-table">
        <colgroup>
            <col style="width: 12%;">
            <col style="width: 21%;">
            <col style="width: 12%;">
            <col style="width: 21%;">
            <col style="width: 12%;">
            <col style="width: 21%;">
        </colgroup>
        <tr>
            <th>사원번호</th>
            <td>${memberVO.emp_id}</td>
            <th>이름</th>
            <td>${memberVO.emp_name}</td>
            <th>성별</th>
            <td>${memberVO.emp_gender}</td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td>${memberVO.emp_birth}</td>
            <th>주소</th>
            <td>${memberVO.emp_addr}</td>
            <th>연락처</th>
            <td>${memberVO.emp_tel}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${memberVO.emp_email}</td>
            <th>부서</th>
            <td>${memberVO.dept_name}</td>
            <th>직급/직책</th>
            <td>${memberVO.emp_position}/ ${memberVO.emp_job}</td>
        </tr>
        <tr>
            <th>근무형태</th>
            <td>${memberVO.emp_work_type}</td>
            <th>근무지</th>
            <td>${memberVO.emp_bnum}</td>
            <th>입사일자</th>
            <td>${memberVO.emp_start_date}</td>
        </tr>
    </table>
</div>

							<!-- 버튼 영역 -->
							<div class="text-end mt-3 mb-4">
								<button type="button" id="checkPasswordBtn"
									class="btn btn-primary">수정</button>
							</div>

							<div class="tabs" style="width: 100%;">
								<a href="#" class="account">계좌 정보</a> <a href="#"
									class="license">자격증</a> <a href="#" class="his_edu">교육 이력</a> <a
									href="#" class="reward">포상/징계</a> <a href="#" class="eval">인사
									평가</a>
							</div>

							<div class="tab-content" style="width: 100%;">
								<!-- 탭 클릭 시 정보가 여기에 표시됩니다. -->
							  </div>
							 </div>
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
			<div class="modal fade" id="passwordCheckModal" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">비밀번호 확인</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form id="passwordCheckForm">
								<div class="mb-3">
									<label for="checkPassword" class="form-label">비밀번호를
										입력하세요</label> <input type="password" class="form-control"
										id="checkPassword" required>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary"
								id="confirmPassword">확인</button>
						</div>
					</div>
				</div>
			</div>

			<script>
			document.getElementById("passwordCheckForm").addEventListener("keydown", function(event) {
				if (event.key === "Enter") {
					event.preventDefault(); // 기본 엔터키 동작 방지
					document.getElementById("confirmPassword").click(); // 확인 버튼 클릭
				}
			});
			
	$(document).ready(function() {
		$('#checkPasswordBtn').click(function() {
	        $('#passwordCheckModal').modal('show');
	    });

	    $('#confirmPassword').click(function() {
	        var password = $('#checkPassword').val();
	        if (!password) {
	            alert('비밀번호를 입력하세요.');
	            return;
	        }

	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/verifyPassword',
	            type: 'POST',
	            data: {
	                emp_id: '${memberVO.emp_id}',
	                password: password
	            },
	            success: function(response) {
	                if (response.success) {
	                    window.location.href = '${pageContext.request.contextPath}/member/update';
	                } else {
	                    alert('비밀번호가 일치하지 않습니다.');
	                    $('#checkPassword').val('');
	                }
	            },
	            error: function() {
	                alert('서버와의 통신 중 오류가 발생했습니다.');
	            }
	        });
	    });
		
	    function formatDate(timestamp) {
	        if (!timestamp || isNaN(timestamp)) {
	            return '--';
	        }
	        const date = new Date(timestamp);
	        return date.toISOString().split('T')[0];
	    }

	    function loadTabContent(tabType) {
	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/' + tabType,
	            type: 'GET',
	            data: { emp_id: '${memberVO.emp_id}' },
	            success: function(data) {
	                let content = '';
	                switch (tabType) {
	                    case 'account':
	                        content = generateAccountContent(data);
	                        break;
	                    case 'license':
	                        content = generateLicenseContent(data);
	                        break;
	                    case 'his_edu':
	                        content = generateTableContent(data, ['edu_name', 'edu_teacher', 'edu_status', 'edu_end_date'], 
	                        										['교육명', '강사명', '수료현황', '수료일']);
	                        break;
	                    case 'reward':
	                        content = generateTableContent(data, ['division', 'rname', 'reason', 'rdate'], 
	                        										['유형', '이름', '사유', '날짜']);
	                        break;
	                    case 'eval':
	                        content = generateTableContent(data, ['eval_name', 'score_total', 'eval_grade', 'emp_name', 'eval_end_date'], 
	                                                      			['평가명', '종합점수', '종합등급', '평가자', '평가일']);
	                        break;
	                }
	                $(".tab-content").html(content);
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: " + error);
	            }
	        });
	    }

	    function generateAccountContent(data) {
	        let content = '<div class="table-button-wrapper">';
	        content += '<table class="info-table"><tr>' +
	                   '<th>예금주</th><td>' + data.emp_account_name + '</td>' +
	                   '<th>계좌번호</th><td>' + data.emp_account_num + '</td>' +
	                   '<th>은행명</th><td>' + data.emp_bank_name + '</td></tr></table>';
	        content += '<div class="button-container">' +
	                   '<button type="button" class="btn-modal" id="openAccountModal">계좌 수정</button>' +
	                   '</div>';
	        content += '</div>';
	        return content;
	    }

	    function generateTableContent(data, fields, headers) {
	        if (!Array.isArray(data) || data.length === 0) {
	            return '<p>정보가 없습니다.</p>';
	        }
	        let content = '<table class="info-table"><tr>';
	        headers.forEach(header => content += '<th>' + header + '</th>');
	        content += '</tr>';
	        data.forEach(function(item) {
	            content += '<tr>';
	            fields.forEach(field => {
	                let value = field === 'division' ? (item[field] === 'R' ? '포상' : (item[field] === 'P' ? '징계' : item[field])) :
	                            (field.includes('date') ? formatDate(item[field]) : item[field]);
	                content += '<td>' + value + '</td>';
	            });
	            content += '</tr>';
	        });
	        content += '</table>';
	        return content;
	    }

	    $(".tabs a").click(function(e) {
	        e.preventDefault();
	        $(".tabs a").removeClass("active");
	        $(this).addClass("active");
	        loadTabContent($(this).attr('class').split(' ')[0]);
	    });

	    $(document).on('click', '#openAccountModal', function(e) {
	        e.preventDefault();
	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/account',
	            type: 'GET',
	            data: { emp_id: '${memberVO.emp_id}' },
	            success: function(data) {
	                $('#accountName').val(data.emp_account_name);
	                $('#accountNumber').val(data.emp_account_num);
	                $('#bankName').val(data.emp_bank_name);
	                $('#accountModal').modal('show');
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: " + error);
	            }
	        });
	    });

	    $('#saveAccountBtn').click(function(e) {
	        e.preventDefault();
	        
	    	 // 입력값 검증
	        const accountName = $('#accountName').val().trim();
	        const accountNumber = $('#accountNumber').val().trim();
	        const bankName = $('#bankName').val();
	        
	        if (!accountName || !accountNumber || !bankName) {
	            alert('모든 필드를 입력해주세요.');
	            return;
	        }
	        
	     	// 계좌정보 업데이트 데이터
	        var accountData = {
	            emp_account_name: accountName,
	            emp_account_num: accountNumber,
	            emp_bank_name: bankName
	        };
	     	
	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/account/update',
	            type: 'POST',
	            data: JSON.stringify(accountData),
	            contentType: 'application/json',
	            success: function(response) {
	                if (response.success) {
	                    alert('계좌 정보가 수정되었습니다.');
	                    $('#accountModal').modal('hide');
	                    loadTabContent('account');
	                } else {
	                    alert('계좌 수정에 실패했습니다.');
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: " + error);
	                alert('서버 오류가 발생했습니다.');
	            }
	        });
	    });
	    
	    // 자격증 추가
		function generateLicenseContent(data) {
	    let content = '<div class="table-button-wrapper">';
	    content += '<table class="info-table"><tr><th>자격증명</th><th>발급처</th><th>취득일</th><th>작업</th></tr>';
	    if (Array.isArray(data) && data.length > 0) {
	        data.forEach(function(item) {
	            content += '<tr><td>' + item.li_name + '</td><td>' + item.li_issu + '</td><td>' + formatDate(item.li_date) + '</td>';
	            content += '<td><button class="delete-license" data-id="' + item.li_id + '">삭제</button></td></tr>';
	        });
	    } else {
	        content += '<tr><td colspan="4">등록된 자격증이 없습니다.</td></tr>';
	    }
	    content += '</table>';
	    content += '<div class="button-container">' +
	               '<button id="addLicenseBtn">자격증 추가</button>' +
	               '</div>';
	    content += '</div>';
	    return content;
	}

		$(document).on('click', '#addLicenseBtn', function() {
	        console.log("Add License button clicked");
	        $.ajax({
	            url: '${pageContext.request.contextPath}/member/licenseList',
	            type: 'GET',
	            dataType: 'json',
	            success: function(data) {
	                console.log("License list received:", data);
	                showAddLicenseModal(data);
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX Error: " + error);
	                alert("자격증 목록을 불러오는데 실패했습니다.");
	            }
	        });
	    });

		function showAddLicenseModal(licenseList) {
	        console.log("Showing add license modal with data:", licenseList);
	        let selectElement = $('#licenseSelect');
	        selectElement.empty().append('<option value="">자격증을 선택하세요</option>');
	        
	        if (Array.isArray(licenseList) && licenseList.length > 0) {
	            licenseList.forEach(function(license) {
	                selectElement.append($('<option>', {
	                    value: license.li_id,
	                    text: license.li_name + ' (' + license.li_issu + ')'
	                }));
	            });
	            console.log("Options added to select:", selectElement.find('option').length);
	        } else {
	            console.warn("License list is empty or not an array");
	            selectElement.append('<option value="">자격증 목록을 불러올 수 없습니다</option>');
	        }

	        $('#licenseDate').val('');
	        $('#licenseModal').modal('show');
		    }
	
			 $('#licenseModal').on('shown.bs.modal', function () {
			        console.log("Modal shown, select options:", $('#licenseSelect option').length);
			    });	
			
			 $(document).on('click', '#saveLicenseBtn', function() {
				    if (!$('#addLicenseForm')[0].checkValidity()) {
				        $('#addLicenseForm')[0].reportValidity();
				        return;
				    }

				    // 선택된 날짜를 가져옴
				    let selectedDate = new Date($('#licenseDate').val());
				    // UTC 시간으로 변환하면서 발생하는 시간차이를 보정
				    selectedDate.setHours(selectedDate.getHours() + 9); // 한국 시간대 기준
				    
				    let licenseData = {
				        li_id: $('#licenseSelect').val(),
				        li_date: selectedDate.toISOString().split('T')[0] // YYYY-MM-DD 형식으로 변환
				    };

				    $.ajax({
				        url: '${pageContext.request.contextPath}/member/addLicense',
				        type: 'POST',
				        contentType: 'application/json',
				        data: JSON.stringify(licenseData),
				        success: function(response) {
				            if (response.success) {
				                alert(response.message);
				                $('#licenseModal').modal('hide');
				                loadTabContent('license');
				            } else {
				                alert(response.message);
				            }
				        },
				        error: function(xhr, status, error) {
				            console.error("AJAX Error: " + error);
				            alert("자격증 추가 중 오류가 발생했습니다.");
				        }
				    });
				});

	    $(document).on('click', '.delete-license', function() {
	        let licenseId = $(this).data('id');
	        if (confirm('정말로 이 자격증을 삭제하시겠습니까?')) {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/member/deleteLicense/' + licenseId,
	                type: 'DELETE',
	                success: function(response) {
	                    if (response.success) {
	                        alert('자격증이 삭제되었습니다.');
	                        loadTabContent('license');
	                    } else {
	                        alert('자격증 삭제에 실패했습니다: ' + response.message);
	                    }
	                },
	                error: function(xhr, status, error) {
	                    console.error("AJAX Error: " + error);
	                }
	            });
	        }
	    });
	    
	    // 초기 탭 로드
	    loadTabContent('account');
	});
	</script>

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
        lineWidth: "2",
        lineColor: "#ffa534",
        fillColor: "rgba(255, 165, 52, .14)",
      });
    </script>
			<div class="modal fade" id="accountModal" tabindex="-1"
				aria-labelledby="accountModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="accountModalLabel">계좌 수정</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form id="accountForm">
								<div class="mb-3">
									<label for="accountName" class="form-label">예금주</label> <input
										type="text" class="form-control" id="accountName"
										placeholder="예금주를 입력하세요">
								</div>
								<div class="mb-3">
									<label for="accountNumber" class="form-label">계좌번호</label> <input
										type="text" class="form-control" id="accountNumber"
										placeholder="계좌번호를 입력하세요">
								</div>
								<div class="mb-3">
									<label for="bankName" class="form-label">은행명</label>
			                        <select class="form-control" id="bankName">
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
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary" id="saveAccountBtn">저장</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 자격증 추가 모달 -->
			<div class="modal fade" id="licenseModal" tabindex="-1"
				aria-labelledby="licenseModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header bg-primary text-white">
							<h5 class="modal-title" id="licenseModalLabel">자격증 추가</h5>
							<button type="button" class="btn-close btn-close-white"
								data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form id="addLicenseForm">
								<div class="mb-3">
									<label for="licenseSelect" class="form-label">자격증 선택</label> <select
										id="licenseSelect" class="form-select" required>
										<option value="">자격증을 선택하세요</option>
									</select>
								</div>
								<div class="mb-3">
									<label for="licenseDate" class="form-label">취득일</label> <input
										type="date" class="form-control" id="licenseDate" required>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="saveLicenseBtn">저장</button>
						</div>
					</div>
				</div>
			</div>
</body>
</html>