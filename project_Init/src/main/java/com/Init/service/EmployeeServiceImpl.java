package com.Init.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.domain.EmployeeVO;
import com.Init.domain.SettingVO;
import com.Init.persistence.EmployeeDAO;

// @Service : 서비스영역 (비지니스 로직 영역)에서의 동작을 구현하도록 설정
// 			  root-context.xml에 빈(MemberService)으로 등록


/*
 * 비지니스 영역, Action 페이지, pro.jsp 동작을 처리하는 공간
 *   => 컨트롤러와 DAO를 연결하는 다리 역할을 함  / 완충영역
 *   => 고객사마다 유연한 대처가 가능
 * 
 */


@Service
public class EmployeeServiceImpl implements EmployeeService{

	private static final Logger logger = LoggerFactory.getLogger(EmployeeServiceImpl.class);
	
	// MemberDAO 객체 주입
	@Autowired
	private EmployeeDAO mdao;
	
	@Override
	public EmployeeVO memberLogin(EmployeeVO vo) {
		return mdao.checkMember(vo);
	}
	
	@Override
	public EmployeeVO memberInfo(String userid) {
		logger.debug(" memberInfo(String userid) 실행)");

		return mdao.getMember(userid);
	};
	
	@Override
	public List<EmployeeVO> memberSearch(String keyword) {
		logger.debug(" memberSearch(String keyword) 실행)");
		return mdao.getMemberList(keyword);
	}

	@Override
	public List<EmployeeVO> getTeammate(String emp_id) {
		return mdao.getTeamList(emp_id);
	}

	@Override
	public List<SettingVO> searchTools(String keyword) {
		return mdao.getToolList(keyword);
	}

	@Override
	public void settingFavoriteTool(SettingVO vo) {
		mdao.updateFavoriteTool(vo);
	}

	@Override
	public SettingVO showSetting(String emp_id) {
		return mdao.getSetting(emp_id);
	}

	@Override
	public void userLogout(String emp_id) {
		mdao.updateLogout(emp_id);
	};
	
	@Override
	public void userLogin(String emp_id) {
		mdao.updateLogin(emp_id);
	}

	@Override
	public void followEmp(String user_emp_id, String emp_id) {
		mdao.insertFollowEmp(user_emp_id, emp_id);
	}

	@Override
	public void unFollowEmp(String user_emp_id, String emp_id) {
		mdao.deleteFollowEmp(user_emp_id, emp_id);
	};
	
	
}
