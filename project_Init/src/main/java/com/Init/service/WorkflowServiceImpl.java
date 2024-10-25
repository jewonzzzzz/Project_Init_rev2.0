package com.Init.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.domain.EmployeeVO;
import com.Init.domain.WorkflowVO;
import com.Init.persistence.EmployeeDAO;
import com.Init.persistence.WorkflowDAO;

// @Service : 서비스영역 (비지니스 로직 영역)에서의 동작을 구현하도록 설정
// 			  root-context.xml에 빈(MemberService)으로 등록


/*
 * 비지니스 영역, Action 페이지, pro.jsp 동작을 처리하는 공간
 *   => 컨트롤러와 DAO를 연결하는 다리 역할을 함  / 완충영역
 *   => 고객사마다 유연한 대처가 가능
 * 
 */


@Service
public class WorkflowServiceImpl implements WorkflowService{

	private static final Logger logger = LoggerFactory.getLogger(WorkflowServiceImpl.class);
	
	// MemberDAO 객체 주입
	@Inject
	private WorkflowDAO wdao;

	@Override
	public List<WorkflowVO> showSentWorkflowList(String userid,String status) {
		logger.debug("WorkflowServiceImpl : showSentWorkflowList(String userid,String status) 실행");
		List<WorkflowVO> workflowList = wdao.getSentWorkflowList(userid,status);
		
		return workflowList;
	}
	
	@Override
	public List<WorkflowVO> showReceivedWorkflowList(String userid,String status) {
		logger.debug("WorkflowServiceImpl : showReceivedWorkflowList(String userid,String status) 실행");
		List<WorkflowVO> workflowList = wdao.getReceivedWorkflowList(userid,status);
		
		return workflowList;
	}

	@Override
	public WorkflowVO showWorkflow(String wf_code) {
		logger.debug("WorkflowServiceImpl : showWorkflow(String wf_code) 실행");
		WorkflowVO result = wdao.getWorkflow(wf_code);
		
		return result;
	}

	@Override
	public int responseWorkflow(WorkflowVO vo) {
		logger.debug("WorkflowServiceImpl : responseWorkflow(WorkflowVO vo) 실행");
		
		return wdao.updateWorkflow(vo);
	}

	@Override
	public Map<String,Object> realtimeCheckWorkflow(String emp_id) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("sentWorkflowList",wdao.alarmSentWorkflowList(emp_id));
		resultMap.put("receivedWorkflowList",wdao.alarmReceivedWorkflowList(emp_id));
		resultMap.put("smallAlarm",wdao.getSmallAlarm(emp_id));
		
		return resultMap;
	}

	@Override
	public Map<String,Object> loginCheckWorkflow(String emp_id) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("sentWorkflowList",wdao.loginAlarmSentWorkflowList(emp_id));
		resultMap.put("receivedWorkflowList",wdao.loginAlarmReceivedWorkflowList(emp_id));
		resultMap.put("smallAlarm",wdao.getSmallAlarm(emp_id));
		
		return resultMap;
	}

}
