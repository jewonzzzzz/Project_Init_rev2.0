package com.Init.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

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

import com.Init.domain.EvalVO;
import com.Init.service.EvalService;

@Controller
@RequestMapping(value = "eval/*")
public class EvalController {

	@Autowired
	private EvalService evService;
	
	private static final Logger logger = LoggerFactory.getLogger(EvalController.class);
	
	
	// 성과관리 페이지 이동
	@GetMapping(value = "evalManage")
	public String evalManage(Model model) {
		
		// 현재까지 성과평과 내역 가져오기
		List<EvalVO> evalListInfo = evService.getEvalList();
		model.addAttribute("evalListInfo", evalListInfo);
		
		return "eval/evalManage";
	}
	
	// 성과관리에서 신규등록 페이지 이동
	@GetMapping(value = "evalCreate")
	public String evalCreateGET() {
		
		return "eval/evalCreate";
	}
	
	// 성과관리에서 신규등록 페이지 이동
	@PostMapping(value = "evalCreate")
	public String evalCreatePOST(EvalVO vo) {
		
		// eval_id 생성
        LocalDate today = LocalDate.now();
        int year = today.getYear();
        String eval_id = "eval" +year+"00001";
        
        // 올해 첫 성과평가번호가 있는지 확인하기
        String checkEvalId = evService.checkEvalId(eval_id);
        
        if(checkEvalId != null) {
        	//있으면 edu_id를 가장 최근 id에서 +1
        	String getEvalId = evService.getEvalId();
        	eval_id = "eval"+(Integer.parseInt(getEvalId.substring(4))+1);
        }
		
        vo.setEval_id(eval_id);
		evService.evalCreate(vo);
		
		return "redirect:/eval/evalManage";
	}
	
	// 성과평가 중복 생성 방지
	@PostMapping(value = "checkCreateEval")
	@ResponseBody
	public String checkCreateEval(@RequestBody EvalVO vo) {
		logger.debug(vo.toString());
		
		// 유형/연도/반기로 중복여부 확인
		EvalVO checkEvalInfo = evService.checkCreateEval(vo);
		
		if(checkEvalInfo == null) {
			return "ok";
		}
		return null;
	}
	
	// 성과평가 목록 삭제
	@PostMapping(value = "deleteEvalInfo")
	public String deleteEvalInfo(EvalVO vo) {
		logger.debug(vo.toString());
		evService.deleteEvalInfo(vo);
		return "redirect:/eval/evalManage";
	}
	
	// 성과보고 페이지 이동
	@GetMapping(value = "reportEval")
	public String reportEval(HttpSession session, Model model) {
		
		// 성과보고를 위한 성과평가리스트 가져오기
		EvalVO evalReportInfo = evService.getEvalReportList();
		model.addAttribute("evalReportInfo", evalReportInfo);
		
		return "eval/reportEval";
	}
	
	// 성과보고 클릭 시 평가준비에서 성과보고로 변경
	@PostMapping(value = "updateEvalInfoToReport")
	public String updateEvalInfoToReport(EvalVO vo) {
		logger.debug(vo.toString());
		evService.updateEvalInfoToReport(vo);
		
		return "redirect:/eval/evalManage";
	}
	
	// 성과보고 페이지 이동
	@GetMapping(value = "evalReportView")
	public String evalReportView(@RequestParam("eval_id") String eval_id, 
			HttpSession session, Model model) {
			logger.debug(eval_id);
		// 성과리스트 정보 가져가기
		EvalVO evalReportInfo = evService.getEvalInfoForView(eval_id);
		
		// 성과 작성내역이 있으면 정보 가져와서 출력하기
		EvalVO vo = new EvalVO();
		vo.setEval_id(eval_id);
		vo.setEmp_id((String)session.getAttribute("emp_id"));
		
		EvalVO evalHisReportInfo = evService.getHisEvaReport(vo);
		if(evalHisReportInfo == null) {
			model.addAttribute("checkHisInfo", "no");
		} else {
			model.addAttribute("checkHisInfo", "yes");
		}
		
		model.addAttribute("evalReportInfo", evalReportInfo);
		model.addAttribute("evalHisReportInfo", evalHisReportInfo);
		
		return "eval/evalReportView";
	}
	
	// 성과보고 성과이력테이블에 저장하기
	@PostMapping(value = "saveEvalReport")
	public String saveEvalReport(EvalVO vo) {
		logger.debug(vo.toString());
		
		evService.saveEvalReport(vo);
		
		return "redirect:/eval/evalReportView?eval_id="+vo.getEval_id();
	}
	
