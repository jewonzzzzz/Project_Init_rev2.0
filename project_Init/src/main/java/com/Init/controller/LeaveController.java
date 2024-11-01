package com.Init.controller;


import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Date;
import java.time.LocalDate;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.Init.domain.LeaveVO;
import com.Init.domain.WorkflowVO;
import com.Init.service.LeaveService;
import com.Init.service.SalaryService;

@Controller
@RequestMapping(value = "/leave/*")
public class LeaveController {

	private static final Logger logger = LoggerFactory.getLogger(AttendanceController.class);

	@Autowired
	private LeaveService leaveService;
	@Autowired
	private SalaryService sService;

	// 템플릿 적용 확인
	// http://localhost:8088/leave/main
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainPage() {
		logger.debug(" /main -> mainPage() 실행");
		logger.debug(" /views/leave/main.jsp 뷰페이지 연결");

		return "leave/main";

	}

	// http://localhost:8088/leave/mainAdmin
	@RequestMapping(value = "/mainAdmin", method = RequestMethod.GET)
	public String AdminMainPage() {
		logger.debug(" /main -> AdminMainPage() 실행");
		logger.debug(" /views/leave/mainAdmin.jsp 뷰페이지 연결");

		return "leave/mainAdmin";

	}

	@RequestMapping(value = "/AdminAnnual", method = RequestMethod.GET)
	public String AdminAnnualPage() {
		logger.debug(" /main -> AdminAnnualPage() 실행");
		logger.debug(" /views/leave/AdminAnnual.jsp 뷰페이지 연결");

		return "leave/AdminAnnual";

	}

	// 사원 ID로 휴가 조회
	// 사원 ID로 휴가 조회
	@GetMapping("/leaveSelect")
	public ResponseEntity<List<LeaveVO>> getAllLeaves(@RequestParam String emp_id,
			@RequestParam(required = false) String leave_start_date, // 휴가 시작 날짜
			@RequestParam(required = false) String annual_leave_start_date) { // 연차 시작 날짜

		logger.debug("사원 ID로 휴가 조회: " + emp_id);
		logger.debug("휴가 시작 날짜: " + leave_start_date);
		logger.debug("연차 시작 날짜: " + annual_leave_start_date);

		List<LeaveVO> leaves = leaveService.getAllLeaves(emp_id, leave_start_date, annual_leave_start_date);
		return ResponseEntity.ok(leaves);
	}

	// 휴가 수정 정보를 가져오기
	@GetMapping("/selectUpdate") // 오타 수정: 'seletUpdate' -> 'selectUpdate'
	public ResponseEntity<LeaveVO> getLeaveById(@RequestParam int leave_id) {
		LeaveVO leave = leaveService.getLeaveById(leave_id);
		return ResponseEntity.ok(leave);
	}

