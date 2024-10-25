<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
              <h3 class="fw-bold mb-3">기본급여정보 설정</h3>
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
                  <a href="#">급여기본정보 설정</a>
                </li>
              </ul>
            </div>
            
            
            
            <div class="row">
              <div class="col-md-11">
                <div class="card">
                <form action="/salary/salaryBasicInfo" method="post">
                  <div class="card-header">
                    <div class="card-title">시급/세율정보 설정</div>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                          <label class="mb-3"><b>시급정보</b></label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">시급</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="hourwage"
                              value="${salaryBasicInfo.hourwage }"
                            />
                            <span class="input-group-text">원</span>
                          </div>
                          <p>* 시급제 직원 급여산출 시 활용</p>
                        </div>
                        
                        <div class="form-group">
                          <label class="mb-3"><b>4대보험 보험료율</b></label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">국민연금 보험료율</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="pension_rate"
                              value="${salaryBasicInfo.pension_rate }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">건강보험 보험료율</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="heal_ins_rate"
                              value="${salaryBasicInfo.heal_ins_rate }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">장기요양 보험료율</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="long_ins_rate"
                              value="${salaryBasicInfo.long_ins_rate }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">고용보험 보험료율</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="emp_ins_rate"
                              value="${salaryBasicInfo.emp_ins_rate }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          
                        </div>
                      </div>
                      
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                        <label class="mb-3"><b>소득세율</b></label>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 1구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate1"
                              value="${salaryBasicInfo.incometax_rate1 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 2구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate2"
                              value="${salaryBasicInfo.incometax_rate2 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 3구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate3"
                              value="${salaryBasicInfo.incometax_rate3 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 4구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate4"
                              value="${salaryBasicInfo.incometax_rate4 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 5구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate5"
                              value="${salaryBasicInfo.incometax_rate5 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 6구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate6"
                              value="${salaryBasicInfo.incometax_rate6 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 7구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate7"
                              value="${salaryBasicInfo.incometax_rate7 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                          <div class="input-group mb-3">
                            <span class="input-group-text">소득세율 8구간</span>
                            <input
                              type="text"
                              class="form-control"
                              aria-label="Amount (to the nearest dollar)"
                              name="incometax_rate8"
                              value="${salaryBasicInfo.incometax_rate8 }"
                            />
                            <span class="input-group-text">%</span>
                          </div>
                        </div>
                      </div>
                      
                      <div class="col-md-6 col-lg-4">
                        <div class="form-group">
                        <label class="mb-3"><b>소득세율정보</b></label>
                          <div class="input-group mb-3">
                            <p>
                             * 소득세율 1구간 : 1400만원 이하<br>
                             * 소득세율 2구간 : 1400만원 초과 5000만원 이하<br>
                             * 소득세율 3구간 : 5000만원 초과 8800만원 이하<br>
                             * 소득세율 4구간 : 8800만원 초과 1억5000만원 이하<br>
                             * 소득세율 5구간 : 1억5000만원 초과 3억 이하<br>
                             * 소득세율 6구간 : 3억원 초과 5억 이하<br>
                             * 소득세율 7구간 : 5억원 초과 10억 이하<br>
                             * 소득세율 8구간 : 10억 초과<br>
                           </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="card-action">
                    <button class="btn btn-success" id="saveBtn" type="submit">저장하기</button>
                  </div>
                  </form>
                </div>
              </div>
          </div>
                 
          <script>
        $(document).ready(function() {
            // 모든 input 요소의 텍스트를 오른쪽으로 정렬
            $('input').css('text-align', 'right');
            
        	 // 쉼표 추가 함수
            function addCommas(value) {
                return value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }

            // 페이지 로드 시 특정 입력 필드의 값에 쉼표 추가
            $('input').each(function() {
                var originalValue = $(this).val();  // 입력 필드의 기존 값 가져오기
                if (originalValue) {  // 값이 존재하면 쉼표 추가
                    var formattedValue = addCommas(originalValue);
                    $(this).val(formattedValue);  // 포맷된 값으로 업데이트
                }
            });
            
            $("#saveBtn").click(function (event) {
            	  event.preventDefault();  // 기본 동작 막기
            	  
            	  // 1. 모든 쉼표를 제거하는 함수
            	  function removeCommas(value) {
            	    return value.replace(/,/g, '');
            	  }

            	  // 2. 특정 form 안의 모든 input 필드의 쉼표 제거
            	  $(this).closest("form").find("input").each(function() {
            	    var cleanedValue = removeCommas($(this).val());  // 각 input 필드의 쉼표 제거
            	    $(this).val(cleanedValue);  // 제거한 값으로 업데이트
            	  });

            	  swal("저장되었습니다.", {
            	    icon: "success",
            	    buttons: {
            	      confirm: {
            	        className: "btn btn-success",
            	      },
            	    },
            	  }).then(function() {  
            	    $(this).closest("form").submit(); 
            	  }.bind(this)); 
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
