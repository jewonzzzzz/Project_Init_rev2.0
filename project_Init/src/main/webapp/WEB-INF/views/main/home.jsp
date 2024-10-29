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
          <div class="page-inner" style="background-color : rgba(250,250,250,0.7); padding-top:10px; height: 85vh; display:flex; flex-direction:column; justify-content: space-between; align-content: flex-end;">
<!------------------------------------------------------------------------------------------------------------------>
<!-- header start -->
<div class="header-box" style="display:flex; width: 100%; flex:0.05; box-sizing: border-box; justify-content: flex-end;">
	<div style="display: flex; flex:0.6; justify-content: flex-end;">
		<div class="card-box button ${empty settingVO.tool_name_1 ? 'extend_user_setting' : ''}">
			<div class="card">
				<div class="card-body">
					<a class="tool_name" style="display:flex; justify-content:center; align-items: center;" href="${empty settingVO.tool_url_1 ? '#' : settingVO.tool_url_1}">
						${empty settingVO.tool_name_1 ? '+' : settingVO.tool_name_1}
					</a>
				</div>
			</div>
		</div>
		<div class="card-box button ${empty settingVO.tool_name_2 ? 'extend_user_setting' : ''}">
			<div class="card">
				<div class="card-body">
					<a class="tool_name" style="display:flex; justify-content:center; align-items: center;" href="${empty settingVO.tool_url_2 ? '#' : settingVO.tool_url_2}">
						${empty settingVO.tool_name_2 ? '+' : settingVO.tool_name_2}
					</a>
				</div>
			</div>
		</div>
		<div class="card-box button ${empty settingVO.tool_name_3 ? 'extend_user_setting' : ''}">
			<div class="card">
				<div class="card-body">
					<a class="tool_name" style="display:flex; justify-content:center; align-items: center;" href="${empty settingVO.tool_url_3 ? '#' : settingVO.tool_url_3}">
						${empty settingVO.tool_name_3 ? '+' : settingVO.tool_name_3}
					</a>
				</div>
			</div>
		</div>
		<div class="card-box button ${empty settingVO.tool_name_4 ? 'extend_user_setting' : ''}">
			<div class="card">
				<div class="card-body">
					<a class="tool_name" style="display:flex; justify-content:center; align-items: center;" href="${empty settingVO.tool_url_4 ? '#' : settingVO.tool_url_4}">
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
				<div class="card" style="width:97%; height:97%; display:flex; flex-direction: column; justify-content: flex-start; align-content: center;">
					<div style="display:flex; flex-direction: column; flex:0.5; width:100%;">
						<div style="display:flex; flex:1; width:100%;">
						
							<div style="display:flex; flex:0.5; width:100%; justify-content: center; align-items: center;">
								<div id="tool_1" data-tool_id="${settingVO.tool_id_1}" class="card-box button tools" style="margin-left:5px; margin-right:5px; display:flex; justify-content: center; align-content: center;">
									<div class="card">
										<div class="card-body">
											<div class="tool_name" style="display:flex; justify-content:center; align-items: center;">${settingVO.tool_name_1}</div>
										</div>
									</div>
								</div>
								<div style="display:flex; justify-content: center; align-content: center;">
									<button id="erase_tool_1" style="background: transparent; border: none; padding: 0; cursor: pointer; outline: none;">
										<i style="font-size:20px; color:gray;" class="fa-solid fa-circle-minus"></i>
									</button>
								</div>
							</div>
							
							<div style="display:flex; flex:0.5; width:100%; justify-content: center; align-items: center;">
								<div id="tool_2" data-tool_id="${settingVO.tool_id_2}" class="card-box button" style="margin-left:5px; margin-right:5px; display:flex; justify-content: center; align-content: center;">
									<div class="card">
										<div class="card-body">
											<div class="tool_name" style="display:flex; justify-content:center; align-items: center;">${settingVO.tool_name_2}</div>
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
							<div style="display:flex; flex:0.5; width:100%; justify-content: center; align-items: center;">
								<div id="tool_3" data-tool_id="${settingVO.tool_id_3}" class="card-box button" style="margin-left:5px; margin-right:5px; display:flex; justify-content: center; align-content: center;">
									<div class="card">
										<div class="card-body">
											<div class="tool_name" style="display:flex; justify-content:center; align-items: center;">${settingVO.tool_name_3}</div>
										</div>
									</div>
								</div>
								<div style="display:flex; justify-content: center; align-content: center;">
									<button id="erase_tool_3" style="background: transparent; border: none; padding: 0; cursor: pointer; outline: none;">
										<i style="font-size:20px; color:gray;" class="fa-solid fa-circle-minus"></i>
									</button>
								</div>
							</div>
							<div style="display:flex; flex:0.5; width:100%; justify-content: center; align-items: center;">
								<div id="tool_4" data-tool_id="${settingVO.tool_id_4}" class="card-box button" style="margin-left:5px; margin-right:5px; display:flex; justify-content: center; align-content: center;">
									<div class="card">
										<div class="card-body">
											<div class="tool_name" style="display:flex; justify-content:center; align-items: center;">${settingVO.tool_name_4}</div>
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
<div class="contents-box" style="display:flex; flex-direction:column; justify-content: flex-start; width: 100%; box-sizing: border-box; flex:0.95; ">
	
	<!-- 중단 -->
	<div style="flex:0.2; display: flex; justify-content: space-between; align-content: center; margin-top: 10px; position:relative; overflow: visible;">
		<div style="width:500px; position: relative; top:-20px;">
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
		<div style="width:500px; position: relative; top:-20px;">
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
		<div style="width:500px;  position: relative; z-index: 10; height:200px;">
			<div class="card-box" style="width:100%; height:122%;">
				<div class="card" style="width:96%; height:94%;">
					<div id="main-info-box" style="width:100%; height:100%; display:flex; flex-direction:column;">
						<div style="width:100%; height:100%; display:flex; flex-direction:column;">
							<div style="flex:1; display:flex; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);">
								<div style="flex:0.4;">
								<img src="" style="border:1px solid black; height: 100%; object-fit: cover; width: auto; border-radius: 50%;">
								</div>
								<div style="flex:0.6; display:flex; flex-direction:column; font-size:14px;">
									<div style="flex:1; display:flex; align-items: flex-end; justify-content: flex-start;">
										${memberVO.emp_bnum}
									</div>
									<div style="flex:1; display:flex; align-items: center; justify-content: flex-start;">
										${memberVO.emp_dname} ${memberVO.emp_position} ${memberVO.emp_job}
									</div>
									<div style="flex:1; display:flex; align-items: flex-start; justify-content: flex-start; font-size:16px;">
										${memberVO.emp_name}
									</div>
								</div>
							</div>
							<div style="flex:1; display:flex;">
								<div style="flex:0.45; display:flex; flex-direction:column;">
									<div style="flex:1; display:flex; flex-direction:column; align-items: center; justify-content: flex-start;">
										<div style="flex:1; display:flex; align-items: flex-end; justify-content: flex-start; text-align: left;">
											<i id = "unread_message_main_badge" class="fa-solid fa-message" style="line-height:25px; font-size:15px; padding-right:10px;"></i>
											 읽지 않은 메세지 :
										</div>
										<div id = "unread_message_main" style="flex:1; display:flex; align-items: flex-start; font-size:12px;">
										</div>
									</div>
										<div style="flex:1; display:flex; flex-direction:column; align-items: center; justify-content: flex-start;">
											<div style="flex:1; display:flex; align-items: flex-end; justify-content: flex-start; text-align: left;">
												<i id = "unread_workflow_main_badge" class="fa-solid fa-bell" style="line-height:25px; font-size:15px; padding-right:10px;"></i>
												 받은 승인요청 :
											</div>
												<div id = "unread_workflow_main" style="flex:1; display:flex; align-items: flex-start; font-size:12px;">
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
	<div style="flex:0.6; display: flex; justify-content: space-between; margin-top: 10px;">
	
		<%@ include file="/resources/assets/inc/messenger.jsp" %>
		
		<div class="card-box md" style="height:500px !important; width:500px; display:flex; flex-direction: column;">
			<div class="card">
				<div class="card-header" style="flex:0.1; z-index: 20 ;">
				<h4 class="card-title">WORKFLOWS</h4>
				</div>	
				<div class="card-body" style="flex:0.9; width:100%; overflow-y: auto;">
                    <div class="workflow_table" style="width:100%; height:100%; overflow-x: hidden;"> 	
                      <table class="display table table-striped table-hover multi-filter-select" style="width:485px;">
                        <thead style="position: sticky; top: 0; z-index: 10 ; box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1); width:100%; font-size:12px; background-color:white !important;">
                          <tr style="width:100%; padding-left:5px !important; padding-right:5px !important;">
                            <th style="width: 5%; font-size:12px; padding-left:5px !important; padding-right:5px !important;">유형</th>
                            <th style="width: 40%; font-size:12px; padding-left:5px !important; padding-right:5px !important;">제목</th>
                            <th style="width: 5%; font-size:12px; padding-left:5px !important; padding-right:5px !important;">발신자</th>
                            <th style="width: 20%; font-size:12px; padding-left:5px !important; padding-right:5px !important;">상태</th>
                            <th style="width: 20%; font-size:12px; padding-left:5px !important; padding-right:5px !important;">수신일</th>
                          </tr>
                        </thead>
                        <tfoot>
                        </tfoot>
                        <tbody class="workflow_modal" style="width:100%;">
                          <c:forEach var="workflow" items="${receivedWorkflowList}">
					        <tr style="width:100%; padding:0 !important; height:35px !important; line-height:35px;">
					            <td style="text-align: center; font-size:10px; padding:0px !important;">
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info" style="padding:0; height:20px; line-height:20px;">
						            	${workflow.wf_type}
						            </a>
						        </td>
					            <td style="font-size:10px; padding:0px !important;">
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info" style="padding:0; height:20px; line-height:20px;">
			                        	${workflow.wf_title}
			                        </a>
		                        </td>
					            <td style="text-align: center; font-size:10px; padding:0px !important;">
						            <a data-wf_code="${workflow.wf_code}" id="workflow_info" style="padding:0; height:20px; line-height:20px;">
						            	${workflow.sender_name}
						            </a>
					            </td>
					            <td style="text-align: center; font-size:10px; padding:0px !important;">
					            	<a data-wf_code="${workflow.wf_code}" id="workflow_info" style="padding:0; height:20px; line-height:20px;">
					            		<c:choose>
								            <c:when test="${workflow.wf_status == 1}">
								                1차 승인 대기
								            </c:when>
								            <c:when test="${workflow.wf_status == 2}">
								                2차 승인 대기
								            </c:when>
								            <c:when test="${workflow.wf_status == 3}">
								                3차 승인 대기
								            </c:when>
								        </c:choose>
					            	</a>
					            </td>
					            <td style="text-align: center; font-size:10px; padding:0px !important;">
					            	<a data-wf_code="${workflow.wf_code}" id="workflow_info" style="padding:0; height:20px; line-height:20px;">
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
		<div style="height:500px !important; width:500px; display:flex; flex-direction: column; justify-content: flex-end;" >
		<%@ include file="/resources/assets/inc/calendar.jsp" %>
		</div>
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
