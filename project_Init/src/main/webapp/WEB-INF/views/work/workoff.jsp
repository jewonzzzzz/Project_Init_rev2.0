<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>INIT</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="${pageContext.request.contextPath }/resources/assets/img/project/favicon_black.png"
      style="border-radius: 50%;"
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

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />
    
    <!--   Core JS Files   -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>

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
           <!-- workflow_header start -->
            <div class="page-header">
              <h3 class="fw-bold mb-3">WORK FLOW</h3>
              <ul class="breadcrumbs mb-3">
                <li class="nav-home">
                  <a href="#">
                    <i class="icon-home"></i>
                  </a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">WORK FLOW</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">완료</a>
                </li>
              </ul>
            </div>
            <!-- workflow_header end -->
            
            <!-- workflow_header_2 start -->
             <div class="page-header">
              <a href="/work/workflow"><h6>진행 중 &nbsp;</h6></a>
              <h3> &nbsp; / &nbsp; </h3> 
              <h1 class="card-title">&nbsp; 완료</h1> 
            </div>
            <!-- workflow_header_2 end -->
            
            <!-- workflow_sent start -->
			<div class="row">
              <div class="col-md-6">
                <div class="card" style="background-color: rgb(240,240,240);">
                  <div class="card-header">
                    <h4 class="card-title">보낸 요청</h4>
                  </div>
                  <div class="card-body">
                    <div class="workflow_table">
                      <table
                        class="display table table-striped table-hover multi-filter-select"
                      >
                        <thead>
                          <tr>
                            <th style="width: 3%;">유형</th>
                            <th style="width: 50%;">제목</th>
                            <th style="width: 18%;">수신자</th>
                            <th style="width: 3%;">상태</th>
                            <th style="width: 23%;">발신일</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>유형</th>
                            <th>제목</th>
                            <th>수신자</th>
                            <th>상태</th>
                            <th>발신일</th>
                          </tr>
                        </tfoot>
                        <tbody class="workflow_modal">
                          <c:forEach var="workflow" items="${sentWorkflowList}">
					        <tr>
					            <td style="text-align: center;">
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info">
						            	${workflow.wf_type}
						            </a>
						        </td>
					            <td>
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info">
			                        	${workflow.wf_title}
			                        </a>
		                        </td>
					            <td style="text-align: center;">
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info">
						            	${workflow.receiver_name}
						            </a>
					            </td>
					            <td style="text-align: center;">
					            	<a data-wf_code="${workflow.wf_code}" id="workflow_info">
					            		<c:choose>
								            <c:when test="${workflow.wf_progress == 1}">
								                1차 승인 대기
								            </c:when>
								            <c:when test="${workflow.wf_progress == 2}">
								                2차 승인 대기
								            </c:when>
								            <c:when test="${workflow.wf_progress == 3}">
								                3차 승인 대기
								            </c:when>
								        </c:choose>
					            	</a>
					            </td>
					            <td style="text-align: center;">
					            	<a data-wf_code="${workflow.wf_code}" id="workflow_info">
					           			<fmt:formatDate value="${workflow.wf_create_date}" pattern="yy.MM.dd HH:mm" />
					           		</a>
					           	</td>
					        </tr>
					      </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            <!-- workflow_sent end -->
            <!-- workflow_received start -->
              <div class="col-md-6">
                <div class="card" style="background-color: rgb(240,240,240);">
                  <div class="card-header">
                    <h4 class="card-title">받은 요청</h4>
                  </div>
                  <div class="card-body">
                    <div class="workflow_table">
                      <table
                        class="display table table-striped table-hover multi-filter-select"
                      >
                       <thead>
                          <tr>
                            <th style="width: 3%;">유형</th>
                            <th style="width: 50%;">제목</th>
                            <th style="width: 18%;">발신자</th>
                            <th style="width: 3%;">상태</th>
                            <th style="width: 23%;">수신일</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>유형</th>
                            <th>제목</th>
                            <th>발신자</th>
                            <th>상태</th>
                            <th>수신일</th>
                          </tr>
                        </tfoot>
                        <tbody>
                          <c:forEach var="workflow" items="${receivedWorkflowList}">
					        <tr>
					            <td style="text-align: center;">
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info">
						            	${workflow.wf_type}
						            </a>
						        </td>
					            <td>
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info">
			                        	${workflow.wf_title}
			                        </a>
		                        </td>
					            <td style="text-align: center;">
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info">
						            	${workflow.sender_name}
						            </a>
					            </td>
					            <td style="text-align: center;">
					            	<a data-wf_code="${workflow.wf_code}" id="workflow_info">
					            		<c:choose>
								            <c:when test="${workflow.wf_progress == 1}">
								                1차 승인 대기
								            </c:when>
								            <c:when test="${workflow.wf_progress == 2}">
								                2차 승인 대기
								            </c:when>
								            <c:when test="${workflow.wf_progress == 3}">
								                3차 승인 대기
								            </c:when>
								        </c:choose>
					            	</a>
					            </td>
					            <td style="text-align: center;">
					            	<a data-wf_code="${workflow.wf_code}" id="workflow_info">
					           			<fmt:formatDate value="${workflow.wf_last_result_date}" pattern="yy.MM.dd HH:mm" />
					           		</a>
					           	</td>
					        </tr>
					      </c:forEach>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- workflow_received end -->
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

    <!-- import custom js -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/multi_filter_select_table.js"></script>
    
  </body>
</html>
