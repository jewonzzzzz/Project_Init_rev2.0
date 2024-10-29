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
			<div style="display: flex; align-items: center; justify-content: center; width:90%; height:50px; padding-top:10px; font-size:13px;">
				${workflowList.length} 개의 읽지 않은 알림이 있습니다!
			</div>
		`); 
	
	let count = 0;
    for (const workflowVO of workflowList) {
    	
    	let nav_wf_progress = null;
    	if (workflowVO.wf_progress == '1') {
    		nav_wf_progress = '1차 승인 대기';
		} else if (wf_progress == '2') {
			nav_wf_progress = '2차 승인 대기';
		} else if (wf_progress == '3') {
			nav_wf_progress = '3차 승인 대기';
		};
    	 $('#extended_navbar_inner').append(`
            		<div style="display: flex; width:90%; height:80px; background-color:white; box-shadow: 0 2px 2px rgba(0, 0, 0, 0.3); border-radius:5px; margin-bottom:10px;">
                		<a data-emp_id="${workflowVO.wf_sender}" class="member_info">
                    		<div style="display: flex; flex:0.4; padding-right:20px; align-items: center; justify-content: center; border-right: 1px solid rgba(0,0,0,0.1); margin-top:10px; ">
                    			<div style="display: flex; flex-direction:column; flex:0.4; align-items: center; justify-content: center;">
					        		<div style="flex:1; width:100%; padding:0px 10px;">
						        		<img src="${workflowVO.sender_profile}"
						        		style=" width: 40px; height: 40px; border-radius: 50%;">
					        		</div>
					        	</div>
                    			<div style="display: flex; flex:0.6; flex-direction:column;">
                    				<div style="display: flex; width:100%; flex:0.4; font-weight: bold; align-items: center; justify-content: center; padding-bottom:5px;">
                    					${workflowVO.sender_name}
                    				</div>
                    				<div style="display: flex; width:100%; flex:0.2; font-size:12px; align-items: center; justify-content: center;" >
                    					${workflowVO.sender_bnum}
                    				</div>
                    				<div style="display: flex; width:100%; flex:0.2; font-size:12px; align-items: center; justify-content: center;">
                    					${workflowVO.sender_dname}
                    				</div>
                    				<div style="display: flex; width:100%; flex:0.2; font-size:12px; align-items: center; justify-content: center;" >
                    					${workflowVO.sender_position}
                    				</div>
                    			</div>
                    		</div>
                		</a>
                		<a data-wf_code="${workflowVO.wf_code}" id="workflow_info" style="display: flex; align-items: center; justify-content: center;">
                    		<div style="display: flex; flex:0.6; flex-direction:column;">
	                    		<div style="display: flex; flex:0.5; width:100%;">
	                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
	                    				<div style="flex:0.5; font-weight: bold; padding-bottom:10px;">유형</div>
                    					<div style="flex:0.5;">${workflowVO.wf_type}</div>
	                    			</div>
	                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
	                    				<div style="flex:0.5; font-weight: bold; padding-bottom:10px;">상태</div>
                    					<div style="flex:0.5;">${nav_wf_progress}</div>
	                    			</div>
	                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
	                    				<div style="flex:0.5; font-weight: bold; padding-bottom:10px;">수신일</div>
                    					<div style="flex:0.5;">${getDate(workflowVO.wf_progress === '1' ? workflowVO.wf_create_date : workflowVO.wf_last_result_date)}</div>
	                    			</div>
	                    		</div>
	                    		<div 
	                    		style="display: flex; padding-top:10px; flex:0.5; width:100%; align-items: center; justify-content: center; margin-left:30px; 
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
	    			<div style="display: flex; align-items: center; justify-content: center; width:90%; height:50px; padding-top:10px; font-size:13px;">
						${workflowList.length-5} 개의 요청이 더 존재합니다!
	        		</div>
    			</a>
    	`); 
    }
}
