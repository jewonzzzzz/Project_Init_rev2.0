package com.Init.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.Init.domain.EmployeeVO;
import com.Init.domain.WorkflowVO;
import com.Init.persistence.EmployeeDAO;
import com.Init.persistence.WorkflowDAO;
import com.Init.persistence.WorkflowDAOImpl;
import com.Init.service.EduService;
import com.Init.service.EmployeeService;
import com.Init.service.MessageService;
import com.Init.service.SalaryService;
import com.Init.service.WorkflowService;

@Controller
@RequestMapping(value = "/work/*")
public class WorkflowController {
	
	@Inject
	private EmployeeService mService;
	
	@Inject
	private WorkflowService wService;

	@Inject
	private MessageService msgService;
	
	@Inject
	private SalaryService sService;
	
	@Inject
	private EduService eService;
	
	private static final Logger logger = LoggerFactory.getLogger(WorkflowController.class);

	@RequestMapping(value = "/workflow",method = RequestMethod.GET)
	public void workflowGET(HttpSession session, Model model) {
		logger.debug(" /work/workflow -> workflowGET()실행 ");
		logger.debug(" 연결된 뷰페이지 (views/work/workflow.jsp)로 이동 ");
		
		String emp_id = (String)session.getAttribute("emp_id");
		logger.debug(" workflow 조회 대상 아이디 : "+emp_id);
		
		List<WorkflowVO> sentWorkflowList = wService.showSentWorkflowList(emp_id,"1");
		List<WorkflowVO> receivedWorkflowList = wService.showReceivedWorkflowList(emp_id,"1");
		
		model.addAttribute("sentWorkflowList",sentWorkflowList);
		model.addAttribute("receivedWorkflowList",receivedWorkflowList);
	}
	
	@RequestMapping(value = "/workoff",method = RequestMethod.GET)
	public void workoffGET(HttpSession session, Model model) {
		logger.debug(" /work/workoff -> workoffGET()실행 ");
		logger.debug(" 연결된 뷰페이지 (views/work/workoff.jsp)로 이동 ");
		
		String emp_id = (String)session.getAttribute("emp_id");
		logger.debug(" workflow 조회 대상 아이디 : "+emp_id);
		
		List<WorkflowVO> sentWorkflowList = wService.showSentWorkflowList(emp_id,"0");
		List<WorkflowVO> receivedWorkflowList = wService.showReceivedWorkflowList(emp_id,"0");
		
		model.addAttribute("sentWorkflowList",sentWorkflowList);
		model.addAttribute("receivedWorkflowList",receivedWorkflowList);
	}
	
	@RequestMapping(value = "/readWorkflow",method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> readWorkflow(@RequestParam("wf_code") String wf_code, HttpSession session) {
		logger.debug(" /work/readWorkflow -> readWorkflow()실행 ");
		
		logger.debug(" 조회 대상 wf_code : "+wf_code);
		
		WorkflowVO workflowVO = wService.showWorkflow(wf_code);
		Map<String,Object> data = new HashMap<String,Object>();
		
		
		data.put("workflowVO", workflowVO);
		data.put("logined_id", session.getAttribute("emp_id"));
		
		logger.debug(" ajax로 보낼 리턴값 : "+data);
		return data;
	}
	
	@RequestMapping(value = "/wfresponse",method = RequestMethod.POST)
	public String responseWorkflow(WorkflowVO uvo) {
		
		WorkflowVO responseVO = wService.showWorkflow(uvo.getWf_code());
		responseVO.setWf_result(uvo.getWf_result());
		responseVO.setWf_comment(uvo.getWf_comment());
		
		wService.responseWorkflow(responseVO);
		
		String wf_target = uvo.getWf_target();
		String wf_type = uvo.getWf_type();
		String wf_result = uvo.getWf_result();
		
		if(!wf_result.equals("2")) {
			switch (wf_type) {
			case "교육" :
				if(wf_result.equals("1")) {
					eService.whenEduSignComplete(wf_target);
				}
				if(wf_result.equals("0")) {
					eService.whenEduSignReject(wf_target);
				}
				break;
			case "급여" :
				if(wf_result.equals("1")) {
					sService.whenSalarySignComplete(wf_target);
				}
				if(wf_result.equals("0")) {
					sService.whenSalarySignReject(wf_target);
				}
			break;
			}
		}
		
		return "redirect:/work/workoff";
	}
	
	
	
	
	
	
	
	
	
}
