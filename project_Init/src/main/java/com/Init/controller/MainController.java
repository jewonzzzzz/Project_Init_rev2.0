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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.Init.domain.EmployeeVO;
import com.Init.domain.MessageVO;
import com.Init.domain.SettingVO;
import com.Init.domain.WorkflowVO;
import com.Init.persistence.EmployeeDAO;
import com.Init.service.EmployeeService;
import com.Init.service.MessageService;
import com.Init.service.WorkflowService;

@Controller
@RequestMapping(value = "/main/*")
public class MainController {
	
	@Inject
	private EmployeeService mService;
	@Inject
	private WorkflowService wService;
	@Inject
	private MessageService msgService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value = "/login",method = RequestMethod.GET)
	public String loginGet(EmployeeVO vo) {
		logger.debug("사용자가 로그인하였습니다. 로그온 정보를 업데이트하였습니다.");
		return "/main/loginForm";
	}

	@RequestMapping(value = "/login",method = RequestMethod.POST)
	public String loginPOST(EmployeeVO vo,HttpSession session,Model model) {
		logger.debug("사용자가 로그인하였습니다. 로그온 정보를 업데이트하였습니다.");
		EmployeeVO resultVO = mService.memberLogin(vo);
		
		session.removeAttribute("emp_id");
		session.setAttribute("emp_id", resultVO.getEmp_id());
		session.setAttribute("emp_name", resultVO.getEmp_name());
		session.setAttribute("emp_position", resultVO.getEmp_position());
		session.setAttribute("logined", true);
		mService.userLogin(resultVO.getEmp_id());
		logger.debug(resultVO.getEmp_id()+"사용자가 로그인하였습니다. 로그온 정보를 업데이트하였습니다.");
		
		return "redirect:/main/home";
	}
	
	@RequestMapping(value = "/logout",method = RequestMethod.POST)
	public void logout(HttpSession session) {
		String emp_id = (String)session.getAttribute("emp_id");
		mService.userLogout(emp_id);
		session.invalidate();
		logger.debug(emp_id+"사용자가 로그아웃하였습니다. 로그온 정보를 업데이트하였습니다.");
	}
		
	@RequestMapping(value = "/home",method = RequestMethod.GET)
	public Map<String,Object> home(HttpSession session) {
		String emp_id = (String)session.getAttribute("emp_id");
		List<WorkflowVO> receivedWorkflowList = wService.showReceivedWorkflowList(emp_id,"1");
		
		getCalendarEvents();
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("receivedWorkflowList", receivedWorkflowList);
		data.put("calender",getCalendarEvents());
		data.put("memberVO",mService.memberInfo(emp_id));
		data.put("settingVO",mService.showSetting(emp_id));
		return data;
	}
	
	@RequestMapping(value = "/memberInfoModal",method = RequestMethod.GET)
	@ResponseBody
	public EmployeeVO memberInfoModal(String emp_id) {
		logger.debug("/member/memberInfoModal -> memberInfoModal() 실행");
		logger.debug(" 조회 대상 아이디 : "+emp_id);
		
		EmployeeVO resultVO = mService.memberInfo(emp_id);
		logger.debug(" 조회 결과 : "+resultVO);
		
		return resultVO;
	}
	
	@RequestMapping(value = "/search",method = RequestMethod.GET)
	@ResponseBody
	public List<EmployeeVO> searchToMember(String keyword) {
		List<EmployeeVO> memberList = mService.memberSearch(keyword);
		return memberList;
	}
	
	@RequestMapping(value = "/toolSearch",method = RequestMethod.GET)
	@ResponseBody
	public List<SettingVO> searchToTools(String keyword) {
		List<SettingVO> Tools = mService.searchTools(keyword.trim());
		return Tools;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateSetting",method = RequestMethod.GET)
	public void updateSetting(HttpSession session, SettingVO vo) {
		String emp_id = (String)session.getAttribute("emp_id");
		vo.setEmp_id(emp_id);
		mService.settingFavoriteTool(vo);
		logger.debug("settingVO :"+vo);
	}
	
	@RequestMapping(value = "/calender",method = RequestMethod.GET)
    public List<Map<String, Object>> getCalendarEvents() {
        List<Map<String, Object>> events = new ArrayList<Map<String, Object>>();

        Map<String, Object> event = new HashMap<String, Object>();

        events.add(event);
        return events;
    }
	
	@RequestMapping(value = "/loginAlarm",method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> loginAlarm(HttpSession session) {
		
		String emp_id = (String)session.getAttribute("emp_id");
		String emp_name = (String)session.getAttribute("emp_name");
		Map<String, Object> loginAlarms = wService.loginCheckWorkflow(emp_id);
		logger.debug(" loginAlarm for "+ emp_id + ", smallAlarm :" + loginAlarms.get("smallAlarm"));
		loginAlarms.put("messageList",msgService.getMessageUnreadAlarm(emp_id));
		
		loginAlarms.put("emp_name", emp_name);
		
		int alarmCount =((List<WorkflowVO>)loginAlarms.get("sentWorkflowList")).size() + ((List<WorkflowVO>)loginAlarms.get("receivedWorkflowList")).size() + ((List<WorkflowVO>)loginAlarms.get("messageList")).size();
			
			if (alarmCount>0) {
			logger.debug(" gotten Alarms : " + (alarmCount + "개의 로그인 알람이 있습니다."));
			}
		
		logger.debug(" 세션의 로그인 토큰을 삭제합니다.");
		session.removeAttribute("logined");
		return loginAlarms;
	}
	
	@RequestMapping(value = "/checkAlarm",method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> checkAlarm(HttpSession session) {
		
		String emp_id = (String)session.getAttribute("emp_id");
		Map<String, Object> alarms = wService.realtimeCheckWorkflow(emp_id);
		alarms.put("unread_messageList",msgService.getMessageUnreadAlarm(emp_id));
		alarms.put("realtimeAlarm_messageList",msgService.getMessageRealtimeAlarm(emp_id));
		int messageAlarmCount = ((List<WorkflowVO>)alarms.get("unread_messageList")).size();
		alarms.put("messageAlarmCount",messageAlarmCount);
		logger.debug(" checkAlarm for "+ emp_id + ", smallAlarm :" + alarms.get("smallAlarm") + ", messageAlarmCount :" + messageAlarmCount);
		
		int alarmCount = ((List<WorkflowVO>)alarms.get("sentWorkflowList")).size() + ((List<WorkflowVO>)alarms.get("receivedWorkflowList")).size();
		
		if (alarmCount>0) {
		logger.debug(" gotten Alarms : " + (alarmCount + "개의 실시간 알람이 있습니다."));
		}
		
		return alarms;
	}
	
	@RequestMapping(value = "/smallAlarm_workflow",method = RequestMethod.GET)
	@ResponseBody
	public List<WorkflowVO> smallAlarmWorkflow(HttpSession session) {
		
		String emp_id = (String)session.getAttribute("emp_id");
		
		return wService.showReceivedWorkflowList(emp_id,"1");
	}
}
