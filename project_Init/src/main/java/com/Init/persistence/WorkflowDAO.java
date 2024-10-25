package com.Init.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.Init.domain.EmployeeVO;
import com.Init.domain.WorkflowVO;

/**
 *	tbl_memeber 테이블의 데이터를 활용하는 동작을 정의 
 *
 */
public interface WorkflowDAO {

	public WorkflowVO getWorkflow(String wf_code);
	public List<WorkflowVO> getSentWorkflowList(String userid,String status);
	public List<WorkflowVO> getReceivedWorkflowList(String userid,String status);
	public int updateWorkflow(WorkflowVO vo);
	public List<WorkflowVO> alarmSentWorkflowList(String emp_id);
	public List<WorkflowVO> alarmReceivedWorkflowList(String emp_id);
	public List<WorkflowVO> loginAlarmSentWorkflowList(String emp_id);
	public List<WorkflowVO> loginAlarmReceivedWorkflowList(String emp_id);
	public int getSmallAlarm(String emp_id);
}
