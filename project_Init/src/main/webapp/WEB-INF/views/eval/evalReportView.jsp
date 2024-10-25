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
<%-- ${evalReportInfo }
${evalHisReportInfo }
${checkHisInfo } --%>
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
                  <a href="#">성과보고</a>
                </li>
              </ul>
            </div>
            
          <form id="saveEvalForm" action="/eval/saveEvalReport" method="post">
            <div class="row">
              <div class="col-md-11">
                <div class="card">
                  <div class="card-header" style="display: flex; justify-content:space-between; margin-right: 10px;">
                    <div class="card-title">성과보고</div>
                    <div>
		              <button type="submit" id="saveEvalBtn" class="btn btn-primary">저장하기</button>
		              <button type="button" id="updateEvalBtn" class="btn btn-primary">수정하기</button>
		              <button type="button" class="btn btn-primary" onclick="location.href='/eval/reportEval'">목록으로</button>
		            </div>
                    </div>
                  <div class="card-body">
                    <div class="row"> 
                      <div class="col">
                      
                      <div class="form-group">
                          <label class="mb-2" style="font-size:16px !important">
                          <b>성과보고 대상&nbsp; : &nbsp;${evalReportInfo.year }년 &nbsp;${evalReportInfo.branch }
                          &nbsp;업무성과</b><br>[작성기간&nbsp; : &nbsp;${evalReportInfo.eval_report_start } ~
                           &nbsp;${evalReportInfo.eval_report_end }]</label>
                      </div>
                        <div class="form-group">
                          <label class="mb-2" style="font-size:16px !important"><b>업무성과 상세보고</b></label>
                          <textarea name="content" class="form-control" id="comment" rows="12" required
                          ><c:choose><c:when test="${checkHisInfo == 'yes'}">${evalHisReportInfo.content }</c:when
                          ><c:otherwise>[0월 업무성과]&#10;1.업무명&#10;:업무성과&#10;&#10;&#10;&#10;[최대 2000자]
						    </c:otherwise></c:choose></textarea>
                          <div style="display: flex; justify-content: flex-end;">
                          <small id="charCount" style="font-size: 15px;">0 / 2000자</small>
                          </div>
                        </div>
                        
                        <!-- 성과평과 자리 -->
                        <div style="display: flex; gap:10px; width:100%;">
                        
                    </div>
                    </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <input type="hidden" name="eval_id" value="${evalReportInfo.eval_id }">
            <input type="hidden" name="emp_id_eval" value="${emp_id }">
          </form>
          <form id="updateEvalForm" action="/eval/updateEvalReport" method="post">
          </form>
                 
        <script>
        $(document).ready(function (){
        	
        	// 작성한 내역이 있는지 없는지에 따른 저장/수정 버튼 토글
        	var checkHisReportEval = "${checkHisInfo}";
        	if(checkHisReportEval === 'yes'){
        		$('#saveEvalBtn').prop('disabled',true);
        	} else {
        		$('#updateEvalBtn').prop('disabled',true);
        	}
        	
        	
        	// 실시간 글자 수 및 최대글자 초과 방지
        	const maxChars = 2000;
        	const initialLength = $('#comment').val().length;
            $('#charCount').text(initialLength + " / " + maxChars + "자");
        	
            $('#comment').on('input', function() {
                const length = $(this).val().length;
                $('#charCount').text(length + " / " + maxChars + "자");

                // 2000자를 초과하면 입력을 제한
                if (length > maxChars) {
                    $(this).val($(this).val().substring(0, maxChars));
                    $('#charCount').text(maxChars + " / " + maxChars + "자");
                }
            });
        	
        	//저장 버튼 클릭 시 성과이력테이블에 저장하기
            $('#saveEvalForm').on('submit', function(event){
            	event.preventDefault();
            	swal({
   	              title: "성과보고 내용을 저장하시겠습니까?",
   	              text: "성과보고 기간중에는 수정이 가능합니다.",
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
   	            		$('#saveEvalForm').off('submit').submit();
                      });
 	             	}
                  });
        	});
        	
        	// 수정버튼 클릭 시 수정form 수행
        	$('#updateEvalBtn').click(function(){
        		var updateEvalInfo = {
        				eval_id: $('input[name="eval_id"]').val(),
        				emp_id:$('input[name="emp_id_eval"]').val(),
        				content:$('#comment').val()
        		}
        		console.log(updateEvalInfo);
        		$.ajax({
        			url:'/eval/updateEvalReport',
            		type: 'POST',
            		data: JSON.stringify(updateEvalInfo),
            		contentType: 'application/json',
            		success: function(response) {
            			swal({
       	            	    title: "Success!",
       	            	    text: "수정완료",
       	            	    icon: "success",
       	            	    buttons: "OK", 
       	            	}).then(function() {
       	            		window.location.href = '/eval/evalReportView?eval_id=${evalReportInfo.eval_id}';
                          });
            		},
            		error: function(xhr, status, error) {
                        swal("Error!", "실패", "error");
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
