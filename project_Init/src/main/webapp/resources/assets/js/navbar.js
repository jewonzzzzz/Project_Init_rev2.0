$(document).ready(function () {
	$(document).on('click', '#extend_workflowAlarm', function (e) {
		if ($('#extended_navbar').css('display') === 'none') {
            extendNavbar();
        }
	});
	
	$(document).on('click', '#extend_messenger', function (e) {
		if (!window.location.href.includes('main')) { 
			if ($('#open_messenger').css('display') === 'none') {
				extendMessenger();
	        }
		}
	});
	
	$(document).on('click', '#message_alarm', function (e) {
		if (!window.location.href.includes('main')) { 
			if ($('#open_messenger').css('display') === 'none') {
				extendMessenger();
	        }
		}
	});
	
	$(document).on('click', '#extend_calendar', function (e) {
		if (!window.location.href.includes('main')) { 
			if ($('#open_calendar').css('display') === 'none') {
				extendCalendar();
	        }
		}
	});
		
	$(document).on('click', function (e) {
        if (!$(e.target).closest('#extended_navbar').length 
        		&& !$(e.target).closest('.modal').length
        		&& !$(e.target).closest('#extend_workflowAlarm').length
        		&& $('#extended_navbar').css('display') === 'flex') 
        {
        	closeNavbar();
        }
    });
	
	$(document).on('click', function (e) {
		if (!window.location.href.includes('main')) { 
	        if (!$(e.target).closest('#extend_messenger').length 
	            && !$(e.target).closest('#message_alarm').length
	            && !$(e.target).closest('.modal').length
 	            && !$(e.target).closest('#open_messenger').length
	            && $('#open_messenger').css('display') === 'flex') 
	        {
	            closeMessenger();
	        }
	    }
	});
	
	$(document).on('click', function (e) {
		if (!window.location.href.includes('main')) { 
	        if (!$(e.target).closest('#extend_calendar').length 
	        		&& !$(e.target).closest('.modal').length
	        		&& !$(e.target).closest('#open_calendar').length
	        		&& $('#open_calendar').css('display') === 'flex') 
	        {
	        	closeCalendar();
	        }
		}
    });

    $(document).on('keydown', function (e) {
        if (e.key === "Escape") {
        	closeNavbar();
        	if (!window.location.href.includes('main')) { 
	        	closeMessenger();
	        	closeCalendar();
        	}
        }
    });	
    
    let clickCount = 0;
    let timer;

});/* doc rdy end*/
	
function extendNavbar() {
	console.log('Navbar extended!');
	document.getElementById("extended_navbar").style.animation = 'dropDown 0.5s forwards';
	document.getElementById("extended_navbar").style.display = 'flex';
	showAlarmedWorkflow();
}

function extendMessenger() {
	console.log('Messenger extended!');
	document.getElementById("open_messenger").style.animation = 'dropDown 0.5s forwards';
	document.getElementById("open_messenger").style.display = 'flex';
	$('#open_messenger').css('position','absolute'); 
	$('#open_messenger').addClass('right_top');
	getMembers();
	chatRoomList();
	
	room_check_interval = setInterval(function() {
		chatRoomList();
    }, 5000);
	
	member_check_interval = setInterval(function() {
		checkMember();
    }, 10000);
}

function extendCalendar() {
	console.log('Calendar extended!');
	document.getElementById("open_calendar").style.animation = 'dropDown 0.5s forwards';
	document.getElementById("open_calendar").style.display = 'flex';
	$('#open_calendar').css('position','absolute'); 
	$('#open_calendar').addClass('right_top');
}

function closeNavbar() {
    console.log('Navbar closed.');
    document.getElementById("extended_navbar").style.animation = 'dropUp 0.5s forwards';
    setTimeout(function() {
        document.getElementById("extended_navbar").style.display = 'none';
        $('#extended_navbar_inner').empty();
    }, 500);
    $('#extended_navbar_inner').empty();
}

function closeMessenger() {
    console.log('Messenger closed.');
    document.getElementById("open_messenger").style.animation = 'dropUp 0.5s forwards';
    setTimeout(function() {
        document.getElementById("open_messenger").style.display = 'none';
    }, 500);
    if (message_check_interval) {
        clearInterval(message_check_interval);
    }
	if (room_check_interval) {
		clearInterval(room_check_interval);
	}
	if (member_check_interval) {
        clearInterval(member_check_interval);
    }
}

function closeCalendar() {
    console.log('Calendar closed.');
    document.getElementById("open_calendar").style.animation = 'dropUp 0.5s forwards';
    setTimeout(function() {
        document.getElementById("open_calendar").style.display = 'none';
    }, 500);
}