	// 휴가 정보 수정
	@PostMapping("/leaveUpdate")
	public ResponseEntity<Map<String, Object>> updateLeave(@RequestParam int leave_id, @RequestBody LeaveVO leaveData) {
		Map<String, Object> response = new HashMap<>();

		// 유효성 검사 (예시)
		if (leaveData == null || leave_id <= 0) {
			response.put("success", false);
			return ResponseEntity.badRequest().body(response); // 잘못된 요청
		}

		try {
			leaveService.updateLeave(leave_id, leaveData);
			response.put("success", true); // 성공적으로 업데이트됨
			return ResponseEntity.ok(response); // 성공 응답
		} catch (Exception e) {
			e.printStackTrace(); // 에러 로그
			response.put("success", false); // 실패
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response); // 서버 오류
		}
	}

	// 휴가 삭제 메서드
	@PostMapping("/leaveDelete")
	public ResponseEntity<?> deleteLeave(@RequestParam("leave_id") int leave_id) {
		try {
			leaveService.deleteLeave(leave_id);
			return ResponseEntity.ok().body("{\"success\": true}");
		} catch (Exception e) {
			return ResponseEntity.status(500).body("{\"success\": false}");
		}
	}

	// 메인 페이지 연차 현황
	@GetMapping("/getLeaveInfo")
	@ResponseBody
	public List<LeaveVO> getLeaveInfo(HttpSession session) {
		String emp_id = (String) session.getAttribute("emp_id");

		// 서비스 호출하여 데이터 조회
		List<LeaveVO> leaveInfo = leaveService.getLeaveInfo(emp_id);
		logger.debug("서비스에서 반환된 leaveInfo: " + leaveInfo);

		return leaveInfo;
	}

	@PostMapping("/use")
	public ResponseEntity<String> useLeave(@RequestBody LeaveVO leaveVO) {
		try {
			leaveService.useAnnualLeave(leaveVO);

			return ResponseEntity.ok("연차 사용이 완료되었습니다. 사용한 연차: " + leaveVO.getUsed_annual_leave());
		} catch (IllegalArgumentException e) {
			return ResponseEntity.badRequest().body(e.getMessage());
		}
	}

	@PostMapping("/leavesubmit")
	public ResponseEntity<String> submitLeaveRequest(@RequestBody LeaveVO leaveVO) {
		// 휴가 신청 요청 처리
		leaveService.submitLeaveRequest(leaveVO);

		// 성공 응답 반환
		return ResponseEntity.ok("휴가 신청이 완료되었습니다.");
	}

	// 휴가 현황 조회
	@GetMapping("/getLeaveStatus")
	@ResponseBody
	public List<LeaveVO> getLeaveStatus(@RequestParam("emp_id") String emp_id) {
		// emp_id를 기반으로 휴가 정보 조회
		return leaveService.getLeaveStatus(emp_id);
	}

	@GetMapping("/getAnnualLeave")
	@ResponseBody
	public List<LeaveVO> getAnnualLeave(@RequestParam("emp_id") String emp_id) {
		List<LeaveVO> leaveList = new ArrayList<>();
		try {
			// 사원의 연차 정보를 조회
			leaveList = leaveService.getAnnualLeaveByEmpId(emp_id); // 반환된 리스트를 직접 사용
		} catch (Exception e) {
			// 예외 처리
			System.err.println("Error retrieving annual leave: " + e.getMessage());
		}
		return leaveList; // LeaveVO 리스트를 JSON으로 반환
	}

	// 연차생성
	@PostMapping("/generateAnnualLeave")
	@ResponseBody
	public List<LeaveVO> generateAnnualLeave(@RequestParam("emp_id") String emp_id) {
		List<LeaveVO> leaveList = new ArrayList<>(); // 반환할 리스트 초기화
		try {
			// 연차 생성 서비스 호출
			leaveService.generateAnnualLeave(emp_id);

			// 생성 후 연차 정보를 다시 조회
			leaveList = leaveService.getAnnualLeaveByEmpId(emp_id); // 반환된 리스트를 직접 사용
		} catch (Exception e) {
			// 예외 처리
			System.err.println("Error generating annual leave: " + e.getMessage());
			leaveList = new ArrayList<>(); // 오류 발생 시 빈 리스트 반환
		}
		return leaveList; // LeaveVO 리스트를 JSON으로 반환
	}

	@GetMapping("/getLeaveInfoA")
	@ResponseBody
	public LeaveVO getLeaveInfo(@RequestParam String emp_id) {
		LeaveVO leaveInfo = leaveService.getLatestLeaveInfo(emp_id);
		return leaveInfo;
	}
	
	@PostMapping("/deleteA")
     public void deleteAnnualLeave(@RequestParam("leave_id") int leave_id) {
	        leaveService.updateAnnualLeaveA(leave_id);
	    }
	
	//휴가결재
	@PostMapping(value = "insertSignInfoForLeave")
	@ResponseBody
	public void insertSignInfo(@RequestBody Map<String, String> signData) {
		logger.debug("signData :"+signData.toString());
		String emp_id = signData.get("emp_id");
		
		// wf_code 설정
        LocalDate today = LocalDate.now();
        int year = today.getYear();
        String wf_code = "wf" +year+"00001";
        
        // 올해 첫 워크플로우번호가 있는지 확인하기
        String checkWfCode = sService.checkWfCode(wf_code);
        
        if(checkWfCode != null) {
        	//있으면 edu_id를 가장 최근 id에서 +1
        	String getWfCode = sService.getWfCode();
        	wf_code = "wf"+(Integer.parseInt(getWfCode.substring(2))+1);
        }
		
		WorkflowVO vo = new WorkflowVO();
		vo.setWf_code(wf_code);
		vo.setWf_type("휴가");
		vo.setWf_sender(signData.get("wf_sender"));
		vo.setWf_receiver_1st(signData.get("wf_receiver_1st"));
		vo.setWf_receiver_2nd(signData.get("wf_receiver_2nd"));
		vo.setWf_receiver_3rd(signData.get("wf_receiver_3rd"));
		vo.setWf_target(emp_id);
		vo.setWf_title(signData.get("wf_title"));
		vo.setWf_content(signData.get("wf_content"));
		
		//결재정보를 워크플로우 디비에 저장
		sService.insertSalarySignInfoToWorkFlow(vo);
		
		// 휴가 및 휴직 정보 처리
		String leaveType = signData.get("leave_type");
		String leaveTypeA = signData.get("leave_typeA");

		
		    LeaveVO leaveVO = new LeaveVO();
		    leaveVO.setEmp_id(emp_id);  // 사번 설정
		    leaveVO.setLeave_status(-1); // 기본 상태 설정


		 // 휴가 정보가 있는 경우 처리
		 if (leaveType != null && leaveType.contains("휴가")) {
		     leaveVO.setLeave_type(leaveType);
		     leaveVO.setLeave_start_date(Date.valueOf(signData.get("leave_start_date")));
		     leaveVO.setEnd_leave_date(Date.valueOf(signData.get("end_leave_date")));
		     leaveVO.setTotal_leave_days(Integer.parseInt(signData.get("total_leave_days")));
		     leaveVO.setReason(signData.get("reason"));
		     leaveService.insertSignInfoForLeave(leaveVO);
		 } 
		 // 휴직 정보가 있는 경우 처리
		 else if (leaveTypeA != null && leaveTypeA.contains("휴직")) {
		     leaveVO.setLeave_type(leaveTypeA);
		     leaveVO.setLeave_start_date(Date.valueOf(signData.get("leave_start_dateA")));
		     leaveVO.setEnd_leave_date(Date.valueOf(signData.get("end_leave_dateA")));
		     leaveVO.setTotal_leave_days(Integer.parseInt(signData.get("total_leave_daysA")));
		     leaveVO.setReason(signData.get("reasonA"));
		     leaveService.insertSignInfoForLeave(leaveVO);
		 }
		 
		 
		 
		
	
	}
	
	
	

}
