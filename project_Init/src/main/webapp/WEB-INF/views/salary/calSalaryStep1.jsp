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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
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
	<form id="submitForm" action="/salary/calSalaryStep2" method="post">
            <div class="row">
            <div class="col-sm-6 col-md-5">
                <div class="card card-stats card-round">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-success bubble-shadow-small"
                        >
                          <i class="fa-solid fa-calendar-days"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Step1</p>
                          <h4 class="card-title">급여형태/귀속연월 설정</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round" style="background-color:#e9ecef;">
                  <div class="card-body" id="second_card">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-primary bubble-shadow-small"
                        >
                          <i class="fas fa-users"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Step2</p>
                          <h4 class="card-title">직원정보 조회</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round" style="background-color:#e9ecef;">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-danger bubble-shadow-small"
                        >
                          <i class="fa-solid fa-calculator"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Step3</p>
                          <h4 class="card-title">급여산출</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            
            
              <div class="col-md-11">
                <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">급여형태/귀속연월 설정</div>
                    <div class="card-category">
                      급여형태와 귀속연도를 설정합니다. <b>기존과 동일한 내역이 있으면 작성되지 않습니다.</b>
                    </div>
                  </div>
                  <div class="card-body">
                    <div class="form">
                      <div class="form-group form-show-notify row">
                        <div class="col-lg-3 col-md-3 col-sm-4 text-end">
                          <label>급여형태 :</label>
                        </div>
                        <div class="col-lg-9 col-md-9 col-sm-8">
                          <select
                            class="form-select input-fixed"
                            id="notify_placement_from"
                            name="sal_type"
                          >
                            <option value="월급여">월급여</option>
                            <option value="성과급">성과급</option>
                            <option value="상여금">상여금</option>
                          </select>
                        </div>
                      </div>
                      <div class="form-group form-show-notify row" id="bonusInput" style="display: none;">
                        <div class="col-lg-3 col-md-3 col-sm-4 text-end">
                          <label>상여지급율(%) :</label>
                        </div>
                        <div class="col-lg-9 col-md-9 col-sm-8">
                          <input type="text" 
				           class="form-control input-fixed" 
				           id="bonus_rate" 
				           name="bonus_rate"
				           placeholder="상여지급율(%) 입력" 
				           style="margin-bottom: 0px; padding: 5px 14px; border-bottom-width: 1px;">
                        </div>
                      </div>
                      
                      
                      <div class="form-group form-show-notify row">
                        <div class="col-lg-3 col-md-3 col-sm-4 text-end">
                          <label>연도 :</label>
                        </div>
                        <div class="col-lg-4 col-md-9 col-sm-8">
                          <select
                            class="form-select input-fixed"
                            id="yearSelect"
                            name="year"
                          >
                          </select>
                        </div>
                      </div>
                      <div class="form-group form-show-notify row">
                        <div class="col-lg-3 col-md-3 col-sm-4 text-end">
                          <label>월 :</label>
                        </div>
                        <div class="col-lg-4 col-md-9 col-sm-8">
                          <select
                            class="form-select input-fixed"
                            id="monthSelect"
                            name="month"
                          >
                          </select>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card-footer">
                    <div class="form">
                      <div class="form-group from-show-notify row">
                        <div class="col-lg-3 col-md-3 col-sm-12">
                          <button type="button" class="btn btn-primary" onclick="history.back()">목록으로</button>
                        </div>
                        <div class="col-lg-4 col-md-9 col-sm-12">
                          <button id="nextBtn" class="btn btn-primary">
                            다음으로
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              </div>
            </div>
            </form>
	
	<script>
        $(document).ready(function() {
        	
            // 현재 연도 구하기
            const currentYear = new Date().getFullYear();
            
            // 최근 10년간의 연도 추가
            for (let year = currentYear; year > currentYear - 3; year--) {
                $('#yearSelect').append(new Option(year, year));  // Option 생성 및 추가
            }
            
            for (let month = 1; month <= 12; month++) {
                $('#monthSelect').append(new Option(month, month));  // Option 생성 및 추가
            }
            
            // 상여금 옵션 선택 시 상여지급율 input 보이기
            $('select[name="sal_type"]').change(function() {
		        if ($(this).val() === '상여금') {
		          $('#bonusInput').show();  // div 보이기
		        } else {
		          $('#bonusInput').hide();  // div 숨기기
		        }
	      	});
            
         	// 다음으로 버튼 시 사번가지고 이동하기
            $('#nextBtn').click(function(event){
            	event.preventDefault();
            	
            	const currentYear = new Date().getFullYear();
                const currentMonth = new Date().getMonth() + 1; // 0부터 시작하므로 +1
            	
                const selectedYear = parseInt($('#yearSelect').val());
                const selectedMonth = parseInt($('#monthSelect').val());
            	
                if (selectedYear > currentYear || (selectedYear === currentYear && selectedMonth >= currentMonth)) {
                	swal("확인필요!", "귀속연월이 현재 연월보다 크거나 같습니다." , "warning");
                } else {
            	// 상여지급율 없을 시 값 0으로 초기화
            	var bonus_rate = $('#bonus_rate').val();
            	if(bonus_rate === ""){
            		$('#bonus_rate').val(0);
            	}
           		var checkSalaryInfo = [];
               	$('option:checked').each(function () {
               		checkSalaryInfo.push($(this).val());
                   });
               	checkSalaryInfo.push(bonus_rate);
            	
            	$.ajax({
            		url:'/salary/checkCreateSalary',
            		type: 'POST',
            		data: JSON.stringify(checkSalaryInfo),
            		contentType: 'application/json',
            		success: function(response) {
            			// 중복여부 체크
            			if(response === 'ok'){
            				$('#submitForm').submit();
            			} else{
                        	swal("Error!", "중복된 입력정보가 있습니다." , "error");
            			}
            		},
            		error: function(xhr, status, error) {
                        swal("Error!", "실패", "error");
                    }
            	});
                }
            });
         	
         	
         	
         	
         	
        }); //ready
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
