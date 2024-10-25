$(document).ready(function () {
	
	// 페이지를 종료할 때만 로그아웃 요청을 보내기 위한 변수
	let isPageClosed = false;

	// 페이지 종료를 감지하는 이벤트
	window.addEventListener('beforeunload', function (e) {
	    // 페이지가 종료될 때만 로그아웃 요청
	    if (isPageClosed) {
	        navigator.sendBeacon('/work/logout');
	    }
	});

	// 페이지가 종료되었음을 나타내는 이벤트
	window.addEventListener('unload', function () {
	    isPageClosed = true;  // 페이지 종료 상태로 변경
	});

	// 링크 클릭 등으로 다른 페이지로 이동할 때 로그아웃 요청을 방지
	window.addEventListener('click', function (e) {
	    const target = e.target.closest('a'); // 클릭한 요소가 링크인지 확인
	    if (target && target.tagName === 'A') {
	        isPageClosed = false;  // 페이지가 이동하는 것이므로 종료 상태를 false로 설정
	    }
	});
	
	checkAlarm();
	setInterval(checkAlarm, 10000);
	
	function checkAlarm() {
		$.ajax({
	        url: '/main/checkAlarm',
			type: 'GET',
	        success: function(data) {
	        	console.log('checked Alarm : ', data);
	        	
	        	if(data.smallAlarm>0){
	        		$('#alarm_workflow').addClass('shake');
	        		$('#alarm_workflow_badge').text(data.smallAlarm);
	        		$('#alarm_workflow_badge').addClass('twinkle');
	        		$('#unread_workflow_main').html(`<a href="/work/workflow">${data.smallAlarm} 개의 받은 승인요청이 있습니다.</a>`);
	        		$('#unread_workflow_main_badge').addClass('twinkle_inner');
	        	}else{
	        		$('#alarm_workflow').removeClass('shake');
	        		$('#alarm_workflow_badge').empty();
	        		$('#alarm_workflow_badge').removeClass('twinkle');
	        		$('#unread_workflow_main').text('승인하지 않은 요청이 없습니다.');
	        		$('#unread_workflow_main_badge').removeClass('twinkle_inner');
	        	} 
	        	
	        	if(data.messageAlarmCount>0){
	        		$('#alarm_message').addClass('shake');
	        		$('#alarm_message_badge').text(data.messageAlarmCount);
	        		$('#alarm_message_badge').addClass('twinkle');
	        		$('#unread_message_main').text(`${data.messageAlarmCount} 개의 읽지 않은 메세지가 있습니다.`);
	        		$('#unread_message_main_badge').addClass('twinkle_inner');
	        	}else{
	        		$('#alarm_message').removeClass('shake');
	        		$('#alarm_message_badge').empty();
	        		$('#alarm_message_badge').removeClass('twinkle');
	        		$('#unread_message_main').text('읽지 않은 메세지가 없습니다.');
	        		$('#unread_message_main_badge').removeClass('twinkle_inner');
	        	}
	        	
	            if (data.receivedWorkflowList.length != 0) {
	            	for (const workflowVO of data.receivedWorkflowList) {
	            		WorkflowAlarm(workflowVO,'received_alarm');
	            	}
	            }
	            if (data.sentWorkflowList.length != 0) {
	            	for (const workflowVO of data.receivedWorkflowList) {
	            		WorkflowAlarm(data,'sent_alarm');
	            	}
	            }
	            if (data.realtimeAlarm_messageList.length != 0) {
            		for (const messageVO of data.realtimeAlarm_messageList) {
	            		MessageAlarm(messageVO);
	            	}
	            }
	        },
	        error: function(err) {
	            console.error('Error fetching data:', err);
	        }
	    });
	}
	
	function showWorkflowAlarm(workflowVO,which) {
		console.log(which+' shown');
		console.log(workflowVO);
		const alarmBox = document.getElementById(which);
		
		$('#realtimeAlarm_date').text(getDate(workflowVO.wf_last_result_date));
		$('#realtimeAlarm_sender_profile').text(workflowVO.sender_profile);
		$('#realtimeAlarm_sender_dnum').text(workflowVO.sender_dnum);
		$('#realtimeAlarm_sender_bnum').text(workflowVO.sender_bnum);
		$('#realtimeAlarm_sender_name').text(workflowVO.sender_name);
		$('#realtimeAlarm_sender_position').text(workflowVO.sender_position);
		$('#realtimeAlarm_wf_type').text(workflowVO.wf_type);
		$('#realtimeAlarm_wf_progress').text(workflowVO.wf_progress);
		$('#realtimeAlarm_wf_title').text(workflowVO.wf_title);
		$('#realtimeAlarm_wf_result_1st').text(workflowVO.wf_result_1st);
		$('#realtimeAlarm_wf_result_2nd').text(workflowVO.wf_result_2nd);
		$('#realtimeAlarm_wf_result_3rd').text(workflowVO.wf_result_3rd);
		$('#workflow_info').attr('data-wf_code', workflowVO.wf_code);
		
		// 알림 박스를 보이도록 설정
		alarmBox.style.display = 'flex';
		alarmBox.style.animation = 'fadeIn 1s forwards, focus 0.5s infinite'; // 페이드인 효과
		
		setTimeout(() => {
			alarmBox.style.animation = 'fadeOut 1s forwards'; // 페이드아웃 효과
			
			setTimeout(() => {
				alarmBox.style.display = 'none';
			}, 1000);
			
		}, 10000);
	}
	
	function MessageAlarm(messageVO) {
		
		$('#message_alarm_msg_sender_emp_profile').text(messageVO.msg_sender.emp_profile);
		$('#message_alarm_room_name').text(messageVO.room_name);
		$('#message_alarm_msg_sender').text(messageVO.msg_sender.emp_position+ ' ' +messageVO.msg_sender.emp_name);
		$('#message_alarm_msg_date').text(getDate(messageVO.msg_date));
		$('#message_alarm_msg_content').text(messageVO.msg_content);
		
		$('#message_alarm').css('display', 'flex');
		$('#message_alarm').css('animation', 'fadeIn 1s forwards, focus 0.5s infinite');
		setTimeout(() => {
			$('#message_alarm').css('animation', 'fadeOut 1s forwards');
			
			setTimeout(() => {
				$('#message_alarm').css('display', 'none');
			}, 5000);
			
		}, 5000);
	}
	
});
