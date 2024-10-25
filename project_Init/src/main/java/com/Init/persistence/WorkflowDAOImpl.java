package com.Init.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.Init.domain.EmployeeVO;
import com.Init.domain.WorkflowVO;
import com.Init.service.WorkflowServiceImpl;

/**
 *	 MemberDAO 동작을 수행 
 *
 */
// @Repository  : 스프링이 해당클래스를 DAO객체 (Bean)로 인식
//                root-context.xml파일에서 해당객체를 사용하도록 설정

@Repository
public class WorkflowDAOImpl implements WorkflowDAO {

	@Inject
	private SqlSession sqlSession; // 자동으로 연결,자원해제,SQL실행,mybatis...
	
	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.Init.mapper.WorkflowMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(WorkflowServiceImpl.class);

	@Override
	public WorkflowVO getWorkflow(String wf_code) {
		WorkflowVO result = sqlSession.selectOne(NAMESPACE + ".getWorkflow",wf_code);
		logger.debug(" 실행 결과 : "+result);
		
		return result;
	}

	@Override
	public List<WorkflowVO> getSentWorkflowList(String emp_id,String status) {
		
		WorkflowVO vo = new WorkflowVO();
		
		vo.setWf_sender(emp_id);
		vo.setWf_status(status);
		
		List<WorkflowVO>result = sqlSession.selectList(NAMESPACE + ".getSentWorkflowList",vo);
		logger.debug(" 실행 결과 (개수): "+result.size());
		
		return result;
	}
	
	@Override
	public List<WorkflowVO> getReceivedWorkflowList(String emp_id,String status) {
		
		WorkflowVO vo = new WorkflowVO();
		
		vo.setWf_receiver(emp_id);
		vo.setWf_status(status);
		
		List<WorkflowVO>result = sqlSession.selectList(NAMESPACE + ".getReceivedWorkflowList",vo);
		logger.debug(" 실행 결과 (개수): "+result.size());
		
		return result;
	}

	@Override
	public int updateWorkflow(WorkflowVO vo) {
		logger.debug(" WorkflowDAOImpl : updateWorkflow("+vo+") 실행");
		return sqlSession.update(NAMESPACE + ".responseWorkflow", vo);
	}

	@Override
	public List<WorkflowVO> alarmSentWorkflowList(String emp_id) {
		List<WorkflowVO> resultList= sqlSession.selectList(NAMESPACE + ".realtimeAlarmSentWorkflow", emp_id);
		for(WorkflowVO workflowVO : resultList) {
			sqlSession.update(NAMESPACE + ".workflowSenderAlarmCheck", workflowVO.getWf_code());
			logger.debug("wf_code : " + workflowVO.getWf_code()+ " : 발신자가 업데이트된 내용에 대한 알람을 받았습니다. 발신자 알람 토큰을 제거합니다. ");
		}
		return resultList;
	}

	@Override
	public List<WorkflowVO> alarmReceivedWorkflowList(String emp_id) {
		List<WorkflowVO> resultList= sqlSession.selectList(NAMESPACE + ".realtimeAlarmReceivedWorkflow", emp_id);
		for(WorkflowVO workflowVO : resultList) {
			sqlSession.update(NAMESPACE + ".workflowReceiverAlarmCheck", workflowVO.getWf_code());
			logger.debug("wf_code : " + workflowVO.getWf_code()+ " : 수신자가 워크플로우에 대한 알람을 받았습니다. 수신자 알람 토큰을 제거합니다. ");
		}
		return resultList;
	}
	
	@Override
	public List<WorkflowVO> loginAlarmSentWorkflowList(String emp_id) {
		List<WorkflowVO> resultList= sqlSession.selectList(NAMESPACE + ".loginAlarmSentWorkflow", emp_id);
			for(WorkflowVO workflowVO : resultList) {
				sqlSession.update(NAMESPACE + ".workflowSenderAlarmCheck", workflowVO.getWf_code());
				logger.debug("wf_code : " + workflowVO.getWf_code()+ " : 발신자가 업데이트 내용에 대한 알람을 받았습니다. 발신자 알람 토큰을 제거합니다. ");
			}
		return resultList;
	}
	
	@Override
	public List<WorkflowVO> loginAlarmReceivedWorkflowList(String emp_id) {
		List<WorkflowVO> resultList= sqlSession.selectList(NAMESPACE + ".loginAlarmReceivedWorkflow", emp_id);
			for(WorkflowVO workflowVO : resultList) {
				sqlSession.update(NAMESPACE + ".workflowReceiverAlarmCheck", workflowVO.getWf_code());
				logger.debug("wf_code : " + workflowVO.getWf_code()+ " : 수신자가 워크플로우에 대한 알람을 받았습니다. 수신자 알람 토큰을 제거합니다. ");
			}
		return resultList;
	}

	@Override
	public int getSmallAlarm(String emp_id) {
		return sqlSession.selectOne(NAMESPACE + ".smallAlarm", emp_id);
	}
	
	

	
}