	// 성과보고 내용 수정하기
	@PostMapping(value = "updateEvalReport")
	@ResponseBody
	public String updateEvalReport(@RequestBody EvalVO vo) {
		logger.debug(vo.toString());
		evService.updateEvalReport(vo);
		
		return "ok";
	}
	
	// 성과관리페이지에서 평가시작 클릭 시 상태 변경
	@PostMapping(value = "startEval")
	public String startEval(EvalVO vo) {
		logger.debug(vo.toString());
		evService.startEval(vo);
		
		return "redirect:/eval/evalManage";
	}
	
	// 성과평가 페이지 이동(현재 평가시작이 되고 부서장만 접근할 수 있어야됨)
	@GetMapping(value = "resultEval")
	public String resultEval(HttpSession session, Model model) {
		
		// 부서장이 아닐 시 접근 막기 => 사이드메뉴에서 안보이기
		
		String emp_id = (String)session.getAttribute("emp_id");
		EvalVO vo = evService.getEvaluatorInfo(emp_id);
		
		// 평가시작된 eval_id와 부서 하위직원 내역 가져오기
		List<EvalVO> resultInfoForEval = evService.getResultInfoForEval(vo);
		model.addAttribute("resultInfoForEval", resultInfoForEval);
		
		return "eval/resultEval";
	}
	
	// 성과평가에서 직원별 상세 페이지로 이동
	@GetMapping(value = "resultEvalDetail")
	public String resultEvalDetail(@RequestParam("eval_his_id") String eval_his_id,
			HttpSession session, Model model) {
		
		// 평가자 정보 가져오기
		String emp_id = (String)session.getAttribute("emp_id");
		EvalVO evaluatorInfo = evService.getEvaluatorInfo(emp_id);
		
		// 피평가자 정보 가져오기
		EvalVO reportInfoForEval = evService.getReportInfoForEval(eval_his_id);
		model.addAttribute("reportInfoForEval", reportInfoForEval);
		model.addAttribute("evaluatorInfo", evaluatorInfo);
		
		return "eval/resultEvalDetail";
	}
	
	// 성과평가 내용 저장하기
	@PostMapping(value = "saveResultEval")
	public String saveResultEval(EvalVO vo) {
		logger.debug(vo.toString());
		evService.saveResultEval(vo);
		
		return "redirect:/eval/resultEvalDetail?eval_his_id="+vo.getEval_his_id();
	}
	
	// 성과평가 내용 수정하기
	@PostMapping(value = "updateResultEval")
	public String updateResultEval(EvalVO vo) {
		logger.debug("updateResultEval : "+vo.toString());
		evService.saveResultEval(vo);
		return "redirect:/eval/resultEvalDetail?eval_his_id="+vo.getEval_his_id();
	}
	
	// 성과관리에서 평가종료로 변경하기
	@PostMapping(value = "endEval")
	public String endEval(EvalVO vo) {
		logger.debug(vo.toString());
		evService.endEval(vo);
		
		return "redirect:/eval/evalManage"; 
	}
	
	// 성과이력조회 페이지 이동
	@GetMapping(value = "evalHisInquiry")
	public String evalHisInquiry() {
		
		return "eval/evalHisInquiry";
	}
	
	// 성과이력조회 페이지 이동 후 비동기로 데이터 가져오기
	@PostMapping(value = "getEvalHisInquiry")
	@ResponseBody
	public List<EvalVO> getEvalHisInquiry(HttpSession session){
		String emp_id = (String)session.getAttribute("emp_id");
		List<EvalVO> evalHisInquiryInfo = evService.getEvalHisInquiry(emp_id);
		
		return evalHisInquiryInfo;
	}
	
	// 성과관리에서 성과평가명 클릭 시 상세페이지 이동
	@GetMapping(value = "evalDetail")
	public String evalDetail(@RequestParam("eval_id") String eval_id, Model model) {
		logger.debug("eval_id :" + eval_id);
		
		// 받아온 eval_id로 정보 가져와서 뷰로 전달
		EvalVO evalInfo = evService.getEvalInfoForView(eval_id);
		model.addAttribute("evalInfo", evalInfo);
		
		return "eval/evalDetail";
	}
	
	// 성과관리 상세페이지에서 수정하기
	@PostMapping(value = "evalUpdate")
	public String evalUpdate(EvalVO vo) {
		logger.debug(vo.toString());
		evService.evalUpdate(vo);
		return "redirect:/eval/evalDetail?eval_id="+vo.getEval_id();
	}
	
	
}