function showAlarmedWorkflow() {
	$.ajax({
		url: '/main/smallAlarm_workflow',
		type: 'GET',
		success: function (data) {
			console.log(data);
			if (data.length === 0) {
				$('#extended_navbar_inner').append(`
					<div style="display: flex; align-items: center; justify-content: center; border-bottom:1px solid rgba(0,0,0,0.1); width:90%; height:50px; padding-top:10px; font-size:15px;">
						확인하지 않은 알림이 없습니다.
					</div>
				`); 
			}else{
				appendWorkflow(data);
			}
		},
		error: function (xhr, status, error) {
			if (status !== 'abort') {
				console.error('AJAX 요청 실패:', status, error);
				console.log('xhr:', xhr);
			}
		}
	});
}

const getDate = (stringDate) => {
    if (!stringDate) return '';
    const date = new Date(stringDate);
    return String(date.getFullYear()).slice(-2) + '.' +
	       String(date.getMonth() + 1).padStart(2, '0') + '.' +
	       String(date.getDate()).padStart(2, '0') + '_' +
	       String(date.getHours()).padStart(2, '0') + ':' +
	       String(date.getMinutes()).padStart(2, '0');
};

function appendWorkflow(workflowList) {
	$('#extended_navbar_inner').append(`
			<div style="display: flex; align-items: center; justify-content: center; border-bottom:1px solid rgba(0,0,0,0.1); width:90%; height:50px; padding-top:10px; font-size:15px;">
				${workflowList.length} 개의 읽지 않은 알림이 있습니다!
			</div>
		`); 
	
	let count = 0;
    for (const workflowVO of workflowList) {
    	 $('#extended_navbar_inner').append(`
            		<div style="display: flex; border-bottom:1px solid rgba(0,0,0,0.1); width:90%; align-items: center; justify-content: center;">
                		<a href="#" data-emp_id="${workflowVO.wf_sender}" class="member_info" style="flex:0.4;">
                    		<div style="display: flex; align-items: center; justify-content: center; border-right: 1px solid rgba(0,0,0,0.1); margin:15px 0px 15px 0px; ">
                    			<div style="display: flex; flex-direction:column; flex:0.4; align-items: center; justify-content: center;">
                    				<div style="flex:0.2; font-weight: bold; text-align:center; width:100%;" >발신자</div>
					        		<div style="flex:0.8; width:100%; display:flex; align-items: center; justify-content: center;">
						        		<img src="${workflowVO.sender_profile}"
						        		style=" width: 40px; height: 40px; border-radius: 50%;">
					        		</div>
					        	</div>
                    			<div style="display: flex; flex:0.3; flex-direction:column;">
                    				<div style="display: flex; width:100%; flex:0.4; align-items: center; justify-content: center;">
                    					${workflowVO.sender_position}
                    				</div>
                    				<div style="display: flex; width:100%; flex:0.2; align-items: center; justify-content: center;" >
                    					${workflowVO.sender_name}
                    				</div>
                    			</div>
                    			<div style="display: flex; flex:0.3; flex-direction:column;">
                    				<div style="display: flex; width:100%; flex:0.4; align-items: center; justify-content: center;">
                    					${workflowVO.sender_bnum}
                    				</div>
                    				<div style="display: flex; width:100%; flex:0.2; align-items: center; justify-content: center;" >
                    					${workflowVO.sender_dnum}
                    				</div>
                    				<div style="display: flex; width:100%; flex:0.2; align-items: center; justify-content: center;">
                    					${workflowVO.sender_job}
                    				</div>
                    			</div>
                    		</div>
                		</a>
                		<a href="#" data-wf_code="${workflowVO.wf_code}" id="workflow_info" style="flex:0.6;">
                    		<div style="display: flex; flex-direction:column;">
	                    		<div style="display: flex; flex:0.5; width:100%;">
	                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
	                    				<div style="flex:0.5; font-weight: bold">유형</div>
                    					<div style="flex:0.5;">${workflowVO.wf_type}</div>
	                    			</div>
	                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
	                    				<div style="flex:0.5; font-weight: bold">상태</div>
                    					<div style="flex:0.5;">${workflowVO.wf_progress}</div>
	                    			</div>
	                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
	                    				<div style="flex:0.5; font-weight: bold">수신일</div>
                    					<div style="flex:0.5;">${getDate(workflowVO.wf_progress === '1' ? workflowVO.wf_create_date : workflowVO.wf_last_result_date)}</div>
	                    			</div>
	                    		</div>
	                    		<div 
	                    		style="border-top:1px solid rgba(0,0,0,0.1); display: flex; flex:0.5; width:100%; align-items: center; justify-content: center; margin-left:30px; 
	                    		white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width:245px;">
	                    			${workflowVO.wf_title}
	                    		</div>
	                    	</div>
                    	</a>
                	</div>
            		`); 
    	 count ++;
    	 if (count >= 10) {
    	     break;
    	 }
    }
    if(workflowList.length > 10){
    	$('#extended_navbar_inner').append(`
    			<a href="/work/workflow" style="width:100%;">
	    			<div style="display: flex; align-items: center; justify-content: center; width:90%; height:50px; padding-top:10px; font-size:15px;">
						${workflowList.length-5} 개의 요청이 더 존재합니다!
	        		</div>
    			</a>
    	`); 
    }
}
