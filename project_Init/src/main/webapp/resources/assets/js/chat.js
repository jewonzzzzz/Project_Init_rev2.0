let message_check_interval;
let room_check_interval;
let member_check_interval;

$(document).ready(function () {
	$('.messenger_body_chat.room').css('display', 'none');
	
	if ($('#open_messenger').css('display') === 'flex') {
		
		getMembers();
		chatRoomList();
		
		room_check_interval = setInterval(function() {
			chatRoomList();
	    }, 5000);
		
		member_check_interval = setInterval(function() {
			checkMember();
	    }, 10000);
		
		$(document).on('click', '#to_chat_list', function (e) {
			if ($(e.target).closest('.follow, .unfollow').length) {
				return;
			}
			if (message_check_interval) {
		        clearInterval(message_check_interval);
		    }
			if (room_check_interval) {
				clearInterval(room_check_interval);
			}
			
			chatRoomList();
			
			console.log('to_chat_list');
			room_check_interval = setInterval(function() {
				chatRoomList();
		    }, 5000);
			$('.messenger_invite').css('display', 'none').removeClass('fadeIn').addClass('fadeOut');
		    $('.messenger_body_chat.room').css('display', 'none').removeClass('fadeUp').addClass('fadeDown');
		    $('.messenger_body_chat.list').css('display', 'block').removeClass('fadeDown').addClass('fadeUp');
		});
		
		$(document).on('click', '#to_chat_room', function (e) {
			if ($(e.target).closest('.follow, .unfollow').length) {
				return;
			}
			if (message_check_interval) {
		        clearInterval(message_check_interval);
		    }
			if (room_check_interval) {
				clearInterval(room_check_interval);
			}
			if (member_check_interval) {
		        clearInterval(member_check_interval);
		    }
			
			const room_id = $(this).data('room_id');
		    console.log('to_chat_room : room_id = ', room_id);
		    
		    getMessages(room_id, null);
		    $('.messenger_invite').css('display', 'block').removeClass('fadeOut').addClass('fadeIn');
		    $('.messenger_body_chat.list').css('display', 'none').removeClass('fadeUp').addClass('fadeDown');
		    $('.messenger_body_chat.room').css('display', 'flex').removeClass('fadeDown').addClass('fadeUp');
		
		    message_check_interval = setInterval(function() {
		        getMessages(room_id, null);
		        console.log('check room ',room_id);
		    }, 1000);
		});
		
		$(document).on('click', '#to_personal_room', function (e) {
			if ($(e.target).closest('.follow, .unfollow').length) {
				return;
			}
			if (message_check_interval) {
		        clearInterval(message_check_interval);
		    }
			if (room_check_interval) {
				clearInterval(room_check_interval);
			}
			if (member_check_interval) {
		        clearInterval(member_check_interval);
		    }
			
			const receiver_emp_id = $(this).data('receiver_emp_id');
			console.log('to_personal_room : receiver_emp_id = ',receiver_emp_id);
			getMessages(null,receiver_emp_id);
			$('.messenger_invite').css('display', 'block').removeClass('fadeOut').addClass('fadeIn');
		    $('.messenger_body_chat.list').css('display', 'none').removeClass('fadeUp').addClass('fadeDown');
		    $('.messenger_body_chat.room').css('display', 'flex').removeClass('fadeDown').addClass('fadeUp');
		    
		    message_check_interval = setInterval(function() {
		        getMessages(null,receiver_emp_id);
		        console.log('check room with ',receiver_emp_id);
		    }, 1000);
		});
		
		if ($('.messenger_body_chat.room').css('display') === 'none') {
		    (function() {
		    	if (message_check_interval) {
			        clearInterval(message_check_interval);
			    }
		    	console.log('user get out from room. clear interval.')
		    	member_check_interval = setInterval(function() {
					checkMember();
			    }, 10000);
		    })();
		}
		
		$(document).on('click', '.messenger_invite', function (e) {
			let room_id = $('#hidden_room_id').val();
			let emp_id = $(this).data('emp_id');
			console.log(emp_id + 'invited to :' + room_id);
			inviteRoom(emp_id,room_id);
		});
		
		$(document).on('click', '.messenger_exit_room', function (e) {
			if (message_check_interval) {
		        clearInterval(message_check_interval);
		    }
			let room_id = $('#hidden_room_id').val();
			getOutRoom(room_id);
			chatRoomList();
			$('.messenger_invite').css('display', 'none').removeClass('fadeIn').addClass('fadeOut');
		    $('.messenger_body_chat.room').css('display', 'none').removeClass('fadeUp').addClass('fadeDown');
		    $('.messenger_body_chat.list').css('display', 'block').removeClass('fadeDown').addClass('fadeUp');
		});
		
		$('#msg_content').keydown(function(e) {
		    if (e.key === 'Enter') {
		        e.preventDefault(); // 기본 엔터키 동작 방지
		        $('#message_send_form').submit(); // 폼 제출
		    }
		});
		
		$('#message_send_form').submit(function(e) {
	        e.preventDefault();  
	
	        $.ajax({
	            url: '/message/sendMessage',
	            type: 'POST',
	            data: {
	                room_id: $('#hidden_room_id').val(),
	                personal_receiver_emp_id: $('#hidden_personal_receiver_emp_id').val(),
	                personal_receiver_emp_name: $('#hidden_personal_receiver_emp_name').val(),
	                msg_content: $('#msg_content').val()
	            },
	            success: function(data) {
	            	console.log('send message!');
	            	console.log(data);
	            	getMessages(data,null);
	            	$('#msg_content').val('');
	            	
	            },
	            error: function(error) {
	                console.error('Error sending message:', error);
	            }
	        });
	    });
		
		$('#messenger_search').blur(function() {
		    if( $('#messenger_search').val().trim() === '' ){
		    	getMembers();
		    }
		});
		
		$('#room_search').blur(function() {
		    if( $('#room_search').val().trim() === '' ){
		    	chatRoomList();
		    }
		});
		$(document).on('click', '.follow', function (e) {
			let emp_id = $(this).data('emp_id');
			let room_id = $(this).data('room_id');
			
			 $.ajax({
		            url: '/message/unfollow',
		            type: 'GET',
		            data: {emp_id:emp_id,
		            		room_id:room_id
		            },
		            success: function(data) {
		            	getMembers();
		        		chatRoomList();
		            },
		            error: function(error) {
		                console.error('Error sending message:', error);
		            }
		        });
		});
		
		$(document).on('click', '.unfollow', function (e) {
			let emp_id = $(this).data('emp_id')
			let room_id = $(this).data('room_id')
			
			 $.ajax({
		            url: '/message/follow',
		            type: 'GET',
		            data: {emp_id:emp_id,
	            			room_id:room_id
		            },
		            success: function(data) {
		            	getMembers();
		        		chatRoomList();
		            },
		            error: function(error) {
		                console.error('Error sending message:', error);
		            }
		        });	
		});
	 }
});

	
function getMembers() {
	
	console.log('check members');
	
	$.ajax({
		url: '/message/getTeam',
		type: 'GET',
		success: function (data) {
			$('.messenger_body_menu').children(':not(.messenger_search)').remove();
			
			if(data.favoriteEmpList && data.favoriteEmpList.favorite_emp && data.favoriteEmpList.favorite_emp.length > 0){
			$('.messenger_body_menu').append(`
					<div style="width:100%, height:15px; padding-left:5px;">
					즐겨찾기 (${data.favoriteEmpList.favorite_emp.length})
					</div>
			`);
				for (const memberVO of data.favoriteEmpList.favorite_emp) {
			    	$('.messenger_body_menu').append(`
						<div class="person" style="display:flex;">
							<div class="member_info" data-emp_id="${memberVO.emp_id}" style="flex:0.3; display:flex; justify-content: center;  align-items: center;">
								<div data-emp_id="${memberVO.emp_id}" class="follow" style="cursor: pointer; flex:2; display:flex; justify-content: center; align-items: center;">
								<i class="fa-solid fa-star favorite" style="font-size:20px;"></i>
								</div>
								<div style="flex:8; display:flex; justify-content: center; align-items: center;">
								${memberVO.emp_profile}
								</div>
							</div>
							<div class="member_info" data-emp_id="${memberVO.emp_id}" style="flex:0.4; display:flex; flex-direction: column;">
								<div style="display:flex; flex:0.4;">
									<div style="flex:1; height:auto; display:flex; justify-content: flex-start;  align-items: center; margin-top:3px;">
									${memberVO.emp_position}  ${memberVO.emp_name}
									</div>
								</div>
								<div style="flex:0.3; display:flex; justify-content: flex-start;  align-items: center; font-size:12px;">
								${memberVO.emp_bnum}
								</div>
								<div style="display:flex; flex:0.3;">
									<div style="flex:1; height:auto; display:flex; justify-content: flex-start;  align-items: center; font-size:12px;">
									${memberVO.emp_dnum}  ${memberVO.emp_job}
									</div>
								</div>
							</div>
							<div style="flex:0.1; display:flex; flex-direction:column; justify-content: center;  align-items: center;">
								<i style="color:rgba(0,0,0,0.1); font-size:20px;" class="fas fa-dot-circle ${memberVO.log_on ? 'log_on' : ''}"></i>
							</div>
							<div style="flex:0.2; display:flex; flex-direction:column; justify-content: center;  align-items: center;">
								<div class="messenger_invite" data-emp_id="${memberVO.emp_id}" style="display:none;">
									<i class="fas fa-user-plus"></i>
								</div>
								<div id="to_personal_room" data-receiver_emp_id="${memberVO.emp_id}">
									<i class="fa-solid fa-message"></i>
								</div>
							</div>
						</div>
			    	`);
				}
			}
			$('.messenger_body_menu').append(`
					<div style="width:100%, height:15px; padding-left:5px;">
					팀원 (${data.memberList.length})
					</div>
			`);
			for (const memberVO of data.memberList) {
		    	$('.messenger_body_menu').append(`
					<div class="person" style="display:flex;">
						<div class="member_info" data-emp_id="${memberVO.emp_id}" style="flex:0.3; display:flex; justify-content: center;  align-items: center;">
							<div data-emp_id="${memberVO.emp_id}" class="unfollow" style="cursor: pointer; flex:2; display:flex; justify-content: center; align-items: center;">
							<i class="fa-solid fa-star" style="font-size:20px; color:rgba(0,0,0,0.1);"></i>
							</div>
							<div style="flex:8; display:flex; justify-content: center; align-items: center;">
							${memberVO.emp_profile}
							</div>
						</div>
						<div class="member_info" data-emp_id="${memberVO.emp_id}" style="flex:0.4; display:flex; flex-direction: column;">
							<div style="display:flex; flex:0.4;">
								<div style="flex:1; height:auto; display:flex; justify-content: flex-start;  align-items: center; margin-top:3px;">
								${memberVO.emp_position}  ${memberVO.emp_name}
								</div>
							</div>
							<div style="flex:0.3; display:flex; justify-content: flex-start;  align-items: center; font-size:12px;">
							${memberVO.emp_bnum}
							</div>
							<div style="display:flex; flex:0.3;">
								<div style="flex:1; height:auto; display:flex; justify-content: flex-start;  align-items: center; font-size:12px;">
								${memberVO.emp_dnum}  ${memberVO.emp_job}
								</div>
							</div>
						</div>
						<div style="flex:0.1; display:flex; flex-direction:column; justify-content: center;  align-items: center;">
							<i style="color:rgba(0,0,0,0.1); font-size:20px;" class="fas fa-dot-circle ${memberVO.log_on ? 'log_on' : ''}"></i>
						</div>
						<div style="flex:0.2; display:flex; flex-direction:column; justify-content: center;  align-items: center;">
							<div class="messenger_invite" data-emp_id="${memberVO.emp_id}" style="display:none;">
								<i class="fas fa-user-plus"></i>
							</div>
							<div id="to_personal_room" data-receiver_emp_id="${memberVO.emp_id}">
								<i class="fa-solid fa-message"></i>
							</div>
						</div>
					</div>
		    	`);
			}
		},
		error: function (xhr, status, error) {
			if (status !== 'abort') {
				console.error('AJAX 요청 실패:', status, error);
				console.log('xhr:', xhr);
			}
		}
	}); // ajax end}	
}	
	
