<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="${pageContext.request.contextPath }/resources/assets/js/navbar.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/js/search.js"></script>

  	<c:if test="${empty sessionScope.emp_id}">
	    <script type="text/javascript">
	   		alert("로그인 정보가 없습니다. 로그인 페이지로 이동합니다.");
	        window.location.href = "/member/login";
	    </script>
	</c:if>
	
		  <!-- Navbar Header -->
          <nav class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom" style="position: relative; background-color: rgba(0,0,0,0.8)">
           	<!-- 알람 확장 -->
           	
           	<%
			    String currentURI = request.getRequestURI(); // 현재 URL 가져오기
			%>
			
			<% if (!currentURI.contains("main")) { %>
			    <%@ include file="/resources/assets/inc/messenger.jsp" %>
			<% } %>
			
			<% if (!currentURI.contains("main")) { %>
			    <%@ include file="/resources/assets/inc/calendar.jsp" %>
			<% } %>
			
           	<div id="extended_navbar">
	           	<div id="extended_navbar_inner">
	           	</div>
           	</div>
           	<!-- 알람 확장 -->
            <div class="container-fluid" >
              <!-- 검색창 -->
              <nav class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex">
				<div id="search_form" class="input-group" style="position: relative; padding: 0px !importatn; margin:0px !important; width:600px !important;">
					<div class="input-group-prepend">
						<button type="submit" class="btn btn-search pe-1">
							<i class="fa fa-search search-icon"></i>
						</button>
					</div>
						<input
						type="text"
						placeholder="Search ..."
						class="form-control"
						id="searchInput"
						oninput="search(this.value)"
						/>
					<div id="search_form_extended">
						<ul id="search_notify" style="font-size: 12px;">
							<li>두글자 이상의 검색어를 입력 해주세요.</li>
						</ul>
						<ul id="search_incorrect" style="display:none; font-size: 12px;">
							<li>올바른 검색어를 입력 해주세요.</li>
						</ul>
						<ul id="search_history" style="font-size: 12px;">
						</ul>
						<ul id="search_employees">
						</ul>
						<ul id="search_null" style="font-size: 12px; display:none;">
							<li></li>
						</ul>
					</div>
				</div>
              </nav>
              <!-- 검색창 -->
              
			  <!-- 드롭다운 메뉴들 -->
              <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
              	<!-- 아이콘1 -->
                <li style="margin-right:30px;" id="to_home" class="nav-item topbar-icon dropdown hidden-caret">
                 	<button type="button" style="border: none !important;">
                 		<a href='/main/home'>
                 			<i style="color:white; font-size:20px;" class="fa-solid fa-house"></i>
                 		</a>
					</button>
                </li>
                <!-- 아이콘1 -->
              	<!-- 아이콘1 -->
                <li style="margin-right:30px;" id="extend_calendar" class="nav-item topbar-icon dropdown hidden-caret">
                 	<button type="button" style="border: none !important;">
                 		<i style="color:white; font-size:20px;" class="fa-solid fa-calendar"></i>
					</button>
                </li>
                <!-- 아이콘1 -->
                
                <!-- 아이콘2 -->
                 <li style="margin-right:30px;" id="extend_messenger" class="nav-item topbar-icon dropdown hidden-caret">
                 	<button type="button" style="border: none !important;">
                 		<i id="alarm_message" style="color:white; font-size:20px;" class="fa-solid fa-comments"></i>
					</button>
                    <span id = "alarm_message_badge" class="badge"></span>
                </li>
                <!-- 아이콘2 -->
                
                <!-- 아이콘3 -->
                <li style="margin-right:30px;" id="extend_workflowAlarm" class="nav-item topbar-icon dropdown hidden-caret">
                    <button type="button" style="border: none !important;">
                    	<i id="alarm_workflow" style="color:white; font-size:20px;" class="fa-solid fa-bell"></i>
					</button>
                    <span id = "alarm_workflow_badge" class="badge"></span>
                </li>
                <!-- 아이콘3 -->
                
				<!-- 개인프로필 -->
                <li class="nav-item topbar-user dropdown hidden-caret">
               			 <img
                              src="${emp_profile}"
                              style="width: 30px; height: 30px; border-radius: 50%;"
                            />
                    <span class="profile-username" style="color:white;">
                      <span class="op-7" style="color:white;">안녕하세요, </span>
                      <span class="fw-bold" style="color:white;">${emp_name}</span>
                      <span class="op-7" style="color:white;"> 님!</span>
                    </span>
                </li>
                <!-- 개인프로필 -->
                <!-- 아이콘1 -->
                <li style="margin-left:20px; margin-right:5px;" id="log_out" class="nav-item topbar-icon dropdown hidden-caret">
                 	<a href="/main/logout" method="POST">
	                 	<button type="button" style="border: none !important;">
	                 		<i style="color:white; font-size:20px;" class="fa-solid fa-circle-xmark"></i>
						</button>
					</a>
					
                </li>
                <!-- 아이콘1 -->
                
              </ul>
              <!-- 드롭다운 메뉴들 -->
              	
            </div>
          </nav>
          <!-- End Navbar -->