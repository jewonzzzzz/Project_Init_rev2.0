$(document).ready(function () {
	
	let modal_emp_id;
	let modal_room_check_interval;
	
	$('#get_employee_info').on('hide.bs.modal', function () {
		if (modal_room_check_interval) {
			clearInterval(modal_room_check_interval);
		}
    });
	
	$('#emp_msg_content').keydown(function(e) {
	    if (e.key === 'Enter') {
	        e.preventDefault(); // 기본 엔터키 동작 방지
	        $('#emp_message_send_form').submit(); // 폼 제출
	    }
	});
	
	$(document).on('click', '.member_info', function (e) {
		
		if ($(e.target).closest('.follow, .unfollow').length) {
			return;
		}
		
		if (modal_room_check_interval) {
			clearInterval(modal_room_check_interval);
		}
		
		modal_emp_id = $(this).data('emp_id');
		
	    $.ajax({
	        url: '/main/memberInfoModal',
	        type: 'GET',
	        data: {emp_id: modal_emp_id},
	        success: function (emp) {
	            
	            $('#emp_modal_name').text(emp.emp_name);
				$('#emp_modal_dnum').text(emp.emp_dnum);
				$('#emp_modal_bnum').text(emp.emp_bnum);
				$('#emp_modal_position').text(emp.emp_position);
				$('#emp_modal_tel').text(emp.emp_tel);
				$('#emp_modal_email').text(emp.emp_email);
				
				$('#get_employee_info').modal('show');
				
				$('#get_employee_info').on('shown.bs.modal', function () {
		            $(this).focus();
		        });
				
				personalInfo_getMessages(null,modal_emp_id);
				
				modal_room_check_interval = setInterval(function() {
					personalInfo_getMessages(null,modal_emp_id);
			    }, 1000);
	        },
	        error: function(xhr, status, error) {
	            console.error('AJAX fail:', status, error);
	            console.log('xhr:', xhr);
	        }
	    });
	});
	
	$('#emp_message_send_form').submit(function(e) {
        e.preventDefault();  

        $.ajax({
            url: '/message/sendMessage',
            type: 'POST',
            data: {
                room_id: $('#emp_hidden_room_id').val(),
                personal_receiver_emp_id: $('#emp_hidden_personal_receiver_emp_id').val(),
                personal_receiver_emp_name: $('#emp_hidden_personal_receiver_emp_name').val(),
                msg_content: $('#emp_msg_content').val()
            },
            success: function(data) {
            	$('#emp_msg_content').val('');
            	
            },
            error: function(error) {
                console.error('Error sending message:', error);
            }
        });
        personalInfo_getMessages(null,modal_emp_id);
    });
	
	
});



function personalInfo_getMessages(room_id,receiver_emp_id) {
	
	$.ajax({
		url: '/message/getMessages',
		type: 'GET',
		data: {receiver_emp_id : receiver_emp_id},
			success: function (data) {
				console.log('sdads',data);
				$('.emp_chat_content').empty();
				if(data.messageList.length==0 && room_id == null){
					$('#emp_hidden_room_id').val(0);
					$('#emp_hidden_personal_receiver_emp_id').val(data.personal_receiver_memberVO.emp_id);
					$('#emp_hidden_personal_receiver_emp_name').val(data.personal_receiver_memberVO.emp_name);
				}else{
					for (const msg of data.messageList) {
						console.log('msgList : ',msg);
						
						if(msg.msg_sender.emp_id == 'system'){
							$('.emp_chat_content').append(`
									<div class="messenger_system">
										<div>
										${msg.msg_content}
										</div>
									</div>
							`);
						}else{
							if(msg.msg_sender.emp_id == data.emp_id){
								$('.emp_chat_content').append(
										`<div class="msg_box" style="display:flex; width:330px; margin:4px 0px; margin-left:auto; height:auto;">
											<div style="height:100%; width:10px; display:flex; justify-content: flex-end; align-items: flex-end; margin-left:auto; margin-right:10px;">
												<span id="s_msg_unread_count">
												${msg.msg_unread_count > 0 ? msg.msg_unread_count : ''}
												</span>
											</div>
											<div class="msg_contents" style="display:flex; flex-direction:column; float:right; min-width:150px; max-width:300px; padding:3px;  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4); border-radius:3px; background-color:rgba(150,200,250,0.3);">
												<div id="s_msg_content" style="padding:3px; min-height:30px;">
												${msg.msg_content}
												</div>	    
												<div id="s_msg_create_date" style="height:20px; text-align:right;">
												${getMsgDate(msg.msg_date)}
												</div>	  
											</div>
										</div>`
								);
							}else{
								$('.emp_chat_content').append(
										`<div class="r_msg_box" style="display:flex; width:330px; margin:4px 0px; height:auto;">
											<a data-emp_id="${msg.msg_sender.emp_id}" class="member_info">
												<div id="r_msg_sender_img" style="width:50px; height:50px; margin-top:10px;">
												${msg.msg_sender.emp_profile}
												</div>
											</a>
											<div style="width:350px; display:flex; flex-direction:column;">
												<div style="display:flex; height:20px;">
													<div id="r_msg_sender_name" style=" padding:0 5px;">
													${msg.msg_sender.emp_name}
													</div>
													<div id="r_msg_sender_dnum" style="display:flex; align-items:flex-end; font-size:10px;">
													${msg.msg_sender.emp_dnum}
													</div>
													<div id="r_msg_sender_position" style="display:flex; align-items:flex-end; font-size:10px; padding:0 5px;">
													${msg.msg_sender.emp_position}
													</div>
												</div>
												<div class="msg_box" style="display:flex;">
													<div class="msg_contents" style="display:flex; flex-direction:column; float:left; min-width:150px; max-width:300px; padding:3px;  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4); border-radius:3px; background-color:rgba(0,0,50,0.1)">
														<div id="r_msg_content" style="padding:3px; min-height:30px;">
														${msg.msg_content}
														</div>	    
														<div id="r_msg_create_date" style="height:20px; text-align:right;">
														${getMsgDate(msg.msg_date)}
														</div>	  
													</div>
													<div style="height:100%; width:10px; display:flex; justify-content: flex-end; align-items: flex-end; margin-left:10px;">
														<span id="r_msg_unread_count">
														${msg.msg_unread_count > 0 ? msg.msg_unread_count : ''}
														</span>
													</div>
												</div>
											</div>
										</div>`	
								);
							}
						}
					}/* for문 종료*/
					$('#emp_hidden_room_id').val(data.messageList[0].room_id);
				}/* if else문 종료*/
				setTimeout(function () {
		            $('.emp_chat_content').scrollTop($('.emp_chat_content')[0].scrollHeight);
		        }, 150);
			},/* success문 종료*/
			error: function (xhr, status, error) {
				if (status !== 'abort') {
					console.error('AJAX 요청 실패:', status, error);
					console.log('xhr:', xhr);
				}
			}
	}); // ajax end}	
}