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
              <h3 class="fw-bold mb-3">교육등록</h3>
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
                  <a href="/salary/salaryBasicInfo">교육</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">교육등록</a>
                </li>
              </ul>
            </div>
            
          <form id="eduCreateForm" action="/edu/eduCreate" method="post" enctype="multipart/form-data">
            <div class="row">
              <div class="col-md-11">
                <div class="card">
                  <div class="card-header" style="display: flex; justify-content:space-between; margin-right: 10px;">
                    <div class="card-title">교육등록</div>
                    <div>
		              <button type="submit" id="eduCreatedBtn" class="btn btn-primary">저장하기</button>
		              <button type="button" class="btn btn-primary" onclick="location.href='/edu/eduManage'">목록으로</button>
		            </div>
                    </div>
                  <div class="card-body">
                    <div class="row"> 
                      <div class="col">
                      
                      <div class="form-group" style="display: flex; gap:10px;">
                        <div style="flex:4;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육명</b></label>
                          <input name="edu_name" type="text" class="form-control" required placeholder="교육명을 입력하세요">
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육구분</b></label>
                          <select class="form-select form-control" id="defaultSelect" name="edu_type" required>
                            <option>사내교육</option>
                            <option>외부교육</option>
                          </select>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>강사명</b></label>
                          <input name="edu_teacher" type="text" class="form-control" placeholder="강사명 입력" required>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육장소</b></label>
                          <input name="edu_place" type="text" class="form-control" placeholder="교육장소 입력" required>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육인원</b></label>
                          <input name="edu_personnel" type="number" class="form-control" placeholder="교육인원 입력" required>
                        </div>
                      </div>
                      
                        <div class="form-group">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 상세내용</b></label>
                          <textarea name="edu_content" class="form-control" id="comment" rows="8" required> </textarea>
                        </div>
                        
                        <div style="display: flex; gap:10px; width:100%;">
                        <div style="flex:1;">
                      <div class="form-group" style="display: flex; gap:10px; width:100%;">
                      <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 시작일</b></label>
                          <input name="edu_start_date" type="date" class="form-control" required>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 접수시작일</b></label>
                          <input name="edu_apply_start" type="date" class="form-control" required>
                        </div>
                      </div>
                      
                      <div class="form-group" style="display: flex; gap:10px; width:100%;">
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 종료일</b></label>
                          <input name="edu_end_date"type="date" class="form-control" required>
                        </div>
                        <div style="flex:1;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 접수마감일</b></label>
                          <input name="edu_apply_end" type="date" class="form-control" required>
                        </div>
                      </div>
                      </div>
                      
                      <div style="flex:1;">
                        <div class="form-group" style="display: flex; gap:10px;">
                          <label class="mb-2" style="font-size:16px !important"><b>교육 썸네일</b></label>
                          <input name="edu_thumbnail" type="file" class="form-control-file" id="edu_thumbnail" required>
                          <div id="thumbnail_preView" style="width: 180px; height: 180px;" >
                          </div>
                        </div>
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
        $(document).ready(function (){
        	
        	$('#edu_thumbnail').on('change', function(event){
        		const file = event.target.files[0]; // 업로드한 파일 가져오기
        	    const $preview = $('#thumbnail_preView'); // 미리보기 영역 선택
        	    if (file) {
        	    	const reader = new FileReader();
        	        reader.onload = function(e) {
        	          const imgTag = 
        	            "<img src='" + e.target.result + "' alt='Uploaded Image' " +
        	            "style='max-width: 100%; max-height: 100%; object-fit: cover;' />";
        	          $preview.html(imgTag);
        	        };
        	        reader.readAsDataURL(file); // 파일을 Data URL로 읽기
        	    } else {
        	    	$preview.empty();
        	    }
        	});
        	
        	//교육생성 버튼 클릭 시 submit하기
            $('#eduCreateForm').on('submit', function(event){
            	event.preventDefault();
            	swal({
   	              title: "교육을 등록하시겠습니까?",
   	              text: "임시저장되며 결재요청은 상세페이지에서 가능합니다.",
   	              type: "warning",
   	              buttons: {
   	                cancel: {
   	                  visible: true,
   	                  text: "취소하기",
   	                  className: "btn btn-danger",
   	                },
   	                confirm: {
   	                  text: "교육생성",
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
   	            		$('#eduCreateForm').off('submit').submit();
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
