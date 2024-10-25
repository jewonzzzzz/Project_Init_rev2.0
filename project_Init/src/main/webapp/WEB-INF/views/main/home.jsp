<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="UTF-8">
    <title>INIT - HOME</title>
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
        },      });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/kaiadmin.min.css" />
    
    
    <!--   Core JS Files   -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/popper.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/js/core/bootstrap.min.js"></script>

    <script src="${pageContext.request.contextPath }/resources/assets/js/main.js"></script>

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />
    
	<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
  </head>
  <body>
    <div class="wrapper">
      <%@ include file="/resources/assets/inc/sidebar.jsp" %> <!-- sidebar -->
      <div class="main-panel">
        <div class="main-header">
          <%@ include file="/resources/assets/inc/logo_header.jsp" %>
          <%@ include file="/resources/assets/inc/navbar.jsp" %>
        </div>
        <div class="container">
          <div class="page-inner" style="background-color : rgba(250,250,250,0.7);  height: 90vh; display:flex; flex-direction:column; justify-content: space-between; align-content: flex-end;">
<!------------------------------------------------------------------------------------------------------------------>
<!-- header start -->
<div class="header-box" style="display:flex; width: 100%; flex:0.1; box-sizing: border-box;">
	<div class="page-header" style="flex:0.4;">
	  <h3 class="fw-bold mb-3">HOME</h3>
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
	      <a href="#">Something</a>
	    </li>
	    <li class="separator">
	      <i class="icon-arrow-right"></i>
	    </li>
	    <li class="nav-item">
	      <a href="#">something</a>
	    </li>
	  </ul>
	</div>
	<div style="display: flex; flex:0.6; justify-content: flex-end;">
		<div class="card-box button ${empty settingVO.tool_name_1 ? 'extend_user_setting' : ''}">
			<div class="card">
				<div class="card-body">
					<a style="display:flex; justify-content:center; align-items: center; font-size:20px;" href="${empty settingVO.tool_url_1 ? '#' : settingVO.tool_url_1}">
						${empty settingVO.tool_name_1 ? '+' : settingVO.tool_name_1}
					</a>
				</div>
			</div>
		</div>
		<div class="card-box button ${empty settingVO.tool_name_2 ? 'extend_user_setting' : ''}">
			<div class="card">
				<div class="card-body">
					<a style="display:flex; justify-content:center; align-items: center; font-size:20px;" href="${empty settingVO.tool_url_2 ? '#' : settingVO.tool_url_2}">
						${empty settingVO.tool_name_2 ? '+' : settingVO.tool_name_2}
					</a>
				</div>
			</div>
		</div>
		<div class="card-box button ${empty settingVO.tool_name_3 ? 'extend_user_setting' : ''}">
			<div class="card">
				<div class="card-body">
					<a style="display:flex; justify-content:center; align-items: center; font-size:20px;" href="${empty settingVO.tool_url_3 ? '#' : settingVO.tool_url_3}">
						${empty settingVO.tool_name_3 ? '+' : settingVO.tool_name_3}
					</a>
				</div>
			</div>
		</div>
		<div class="card-box button ${empty settingVO.tool_name_4 ? 'extend_user_setting' : ''}">
			<div class="card">
				<div class="card-body">
					<a style="display:flex; justify-content:center; align-items: center; font-size:20px;" href="${empty settingVO.tool_url_4 ? '#' : settingVO.tool_url_4}">
						${empty settingVO.tool_name_4 ? '+' : settingVO.tool_name_4}
					</a>
				</div>
			</div>
		</div>
		<div style="position: relative;">
			<button id="extend_user_setting" style="background: transparent; border: none; padding: 0; cursor: pointer; outline: none;">
				<i style="color: rgba(0,0,0,0.5); font-size: 24px;" class="fa-solid fa-gear"></i>
			</button>
			<!-- 설정창 -->
			<div id = "user_setting" class="card-box" style="display:none;">
				<div class="card" style="width:95%; height:96%; display:flex; flex-direction: column; justify-content: flex-start; align-content: center;">
					<div style="display:flex; flex-direction: column; flex:0.5; width:100%;">
						<div style="display:flex; flex:1; width:100%;">
							<div style="display:flex; flex:0.5; width:100%; justify-content: flex-start; align-content: center;">
								<div id="tool_1" data-tool_id="${settingVO.tool_id_1}" class="card-box button" style="margin-left:5px; margin-right:5px;">
									<div class="card">
										<div class="card-body">
												<div class="tool_name" style="display:flex; justify-content:center; align-items: center; font-size:20px;">${settingVO.tool_name_1}</div>
										</div>
									</div>
								</div>
								<div style="display:flex; justify-content: center; align-content: center;">
									<button id="erase_tool_1" style="background: transparent; border: none; padding: 0; cursor: pointer; outline: none;">
										<i style="font-size:20px; color:gray;" class="fa-solid fa-circle-minus"></i>
									</button>
								</div>
							</div>
							
							<div style="display:flex; flex:0.5; width:100%; justify-content: flex-start; align-content: center;">
								<div id="tool_2" data-tool_id="${settingVO.tool_id_2}" class="card-box button" style="margin-left:5px; margin-right:5px;">
									<div class="card">
										<div class="card-body">
												<div class="tool_name" style="display:flex; justify-content:center; align-items: center; font-size:20px;">${settingVO.tool_name_2}</div>
										</div>
									</div>
								</div>
								<div style="display:flex; justify-content: center; align-content: center;">
									<button id="erase_tool_2" style="background: transparent; border: none; padding: 0; cursor: pointer; outline: none;">
										<i style="font-size:20px; color:gray;" class="fa-solid fa-circle-minus"></i>
									</button>
								</div>
							</div>
						</div>
						<div style="display:flex; flex:1; width:100%;">
							<div style="display:flex; flex:0.5; width:100%; justify-content: flex-start; align-content: center;">
								<div id="tool_3" data-tool_id="${settingVO.tool_id_3}" class="card-box button" style="margin-left:5px; margin-right:5px;">
									<div class="card">
										<div class="card-body">
												<div class="tool_name" style="display:flex; justify-content:center; align-items: center; font-size:20px;">${settingVO.tool_name_3}</div>
										</div>
									</div>
								</div>
								<div style="display:flex; justify-content: center; align-content: center;">
									<button id="erase_tool_3" style="background: transparent; border: none; padding: 0; cursor: pointer; outline: none;">
										<i style="font-size:20px; color:gray;" class="fa-solid fa-circle-minus"></i>
									</button>
								</div>
							</div>
							<div style="display:flex; flex:0.5; width:100%; justify-content: flex-start; align-content: center;">
								<div id="tool_4" data-tool_id="${settingVO.tool_id_4}" class="card-box button" style="margin-left:5px; margin-right:5px;">
									<div class="card">
										<div class="card-body">
												<div class="tool_name" style="display:flex; justify-content:center; align-items: center; font-size:20px;">${settingVO.tool_name_4}</div>
										</div>
									</div>
								</div>
								<div style="display:flex; justify-content: center; align-content: center;">
									<button id="erase_tool_4" style="background: transparent; border: none; padding: 0; cursor: pointer; outline: none;">
										<i style="font-size:20px; color:gray;" class="fa-solid fa-circle-minus"></i>
									</button>
								</div>
							</div>
						</div>
						<div style="display:flex; flex:1; width:100%;">
							<div id="setting_search_form" class="input-group" style="height:40px; display:flex; justify-content: center; align-content: center; position: relative; padding: 0px !importatn; margin:0px !important; width:600px !important; padding:0 20px;">
								<i style="text-align:center; line-height:40px; font-size:20px; margin-right:10px;" class="fa fa-search search-icon"></i>
								<input
								type="text"
								placeholder="두글자 이상의 검색어를 입력하세요."
								class="form-control"
								id="searchInput"
								oninput="tool_search(this.value)"
								style="text-align:left; line-height:40px; border:none; border-bottom: 1px solid rgba(0,0,0,0.1); margin-right:20px;"
								/>
							</div>
						</div>
					</div>
					
					<div id="tool_search_result" style="display:flex; flex-direction:column; flex:0.4; width:100%; overflow-y: auto;">
						
					</div>
					<input id="tool_selected" type="hidden">
					<div style="display:flex; flex:0.1; width:100%; align-content: center;">
                        <div id="update_setting" class="input-group" style="width:100%; border:none; margin:10px;">
	                         <button
	                         class="btn btn-black btn-border"
	                         type="submit"
	                         style="width:100%; border:none !important; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);"
	                         >
	                       	  수정하기
	                         </button>
                        </div>
					</div>
				</div>	
			</div>	
			<!-- 설정창 -->
		</div>
	</div>
