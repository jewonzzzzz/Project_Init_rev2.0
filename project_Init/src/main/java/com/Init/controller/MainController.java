package com.Init.controller;

import java.sql.Date;
import java.time.YearMonth;
import java.time.LocalDate;
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
		return "/main/loginForm";
	}

	@RequestMapping(value = "/login",method = RequestMethod.POST)
	public String loginPOST(EmployeeVO vo,HttpSession session,Model model) {
		EmployeeVO resultVO = mService.memberLogin(vo);
		
		session.removeAttribute("emp_id");
		session.setAttribute("emp_id", resultVO.getEmp_id());
		session.setAttribute("emp_name", resultVO.getEmp_name());
		session.setAttribute("emp_position", resultVO.getEmp_position());
		session.setAttribute("logined", true);
		mService.userLogin(resultVO.getEmp_id());
		
		return "redirect:/main/home";
	}
	
	@RequestMapping(value = "/logout",method = RequestMethod.GET)
	public String logout(HttpSession session) {
		String emp_id = (String)session.getAttribute("emp_id");
		mService.userLogout(emp_id);
		session.invalidate();
		return "redirect:/member/login";
	}
		
	@RequestMapping(value = "/home",method = RequestMethod.GET)
	public Map<String,Object> home(HttpSession session) {
		String emp_id = (String)session.getAttribute("emp_id");
		List<WorkflowVO> receivedWorkflowList = wService.showReceivedWorkflowList(emp_id,"1");
		
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("receivedWorkflowList", receivedWorkflowList);
		data.put("memberVO",mService.memberInfo(emp_id));
		data.put("settingVO",mService.showSetting(emp_id));
		return data;
	}
	
	@RequestMapping(value = "/memberInfoModal",method = RequestMethod.GET)
	@ResponseBody
	public EmployeeVO memberInfoModal(String emp_id) {
		
		EmployeeVO resultVO = mService.memberInfo(emp_id);
		
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
	
	@RequestMapping(value = "/updateSetting",method = RequestMethod.GET)
	@ResponseBody
	public void updateSetting(HttpSession session, SettingVO vo) {
		String emp_id = (String)session.getAttribute("emp_id");
		vo.setEmp_id(emp_id);
		mService.settingFavoriteTool(vo);
	}
	
	@RequestMapping(value = "/calendar",method = RequestMethod.GET)
	@ResponseBody
    public Map<String, Object> getCalendarEvents(HttpSession session, String year, String month) {
		String emp_id = (String)session.getAttribute("emp_id");
		Map<String, Object> event = new HashMap<String, Object>();
		LocalDate today = LocalDate.now();
		
		Integer target_year = Integer.parseInt(year);
		Integer target_month = Integer.parseInt(month);
		YearMonth yearMonth = YearMonth.of(target_year, target_month);
		LocalDate firstDay = yearMonth.atDay(1);                  // 해당 월의 첫 번째 날
		LocalDate lastDay = yearMonth.atEndOfMonth();
		
		event.put("presence",mService.showPrecense(emp_id, firstDay, lastDay));
		event.put("workflow",wService.showCalendarWorkflow(emp_id, firstDay, lastDay));
		event.put("session_emp_id",emp_id);
		logger.debug("year :"+year);
		logger.debug("month :"+month);
		logger.debug("presence :"+event.get("presence"));
		logger.debug("workflow :"+event.get("workflow"));
		
        return event;
    }
	
	@RequestMapping(value = "/loginAlarm",method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> loginAlarm(HttpSession session) {
		
		String emp_id = (String)session.getAttribute("emp_id");
		String emp_name = (String)session.getAttribute("emp_name");
		Map<String, Object> loginAlarms = wService.loginCheckWorkflow(emp_id);
		loginAlarms.put("messageList",msgService.getMessageUnreadAlarm(emp_id));
		loginAlarms.put("emp_name", emp_name);
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
		
		return alarms;
	}
	
	@RequestMapping(value = "/smallAlarm_workflow",method = RequestMethod.GET)
	@ResponseBody
	public List<WorkflowVO> smallAlarmWorkflow(HttpSession session) {
		
		String emp_id = (String)session.getAttribute("emp_id");
		
		return wService.showReceivedWorkflowList(emp_id,"1");
	}
	
	@RequestMapping(value = "/yammyDummy",method = RequestMethod.GET)
	public void yammyDummy(String emp_id) {
		logger.debug("dummy for emp_id :"+emp_id);
		mService.yammyDummy("240002");
	}
	
	@RequestMapping(value = "/dummySetting",method = RequestMethod.GET)
	public void dummySetting() {
		mService.dummySetting();
	}
	
}
