<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<!-- CSS Just for demo purpose, don't include it in your project -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />

<style>
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
.table-container {
	max-width: 100%;
	margin: 0 auto;
}

.table {
	width: 100%;
	margin-bottom: 0;
}

.table th {
	background-color: #f8f9fa;
	width: 20%;
	vertical-align: middle;
}

.table td {
	vertical-align: middle;
}

/* 폼 스타일 */
.form-group {
	margin-bottom: 20px;
}

.form-control {
	border: 1px solid #ebedf2;
	border-radius: 4px;
	padding: 0.5rem;
}

.form-control:focus {
	border-color: #0055FF;
	box-shadow: 0 0 0 0.2rem rgba(0, 85, 255, 0.25);
}

.form-check {
	padding: 1rem;
	background-color: #f8f9fa;
	border-radius: 4px;
}

/* 승인자 관련 스타일 */
.approver-box {
	width: 50%;
	border: 1px solid #ddd;
	padding: 10px;
	margin-bottom: 20px;
	display: flex;
	justify-content: space-between;
}

.approver-item {
	flex: 1;
	padding: 5px;
	border: 1px solid #eee;
	margin-right: 10px;
	text-align: center;
}

.approver-item:last-child {
	margin-right: 0;
}

/* 퇴사 규칙 스타일 */
#quitRules {
	background-color: #f8f9fa;
	border: 1px solid #ebedf2;
	border-radius: 4px;
	padding: 1.5rem;
}

#quitRules ol {
	margin-bottom: 0;
	padding-left: 1.5rem;
}

#quitRules li {
	margin-bottom: 0.5rem;
}

#quitRules h4 {
	margin-top: 0;
}

/* 버튼 스타일 */
.btn {
	padding: 0.5rem 1rem;
	border-radius: 4px;
	font-weight: 500;
}

.btn-primary {
	background-color: #0055FF;
	border-color: #0055FF;
}

.btn-secondary {
	background-color: #6c757d;
	border-color: #6c757d;
}

/* 유틸리티 클래스 */
.me-2 {
	margin-right: 0.5rem;
}

.mt-4 {
	margin-top: 1.5rem;
}

.button-container {
	text-align: right;
	margin-top: 20px;
}

#appBox {
	float: right;
}

