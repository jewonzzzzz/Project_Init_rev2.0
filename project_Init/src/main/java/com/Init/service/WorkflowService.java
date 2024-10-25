package com.Init.service;

import java.util.List;
import java.util.Map;

import com.Init.domain.EmployeeVO;
import com.Init.domain.WorkflowVO;

public interface WorkflowService {
	
	public List<WorkflowVO> showSentWorkflowList(String emp_id,String status);
	public List<WorkflowVO> showReceivedWorkflowList(String emp_id,String status);
	public WorkflowVO showWorkflow(String wf_code);
	public int responseWorkflow(WorkflowVO vo);
	public Map<String,Object> realtimeCheckWorkflow(String emp_id);
	public Map<String,Object> loginCheckWorkflow(String emp_id);
}
