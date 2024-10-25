package com.Init.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.Init.domain.BankTransperVO;
import com.Init.domain.CalSalaryFinalVO;
import com.Init.domain.CalSalaryListVO;
import com.Init.domain.MemberInfoForSalaryVO;
import com.Init.domain.SalaryBasicInfoVO;
import com.Init.domain.SalaryPositionJobVO;
import com.Init.domain.WorkflowVO;
import com.Init.service.SalaryService;

@Controller
@RequestMapping(value = "salary/*")
public class SalaryController {
	
	@Autowired
	private SalaryService sService;
	
	private static final Logger logger = LoggerFactory.getLogger(SalaryController.class);
	
	
	//http://localhost:8088/salary/salaryBasicInfo
	@GetMapping(value = "salaryBasicInfo")
	public String salaryBasicInfoGet(Model model) {
		logger.debug("salaryBasicInfoGet(Model model) 실행");
		SalaryBasicInfoVO result = sService.getSalaryBasicInfo();
		
		if(result == null) {
			logger.debug("null임");
			sService.initSalaryBasicInfo();
			result = sService.getSalaryBasicInfo();
		}
		model.addAttribute("salaryBasicInfo", result);
		return "/salary/salaryBasicInfo";
	}
	
	// 급여기본정보 수정
	@PostMapping(value = "/salaryBasicInfo")
	public String salaryBasicInfoPost(SalaryBasicInfoVO vo ,Model model) {
		logger.debug("salaryBasicInfoPost(SalaryBasicInfoVO vo ,Model model) 실행");
		
		sService.updateSalaryBasicInfo(vo); //수정
		SalaryBasicInfoVO result = sService.getSalaryBasicInfo(); //조회
		
		model.addAttribute("salaryBasicInfo", result);
		return "/salary/salaryBasicInfo";
	}
	
	// 직급급/직무급 설정 페이지
	// http://localhost:8088/salary/salaryPositionJobInfo
	@GetMapping(value = "/salaryPositionJobInfo")
	public String salaryPositionJobInfoGet(Model model) {
		logger.debug("salaryPositionJobInfoGet(Model model) 실행");
		SalaryPositionJobVO result = sService.getSalaryPositionJobInfo();
		
		if(result == null) {
			logger.debug("null임");
			sService.initSalaryPositionJobInfo();
			result = sService.getSalaryPositionJobInfo();
		}
		
		model.addAttribute("salaryPositionJobInfo", result);
		return "/salary/salaryPositionJobInfo";
	}
	
	// 직급급/직무급 수정
	@PostMapping(value = "/salaryPositionJobInfo")
	public String salaryRankDutyInfoPost(SalaryPositionJobVO vo ,Model model) {
		logger.debug("salaryRankDutyInfoPost(SalaryPositionJobVO vo ,Model model) 실행");
		
		sService.updatesalaryPositionJobInfo(vo); //수정
		SalaryPositionJobVO result = sService.getSalaryPositionJobInfo(); //조회
		
		model.addAttribute("salaryPositionJobInfo", result);
		return "/salary/salaryPositionJobInfo";
	}
	
	// 급여산출 페이지
	// http://localhost:8088/salary/calSalary
	@GetMapping(value = "/calSalary")
	public String calSalary(Model model, HttpSession session){
		logger.debug("calSalary(Model model) 실행");
		
		session.setAttribute("emp_id", "user31"); //테스트용 삭제해야됨
		
		// 급여내역리스트 가져오기
		List<CalSalaryListVO> calSalaryList = sService.getCalSalaryList();
		model.addAttribute("calSalaryListInfo", calSalaryList);
	
		return "/salary/calSalary";
	}
	
	// 급여산출 페이지 Step1
	// http://localhost:8088/salary/calSalaryStep1
	@GetMapping(value = "/calSalaryStep1")
	public String calSalaryStep1(){
		logger.debug("calSalaryStep1() 실행");
		return "/salary/calSalaryStep1";
	}
	
	// 급여 중복 작성여부 체크
	// http://localhost:8088/salary/checkCreateSalary
	@PostMapping(value = "/checkCreateSalary")
	@ResponseBody
	public String checkCreateSalary(@RequestBody List<String> checkSalaryInfo){
		logger.debug("checkCreateSalary() 실행");
		logger.debug(checkSalaryInfo.toString());
		CalSalaryListVO vo = new CalSalaryListVO();
		vo.setSal_type(checkSalaryInfo.get(0));
		vo.setYear(checkSalaryInfo.get(1));
		vo.setMonth(checkSalaryInfo.get(2));
		CalSalaryListVO cvo = sService.checkCreateSalary(vo);
		if(cvo == null) { //입력정보 없으면 ok
			return "ok";
		}
		return null; //입력정보 있으면 null
	}
	
