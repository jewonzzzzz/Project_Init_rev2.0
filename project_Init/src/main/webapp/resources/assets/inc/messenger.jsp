<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="${pageContext.request.contextPath }/resources/assets/js/chat.js"></script>

<div id="open_messenger" class="col-md-4" style="display:none; flex-direction:column; justify-content: flex-end;  align-content: flex-end;">
	<div class="card-box md">
		<div class="card">
			<div class="card-header">
			<h4 class="card-title">MESSENGER</h4>
			</div>	
			<div class="card-body">
				<div class="messenger_body">
					<!-- 메뉴 -->
					<div class="messenger_body_menu">
						<div class="messenger_search" style="width:100%; height:40px;">
							<i class="fa-solid fa-magnifying-glass" style="width:15%; line-height:30px; justify-content: center; text-align: center; font-size:15px;"></i>
							<input id="messenger_search" oninput="messenger_search(this.value)" type="text" style="width:80%; line-height:30px;" placeholder="두글자 이상의 검색어를 입력하세요."/>
						</div>
					</div>
					<!-- 메뉴 -->
					
					<!-- 채팅목록 -->
					<div class="messenger_body_chat list">
						<div class="messenger_room_search" style="width:100%; height:40px;">
							<i class="fa-solid fa-magnifying-glass" style="width:10%; line-height:30px;  justify-content: center; text-align: center; font-size:15px;"></i>
							<input id="room_search" oninput="room_search(this.value)" type="text" style="width:85%; line-height:30px;" placeholder="두글자 이상의 검색어를 입력하세요."/>
						</div>
					</div>
					<!-- 채팅목록 -->
					
					<!-- 채팅방-->
					<div class="messenger_body_chat room" style="display:none">
						<!-- 채팅방 상단 -->
						<div class="head_chat" style="display:flex; flex:0.1; width:100%; box-shadow: 0 3px 5px rgba(0, 0, 0, 0.4); background-color: rgba(0,0,0,0.7); color: rgb(250,250,250); font-size:18px; padding:0 10px;">
							<div id ="to_chat_list" style="display:flex; flex:0.1; justify-content: center; align-items: center;">
								<button style="border: none;">
									<i style="color: rgb(250,250,250);  font-size:22px;" class="fa-solid fa-arrow-left"></i>
								</button>
							</div>
							<div style="display:flex; flex:0.8;">
								<div class="chat_room_name" style="display:flex; width:100%; padding-left:10px; justify-content: flex-start; align-items: center;">
								</div>
							</div>
							<div class ="messenger_exit_room" style="display:flex; flex:0.1; justify-content: center; align-items: center; position: relative;">
								<button style="border: none;">
									<i style="color: rgb(250,250,250); font-size:22px;" class="fa-solid fa-arrow-right-from-bracket"></i>
								</button>
							</div>
						</div>
						<!-- 채팅방 상단 -->
						
						
						
						<!-- 채팅방 안쪽 -->
						<div class="chat_content" style="display:flex; flex-direction:column; flex:0.7; width:100%; padding:0 10px; overflow-y: auto; background-color: rgba(100,100,100,0.1); overflow-x: hidden;"> 
						</div>
						<!-- 채팅방 안쪽 -->
						
						<!-- 채팅방 입력란 -->
						<div class="chat_input" style="display:flex; flex:0.2; width:100%; border-top:1px solid rgba(0,0,0,0.5); box-shadow: 0 -3px 5px rgba(0, 0, 0, 0.7);"> 
							<form id="message_send_form" action="/member/sendMessage" method="POST" style="display:flex; width:100%; height:100%;">
								<div id="msg_textarea" style="flex:0.9; height:100%;">
									<input id="hidden_room_id" type="hidden" name="room_id"></input>
									<input id="hidden_personal_receiver_emp_id" type="hidden" name="personal_receiver_emp_id"></input>
									<input id="hidden_personal_receiver_emp_name" type="hidden" name="personal_receiver_emp_name"></input>
									<textarea id="msg_content" name="msg_content" style="width:100%; height:100%; resize: none;"></textarea>
								</div>
								<div id="msg_submit" style="display:flex; flex:0.1; height:100%; justify-content: center; align-items: center;">
									<button type="submit" style="width:100%; height:100%; cursor: pointer;" >
										<i style="background:transparent;" class="fa-solid fa-paper-plane"></i>
									</button>
								</div>
							</form>
						</div>
						<!-- 채팅방 입력란 -->
					</div>
					<!-- 채팅방 -->
					
					
					
				</div>
			</div>
		</div>
	</div>
</div>		