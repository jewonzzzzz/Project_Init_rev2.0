<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>    
    
<script src="${pageContext.request.contextPath }/resources/assets/js/calendar.js"></script>

<div id="open_calendar" class="col-md-3" style="display:none; flex-direction:column; justify-content: flex-end;  align-content: flex-end;">
	<div class="card-box" style="height:600px;">
		<div class="card" style="width:96%; height:96%; margin:0px;">
			<div class="card-header">
			<h4 class="card-title">CALENDAR</h4>
			</div>	
			<div class="calendar-container">
				<div class="calendar-head">
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
			    </div>
			    <div class="calendar-body">
			        <!-- 날짜를 여기 표시 -->
			        <div class="days sunday" id="d_1"></div>
			        <div class="days" id="d_2"></div>
			        <div class="days" id="d_3"></div>
			        <div class="days" id="d_4"></div>
			        <div class="days" id="d_5"></div>
			        <div class="days" id="d_6"></div>
			        <div class="days saturday" id="d_7"></div>
			        <div class="days sunday" id="d_8"></div>
			        <div class="days" id="d_9"></div>
			        <div class="days" id="d_10"></div>
			        <div class="days" id="d_11"></div>
			        <div class="days" id="d_12"></div>
			        <div class="days" id="d_13"></div>
			        <div class="days saturday" id="d_14"></div>
			        <div class="days sunday" id="d_15"></div>
			        <div class="days" id="d_16"></div>
			        <div class="days" id="d_17"></div>
			        <div class="days" id="d_18"></div>
			        <div class="days" id="d_19"></div>
			        <div class="days" id="d_20"></div>
			        <div class="days saturday" id="d_21"></div>
			        <div class="days sunday" id="d_22"></div>
			        <div class="days" id="d_23"></div>
			        <div class="days" id="d_24"></div>
			        <div class="days" id="d_25"></div>
			        <div class="days" id="d_26"></div>
			        <div class="days" id="d_27"></div>
			        <div class="days saturday" id="d_28"></div>
			        <div class="days sunday" id="d_29"></div>
			        <div class="days" id="d_30"></div>
			        <div class="days" id="d_31"></div>
			        <div class="days" id="d_32"></div>
			        <div class="days" id="d_33"></div>
			        <div class="days" id="d_34"></div>
			        <div class="days saturday" id="d_35"></div>
			        <div class="days sunday" id="d_36"></div>
			        <div class="days" id="d_37"></div>
			        <div class="days" id="d_38"></div>
			        <div class="days" id="d_39"></div>
			        <div class="days" id="d_40"></div>
			        <div class="days" id="d_42"></div>
			        <div class="days" id="d_43"></div>
			    </div>
			</div>

		</div>
	</div>
</div>