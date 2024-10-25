<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
    	.table-responsive {
		  overflow-x: auto; /* 가로 스크롤 활성화 */
		}
		.table th, .table td {
		  white-space: nowrap; /* 텍스트가 줄바꿈되지 않도록 설정 */
		}
		
		.table th {
		  min-width: 100px; /* 각 열의 최소 너비 설정 */
		  text-align: center; /* 텍스트 중앙 정렬 */
		  background-color: #FAF9F6;
		  position: sticky;
		  top: 0;
		  z-index: 10;  /* 헤더가 본문 데이터 위에 오도록 설정 */
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
		<div class="page-header">
              <h3 class="fw-bold mb-3">급여산출</h3>
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
                  <a href="/salary/salaryBasicInfo">급여관리</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">급여산출</a>
                </li>
              </ul>
            </div>
            
            <div class="row">
              <div class="col-md-11">
              	<div style="margin-bottom: 10px; display: flex; justify-content: flex-end;;">
              		<button type="button" class="btn btn-primary" onclick="history.back()">
                            	목록으로
                    </button>
              	</div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여산출 종합내역</div>
                  </div>
                  
                  <div class="card-body">
                    <table class="table table-bordered" id="resultTable">
                      <thead>
                        <tr>
                          <th>급여유형</th>
                          <th>연도</th>
                          <th>월</th>
                          <th>대상 인원</th>
                          <th>(세전)급여 총액</th>
                          <th>공제금 총액</th>
                          <th>(세후)실지급액 총액</th>
                        </tr>
                      </thead>
                      <tbody>
                      	<tr>
                      	  <td>${calSalaryListInfo.sal_type }</td>
                      	  <td class="year">${calSalaryListInfo.year }</td>
                      	  <td>${calSalaryListInfo.month }</td>
                      	  <td id="sumMember"></td>
                      	  <td id="sumSalBasic"></td>
                      	  <td id="sumSalDeduct"></td>
                      	  <td id="sumSalTotal"></td>
                      	</tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              
              	<div class="col-md-11">
              <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여산출 상세내역</div>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                      <table class="table table-bordered" id="calSalaryTable">
                        <thead>
                          <tr>
                            <th>사번</th>
                            <th>이름</th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>직무</th>
                            <th>근무형태</th>
                            <th>직급급</th>
                            <th>직무급</th>
                            <th>기본급</th>
                            <th>법정수당</th>
                            <th>성과지급율(%)</th>
                            <th>상여지급율(%)</th>
                            <th>성과급</th>
                            <th>상여금</th>
                            <th>(세전)급여액</th>
                            <th>소득세</th>
                            <th>국민연금</th>
                            <th>건강보험료</th>
                            <th>장기요양보험료</th>
                            <th>고용보험료</th>
                            <th>공제금 합계</th>
                            <th>(세후)실지급액</th>
                          </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="list" items="${calSalaryFinalInfo }">
                        	<tr>
								<td class="employee_id">${list.emp_id }</td>                        	
								<td>${list.emp_name }</td>                        	
								<td>${list.dname }</td>                        	
								<td>${list.emp_position }</td>                        	
								<td>${list.emp_job }</td>                        	
								<td>${list.emp_work_type }</td>                        	
								<td>${list.sal_position }</td>                        	
								<td>${list.sal_job }</td>                        	
								<td>${list.sal_total_basic }</td>                        	
								<td>${list.sal_allow }</td>                        	
								<td>${list.perform_rate }</td>                        	
								<td>${list.bonus_rate }</td>                        	
								<td>${list.sal_perform }</td>                        	
								<td>${list.sal_bonus }</td>                        	
								<td class="salBasic">${list.sal_total_before }</td>                        	
								<td>${list.incometax }</td>                        	
								<td>${list.pension }</td>                        	
								<td>${list.heal_ins }</td>                        	
								<td>${list.long_ins }</td>                        	
								<td>${list.emp_ins }</td>                        	
								<td class="salDeduct">${list.sal_total_deduct }</td>                        	
								<td class="salTotal">${list.sal_total_after }</td>                        	
                        	</tr>
                        </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
                </div>
            </div>
            
            <script>
        $(document).ready(function() {
        	
        	// 전체 테이블 가운대 정렬
        	$('table').wrap('<div style="text-align: center;"></div>');
        	
        	// 화면로드 시 기본급,공제금,실지급액 합 계산 및 출력
        	let sumSalBasic = 0;
        	$('td.salBasic').each(function(){
        		sumSalBasic += parseInt($(this).text());
        	});
            $('#sumSalBasic').text(sumSalBasic);
            
        	let sumSalDeduct = 0;
        	$('td.salDeduct').each(function(){
        		sumSalDeduct += parseInt($(this).text());
        	});
            $('#sumSalDeduct').text(sumSalDeduct);
            
        	let sumSalTotal = 0;
        	$('td.salTotal').each(function(){
        		sumSalTotal += parseInt($(this).text());
        	});
            $('#sumSalTotal').text(sumSalTotal);
            
            // 대상인원 출력
            $('#sumMember').text($('#calSalaryTable tbody tr').length);
            
            function addCommasToNumber(num) {
                return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
            const filteredTds = $('td').not('.year');
            
            filteredTds.each(function() {
                // 현재 <td>의 텍스트 가져오기
                const currentText = $(this).text();
                
                // 숫자인 경우에만 쉼표 추가
                if ($.isNumeric(currentText)) {
                    const formattedNumber = addCommasToNumber(currentText);
                    $(this).text(formattedNumber);  // 쉼표가 추가된 값으로 텍스트 업데이트
                }
            });
            
            
            
            
            
            
            
            
            
            
        });
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
