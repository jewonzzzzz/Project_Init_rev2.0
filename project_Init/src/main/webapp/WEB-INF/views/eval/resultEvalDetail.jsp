<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    
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

    <style>
		.table th {
		  min-width: 100px; /* 각 열의 최소 너비 설정 */
		  text-align: center; /* 텍스트 중앙 정렬 */
		  background-color: #f8f9fa;
		}
    </style>
    
    
    
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
<%-- ${evaluatorInfo } --%>
<%-- ${reportInfoForEval } --%>
	      <div class="page-header">
              <h3 class="fw-bold mb-3">성과보고</h3>
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
                  <a href="/salary/salaryBasicInfo">성과관리</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">성과평가</a>
                </li>
              </ul>
            </div>
            
          <form id="resultEvalForm" action="/eval/saveResultEval" method="post">
            <div class="row">
              <div class="col-md-11">
                <div class="card">
                  <div class="card-header" style="display: flex; justify-content:space-between; margin-right: 10px;">
                    <div class="card-title">성과평가[${reportInfoForEval.year }년 ${reportInfoForEval.branch }]</div>
                    <div>
		              <button type="submit" id="saveResultEvalBtn" class="btn btn-primary">저장하기</button>
		              <button type="button" id="updateResultEvalBtn" class="btn btn-primary">수정하기</button>
		              <button type="button" id="backBtn" class="btn btn-primary" onclick="history.back()">목록으로</button>
		            </div>
                   </div>
                  <div class="card-body">
                    <div class="row"> 
                      <div class="col">
                      
                      <div class="form-group">
                          <label class="mb-2" style="font-size:16px !important">
                          <b>평가대상자&nbsp; : &nbsp;${reportInfoForEval.emp_position }&nbsp;${reportInfoForEval.emp_name }
                          <br>평가자&nbsp; : &nbsp;${evaluatorInfo.emp_position }&nbsp;${evaluatorInfo.emp_name }</b></label>
                      </div>
                      
                        <div class="form-group">
                          <label class="mb-2" style="font-size:16px !important"><b>평가항목</b></label>
                          <table class="table table-bordered">
                      <thead>
                        <tr style="text-align: center;">
                          <th scope="col">업무성과(50%)</th>
                          <th scope="col">근무태도(25%)</th>
                          <th scope="col">자기개발(25%)</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr style="height: 30px !important;">
                          <td style="padding: 0px 24px !important; height: 30px;">
                          <div class="d-flex" style="justify-content: center;">
                          <c:forEach var="i" begin="1" end="10">
                            <div class="form-check" style="display: flex; flex-direction: column; padding-right: 1px;">
                              <input class="form-check-input" type="radio" name="score_perform" value="${i }" required>
                              <label class="form-check-label" for="flexRadioDefault1">${i }</label>
                            </div></c:forEach>
                          </div></td>
                          <td style="padding: 0px 24px !important; height: 30px;"><div class="d-flex" style="justify-content: center;">
                          <c:forEach var="i" begin="1" end="10">
                            <div class="form-check" style="display: flex; flex-direction: column; padding-right: 1px;">
                              <input class="form-check-input" type="radio" name="score_attendance" value="${i }" required>
                              <label class="form-check-label" for="flexRadioDefault1">${i }</label>
                            </div></c:forEach>
                          </div></td>
                          <td style="padding: 0px 24px !important; height: 30px;"><div class="d-flex" style="justify-content: center;">
                          <c:forEach var="i" begin="1" end="10">
                            <div class="form-check" style="display: flex; flex-direction: column; padding-right: 1px;">
                              <input class="form-check-input" type="radio" name="score_develop" value="${i }" required>
                              <label class="form-check-label" for="flexRadioDefault1">${i }</label>
                            </div></c:forEach>
                          </div></td>
                        </tr>
                      </tbody>
                    </table>
                          </div>
                          
                        <div class="form-group" >
                          <label class="mb-2" style="font-size:16px !important"><b>평과결과(자동계산, 100점 환산)</b></label>
                          	<div style="display: flex; gap: 10px;">
	                          <div class="input-group mb-3" style="flex: 1">
	                            <span class="input-group-text">평가점수</span>
	                            <input type="text" class="form-control" name="score_total" readonly
	                            value="${reportInfoForEval.score_total }">
	                          </div>
	                          <div class="input-group mb-3" style="flex: 1">
	                            <span class="input-group-text">평가등급</span>
	                            <input type="text" class="form-control" name="eval_grade" readonly
	                            value="${reportInfoForEval.eval_grade }">
	                          </div>
	                          <div class="input-group mb-3" style="flex: 2">
	                            <span class="input-group-text">평과결과평</span>
	                            <input type="text" class="form-control" name="eval_comment" required
	                            value="${reportInfoForEval.eval_comment }">
	                          </div>
                          </div>
                          </div>
                          
                        <div class="form-group" >
                          <label class="mb-2" style="font-size:16px !important"><b>업무성과 상세보고</b></label>
                          <textarea name="content" class="form-control" rows="9" readonly
                          >${reportInfoForEval.content }</textarea>
                          </div>
                          
                        </div>
                        </div>
                        </div>
                      </div>
                    </div>
                    </div>
            <input type="hidden" name="eval_his_id" value="${reportInfoForEval.eval_his_id }">
            <input type="hidden" name="evaluator" value="${evaluatorInfo.emp_id }">
          </form>
                 
        <script>
        $(document).ready(function (){
        	
        	// 작성한 내역이 있는지 없는지에 따른 저장/수정 및 불러온 값 지정하기
        	var checkHisReportEval = "${reportInfoForEval.eval_his_status}";
        	if(checkHisReportEval === '평가미완료'){
        		$('#updateResultEvalBtn').prop('disabled',true);
        		$('#backBtn').attr('onclick',"location.href='/eval/resultEval'")
        	} else if(checkHisReportEval === '평가완료') {
        		$('#saveResultEvalBtn').prop('disabled',true);
        		$('#backBtn').attr('onclick',"location.href='/eval/resultEval'")
        		$('input[name="score_perform"][value="' + '${reportInfoForEval.score_perform}' + '"]').prop('checked', true);
        		$('input[name="score_attendance"][value="' + '${reportInfoForEval.score_attendance}' + '"]').prop('checked', true);
        		$('input[name="score_develop"][value="' + '${reportInfoForEval.score_develop}' + '"]').prop('checked', true);
        	} else {
        		$('#updateResultEvalBtn').hide();
        		$('#saveResultEvalBtn').hide();
        		$('input[name="score_perform"][value="' + '${reportInfoForEval.score_perform}' + '"]').prop('checked', true);
        		$('input[name="score_attendance"][value="' + '${reportInfoForEval.score_attendance}' + '"]').prop('checked', true);
        		$('input[name="score_develop"][value="' + '${reportInfoForEval.score_develop}' + '"]').prop('checked', true);
        		$('input[name="score_perform"]').prop('disabled', true);
        		$('input[name="score_attendance"]').prop('disabled', true);
        		$('input[name="score_develop"]').prop('disabled', true);
        		$('input[name="eval_comment"]').prop('disabled', true);
        	}
        	
        	 // 모든 라디오 버튼의 클릭 이벤트에 대해 처리
        	$('input[type="radio"]').on('change', function() {
                let selectedCount = 0;
                let totalSum = 0;

                // 그룹별 선택된 값 확인 및 가중치 적용
                const group1Value = $('input[name="score_perform"]:checked').val();
                const group2Value = $('input[name="score_attendance"]:checked').val();
                const group3Value = $('input[name="score_develop"]:checked').val();

                if (group1Value) selectedCount++;
                if (group2Value) selectedCount++;
                if (group3Value) selectedCount++;

                // 모든 그룹에서 선택되었을 때만 합산 실행
                if (selectedCount === 3) {
                    totalSum += parseFloat(group1Value) * 5;  // 첫 번째 그룹: 5배
                    totalSum += parseFloat(group2Value) * 2.5;  // 두 번째 그룹: 2.5배
                    totalSum += parseFloat(group3Value) * 2.5;  // 세 번째 그룹: 2.5배
                    $('input[name="score_total"]').val(totalSum).trigger('change');  // 합계를 입력 필드에 표시
                } else {
                    $('input[name="score_total"]').val('');  // 선택이 부족하면 필드 비우기
                }
            });
        	
        	// 평가점수에 따른 등급 변화
        	$('input[name="score_total"]').on('change', function() {
        	    // 입력된 값 가져오기 및 숫자 변환
        	    let totalSum = parseFloat($(this).val());

        	    // 조건에 따른 등급 설정
        	    if (totalSum > 90) {
        	        $('input[name="eval_grade"]').val('S');
        	    } else if (totalSum > 80) {
        	        $('input[name="eval_grade"]').val('A');
        	    } else if (totalSum > 70) {
        	        $('input[name="eval_grade"]').val('B');
        	    } else if (totalSum > 60) {
        	        $('input[name="eval_grade"]').val('C');
        	    } else {
        	        $('input[name="eval_grade"]').val('F');
        	    }
        	});
        	
        	
        	//평가완료 버튼 클릭 시 성과이력테이블에 저장하기
            $('#resultEvalForm').on('submit', function(event){
            	event.preventDefault();
            	swal({
   	              title: "성과평가 내용을 저장하시겠습니까?",
   	              text: "성과평가 기간중에는 수정이 가능합니다.",
   	              type: "warning",
   	              buttons: {
   	                cancel: {
   	                  visible: true,
   	                  text: "취소하기",
   	                  className: "btn btn-danger",
   	                },
   	                confirm: {
   	                  text: "저장하기",
   	                  className: "btn btn-success",
   	                },
   	              },
   	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
   	             if (willDelete) {
   	            	swal({
   	            	    title: "Success!",
   	            	    text: "저장완료",
   	            	    icon: "success",
   	            	    buttons: "OK", 
   	            	}).then(function() {
   	            		$('#resultEvalForm').off('submit').submit();
                      });
 	             	}
                  });
        	});
        	
        	// 수정버튼 클릭 시 수정form 수행
        	$('#updateResultEvalBtn').click(function(){
        		event.preventDefault();
        		$('#resultEvalForm').attr('action','/eval/updateResultEval');
        		swal({
     	              title: "성과평가 내용을 수정하시겠습니까?",
     	              text: "성과평가 기간중에는 수정이 가능합니다.",
     	              type: "warning",
     	              buttons: {
     	                cancel: {
     	                  visible: true,
     	                  text: "취소하기",
     	                  className: "btn btn-danger",
     	                },
     	                confirm: {
     	                  text: "수정하기",
     	                  className: "btn btn-success",
     	                },
     	              },
     	            }).then(function(willDelete) {  // 일반 함수 문법으로 변경
     	             if (willDelete) {
     	            	swal({
     	            	    title: "Success!",
     	            	    text: "수정완료",
     	            	    icon: "success",
     	            	    buttons: "OK", 
     	            	}).then(function() {
     	            		$('#resultEvalForm').off('submit').submit();
                        });
   	             	}
                    });
       		});
        		
        	
        	
        	
        	
        });//ready
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
