<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
<meta charset="UTF-8"> <!-- 한글 인코딩 추가 -->
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
   <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
   <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
   
   
   
   
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

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">


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

  
                <div class="card">
                  <div class="card-header">
                    <div class="card-title">연차관리</div>
               
               <br>
               <br>







<div class="card-body">
    <div class="table-responsive">
        <div id="basic-datatables_wrapper" class="dataTables_wrapper container-fluid dt-bootstrap4">
            <div class="d-flex align-items-center">
                <label class="me-2">사원 ID:</label>
                <input type="text" class="form-control me-2" id="emp_id_to_view" placeholder="사원 ID를 입력하세요" required style="width: 200px;">
                
                <button id="viewLeaveButton" class="btn btn-info">사원 연차 조회</button>
            </div>
            <br>
            <br>

            <!-- 연차 정보를 표시할 테이블 -->
            <div id="annualLeaveData">
                <table id="annualLeaveTable" class="display table mt-3" style="width: 100%;">
                    <thead>
                        <tr>
                            <th>입사일</th>                <!-- 사원의 입사일 -->
                            <th>사원 ID</th>               <!-- 연차 테이블의 사원 번호 -->
                            <th>총 연차 일수</th>
                            <th>사용된 연차 일수</th>
                            <th>남은 연차 일수</th>
                            <th>연차 부여</th>
                            <th>조정일</th>                <!-- 조정일 추가 -->
                            <th>연차 생성</th> 
                            <th>연차 이력 초기화</th>       <!-- 연차 이력 삭제 버튼 열 추가 -->
                        </tr>
                    </thead>
                    <tbody id="annualLeaveList">
                        <!-- 조회된 연차 데이터가 여기에 삽입됩니다 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#viewLeaveButton').click(function() {
            var empId = $('#emp_id_to_view').val();
            if (empId) {
                $.ajax({
                    type: 'GET',
                    url: 'getAnnualLeave',
                    data: { emp_id: empId },
                    success: function(response) {
                        $('#annualLeaveList').empty();

                        if (Array.isArray(response) && response.length > 0) {
                            response.forEach(function(leave) {
                                var startDate = formatDate(leave.emp_start_date); // 사원의 입사일
                                $('#annualLeaveList').append(
                                    '<tr>' +
                                        '<td>' + (startDate|| "-") + '</td>' + // 사원의 입사일
                                        '<td>' + (leave.emp_id|| "-") + '</td>' + // 테이블의 사원 번호
                                        '<td>' + (leave.total_annual_leave|| "-") + '</td>' +
                                        '<td>' + (leave.used_annual_leave|| "-") + '</td>' +
                                        '<td>' + (leave.remaining_annual_leave || "-" ) + '</td>' +
                                        '<td>' + (leave.lgrant || "-") + '</td>' + // 
                                        '<td>' + (leave.adjustmentDate || "-") + '</td>' + // 조정일
                                        '<td><button class="btn btn-success createLeaveButton" data-emp-id="' + leave.emp_id + '">연차 생성</button></td>' + // 연차 생성 버튼
                                        '<td><button class="btn btn-danger deleteLeaveButton" data-leave-id="' + leave.leave_id + '">이력 초기화</button></td>' + // 연차 삭제 버튼 추가
                                    '</tr>'
                                );
                            });
                            $('#annualLeaveTable').show();
                        } else {
                            alert('해당 사원의 연차 정보가 없습니다.');
                        }
                    },
                    error: function() {
                        alert('연차 조회 중 오류가 발생했습니다.');
                    }
                });
            } else {
                alert('사원 ID를 입력해 주세요.');
            }
        });

        // 연차 생성 버튼 클릭 이벤트
        $(document).on('click', '.createLeaveButton', function() {
            var empId = $(this).data('emp-id');
            $.ajax({
                type: 'POST',
                url: 'generateAnnualLeave',
                data: { emp_id: empId },
                success: function(response) {
                    alert('연차가 성공적으로 생성되었습니다.');
                    console.log(response);
                },
                error: function() {
                    alert('연차 생성 중 오류가 발생했습니다.');
                }
            });
        });

        // 연차 삭제 버튼 클릭 이벤트
        $(document).on('click', '.deleteLeaveButton', function() {
            var leaveId = $(this).data('leave-id');
            if (confirm('정말로 이 연차 이력을 삭제하시겠습니까?')) {
                $.ajax({
                    type: 'POST',
                    url: 'deleteA',  // 연차 삭제를 처리할 URL
                    data: { leave_id: leaveId },
                    success: function(response) {
                        alert('연차 이력이 성공적으로 삭제되었습니다.');
                        $('#viewLeaveButton').click(); // 조회 버튼을 다시 클릭하여 갱신
                    },
                    error: function() {
                        alert('연차 이력이 성공적으로 삭제되었습니다.');
                        $('#viewLeaveButton').click(); 
                    }
                });
            }
        });
    });

    // 날짜를 "YYYY-MM-DD" 형식으로 변환하는 함수
    function formatDate(dateString) {
        if (!dateString) return ''; // 값이 없으면 빈 문자열 반환
        var date = new Date(dateString);
        return date.toISOString().split('T')[0]; // "YYYY-MM-DD" 형식으로 변환
    }
</script>



   </div>
                  <div class="card-body">
                    

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