	// 급여산출 페이지 Step2
	// http://localhost:8088/salary/calSalaryStep2
	@PostMapping(value = "/calSalaryStep2")
	public String calSalaryStep2(CalSalaryListVO vo, Model model){
		logger.debug("calSalaryStep2() 호출");
		logger.debug(vo.toString());
		
		model.addAttribute("calSalaryInfo", vo);
	
		return "/salary/calSalaryStep2";
	}
	
	// 조회버튼 클릭 이후 조회 시 직원정보 가져오기(모달테이블에 추가)
	@PostMapping(value = "/getMemberInfoForModal")
	@ResponseBody
	public List<MemberInfoForSalaryVO> getMemberInfoForModal(@RequestBody String employeeInfo){
		logger.debug("getMemberInfoForModal(@RequestBody String employeeInfo) 실행");
		logger.debug("employeeInfo:" + employeeInfo);
	
	//사번으로 먼저 select
	List<MemberInfoForSalaryVO> memberInfoList = sService.getMemberInfoToId(employeeInfo);
	
	//사번으로 검색 없으면
	if(memberInfoList.size() == 0) {
		memberInfoList = sService.getMemberInfoToName(employeeInfo);
	}
	logger.debug(memberInfoList.toString());
	
		return memberInfoList;
	}
	
	// 모달테이블에서 조회된 사원정보 본 테이블로 이동하기
	// http://localhost:8088/salary/transModalToTable
	@PostMapping(value = "/transModalToTable")
	@ResponseBody
	public List<MemberInfoForSalaryVO> transModalToTable(@RequestBody Map<String, String> data){
		logger.debug(data.toString());
		
		String year = data.get("year");
		String month = data.get("month");
		String check_in = year + "-" + month+"-01";
		logger.debug(check_in);
		
		MemberInfoForSalaryVO vo = new MemberInfoForSalaryVO();
		vo.setEmp_id(data.get("emp_id"));
		vo.setCheck_in(check_in);
		
		return sService.getMemberInfoForSalary(vo);
	}
	
	// 급여산출 관련 전체직원정보 가져오기
	// http://localhost:8088/salary/getMemberAllInfo
	@PostMapping(value = "/getMemberAllInfo")
	@ResponseBody
	public List<MemberInfoForSalaryVO> getMemberAllInfo(@RequestBody Map<String, String> data){
		String year = data.get("year");
		String month = data.get("month");
		String check_in = year + "-" + month+"-01";
		logger.debug(check_in);
		
		MemberInfoForSalaryVO vo = new MemberInfoForSalaryVO();
		vo.setCheck_in(check_in);
		logger.debug(vo.toString());
		
		return sService.getMemberAllInfo(vo);
	}
	
	// 급여산출 페이지 Step3
	// http://localhost:8088/salary/calSalaryStep3
	@PostMapping(value = "/calSalaryStep3")
	public String calSalaryStep3(@RequestParam("employeeIds") List<String> employeeIds, CalSalaryListVO vo, Model model){
		logger.debug("calSalaryStep3() 호출");
		logger.debug(employeeIds.toString());
		logger.debug(vo.toString());
		
		String check_in = vo.getYear() + "-" + vo.getMonth()+"-01";
		vo.setCheck_in(check_in);
		
		//급여산출 메서드
		List<CalSalaryFinalVO> CalSalaryFinalInfo = sService.calSalary(employeeIds, vo);
		
		logger.debug(CalSalaryFinalInfo.toString());
		model.addAttribute("CalSalaryFinalInfo", CalSalaryFinalInfo);
		model.addAttribute("calSalaryInfo", vo);
		
		return "/salary/calSalaryStep3";
	}
	
	// 최종 급여산출내용을 테이블로 저장하기
	@PostMapping(value = "/saveSalaryInfo")
	@ResponseBody
	public String saveSalaryInfo(@RequestBody Map<String, Object> data){
		
		//전달된 데이터 저장
		logger.debug(data.toString());
		List<String> employeeIds = (List<String>)data.get("employeeIds");
		String year = (String)data.get("year");
		String month = (String)data.get("month");
		String sal_type = (String)data.get("sal_type");
		double bonus_rate = Double.parseDouble((String)data.get("bonus_rate"));
		String check_in = year + "-" + month+"-01";
		
		// 전달된 정보 저장 idList, (급여유형, 연도, 월) => 객체 저장
		CalSalaryListVO vo = new CalSalaryListVO();
		vo.setSal_type(sal_type);
		vo.setYear(year);
		vo.setMonth(month);
		vo.setBonus_rate(bonus_rate);
		vo.setCheck_in(check_in);
		
		//급여산출
		List<CalSalaryFinalVO> CalSalaryFinalInfo = sService.calSalary(employeeIds, vo);
		logger.debug(CalSalaryFinalInfo.toString());
		
		//산출된 급여 급여상세내역 테이블 저장
		sService.saveCalSalaryFinal(CalSalaryFinalInfo);
		
		// 급여내역테이블 저장
		sService.saveCalSalaryList(vo);
		
		return "ok";
	}
	
