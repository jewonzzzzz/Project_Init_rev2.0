<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath }/resources/assets/js/realtime_alarm.js"></script>

<!-- received alarm start -->
<div id="received_alarm" class="realtime_alarm">
	<div class="alarm_inner_box">
		<a data-wf_code="" id="workflow_info">
			<div style="display:flex; flex-direction: column; width:100%; height:100%;">
		  		<div style="display:flex; flex-direction: column; flex:0.4; border-bottom: 1px solid rgba(0,0,0,0.9); padding-bottom: 10px;">
		  			<div id="realtimeAlarm_date" style="display:flex; flex:1; justify-content: flex-end; align-items: flex-start;">
		  			</div>
		  			<div style="display:flex; flex:1; justify-content: flex-start; align-items: center; text-align: left;">
		  				새로운 승인 요청이 있습니다!
		  			</div>
		  		</div>
		  		<div style="display:flex; flex:0.6; padding-top: 10px;">
		  			<div id="realtimeAlarm_sender_profile" style="display: flex; align-items: center; justify-content: center; flex:3;">
		  				<img src=""
						style="width: 40px; height: 40px; border-radius: 50%;">
		  			</div>
		  			<div style="display:flex; flex-direction: column; flex:7;">
		  				<div style="display:flex; flex:3; align-items: center;">
		  					<div style="flex:1; text-align: center; display:flex;">
		  						<div style="flex:0.4; font-weight: bold;">유형</div>
		  						<div id="realtimeAlarm_wf_type" style="flex:0.6"></div>
		  					</div>
		  					<div style="flex:1; text-align: center; display:flex;">
		  						<div style="flex:0.4; font-weight: bold;">상태</div>
		  						<div id="realtimeAlarm_wf_progress" style="flex:0.6"></div>
		  					</div>
		  				</div>
		  				<div id="realtimeAlarm_wf_title" style="display: flex; align-items: center; flex:7; "></div>
		  			</div>
		  		</div>
		  	</div>
		</a>
  	</div>
</div>
<!-- received alarm end-->
<!-- sent alarm start -->
<div id="sent_alarm" class="realtime_alarm" style="box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2); animation: focus 0.5s infinite;">
	<div class="alarm_inner_box">
		<a data-wf_code="" id="workflow_info">
			<div style="display:flex; flex-direction: column; width:100%; height:100%;">
				<div style="display:flex; flex-direction: column; flex:0.4; border-bottom: 1px solid rgba(0,0,0,0.9); padding-bottom: 10px;">
					<div id="realtimeAlarm_date" style="display:flex; flex:1; justify-content: flex-end; align-items: flex-start;">
					</div>
					<div style="display:flex; flex:1; justify-content: flex-start; align-items: center; text-align: left;">
						발송하신 요청에 대한 새로운 응답이 있습니다!
					</div>
				</div>
				<div style="display:flex; flex:0.6; padding-top: 10px;">
					<div style="display:flex; flex-direction: column; flex:5;">
						<div style="display:flex; flex:3; align-items: center;">
							<div style="flex:1; text-align: center; display:flex;">
								<div style="flex:0.4; font-weight: bold;">유형</div>
								<div id="realtimeAlarm_wf_type" style="flex:0.6"></div>
							</div>
							<div style="flex:1; text-align: center; display:flex;">
								<div style="flex:0.4; font-weight: bold;">상태</div>
								<div id="realtimeAlarm_wf_progress" style="flex:0.6"></div>
							</div>
						</div>
						<div id="realtimeAlarm_wf_title" style="display: flex; align-items: center; flex:7; "></div>
					</div>
					<div id="results" style="display: flex; justify-content: center; flex:5; flex-direction: column;">
						<div style="display: flex; flex:1;">
							<div style="flex:0.6; font-weight: bold; text-align: center;">1차 승인결과 :</div>
							<div id="realtimeAlarm_wf_result_1st" style="flex:0.4; text-align: center;"></div>
						</div>
						<div style="display: flex; flex:1;">
							<div style="flex:0.6; font-weight: bold; text-align: center;">2차 승인결과 :</div>
							<div id="realtimeAlarm_wf_result_2nd" style="flex:0.4; text-align: center;"></div>
						</div>
						<div style="display: flex; flex:1;">
							<div style="flex:0.6; font-weight: bold; text-align: center;">3차 승인결과 :</div>
							<div id="realtimeAlarm_wf_result_3rd" style="flex:0.4; text-align: center;"></div>
						</div>
					</div>
				</div>
			</div>
		</a>
	</div>
</div>
<!-- sent alarm end-->
<!-- message alarm start-->
<div id="message_alarm" class="realtime_alarm left_down" style="box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2); animation: focus 0.5s infinite; height:100px;">
	<div class="alarm_inner_box" style="display:flex; justify-content: center; align-items: center; padding:5px;">
		<div style="display:flex; justify-content: center; align-items: center; width: 100%; height:100%; margin:0px; box-sizing: border-box; overflow-x: hidden;">
			<div id="message_alarm_msg_sender_emp_profile" style="flex:0.2; display:flex; height:100%; justify-content: center; align-items: center;">
			</div>
			<div style="flex:0.8; display:flex; height:100%; flex-direction:column; justify-content: center; align-items: center;">
				<div style="flex:0.3; display:flex; width: 100%; box-sizing: border-box; justify-content: flex-start; align-items: center;">
					<div id="message_alarm_room_name" style="font-size:15px; font-weight:bold; width:100%; height:100%; width: 100%; box-sizing: border-box; display:flex; justify-content: flex-start; align-items: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
					</div>
				</div>
				<div style="flex:0.2; display:flex; width:100%; justify-content: flex-start; align-items: center;">
					<div id="message_alarm_msg_sender" style="font-size:12px; flex:1; height:100%; display:flex; justify-content: flex-start; align-items: center;">
					</div>
					<div id="message_alarm_msg_date" style="font-size:12px; flex:1; height:100%; display:flex; justify-content: flex-end; align-items: center;">
					</div>
				</div>
				<div id="message_alarm_msg_content" style="font-size:12px; flex:0.5; width:100%; display:flex; box-sizing: border-box; justify-content: flex-start; align-items: center; text-align:left; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp: 2; line-clamp: 2;">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- message alarm end-->