</div>
<!-- header end -->
<!-- contents start -->
<div class="contents-box" style="display:flex; flex-direction:column; justify-content: space-between; width: 100%; box-sizing: border-box; flex:0.9;">
	
	<!-- 중단 -->
	<div style="flex:0.2; display: flex; justify-content: space-between; align-content: center; margin-top: 10px;">
		<div style="flex:0.3;">
			<div id="main-notify-box" style="width:100%; height:100%; display:flex; flex-direction:column;">
				<div class="main-box-title">
					<div class="run">
					공지사항
					</div>
				</div>
				<div class="main-box-body" style="display:flex; flex-direction:column;">
					<div></div>
					<div></div>
				</div>
			</div>		
		</div>
		<div style="flex:0.3;">
			<div id="main-board-box" style="width:100%; height:100%; display:flex; flex-direction:column;">
				<div class="main-box-title">
					<div style="box-shadow: 2px 0px 2px 1px rgba(0, 0, 0, 0.4);">교육 일정</div>
					<div style="box-shadow: 2px 0px 2px 1px rgba(0, 0, 0, 0.4);">우수 사원</div>
				</div>
				<div class="main-box-body" style="display:flex; flex-direction:column;">
					<div></div>
					<div></div>
				</div>
			</div>	
		</div>
		<div style="flex:0.25;">
			<div class="card-box" style="width:100%; height:130%;">
				<div class="card" style="width:96%; height:94%;">
					<div id="main-info-box" style="width:100%; height:100%; display:flex; flex-direction:column;">
						<div style="width:100%; height:100%; display:flex; flex-direction:column;">
							<div style="flex:1; display:flex; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);">
								<div style="flex:0.4;">
								<img src="" style="border:1px solid black; height: 100%; object-fit: cover; width: auto; border-radius: 50%;">
								</div>
								<div style="flex:0.6; display:flex; flex-direction:column; font-size:16px;">
									<div style="flex:1; display:flex; align-items: flex-end; justify-content: flex-start;">
										${memberVO.emp_bnum}
									</div>
									<div style="flex:1; display:flex; align-items: center; justify-content: flex-start;">
										${memberVO.emp_dnum} ${memberVO.emp_position} ${memberVO.emp_job}
									</div>
									<div style="flex:1; display:flex; align-items: flex-start; justify-content: flex-start; font-size:20px;">
										${memberVO.emp_name}
									</div>
								</div>
							</div>
							<div style="flex:1; display:flex; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);">
								<div style="flex:0.45; display:flex; flex-direction:column; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);">
									<div style="flex:1; display:flex; flex-direction:column; align-items: center; justify-content: flex-start;">
										<div style="flex:1; display:flex; align-items: flex-end; justify-content: flex-start; text-align: left;">
											<i id = "unread_message_main_badge" class="fa-solid fa-message" style="line-height:25px; font-size:15px; padding-right:10px;"></i>
											 읽지 않은 메세지 :
										</div>
										<div id = "unread_message_main" style="flex:1; display:flex; align-items: flex-start;">
										</div>
									</div>
										<div style="flex:1; display:flex; flex-direction:column; align-items: center; justify-content: flex-start;">
											<div style="flex:1; display:flex; align-items: flex-end; justify-content: flex-start; text-align: left;">
												<i id = "unread_workflow_main_badge" class="fa-solid fa-bell" style="line-height:25px; font-size:15px; padding-right:10px;"></i>
												 받은 승인요청 :
											</div>
												<div id = "unread_workflow_main" style="flex:1; display:flex; align-items: flex-start;">
												</div>
										</div>
								</div>
								<div style="flex:0.55; padding:10px 0px 0px 30px;">
								<i class="fa-solid fa-list" style="font-size:15px; padding-right:10px;"></i>
								오늘의 일정
								</div>
							</div>
						</div>
					</div>	
				</div>	
			</div>	
		</div>
	</div>
	<!-- 중단 -->
	
	<!-- 최하단 -->
	<div style="flex:0.8; display: flex; justify-content: space-between; margin-top: 10px;">
	
		<%@ include file="/resources/assets/inc/messenger.jsp" %>
		
		<div class="col-md-4" style="display:flex; flex-direction:column; justify-content: flex-end;  align-content: flex-end;">
			<div class="card-box md">
				<div class="card">
					<div class="card-header">
					<h4 class="card-title">WORKFLOWS</h4>
					</div>	
					<div class="card-body">
                    <div class="workflow_table" style="height:500px; overflow-y: auto; overflow-x: hidden;">
                      <table class="display table table-striped table-hover multi-filter-select">
                        <thead style="position: sticky; top: 0; z-index: 3 ; box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1);">
                          <tr>
                            <th style="width: 3%;">NUM</th>
                            <th style="width: 3%;">TYPE</th>
                            <th style="width: 50%;">TITLE</th>
                            <th style="width: 18%;">RECEIVER</th>
                            <th style="width: 3%;">STATUS</th>
                            <th style="width: 23%;">DATE</th>
                          </tr>
                        </thead>
                        <tfoot>
                        </tfoot>
                        <tbody class="workflow_modal">
                          <c:forEach var="workflow" items="${receivedWorkflowList}">
					        <tr>
					            <td style="text-align: center;">
					            	<a data-wf_code="${workflow.wf_code}" id="workflow_info">
					            		${workflow.wf_code}
					            	</a>
					            </td>
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
					            		${workflow.wf_status}
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
		</div>
		
		<%@ include file="/resources/assets/inc/calendar.jsp" %>
		
	</div>
	<!-- 최하단 -->
</div>
<!-- contents end -->
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
	
	<c:if test="${logined == true}">
	  	<%@ include file="/resources/assets/inc/login_alarm_modal.jsp" %>
	</c:if>
	
	<%@ include file="/resources/assets/inc/game.jsp" %>
	
	<script>
	document.getElementById("open_calendar").style.display = 'flex';
	document.getElementById("open_messenger").style.display = 'flex';
	
	$(document).on('click', '#easter_egg', function (e) {
		$('#game').modal('show');
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</script>
	
	</body>
</html>
