package com.Init.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.Init.domain.AttendanceVO;
import com.Init.service.AttendanceService;

@Controller
@RequestMapping(value = "/Attendance/*")
public class AttendanceController {

	@Autowired
	private AttendanceService attendanceService;

	private static final Logger logger = LoggerFactory.getLogger(AttendanceController.class);

	// 템플릿 적용 확인
	// http://localhost:8088/Attendance/main
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainPage() {
		logger.debug(" /main -> mainPage() 실행");
		logger.debug(" /views/Attendance/main.jsp 뷰페이지 연결");

		return "Attendance/main";

	}

	// 메인
	// qr코드로 넘어온 파라메터값 출퇴근 로직을 처리하고 최근 출퇴근을 조회하는 메서드

	@GetMapping(value = "attendanceMain")
	public String handleAttendance(@RequestParam(value = "emp_id", required = false) String emp_id, Model model,
			HttpSession session) {

		logger.debug("/attendanceMain -> page 실행 ");

		if (emp_id != null && !emp_id.isEmpty()) {
			// 세션에 emp_id 저장
			session.setAttribute("emp_id", emp_id);

			// 출근 기록 삽입 (출근 시에만 실행)
			attendanceService.recordCheckIn(emp_id); // 매퍼를 통해 출근 기록 삽입

			// 방금 저장된 최신 출근 기록 조회
			AttendanceVO latestCheckInData = attendanceService.fetchLatestAttendanceRecord(emp_id);

			if (latestCheckInData != null) {
				model.addAttribute("checkInTime", formatTimestamp(latestCheckInData.getCheck_in()));

				// 출근 기록이 성공적으로 인서트되었음을 알리기 위한 플래그 설정
				model.addAttribute("checkInSuccess", true);
			}

			// 직원 정보 조회 및 세션에 저장
			AttendanceVO employee = attendanceService.getEmployee(emp_id);
			if (employee != null) {
				session.setAttribute("emp_job", employee.getEmp_job());
				session.setAttribute("emp_position", employee.getEmp_position());
				session.setAttribute("emp_name", employee.getEmp_name());

				model.addAttribute("emp_job", employee.getEmp_job());
				model.addAttribute("emp_position", employee.getEmp_position());
				model.addAttribute("emp_name", employee.getEmp_name());
			}
		} else {
			logger.debug("emp_id가 존재하지 않거나 비어 있습니다.");
		}

		return "Attendance/attendanceMain";
	}

	// 퇴근 처리 요청 (GET)
	@GetMapping("/checkOut")
	public ResponseEntity<Map<String, Object>> checkOut(HttpSession session) {
		// 세션에서 emp_id 조회
		String emp_id = (String) session.getAttribute("emp_id");
		logger.debug("퇴근 요청: emp_id = {}", emp_id);

		Map<String, Object> response = new HashMap<>();

		// 현재 출근한 시간을 조회 (가장 최근 출근 기록을 가져옴)
		AttendanceVO latestCheckInData = attendanceService.fetchLatestAttendanceRecord(emp_id);

		if (latestCheckInData != null) {
			// 퇴근 기록 처리
			attendanceService.recordCheckout(emp_id);
			response.put("status", "success");
			response.put("message", "퇴근 처리 완료");
			return ResponseEntity.ok(response); // 성공 응답 반환
		} else {
			// 출근 기록이 없을 경우 오류 메시지를 설정하고 응답 반환
			response.put("status", "error");
			response.put("message", "출근 기록이 없습니다.");
			return ResponseEntity.badRequest().body(response); // 400 Bad Request 반환
		}
	}

	@GetMapping("/calculateWorkingTime")
	public ResponseEntity<Map<String, Object>> calculateWorkingTime(HttpSession session) {
		String emp_id = (String) session.getAttribute("emp_id");
		Map<String, Object> response = new HashMap<>();

		// 근무 시간을 자동으로 계산하고 업데이트
		attendanceService.calculateAndUpdateWorkingTime(emp_id);

		// 업데이트된 근무 시간을 조회
		double workingTime = attendanceService.getLatestWorkingTime(emp_id);

		response.put("status", "success");
		response.put("message", "근무 시간이 성공적으로 업데이트되었습니다.");
		response.put("workingTime", workingTime); // 근무 시간을 응답에 추가

		return ResponseEntity.ok(response);
	}