	// 급여내역리스트에서 삭제하기
	@PostMapping(value = "/deleteSalaryInfo")
	public String deleteSalaryInfo(@RequestParam("sal_list_id") String sal_list_id){
		logger.debug("deleteSalaryList(@RequestParam(\"sal_list_id\") String sal_list_id) 실행");
		// 급여내역리스트 및 급여상세테이블 삭제하기
		sService.deleteSalaryInfo(sal_list_id);
		
		return "redirect:/salary/calSalary";
	}
	
	// 급여내역리스트에서 최종확정 하기
	@PostMapping(value = "/confirmSalaryList")
	public String confirmSalaryList(@RequestParam("sal_list_id") String sal_list_id){
		logger.debug("confirmSalaryList(@RequestParam(\"sal_list_id\") String sal_list_id) 실행");
		logger.debug(sal_list_id);
		// 급여내역리스트 상태 최종확정으로 변경
		sService.confirmSalaryList(sal_list_id);
		
		return "redirect:/salary/calSalary";
	}
	
	// 급여내역페이지에서 조회시 급여조회 페이지 이동
	// http://localhost:8088/salary/calSalaryView
	@GetMapping(value = "/calSalaryView")
	public String calSalaryView(@RequestParam("sal_list_id") String sal_list_id, Model model){
		logger.debug("calSalaryView(@RequestParam(\"sal_list_id\") String sal_list_id, Model model) 실행");
		logger.debug(sal_list_id);
		
		// 급여상세내역 가져오기
		List<CalSalaryFinalVO> calSalaryFinalInfo = sService.getCalSalaryFinalListForView(sal_list_id);
		model.addAttribute("calSalaryFinalInfo", calSalaryFinalInfo);
		
		// 기본내용가져오기(급여형태/연/월)
		CalSalaryListVO calSalaryListInfo = sService.getCalSalaryListForView(sal_list_id);
		model.addAttribute("calSalaryListInfo", calSalaryListInfo);
		
		return "/salary/calSalaryView";
	}
	
	// 급여조회(관리자) 페이지 호출
	@GetMapping(value = "salaryInquiryForManage")
	public String salaryInquiryForManage() {
		return "/salary/salaryInquiryForManage";
	}
	
	// 급여조회(관리자) 조회하기
	@PostMapping(value = "getSalaryInquiryForManage")
	@ResponseBody
	public List<CalSalaryFinalVO> getSalaryInquiryForManage(@RequestBody List<String> checkSalaryInfo) {
		logger.debug(checkSalaryInfo.toString());
		
		CalSalaryListVO vo = new CalSalaryListVO();
		vo.setYear(checkSalaryInfo.get(0));
		vo.setEmp_id(checkSalaryInfo.get(1));
		vo.setEmp_name(checkSalaryInfo.get(1));
		
		//사번으로 먼저 select
		List<CalSalaryFinalVO> calSalaryInquiryList = sService.getSalaryInquiryForManageToId(vo) ;
		
		//사번으로 검색 없으면
		if(calSalaryInquiryList.size() == 0) {
			calSalaryInquiryList = sService.getSalaryInquiryForManageToName(vo);
		}
		logger.debug(calSalaryInquiryList.toString());
		
		return calSalaryInquiryList;
	}
	
	// 급여조회 상세페이지(매니저 및 직원 겸용)
	@GetMapping(value = "salaryDetail")
	public String getSalaryDetail(@RequestParam("sal_final_id") int sal_final_id, Model model) {
		logger.debug(""+sal_final_id);
		
		// 해당 급여번호 급여정보 가져가기
		CalSalaryFinalVO calSalaryFinalInfo = sService.getSalaryDetail(sal_final_id);
		model.addAttribute("calSalaryFinalInfo", calSalaryFinalInfo);
		
		return "/salary/salaryDetail";
	}

	// 급여조회(직원) 페이지 호출
		@GetMapping(value = "salaryInquiryForEmployee")
		public String salaryInquiryForEmployee(HttpSession session) {
			return "/salary/salaryInquiryForEmployee";
		}
	
	// 급여조회(직원) 조회하기
	@PostMapping(value = "getSalaryInquiryForEmployee")
	@ResponseBody
	public List<CalSalaryFinalVO> getSalaryInquiryForEmployee(@RequestBody List<String> checkSalaryInfo) {
		logger.debug("getSalaryInquiryForEmployee() 호출");
		logger.debug(checkSalaryInfo.toString());
		
		CalSalaryListVO vo = new CalSalaryListVO();
		vo.setYear(checkSalaryInfo.get(0));
		vo.setEmp_id(checkSalaryInfo.get(1));
		
		//사번으로 먼저 select
		List<CalSalaryFinalVO> calSalaryInquiryList = sService.getSalaryInquiryForManageToId(vo) ;
		
		logger.debug(calSalaryInquiryList.toString());
		
		return calSalaryInquiryList;
	}	
		