function getMessages(room_id,receiver_emp_id) {
	console.log('getMessages('+room_id+','+receiver_emp_id+') run');
	
	$.ajax({
		url: '/message/getMessages',
		type: 'GET',
		data: {room_id : room_id,
			receiver_emp_id : receiver_emp_id},
		success: function (data) {
			console.log('getMessages :'+data);
			$('.chat_content').empty();
		    if(data.messageList.length==0 && room_id == null){
				$('#hidden_room_id').val(0);
				$('.chat_room_name').text(data.personal_receiver_memberVO.emp_name);
				$('#hidden_personal_receiver_emp_id').val(data.personal_receiver_memberVO.emp_id);
				$('#hidden_personal_receiver_emp_name').val(data.personal_receiver_memberVO.emp_name);
		    }else{
			for (const msg of data.messageList) {
					console.log('msgList : ',msg);
				
					if(msg.msg_sender.emp_id == 'system'){
						$('.chat_content').append(`
							<div class="messenger_system">
								<div>
								${msg.msg_content}
								</div>
							</div>
						`);
					}else{
				    	if(msg.msg_sender.emp_id == data.emp_id){
				    		$('.chat_content').append(
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
			    				$('.chat_content').append(
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
				$('#hidden_room_id').val(data.messageList[0].room_id);
				$('.chat_room_name').text(data.messageList[0].room_name);
		    }/* if else문 종료*/
		    
		    $('.chat_content').scrollTop($('.chat_content')[0].scrollHeight);
			},/* success문 종료*/
			error: function (xhr, status, error) {
				if (status !== 'abort') {
					console.error('AJAX 요청 실패:', status, error);
					console.log('xhr:', xhr);
				}
			}
	}); // ajax end}	
}

function chatRoomList() {
	if (message_check_interval) {
        clearInterval(message_check_interval);
    }
	$.ajax({
		url: '/message/getChatRoomList',
		type: 'GET',
		success: function (data) {
			$('.messenger_body_chat.list').children(':not(.messenger_room_search)').remove();
			for (const rooms of data.favoriteChatRoomList) {
				console.log(rooms);
				$('.messenger_body_chat.list').append(`
						<div class="room" id="to_chat_room" data-room_id="${rooms.room_id}" style="display:flex; justify-content: center; align-items: center; width: 100%; box-sizing: border-box; overflow-x: hidden;">
							<div style="flex:2; display:flex; justify-content: center; align-items: center;">
								<div data-room_id="${rooms.room_id}" class="follow" style="cursor: pointer; flex:2; display:flex; justify-content: center; align-items: center;">
								<i class="fa-solid fa-thumbtack favorite" style="font-size:20px;"></i>
								</div>
								<div style="flex:8; display:flex; justify-content: center; align-items: center;">
								${rooms.room_name.split(',').length > 1 ? '<i style="font-size:20px; color:rgba(0,0,0,0.5)" class="fas fa-users"></i>' : rooms.room_thumbnail}
								</div>
							</div>
							<div style="flex:7; display:flex; flex-direction:column; justify-content: center; align-items: center;">
								<div style="flex:4; display:flex; width: 100%; box-sizing: border-box; justify-content: flex-start; align-items: center;">
									<div style="font-size:15px; font-weight:bold; width:100%; height:100%; width: 100%; box-sizing: border-box; display:flex; justify-content: flex-start; align-items: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
									${rooms.room_name}
									</div>
								</div>
								<div style="flex:3; display:flex; width:100%; justify-content: flex-start; align-items: center;">
									<div style="font-size:12px; flex:1; height:100%; display:flex; justify-content: flex-start; align-items: center;">
									${rooms.room_last_sender_position  ? rooms.room_last_sender_position : ""}  ${rooms.room_last_sender_name  ? rooms.room_last_sender_name : ""}
									</div>
									<div style="font-size:12px; flex:1; height:100%; display:flex; justify-content: flex-end; align-items: center;">
									${getMsgDate(rooms.room_last_message_date)}
									</div>
								</div>
								<div style="font-size:12px; flex:3; display:flex; width: 300px; box-sizing: border-box; justify-content: flex-start; align-items: center; padding-left:3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: block;">
								${rooms.room_last_message ? rooms.room_last_message : "입력 된 메세지가 없습니다."}
								</div>
							</div>
							<div style="flex:1; justify-content: center; align-items: center; display:flex;">
								<div style="display: ${rooms.room_alarm_count > 0 ? 'flex' : 'none'}; justify-content: center; align-items: center; width: 23px; height: 23px;  background-color: rgb(0,0,100); color: white; border-radius: 50%; font-size: 12px;">
								${rooms.room_alarm_count}
								</div>
							</div>
						</div>`
				);
				
			}
			for (const rooms of data.chatRoomList) {
				console.log(rooms);
				$('.messenger_body_chat.list').append(`
						<div class="room" id="to_chat_room" data-room_id="${rooms.room_id}" style="display:flex; justify-content: center; align-items: center; width: 100%; box-sizing: border-box; overflow-x: hidden;">
							<div style="flex:2; display:flex; justify-content: center; align-items: center;">
								<div data-room_id="${rooms.room_id}" class="unfollow" style="cursor: pointer; flex:2; display:flex; justify-content: center; align-items: center;">
								<i class="fa-solid fa-thumbtack" style="font-size:20px; color:rgba(0,0,0,0.1);"></i>
								</div>
								<div style="flex:8; display:flex; justify-content: center; align-items: center;">
								${rooms.room_name.split(',').length > 1 ? '<i style="font-size:20px; color:rgba(0,0,0,0.5)" class="fas fa-users"></i>' : rooms.room_thumbnail}
								</div>
							</div>
							<div style="flex:7; display:flex; flex-direction:column; justify-content: center; align-items: center;">
								<div style="flex:4; display:flex; width: 100%; box-sizing: border-box; justify-content: flex-start; align-items: center;">
									<div style="font-size:15px; font-weight:bold; width:100%; height:100%; width: 100%; box-sizing: border-box; display:flex; justify-content: flex-start; align-items: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
									${rooms.room_name}
									</div>
								</div>
								<div style="flex:3; display:flex; width:100%; justify-content: flex-start; align-items: center;">
									<div style="font-size:12px; flex:1; height:100%; display:flex; justify-content: flex-start; align-items: center;">
									${rooms.room_last_sender_position  ? rooms.room_last_sender_position : ""}  ${rooms.room_last_sender_name  ? rooms.room_last_sender_name : ""}
									</div>
									<div style="font-size:12px; flex:1; height:100%; display:flex; justify-content: flex-end; align-items: center;">
									${getMsgDate(rooms.room_last_message_date)}
									</div>
								</div>
								<div style="font-size:12px; flex:3; display:flex; width: 300px; box-sizing: border-box; justify-content: flex-start; align-items: center; padding-left:3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: block;">
								${rooms.room_last_message ? rooms.room_last_message : "입력 된 메세지가 없습니다."}
								</div>
							</div>
							<div style="flex:1; justify-content: center; align-items: center; display:flex;">
								<div style="display: ${rooms.room_alarm_count > 0 ? 'flex' : 'none'}; justify-content: center; align-items: center; width: 23px; height: 23px;  background-color: rgb(0,0,100); color: white; border-radius: 50%; font-size: 12px;">
								${rooms.room_alarm_count}
								</div>
							</div>
						</div>`
				);
				
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

const getMsgDate = (stringDate) => {
    if (!stringDate) return '';
    const date = new Date(stringDate);
    return String(date.getMonth() + 1).padStart(2, '0') + '.' +
	       String(date.getDate()).padStart(2, '0') + ' ' +
	       String(date.getHours()).padStart(2, '0') + ':' +
	       String(date.getMinutes()).padStart(2, '0');
};

let prev_messenger_search;
function messenger_search(input) {
	const keyword = input.replace(/\s+/g, '');

	if (keyword.length >= 2 && /^[a-zA-Z가-힣0-9]+$/.test(keyword)) {
		if (prev_messenger_search) {
			prev_messenger_search.abort();
			}
		prev_messenger_search = 
			$.ajax({
			url: '/main/search',
			type: 'GET',
			data: { keyword: keyword },
			success: function (data) {
				console.log('correct value input. start messenger_search, result:', data);
				$('.messenger_search_result').remove();
				$('.messenger_search_person').remove();
				$('.messenger_search').after(`
						<div class="messenger_search_result" style="width:100%, height:5px;">
							'${keyword}' 검색 결과 (${data.length})
						</div>
				`);
				for (const memberVO of data) {
					$('.messenger_search_result').after(`
						<div class="messenger_search_person" style="display:flex;">
							<div class="member_info" data-emp_id="${memberVO.emp_id}" style="flex:0.3; display:flex; justify-content: center;  align-items: center;">
								<div style="flex:2; display:flex; justify-content: center; align-items: center;">
								<i class="fa-solid fa-star" style="font-size:20px; color:rgba(0,0,0,0.1);"></i>
								</div>
								<div style="flex:8; display:flex; justify-content: center; align-items: center;">
								${memberVO.emp_profile}
								</div>
							</div>
							<div class="member_info" data-emp_id="${memberVO.emp_id}" style="flex:0.4; display:flex; flex-direction: column;">
								<div style="display:flex; flex:0.4;">
									<div style="flex:1; height:auto; display:flex; justify-content: flex-start;  align-items: center; margin-top:3px;">
									${memberVO.emp_position}  ${memberVO.emp_name}
									</div>
								</div>
								<div style="flex:0.3; display:flex; justify-content: flex-start;  align-items: center; font-size:12px;">
								${memberVO.emp_bnum}
								</div>
								<div style="display:flex; flex:0.3;">
									<div style="flex:1; height:auto; display:flex; justify-content: flex-start;  align-items: center; font-size:12px;">
									${memberVO.emp_dnum}  ${memberVO.emp_job}
									</div>
								</div>
							</div>
							<div style="flex:0.1; display:flex; flex-direction:column; justify-content: center;  align-items: center;">
								<i style="color:rgba(0,0,0,0.1); font-size:20px;" class="fas fa-dot-circle ${memberVO.log_on ? 'log_on' : ''}"></i>
							</div>
							<div style="flex:0.2; display:flex; flex-direction:column; justify-content: center;  align-items: center;">
								<div class="messenger_invite" data-emp_id="${memberVO.emp_id}" style="display:none;">
									<i class="fas fa-user-plus"></i>
								</div>
								<div id="to_personal_room" data-receiver_emp_id="${memberVO.emp_id}">
									<i class="fa-solid fa-message"></i>
								</div>
							</div>
						</div>
					`);
				}
				if ($('.messenger_body_chat.room').css('display') === 'flex') {
					$('.messenger_invite').css('display', 'block').removeClass('fadeOut').addClass('fadeIn');
				}
			},
			error: function (xhr, status, error) {
				if (status !== 'abort') {
					console.error('AJAX 요청 실패:', status, error);
					console.log('xhr:', xhr);
				}
			}
		}); // ajax end
	}
}

let prev_room_search;
function room_search(input) {
	const keyword = input.replace(/\s+/g, '');

	if (keyword.length >= 2 && /^[a-zA-Z가-힣0-9]+$/.test(keyword)) {
		if (prev_room_search) {
			prev_room_search.abort();
			}
		prev_room_search = 
			$.ajax({
			url: '/message/msgSearch',
			type: 'GET',
			data: { keyword: keyword },
			success: function (data) {
				console.log('correct value input. start room_search, result:', data);
				$('.messenger_body_chat.list').children(':not(.messenger_room_search)').remove();
				$('.messenger_room_search').after(`
						<div class="room_search_result" style="width:100%, height:5px;">
							'${keyword}' 검색 결과 (${data.length})
						</div>
				`);
				for (const rooms of data) {
					$('.room_search_result').after(`
						<div class="room" id="to_chat_room" data-room_id="${rooms.room_id}" style="display:flex; justify-content: center; align-items: center; width: 100%; box-sizing: border-box; overflow-x: hidden;">
							<div style="flex:2; display:flex; justify-content: center; align-items: center;">
								<div style="flex:2; display:flex; justify-content: center; align-items: center;">
								<i class="fa-solid fa-thumbtack" style="font-size:20px; color:rgba(0,0,0,0.1);"></i>
								</div>
								<div style="flex:8; display:flex; justify-content: center; align-items: center;">
								${rooms.room_thumbnail}
								</div>
							</div>
							<div style="flex:7; display:flex; flex-direction:column; justify-content: center; align-items: center;">
								<div style="flex:4; display:flex; width: 100%; box-sizing: border-box; justify-content: flex-start; align-items: center;">
									<div style="font-size:15px; width:100%; height:100%; width: 100%; box-sizing: border-box; display:flex; justify-content: flex-start; align-items: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-weight:bold;">
									${rooms.room_name}
									</div>
								</div>
								<div style="flex:3; display:flex; width:100%; justify-content: flex-start; align-items: center;">
									<div style="font-size:12px; flex:1; height:100%; display:flex; justify-content: flex-start; align-items: center;">
									${rooms.room_last_sender_position}  ${rooms.room_last_sender_name}
									</div>
									<div style="font-size:12px; flex:1; height:100%; display:flex; justify-content: flex-end; align-items: center;">
									${getMsgDate(rooms.room_last_message_date)}
									</div>
								</div>
								<div style="font-size:12px; flex:3; display:flex; width: 300px; box-sizing: border-box; justify-content: flex-start; align-items: center; padding-left:3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: block;">
								${rooms.room_last_message}
								</div>
							</div>
							<div style="flex:1; justify-content: center; align-items: center; display:flex;">
								<div style="display: ${rooms.room_alarm_count > 0 ? 'flex' : 'none'}; justify-content: center; align-items: center; width: 23px; height: 23px;  background-color: rgb(0,0,100); color: white; border-radius: 50%; font-size: 12px;">
								${rooms.room_alarm_count}
								</div>
							</div>
						</div>
					`);
				}
			},
			error: function (xhr, status, error) {
				if (status !== 'abort') {
					console.error('AJAX 요청 실패:', status, error);
					console.log('xhr:', xhr);
				}
			}
		}); // ajax end
	}
}

function inviteRoom(emp_id,room_id){
	$.ajax({
		url: '/message/invite',
		type: 'GET',
		data: { emp_id: emp_id ,
				room_id : room_id,
		},
		success: function (data) {
			console.log('invite result : ',data)
			console.log(emp_id + ' is entered into ' + data);
			getMessages(data,null);
			console.log('reset chat room ' + data);
			
			if (message_check_interval) {
				clearInterval(message_check_interval);
			}
			
			if(data == 0){
				alert('초대 할 수 없는 사용자입니다.');
				message_check_interval = setInterval(function() {
					getMessages(room_id,null);
				}, 1000);
			}
			
			if(data == -1){
				alert('이미 해당 방에 입장한 사용자 입니다.');
				message_check_interval = setInterval(function() {
					getMessages(room_id,null);
				}, 1000);
			}
			if(data == 0 && data == -1){
				
				message_check_interval = setInterval(function() {
					getMessages(data,null);
				}, 1000);
			}
		},error:function (xhr, status, error) {
			alert('초대에 실패했습니다.');
		}
	});
}

function getOutRoom(room_id){
	$.ajax({
		url: '/message/getOutRoom',
		type: 'GET',
		data: {room_id : room_id},
		success: function (data) {
			console.log('exit from' + room_id);
			console.log('get Room List again');
		},error:function (xhr, status, error) {
			if (status !== 'abort') {
				console.error('AJAX 요청 실패:', status, error);
				console.log('xhr:', xhr);
			}
		}
	});
}

function checkRoomList() {
    if ($('.messenger_body_chat.list').css('display') === 'block') {
        chatRoomList(); // 메서드 실행
    }
}

function checkMember() {
    if ($('.messenger_body_menu').css('display') === 'block') {
        getMembers(); // 메서드 실행
    }
}