	// 어드민
	// http://localhost:8088/Attendance/attendanceAdmin
	@RequestMapping(value = "attendanceAdmin", method = RequestMethod.GET)
	public String getCheckTimePage() {
		// 초기 로드 시 데이터 조회는 하지 않음
		logger.debug(" /attendanceAdmin -> page 실행 ");
		logger.debug(" /views/Attendance/attendanceMain.jsp 뷰페이지 연결");
		return "Attendance/attendanceAdmin"; // 이동할 JSP 페이지
	}

	@RequestMapping(value = "attendanceData", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPagedCheckTime(@RequestParam("emp_id") String emp_id, @RequestParam("page") int page,
			@RequestParam("size") int size, @RequestParam(value = "date", required = false) String date) {

		// 페이지 인덱스 계산 (0부터 시작하므로)
		int offset = (page - 1) * size;

		List<AttendanceVO> attendanceList;

		// 날짜가 없을 경우 전체 출석 기록 가져오기
		if (date == null || date.isEmpty()) {
			attendanceList = attendanceService.getAllCheckTime(emp_id, offset, size, null); // null을 전달하여 전체 데이터 가져오기
		} else {
			attendanceList = attendanceService.getAllCheckTime(emp_id, offset, size, date); // 날짜에 따라 필터링된 데이터 가져오기
		}

		System.out.println("Retrieved attendanceList: " + attendanceList);

		// 총 근태 항목 수 계산 (날짜 필터링 적용)
		int totalItems = attendanceService.countAttendance(emp_id, date);

		List<Map<String, Object>> attendanceDataList = new ArrayList<>();

		// AttendanceVO 리스트를 Map으로 변환하여 포맷팅
		for (AttendanceVO attendance : attendanceList) {
			Map<String, Object> attendanceData = new HashMap<>();

			// 포맷된 데이터 추가
			attendanceData.put("check_in", formatTimestamp(attendance.getCheck_in()));
			attendanceData.put("check_out", formatTimestamp(attendance.getCheck_out()));
			attendanceData.put("return_time", formatTimestamp(attendance.getReturn_time()));
			attendanceData.put("workingoutside_time", formatTimestamp(attendance.getWorkingOutside_time()));
			attendanceData.put("new_check_in", formatTimestamp(attendance.getNew_check_in()));
			attendanceData.put("new_check_out", formatTimestamp(attendance.getNew_check_out()));
			attendanceData.put("new_workingoutside_time", formatTimestamp(attendance.getNew_WorkingOutside_time()));
			attendanceData.put("modified_time", formatTimestamp(attendance.getModified_time()));
			

			// 원본 데이터 추가
			attendanceData.put("attendance_id", attendance.getAttendance_id());
			attendanceData.put("emp_id", attendance.getEmp_id());
			attendanceData.put("emp_cid", attendance.getEmp_cid());
			attendanceData.put("status", attendance.getStatus());
			attendanceData.put("overtime", attendance.getOvertime());
			attendanceData.put("working_time", attendance.getWorking_time());
			attendanceData.put("night_work_time", attendance.getNight_work_time());
			attendanceData.put("special_working_time", attendance.getSpecial_working_time());
			attendanceData.put("modified_reason", attendance.getModified_reason());
			attendanceData.put("modified_person", attendance.getModified_person());
			attendanceData.put("workform_status", attendance.getWorkform_status());
			
			attendanceData.put("businessDate", formatDate(attendance.getBusinessDate()));
			attendanceData.put("business_endDate", formatDate(attendance.getBusiness_endDate()));
			attendanceData.put("educationDate", formatDate(attendance.getEducationDate()));
			attendanceData.put("education_endDate", formatDate(attendance.getEducation_endDate()));
			attendanceData.put("created_at", formatDate(attendance.getCreated_at()));
			
			attendanceDataList.add(attendanceData);
		}

		// 응답을 Map에 담아 반환
		Map<String, Object> response = new HashMap<>();
		response.put("data", attendanceDataList);
		response.put("totalItems", totalItems);
		response.put("currentPage", page);
		response.put("totalPages", (totalItems + size - 1) / size); // 전체 페이지 수

		return response;
	}

	private String formatDate(Date date) {
		if (date != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			return dateFormat.format(date);
		}
		return null; // 또는 적절한 기본값
	}

	// Timestamp를 포맷된 문자열로 변환하는 메서드
	private String formatTimestamp(Timestamp timestamp) {
		if (timestamp != null) {
			LocalDateTime dateTime = timestamp.toLocalDateTime();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			return dateTime.format(formatter);
		}
		return ""; // null인 경우 빈 문자열 반환
	}

	@RequestMapping(value = "updateAttendance", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> updateAttendance(@RequestBody AttendanceVO attendanceVO) {
		try {
			attendanceService.updateAttendanceRecord(attendanceVO); // 서비스 호출
			return ResponseEntity.ok("수정 완료");
		} catch (Exception e) {
			logger.error("Error updating attendance record: ", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정 실패");
		}
	}

	@PostMapping("/deleteAttendance")
	@ResponseBody
	public ResponseEntity<Map<String, String>> deleteAttendance(@RequestParam("attendance_id") int attendance_id) {
		boolean isDeleted = attendanceService.deleteAttendance(attendance_id);

		Map<String, String> response = new HashMap<>();

		if (isDeleted) {
			response.put("message", "근태가 성공적으로 삭제되었습니다.");
			return ResponseEntity.ok(response);
		} else {
			response.put("message", "근태 삭제에 실패했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@GetMapping("/fetchAttendanceRecords")
	@ResponseBody
	public List<AttendanceVO> fetchRecentAttendanceRecords(HttpSession session) {
		// 세션에서 emp_id 가져오기
		String emp_id = (String) session.getAttribute("emp_id");

		// 최근 3일간 출근 기록을 조회하는 서비스 메서드 호출
		return attendanceService.fetchRecentAttendanceRecords(emp_id);
	}

	@PostMapping("/checkin")
	public ResponseEntity<String> checkIn(HttpSession session) {
		String emp_id = (String) session.getAttribute("emp_id"); // 세션에서 emp_id 가져오기

		if (emp_id == null || emp_id.isEmpty()) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("사용자가 로그인되어 있지 않습니다.");
		}

		try {
			// 출근 처리 로직
			attendanceService.checkIn(emp_id); // emp_id를 통해 출근 처리
			return ResponseEntity.ok("출근 처리가 완료되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("출근 기록 저장 실패: " + e.getMessage());
		}
	}

	@PostMapping("/overtimeSubmit")
	public ResponseEntity<String> submitOvertime(@RequestBody AttendanceVO attendanceVO) {
		attendanceService.submitOvertime(attendanceVO);
		return ResponseEntity.ok("연장 근무 신청이 성공적으로 제출되었습니다.");
	}

	@PostMapping("/outdoor")
	@ResponseBody
	public ResponseEntity<String> recordOutdoorTime(@RequestBody AttendanceVO attendanceVO) {
		try {
			attendanceService.updateWorkingOutsideTime(attendanceVO);
			return new ResponseEntity<>("외출 시간이 기록되었습니다.", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>("오류 발생: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/return")
	@ResponseBody
	public ResponseEntity<String> recordReturnTime(@RequestBody AttendanceVO attendanceVO) {
		try {
			attendanceService.updateReturnTime(attendanceVO);
			return new ResponseEntity<>("복귀 시간이 기록되었습니다.", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>("오류 발생: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/attendanceDataA")
	@ResponseBody
	public List<AttendanceVO> getAttendanceDataA(@RequestParam("emp_id") String emp_id) {
		List<AttendanceVO> attendanceList = attendanceService.getAttendanceByEmpId(emp_id);
		System.out.println("Attendance List: " + attendanceList); // 로그 추가
		return attendanceList;
	}

	@PostMapping("/updateAttendanceA")
	public ResponseEntity<String> updateAttendanceA(@RequestBody AttendanceVO attendanceVO) {

		try {
			attendanceService.updateAttendanceRecordA(attendanceVO);
			return ResponseEntity.ok("신청서가 제출되었습니다.");
		} catch (Exception e) {
			logger.error("신청서 제출에 실패했습니다: ", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("신청서 제출에 실패했습니다.");
		}
	}

	@PostMapping("/applyBusinessTrip")
	public ResponseEntity<String> applyBusinessTrip(@RequestBody AttendanceVO attendanceVO) {
		try {
			attendanceService.applyBusinessTrip(attendanceVO);
			return ResponseEntity.ok("신청이 성공적으로 처리되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("신청 처리 중 오류가 발생했습니다.");
		}
	}
	
	
	

}