package com.Init.persistence;

import java.util.List;

import com.Init.domain.EmployeeVO;
import com.Init.domain.MessageVO;
import com.Init.domain.SettingVO;

public interface MessageDAO {

	public int check_personal_chat(String sender_emp_id, String receiver_emp_id);
	public void insert_participant(MessageVO vo);
	public void delete_participant(MessageVO vo);
	public int insert_message(MessageVO vo);
	public List<MessageVO> join_messages(String reader, Integer room_id);
	public int insert_msg_room(MessageVO vo);
	public int insert_party_room(MessageVO vo);
	public List<MessageVO> select_rooms(String emp_id);
	public List<MessageVO> select_favorite_rooms(String emp_id);
	public List<MessageVO> search_into_rooms(String emp_id,String keyword);
	public void update_room_info(MessageVO vo);
	public void update_room_name(MessageVO vo);
	public void delete_room_name(MessageVO vo);
	public List<EmployeeVO> get_person(int room_id);
	public List<MessageVO> get_message_unread_alarm(String emp_id);
	public List<MessageVO> get_message_realtime_alarm(String emp_id);
	public void insert_system_message(MessageVO vo);
	public int check_participant_count(int room_id);
	public MessageVO get_room_info(int room_id);
	public SettingVO get_messenger_setting(String emp_id);
	public void insert_follow_room(String emp_id,Integer room_id);
	public void delete_follow_room(String emp_id,Integer room_id);
	public String getRoomName(Integer room_id);
	
}