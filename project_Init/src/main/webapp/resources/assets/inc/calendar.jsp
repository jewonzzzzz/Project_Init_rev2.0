<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>    
    
<script src="${pageContext.request.contextPath }/resources/assets/js/calendar.js"></script>

<div id="open_calendar" class="card-box" style="display:none; flex-direction:column; height:450px !important; width:500px;">
	<div class="card" style="width:96%; height:96%; margin:0px;">
		<div class="calendar-container" style="flex:0.9;">
			<div class="calendar-head" style="height:80px;">
				<div class="year_month">
				    <div class="year">
				        <button id="prevYear">
				        	<i class="fas fa-angle-double-left"></i>
				        </button>
				        	<span id="year"></span>
				        <button id="nextYear">
				        	<i class="fas fa-angle-double-right"></i>
				        </button>
				    </div>
				    <div class="month">
				        <button id="prevMonth">
				        	<i class="fas fa-angle-left"></i>
				        </button>
				        	<span id="month"></span> 월
				        <button id="nextMonth">
				        	<i class="fas fa-angle-right"></i>
				        </button>
				    </div>
			    </div>
			    <div class="day">
			       		<span id="day"></span> 일
			    </div>
			    <div class="time">
				    <%
					    Date now = new Date();
					    SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
					    String currentTime = formatter.format(now);
					%>
			    	 <%= currentTime %>
			    </div>
			    <input type="hidden" id="asdasd"/>
		    </div>
		    <div class="calendar-body">
		        <!-- 날짜를 여기 표시 -->
		        <div class="days 1 sunday" id="d_1">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 2" id="d_2">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 3" id="d_3">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 4" id="d_4">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 5" id="d_5">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 6" id="d_6">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 7 saturday" id="d_7">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 8 sunday" id="d_8">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 9" id="d_9">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 10" id="d_10">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 11" id="d_11">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 12" id="d_12">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 13" id="d_13">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 14 saturday" id="d_14">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 15 sunday" id="d_15">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 16" id="d_16">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 17" id="d_17">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 18" id="d_18">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 19" id="d_19">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 20" id="d_20">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 21 saturday" id="d_21">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 22 sunday" id="d_22">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 23" id="d_23">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 24" id="d_24">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 25" id="d_25">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 26" id="d_26">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 27" id="d_27">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 28 saturday" id="d_28">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 29 sunday" id="d_29">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 30" id="d_30">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 31" id="d_31">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 32" id="d_32">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 33" id="d_33">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 34" id="d_34">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 35 saturday" id="d_35">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 36 sunday" id="d_36">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 37" id="d_37">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 38" id="d_38">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 39" id="d_39">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 40" id="d_40">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 41" id="d_41">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		        <div class="days 42" id="d_42">
		        	<div class="flag presence" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info presence"></div>
            		</div>
		        	<div class="flag s_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info s_workflow"></div>
            		</div>
            		<div class="flag r_workflow" >
            			<i class="fa-solid fa-bookmark"></i>
            			<div class="calendar_info r_workflow"></div>
            		</div>
		        </div>
		    </div>
		</div>
	</div>
</div>