textarea.form-control {
	min-height: 100px;
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
							<h4 class="card-title">퇴사 신청</h4>
						</div>
						<div class="card-body">
								<!-- 기본 정보 테이블 -->
								<div class="table-container">
									<table class="table table-bordered">
										<tr>
											<th width="20%">사원번호</th>
											<td><input type="text" class="form-control" id="emp_id"
												name="emp_id" value="${memberVO.emp_id}" readonly></td>
										</tr>
										<tr>
											<th>이름</th>
											<td><input type="text" class="form-control"
												id="emp_name" name="emp_name" value="${memberVO.emp_name}"
												readonly></td>
										</tr>
										<tr>
											<th>부서</th>
											<td><input type="text" class="form-control"
												id="emp_dnum" name="emp_dnum" value="${memberVO.emp_dnum}"
												readonly></td>
										</tr>
										<tr>
											<th>직책</th>
											<td><input type="text" class="form-control"
												id="emp_position" name="emp_position"
												value="${memberVO.emp_job}" readonly></td>
										</tr>
										<tr>
											<th>퇴사희망일</th>
											<td><input type="date" class="form-control datepicker"
												id="emp_quit_date" name="emp_quit_date"></td>
										</tr>
										<tr>
											<th>퇴사사유</th>
											<td><select class="form-control" id="quit_reason"
												name="quit_reason">
													<option value="">선택하세요</option>
													<option value="이직">이직</option>
													<option value="휴식">휴식</option>
													<option value="학업/자기개발">학업/자기개발</option>
													<option value="창업/자영업">창업/자영업</option>
													<option value="가족/육아">가족/육아</option>
													<option value="해외거주/이주">해외거주/이주</option>
													<option value="직무불만족">직무불만족</option>
													<option value="기타">기타</option>
											</select></td>
										</tr>
										<tr>
											<th>사유상세</th>
											<td><textarea class="form-control"
													id="quit_reason_detail" name="quit_reason_detail" rows="5"></textarea></td>
										</tr>
									</table>
								</div>

								<!-- 퇴사 규칙 카드 -->
								<div class="card mt-4">
									<div class="card-header">
										<h5 class="card-title mb-0">퇴사 규칙</h5>
									</div>
									<div class="card-body">
										<div id="quitRules">
											<ol>
												<li>퇴사 후 12개월 동안 동종업계 또는 경쟁 회사로의 이직을 금지하며, 위반 시 법적 책임을
													질 수 있습니다.</li>
												<li>퇴사 후에도 회사의 기밀 정보 및 영업 비밀을 외부에 유출하거나 개인적으로 사용하지 않을
													것을 동의합니다.</li>
												<li>회사에서 근무 중에 개발된 모든 지식 재산은 회사의 소유임을 인정하고, 이에 대한 권리를
													주장하지 않겠습니다.</li>
												<li>퇴사 전 모든 업무에 대한 인수인계를 완료하고, 필요한 자료 및 정보를 후임자에게 제공할
													것에 동의합니다.</li>
												<li>회사 소유의 장비 및 자산(노트북, 명함, 업무 관련 자료 등)을 퇴사 전 모두 반환할 것에
													동의합니다.</li>
												<li>퇴사 후에도 회사 및 동료에 대해 비방하지 않으며, 명예를 훼손하는 행동을 하지 않을 것을
													동의합니다.</li>
												<li>퇴사 시 남아있는 미지급금(급여, 퇴직금 등)은 정확히 정산되며 이에 동의합니다.</li>
												<li>퇴사 후 12개월 동안 회사의 고객, 협력업체, 거래처 등에 접촉하여 사업 제안이나 개인적인
													거래를 하지 않겠다는 것에 동의합니다.</li>
											</ol>
										</div>
										<div class="form-check mt-3">
											<input type="checkbox" class="form-check-input"
												id="agreeRules" name="agreeRules"> <label
												class="form-check-label" for="agreeRules">퇴사절차에
												동의합니다.</label>
										</div>
									</div>
								</div>

								<div class="d-flex justify-content-end mt-4">
									<button type="button" class="btn btn-secondary me-2"
										onclick="history.back()">취소</button>
									<button type="button" class="btn btn-primary" id="signBtn">결재선 지정</button>
								</div>
						</div>
					</div>
					<%@ include file="../inc/signModal.jsp" %>

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

	<!-- Kaiadmin DEMO methods, don't include it in your project! -->
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/setting-demo.js"></script>
	<script
		src="${pageContext.request.contextPath }/resources/assets/js/demo.js"></script>

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

	<script>
	$(document).ready(function() {
	    // 결재선지정 버튼 클릭 이벤트
	    $('#signBtn').click(function(e) {
	        e.preventDefault();
    	    
    	    // 현재 날짜 가져오기
    	    const today = new Date();
    	    today.setHours(0, 0, 0, 0); 
    	    
    	    // 선택된 퇴사 희망일
    	    const quitDate = new Date($('#emp_quit_date').val());
    	    
    	    // 유효성 검사
    	    if (!$('#agreeRules').is(':checked')) {
    	        swal("Error!", "퇴사 규칙에 동의해주세요.", "error");
    	        return false;
    	    }
    	    if (!$('#emp_quit_date').val()) {
    	        swal("Error!", "퇴사희망일을 선택해주세요.", "error");
    	        return false;
    	    }
    	    if (quitDate < today) {
    	        swal("Error!", "퇴사 희망일은 오늘 이후 날짜만 선택 가능합니다.", "error");
    	        return false;
    	    }
    	    if (!$('#quit_reason').val()) {
    	        swal("Error!", "퇴사사유를 선택해주세요.", "error");
    	        return false;
    	    }
    	    if (!$('#quit_reason_detail').val().trim()) {
    	        swal("Error!", "사유상세를 입력해주세요.", "error");
    	        return false;
    	    }

    	    // 모든 유효성 검사를 통과하면 모달창 표시
    	    $('#addRowModal').modal('show');
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
	            	//전달정보 (edu_id, 결재요청자 및 1~3차 결재자의 사번 )
	             	var signData = {
             			emp_id: $('#emp_id').val(),
             			wf_sender: $('select option[name="wf_receiver"]:selected').closest('tr').find('input').val(),
             			wf_receiver_1st: $('select option[name="wf_receiver_1st"]:selected').closest('tr').find('input').val(),
             			wf_receiver_2nd: $('select option[name="wf_receiver_2nd"]:selected').closest('tr').find('input').val(),
             			wf_receiver_3rd: $('select option[name="wf_receiver_3rd"]:selected').closest('tr').find('input').val(),
             			wf_title: $('input[name="wf_title"]').val(),
             			wf_content: $('textarea[name="wf_content"]').val(),
             			reason: $('#quit_reason').val(),
		                emp_quit_date: $('#emp_quit_date').val(),
		                reason_detail: $('#quit_reason_detail').val()
	             	};
	             	$.ajax({
	            		url:'/member/insertSignInfoForQuit',
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
	                            window.location.href = "/member/main";  // 페이지 이동
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

</body>
</html>