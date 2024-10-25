package com.Init.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.Init.domain.EmployeeVO;
import com.Init.domain.MessageVO;
import com.Init.domain.SettingVO;
import com.Init.service.EmployeeService;
import com.Init.service.MessageService;
import com.Init.service.WorkflowService;

@Controller
@RequestMapping(value = "/message/*")
public class MessageController {
	
	@Inject
	private EmployeeService mService;
	@Inject
	private WorkflowService wService;
	@Inject
	private MessageService msgService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value = "/getTeam",method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> getTeam(HttpSession session) {
		String emp_id = (String)session.getAttribute("emp_id");
		List<EmployeeVO> memberList = mService.getTeammate(emp_id);
		SettingVO favoriteEmpList = msgService.showMessengerSetting(emp_id);
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("memberList", memberList);	
		data.put("favoriteEmpList", favoriteEmpList);	
		
		return data;
	}

	@RequestMapping(value = "/getChatRoomList",method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> showChatRoomList(HttpSession session) {
		String emp_id = (String)session.getAttribute("emp_id");
		String emp_name = (String)session.getAttribute("emp_name");
		List<MessageVO> chatRoomList = msgService.getChatRoomList(emp_id,emp_name);
		List<MessageVO> favoriteChatRoomList = msgService.getFavoriteChatRoomList(emp_id,emp_name);
		
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("chatRoomList", chatRoomList);	
		data.put("favoriteChatRoomList", favoriteChatRoomList);	
		return data;
	}
	
	@RequestMapping(value = "/getMessages",method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> getMessages(HttpSession session, @RequestParam(required = false) Integer room_id, @RequestParam(required = false) String receiver_emp_id ) {
		logger.debug("/member/getMessages -> getMessages("+room_id+","+receiver_emp_id+") 실행");
		String emp_id = (String)session.getAttribute("emp_id");
		String emp_name = (String)session.getAttribute("emp_name");
		
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("emp_id", session.getAttribute("emp_id"));	
		
		/* 개인톡으로 접근 */
		if(room_id == null) {
			logger.debug(emp_id + " 사용자가 " + receiver_emp_id +" 사용자와의 개인 채팅방에 접속하였습니다.");
			data.put("personal_receiver_memberVO", mService.memberInfo(receiver_emp_id));
			
			List<MessageVO> messageList = msgService.openPersonalChat(emp_id, receiver_emp_id);
			if (!messageList.isEmpty() && messageList.get(0) != null) {
				messageList.get(0).setRoom_name(
				messageList.get(0).getRoom_name().replaceAll("(^|,)"+ emp_name + "(,|$)", "$1$2")
	            .replaceAll(",,", ",") 
	            .replaceAll("^,|,$", "")
	            );
			}
			data.put("messageList", messageList);
		}else {
			logger.debug(emp_id + " 사용자가 " + room_id +" 번 채팅방에 접속하였습니다.");
			
			
			List<MessageVO> messageList = msgService.openChatRoom(emp_id, room_id);
			if (!messageList.isEmpty() && messageList.get(0) != null) {
				messageList.get(0).setRoom_name(
				messageList.get(0).getRoom_name().replaceAll("(^|,)\\s*" + emp_name.trim() + "\\s*(,|$)", "$1$2") 
			    .replaceAll(",,", ",")  
			    .replaceAll("^,|,$", "")
	            );
			}
			data.put("messageList", messageList);
		}
		return data;
	}
	
	@RequestMapping(value = "/sendMessage",method = RequestMethod.POST)
	@ResponseBody
	public Integer sendMessage(HttpSession session, MessageVO vo) {
		logger.debug("/member/sendMessage -> sendMessage() 실행 :"+vo);
		String emp_id = (String)session.getAttribute("emp_id");
		String emp_name = (String)session.getAttribute("emp_name");
		vo.setPersonal_sender_emp_id(emp_id);
		vo.setPersonal_sender_emp_name((String)session.getAttribute("emp_name"));
		vo.setPersonal_sender_emp_position((String)session.getAttribute("emp_position"));
		int room_id = vo.getRoom_id();
		
		if(room_id==0) {
			room_id = msgService.createChatRoom(vo);
			logger.debug("새로운 채팅방을 생성합니다."+ room_id +" 번 채팅방이 생성되었습니다.");
			logger.debug("생성된 채팅방은 다음 데이터를 기반으로 합니다. :"+ vo);
			vo.setRoom_id(room_id);
			vo.setEnter_emp_id(vo.getPersonal_receiver_emp_id());
			msgService.enterRoom(vo);
			vo.setEnter_emp_id(vo.getPersonal_sender_emp_id());
			msgService.enterRoom(vo);
		}
		
		logger.debug(room_id+"번 채팅방에 "+emp_id+" 사용자가 채팅을 입력하였습니다.");
		logger.debug("채팅 입력값 :"+vo);
		msgService.sendMessage(vo);
		
		return vo.getRoom_id();
	}
	
	@RequestMapping(value = "/msgSearch",method = RequestMethod.GET)
	@ResponseBody
	public List<MessageVO> searchToMessage(HttpSession session,String keyword) {
		String emp_id = (String)session.getAttribute("emp_id");
		logger.debug(" /member/msgSearch -> searchToMessage("+emp_id+","+keyword+"); 실행");
		
		List<MessageVO> roomList = msgService.searchRoom(emp_id,keyword);
		return roomList;
	}
	
	@RequestMapping(value = "/invite",method = RequestMethod.GET)
	@ResponseBody
	public int inviteToRoom(HttpSession session,String emp_id, int room_id) {
		logger.debug(" /member/invite -> invite("+emp_id+","+room_id+"); 실행");
		int currentPeopleCount = msgService.countParticipant(room_id);
		logger.debug(" /member/invite -> "+room_id+"번 채팅방의 현재 참가자 수 :"+currentPeopleCount);
		
		String inviter_emp_id = (String)session.getAttribute("emp_id");
		String inviter_emp_name = (String)session.getAttribute("emp_name");
		
		MessageVO room_info = msgService.checkRoomInfo(room_id);
		EmployeeVO new_person = mService.memberInfo(emp_id);
		
		if(inviter_emp_id.equals(emp_id)) {
			return 0;
		}
		
		for(EmployeeVO vo : room_info.getRoom_people()) {
			if(vo.getEmp_id().equals(emp_id)){
				return -1;
			}
		}
		
		if(currentPeopleCount>2) {
			logger.debug(" 단톡방 초대 실행 ");
			MessageVO vo = new MessageVO();
			vo.setInviter_emp_id(inviter_emp_id);
			vo.setInviter_emp_name(inviter_emp_name);
			vo.setRoom_id(room_id);
			vo.setEnter_emp_id(emp_id);
			vo.setEnter_emp_name(mService.memberInfo(emp_id).getEmp_name());
			vo.setMsg_content(inviter_emp_name+"님이 "+vo.getEnter_emp_name()+"님을 초대하였습니다.");
			logger.debug(inviter_emp_name+"님이 기존의 "+room_id+"번 단체 대화방에 "+vo.getEnter_emp_name()+"님을 초대하였습니다.");
			logger.debug("System Message : "+inviter_emp_name+"님이 "+vo.getEnter_emp_name()+"님을 초대하였습니다.");
			msgService.systemMessage(vo);
			logger.debug("System Message : "+vo.getEnter_emp_name()+"님이 대화방에 입장하셨습니다.");
			vo.setMsg_content(vo.getEnter_emp_name()+"님이 대화방에 입장하셨습니다.");
			msgService.systemMessage(vo);
			msgService.enterRoom(vo);
			msgService.changeRoomName(vo);
			return room_id;
		}else {
			logger.debug(" 개인톡 -> 단체톡 생성 및 이동 실행 ");
			
			StringBuilder prev_room_name = new StringBuilder();
			List<String> people_emp_id = new ArrayList<String>();
			List<String> people_emp_name = new ArrayList<String>();
			
			logger.debug("room_info :"+room_info);

			for (EmployeeVO vo : room_info.getRoom_people()) {
			    if (prev_room_name.length() > 0) {
			        prev_room_name.append(", ");
			    }
			    prev_room_name.append(vo.getEmp_name());
			    people_emp_id.add(vo.getEmp_id());
			    people_emp_name.add(vo.getEmp_name());
			}
			
			String new_room_name = prev_room_name.append(", "+ new_person.getEmp_name()).toString();
			MessageVO param = new MessageVO();
			param.setRoom_name(new_room_name);
			param.setRoom_admin(inviter_emp_id);
			room_id = msgService.createPartyRoom(param);
			param.setRoom_id(room_id);
			
			MessageVO sysMsg = new MessageVO();
			sysMsg.setRoom_id(room_id);
			
			sysMsg.setMsg_content("새로운 채팅방이 개설되었습니다.");
			msgService.systemMessage(sysMsg);
			
			sysMsg.setMsg_content(inviter_emp_name+"님이 "+people_emp_name.get(1)+", "+new_person.getEmp_name()+"님을 초대하였습니다.");
			msgService.systemMessage(sysMsg);
			
			param.setEnter_emp_id(people_emp_id.get(0));
			msgService.enterRoom(param);
			param.setEnter_emp_id(people_emp_id.get(1));
			msgService.enterRoom(param);
			param.setEnter_emp_id(new_person.getEmp_id());
			msgService.enterRoom(param);
			
			logger.debug(inviter_emp_name+"님이 새로 생성된 "+room_id+"번 단체 대화방에 "+people_emp_name.get(1)+", "+new_person.getEmp_name()+"님을 초대하였습니다.");
			return room_id;
		}
	}
	
	@RequestMapping(value = "/getOutRoom",method = RequestMethod.GET)
	@ResponseBody
	public void getOutRoom(HttpSession session, int room_id) {
		String emp_id = (String)session.getAttribute("emp_id");
		String emp_name = (String)session.getAttribute("emp_name");
		logger.debug(" /member/getOutRoom -> getOutRoom("+emp_id+","+room_id+"); 실행");
		MessageVO vo = new MessageVO();
		vo.setRoom_id(room_id);
		vo.setLeaver_emp_id(emp_id);
		vo.setLeaver_emp_name(mService.memberInfo(emp_id).getEmp_name());
		msgService.exitRoom(vo);
		msgService.cutRoomName(vo);
		vo.setMsg_content(emp_name+"님이 대화방에서 퇴장하였습니다.");
		msgService.systemMessage(vo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/follow",method = RequestMethod.GET)
	public void followEmp(HttpSession session, String emp_id, Integer room_id) {
		String user_emp_id = (String)session.getAttribute("emp_id");
		logger.debug(" follow("+user_emp_id+","+emp_id+"); 실행");
		if(emp_id != null && room_id == null) {
			mService.followEmp(user_emp_id, emp_id);
		}
		if(emp_id == null && room_id != null) {
			msgService.followRoom(user_emp_id, room_id);
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/unfollow",method = RequestMethod.GET)
	public void unFollowEmp(HttpSession session, String emp_id, Integer room_id) {
		String user_emp_id = (String)session.getAttribute("emp_id");
		logger.debug(" unfollow("+user_emp_id+","+emp_id+"); 실행");
		if(emp_id != null && room_id == null) {
			mService.unFollowEmp(user_emp_id, emp_id);
		}
		if(emp_id == null && room_id != null) {
			msgService.unfollowRoom(user_emp_id, room_id);
		}
	}

}
