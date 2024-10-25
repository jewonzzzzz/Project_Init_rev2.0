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
              <h3 class="fw-bold mb-3">급여조회</h3>
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
                  <a href="#">급여조회</a>
                </li>
              </ul>
            </div>
            
            <div class="row">
              <div class="col-md-11">
              <div class="form">
                      <div style="display: flex; margin-bottom: 10px; justify-content: flex-end;">
                          <select
                            class="form-select input-fixed"
                            id="yearSelect"
                            name="year"
                          >
                          </select>
                          <input type="hidden" id="emp_id_salary" value="${emp_id }">
                    </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여내역 조회</div>
                  </div>
                  
                  <div class="card-body">
                    <div class="table-responsive">
                      <table
                        id="basic-datatables"
                        class="display table table-striped table-hover"
                      >
                        <thead>
                          <tr>
                          <th>사번</th>
                          <th>급여유형</th>
                          <th>연도</th>
                          <th>월</th>
                          <th>(세전)급여액</th>
                          <th>공제금 총액</th>
                          <th>(세후)실지급액</th>
                          <th>비고</th>
                          </tr>
                        </thead>
                        <tbody>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
              
              	
            </div>
            </div>
            
            <script>
        $(document).ready(function() {
        	// 테이블 가운대 정렬
        	$('table th td').wrap('<div style="text-align: center;"></div>');
        	// 현재 연도 구하기
            const currentYear = new Date().getFullYear();
            for (let year = currentYear; year > currentYear - 10; year--) {
                $('#yearSelect').append(new Option(year, year));  // Option 생성 및 추가
            }
            
            // 첫화면 로드 시 최근 연도에 대한 급여정보 가져오기
            	var checkSalaryInfo = [];
            	checkSalaryInfo.push($('#yearSelect').val());
            	checkSalaryInfo.push($('#emp_id_salary').val());
            	console.log(checkSalaryInfo);
            	$.ajax({
            		url:'/salary/getSalaryInquiryForEmployee',
            		type: 'POST',
            		data: JSON.stringify(checkSalaryInfo),
            		contentType: 'application/json',
            		success: function(response) {
            			dataTable.clear();
            			response.forEach(function(data){
            				dataTable.row.add([
                            data.emp_id,
                            data.sal_type,
                            '<span class="year">' + data.year + '</span>',
                            data.month,
                            data.sal_total_before,
                            data.sal_total_deduct,
                            data.sal_total_after,
                            '<a href="/salary/salaryDetail?sal_final_id=' + data.sal_final_id + '">상세보기</a>'
                            ]);
            			});
            			dataTable.draw();
            		},
            		error: function(xhr, status, error) {
                        swal("Error!", "실패", "error");
                    }
            	});
            
            
         	// 연도 변경 시 해당연도에 대한 급여정보 가져오기
            $('#yearSelect').change(function(event){
            	var checkSalaryInfo = [];
            	checkSalaryInfo.push($('#yearSelect').val());
            	checkSalaryInfo.push($('#emp_id_salary').val());
            	console.log(checkSalaryInfo);
            	$.ajax({
            		url:'/salary/getSalaryInquiryForEmployee',
            		type: 'POST',
            		data: JSON.stringify(checkSalaryInfo),
            		contentType: 'application/json',
            		success: function(response) {
            			dataTable.clear();
            			response.forEach(function(data){
            				dataTable.row.add([
                            data.emp_id,
                            data.sal_type,
                            '<span class="year">' + data.year + '</span>',
                            data.month,
                            data.sal_total_before,
                            data.sal_total_deduct,
                            data.sal_total_after,
                            '<a href="/salary/salaryDetail?sal_final_id=' + data.sal_final_id + '">상세보기</a>'
                            ]);
            			});
            			dataTable.draw();
            		},
            		error: function(xhr, status, error) {
                        swal("Error!", "실패", "error");
                    }
            	});
            });
            
            let dataTable = $("#basic-datatables").DataTable({
            	pageLength: 6,
            	drawCallback: function() { //가운대 정렬
        			$('#basic-datatables th, #basic-datatables td').css({
        	            'text-align': 'center',
        	            'vertical-align': 'middle'
        	        });
        			addCommasToNumbersInTable();
            	 }
            });
        
            function addCommasToNumber(num) {
                return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
            function addCommasToNumbersInTable() {
                const filteredTds = $('#basic-datatables tbody td').not(':has(.year)');

                filteredTds.each(function() {
                    const currentText = $(this).text();

                    // 숫자인 경우에만 쉼표 추가
                    if ($.isNumeric(currentText)) {
                        const formattedNumber = addCommasToNumber(currentText);
                        $(this).text(formattedNumber);  // 쉼표가 추가된 값으로 텍스트 업데이트
                    }
                });
            }
        
        
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