	// 엑셀내려받기 시 은행이체양식으로 작성 및 엑셀 다운로드
	@GetMapping(value = "excelDownload")
	public String excelTest(HttpServletResponse response, @RequestParam("sal_list_id") String sal_list_id) throws IOException {
		logger.debug("sal_list_id: "+sal_list_id);
		
		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("BankTransperData");
		
		// 은행이체용 정보 가져오기
		List<BankTransperVO> csList = sService.excelDownload(sal_list_id);
		
		 // 2. 헤더 생성 (첫 번째 행)
        String[] headers = { "수취인명", "은행명", "계좌번호", "이체금액", "지급일", "이체구분", 
        			"송금인명", "송금인 계좌", "비고" };
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }
        
        LocalDate today = LocalDate.now();
        int year = today.getYear();           // 연도
        int month = today.getMonthValue();    // 월 (숫자 형식)
        
        int rowNum = 1; // 두 번째 행부터 데이터 시작
        for (BankTransperVO dto : csList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(dto.getEmp_account_name());
            row.createCell(1).setCellValue(dto.getEmp_bank_name());
            row.createCell(2).setCellValue(dto.getEmp_account_num());
            row.createCell(3).setCellValue(dto.getSal_total_after());
            row.createCell(4).setCellValue(year+""+month+"25");
            row.createCell(5).setCellValue(dto.getSal_type());
            row.createCell(6).setCellValue("주식회사 Init");
            row.createCell(7).setCellValue("121-2112-121212");
            row.createCell(8).setCellValue(dto.getYear()+"년 "+dto.getMonth()+"월 "+dto.getSal_type());
        }
		
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"data.xlsx\"");
        
        workbook.write(response.getOutputStream());
        workbook.close();
		
		return "/salary/calSalary";
	}
	
	// 결재요청하기 눌렀을 때 왼쪽 직원관련 본부+부서, 직원정보 가져오기
	@PostMapping(value = "getMemberInfoForSign")
	@ResponseBody
	public Map<String,Object> getMemberInfoForSign(HttpSession session){
		// 사번저장
		String emp_id = (String)session.getAttribute("emp_id");
		logger.debug(emp_id);
				
		// 직원정보 가져오기 (본부, 부서)
		MemberInfoForSalaryVO memberInfo = sService.getMemberInfoForSignToId(emp_id);
		
		MemberInfoForSalaryVO vo = new MemberInfoForSalaryVO();
		String emp_bnum = memberInfo.getEmp_bnum();
		String dname = memberInfo.getDname();
		
		vo.setEmp_bnum(emp_bnum); // 가져온 본부정보
		vo.setDname(dname); // 가져온 부서정보
		
		// 본부명으로 본부장 정보 가져오기
		MemberInfoForSalaryVO directorInfo = sService.getMemberInfoForSignToBnum(vo);
		// 부장 및 팀장 정보 가져오기
		List<MemberInfoForSalaryVO> deptInfo = sService.getMemberInfoForSignToDname(vo);
		
		Map<String, Object> memberInfoData = new HashMap<String, Object>();
		memberInfoData.put("memberInfo", memberInfo);
		memberInfoData.put("emp_bnum", emp_bnum);
		memberInfoData.put("dname", dname);
		memberInfoData.put("directorInfo", directorInfo);
		memberInfoData.put("deptInfo", deptInfo);
		
		logger.debug(memberInfoData.toString());
		
		return memberInfoData;
	}
	
	//결재요청 시 워크플로우 테이블에 저장
	@PostMapping(value = "insertSignInfo")
	@ResponseBody
	public void insertSignInfo(@RequestBody Map<String, String> signData) {
		logger.debug("signData :"+signData.toString());
		String sal_list_id = signData.get("sal_list_id");
		
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
		vo.setWf_type("급여");
		vo.setWf_sender(signData.get("wf_sender"));
		vo.setWf_receiver_1st(signData.get("wf_receiver_1st"));
		vo.setWf_receiver_2nd(signData.get("wf_receiver_2nd"));
		vo.setWf_receiver_3rd(signData.get("wf_receiver_3rd"));
		vo.setWf_target(sal_list_id);
		vo.setWf_title(signData.get("wf_title"));
		vo.setWf_content(signData.get("wf_content"));
		
		//결재정보를 워크플로우 디비에 저장
		sService.insertSalarySignInfoToWorkFlow(vo);
		
		//급여내역리스트 상태를 결재중으로 변경
		sService.updateCalSalaryListForSigning(sal_list_id);
	}
	
	
}
