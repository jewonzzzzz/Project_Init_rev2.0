package com.Init.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.domain.EmployeeVO;
import com.Init.domain.MessageVO;
import com.Init.domain.SettingVO;
import com.Init.persistence.EmployeeDAO;
import com.Init.persistence.MessageDAO;

// @Service : 서비스영역 (비지니스 로직 영역)에서의 동작을 구현하도록 설정
// 			  root-context.xml에 빈(MemberService)으로 등록

/*
 * 비지니스 영역, Action 페이지, pro.jsp 동작을 처리하는 공간
 *   => 컨트롤러와 DAO를 연결하는 다리 역할을 함  / 완충영역
 *   => 고객사마다 유연한 대처가 가능
 * 
 */

@Service
public class MessageServiceImpl implements MessageService{

	private static final Logger logger = LoggerFactory.getLogger(MessageServiceImpl.class);
	
	// MemberDAO 객체 주입
	@Autowired
	private MessageDAO msgdao;
	
	@Inject
	private EmployeeDAO mdao;
	
	@Override
	public List<MessageVO> openPersonalChat(String sender_emp_id, String receiver_emp_id) {
		logger.debug("msgServiceImpl : openPersnalChat ("+sender_emp_id+", "+receiver_emp_id+") 실행");
		
		return msgdao.join_messages(sender_emp_id,msgdao.check_personal_chat(sender_emp_id, receiver_emp_id));
	}

	@Override
	public List<MessageVO> openChatRoom(String msg_reader,Integer room_id) {
		logger.debug("msgServiceImpl : openChatRoom ("+msg_reader+","+room_id+")실행");
		
		return msgdao.join_messages(msg_reader, room_id);
	}
	
	@Override
	public int createChatRoom(MessageVO vo) {
		logger.debug("msgServiceImpl : createChatRoom 실행");
		return msgdao.insert_msg_room(vo);
	}
	
	@Override
	public void enterRoom(MessageVO vo) {
		logger.debug("msgServiceImpl : enterRoom 실행");
		msgdao.insert_participant(vo);
		logger.debug("msgServiceImpl : "+vo.getRoom_id()+"번 채팅방에 "+vo.getEnter_emp_id()+"사용자가 입장하였습니다.");
	}
	
	@Override
	public void sendMessage(MessageVO vo) {
		logger.debug("msgServiceImpl : sendMessage 실행");
		msgdao.insert_message(vo);
		msgdao.update_room_info(vo);
	}

	@Override
	public List<MessageVO> getChatRoomList(String emp_id,String emp_name) {
		List<MessageVO> result = msgdao.select_rooms(emp_id);
		for(MessageVO vo : result) {			
			
			if((vo.getRoom_name().split(",")).length==2) {	
				List<EmployeeVO> people = msgdao.get_person(vo.getRoom_id());		
				for(EmployeeVO person : people) {									
					if(!person.getEmp_id().equals(emp_id)){						
						vo.setRoom_thumbnail(person.getEmp_profile());			
					}
				}
			}
			
			logger.debug("기존의 room_name : "+vo.getRoom_name()+"에서 "+emp_name+"을 제거합니다.");
			vo.setRoom_name(
					vo.getRoom_name()
				    .replaceAll("(^|,)\\s*" + emp_name.trim() + "\\s*(,|$)", "$1$2")  // 쉼표 뒤 공백 포함하여 이름 제거
				    .replaceAll(",,", ",")   // 중복 쉼표 제거
				    .replaceAll("^,|,$", "") // 앞뒤 쉼표 제거
            );
			
	        logger.debug("본인 이름을 제거한 room_name : "+vo.getRoom_name());
		}
		return result;
	}
	
	@Override
	public List<MessageVO> getFavoriteChatRoomList(String emp_id,String emp_name) {
		List<MessageVO> result = msgdao.select_favorite_rooms(emp_id);
		for(MessageVO vo : result) {			
			
			if((vo.getRoom_name().split(",")).length==2) {	
				List<EmployeeVO> people = msgdao.get_person(vo.getRoom_id());		
				for(EmployeeVO person : people) {									
					if(!person.getEmp_id().equals(emp_id)){						
						vo.setRoom_thumbnail(person.getEmp_profile());			
					}
				}
			}
			
			logger.debug("기존의 room_name : "+vo.getRoom_name()+"에서 "+emp_name+"을 제거합니다.");
			vo.setRoom_name(
					vo.getRoom_name()
				    .replaceAll("(^|,)\\s*" + emp_name.trim() + "\\s*(,|$)", "$1$2")  // 쉼표 뒤 공백 포함하여 이름 제거
				    .replaceAll(",,", ",")   // 중복 쉼표 제거
				    .replaceAll("^,|,$", "") // 앞뒤 쉼표 제거
            );
			
	        logger.debug("본인 이름을 제거한 room_name : "+vo.getRoom_name());
		}
		return result;
	}

	@Override
	public List<MessageVO> searchRoom(String emp_id, String keyword) {
			
		return msgdao.search_into_rooms(emp_id,keyword);
	}

	@Override
	public void changeRoomName(MessageVO vo) {
		 msgdao.update_room_name(vo);
	}

	@Override
	public void exitRoom(MessageVO vo) {
		msgdao.delete_participant(vo);
	}

	@Override
	public void cutRoomName(MessageVO vo) {
		msgdao.delete_room_name(vo);
	}
	
	@Override
	public void systemMessage(MessageVO vo) {
		msgdao.insert_system_message(vo);
	}

	@Override
	public List<MessageVO> getMessageUnreadAlarm(String emp_id) {
		return msgdao.get_message_unread_alarm(emp_id);
	}

	@Override
	public List<MessageVO> getMessageRealtimeAlarm(String emp_id) {
		List<MessageVO> result = msgdao.get_message_realtime_alarm(emp_id);
		
		String emp_name = mdao.getMember(emp_id).getEmp_name();
		
		for(MessageVO vo : result) {
			vo.setRoom_name(
					vo.getRoom_name()
				    .replaceAll("(^|,)\\s*" + emp_name.trim() + "\\s*(,|$)", "$1$2")  // 쉼표 뒤 공백 포함하여 이름 제거
				    .replaceAll(",,", ",")   // 중복 쉼표 제거
				    .replaceAll("^,|,$", "") // 앞뒤 쉼표 제거
	        );
		}
		return result;
	}

	@Override
	public int countParticipant(int room_id) {
		return msgdao.check_participant_count(room_id);
	}

	@Override
	public MessageVO checkRoomInfo(int room_id) {
		return msgdao.get_room_info(room_id);
	}

	@Override
	public int createPartyRoom(MessageVO vo) {
		int result = msgdao.insert_party_room(vo);
		logger.debug("msgServiceImpl : createPartyRoom 실행 :" + result + "번 채팅방 생성");
		return result;
	}

	@Override
	public SettingVO showMessengerSetting(String emp_id) {
		return msgdao.get_messenger_setting(emp_id);
	}

	@Override
	public void followRoom(String emp_id, Integer room_id) {
		msgdao.insert_follow_room(emp_id, room_id);
	}

	@Override
	public void unfollowRoom(String emp_id, Integer room_id) {
		msgdao.delete_follow_room(emp_id, room_id);
	}
	
	
}
