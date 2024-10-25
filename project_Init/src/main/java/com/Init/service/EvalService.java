package com.Init.service;

import java.util.List;

import com.Init.domain.EvalVO;

public interface EvalService {

	// 성과평가 신규등록 하기
	public void evalCreate(EvalVO vo);
	
	// 올해 첫 평가번호가 있는지 확인하기
	public String checkEvalId(String eval_id);
	
	// 가장 최근의 eval_id 가져오기
	public String getEvalId();
	
	// 현재까지 평가내역 가져오기
	public List<EvalVO> getEvalList();
	
	// 유형/연도/반기로 중복여부 확인
	public EvalVO checkCreateEval(EvalVO vo);
	
	// 성과평가 리스트 삭제
	public void deleteEvalInfo(EvalVO vo);
	
	// 성과보고를 위한 성과평가리스트 가져오기
	public EvalVO getEvalReportList();
	
	// 성과보고 클릭 시 평가준비에서 성과보고로 변경
	public void updateEvalInfoToReport(EvalVO vo);
	
	// 성과보고 페이지 업무성과 보고대상용 리스트 정보 가져오기
	public EvalVO getEvalInfoForView(String eval_id);
	
	// 성과보고 내용 성과이력테이블에 저장하기
	public void saveEvalReport(EvalVO vo);
	
	// 성과보고 작성내역 확인용 가져오기
	public EvalVO getHisEvaReport(EvalVO vo);
	
	// 성과보고 내용 수정하기
	public void updateEvalReport(EvalVO vo);
	
	// 성과관리페이지에서 평가시작으로 변경
	public void startEval(EvalVO vo);
	
	// 성과보고페이지 접근 시 이전 모든 이력 가져오기
	public List<EvalVO> getHisEvalReportAll(String emp_id);
	
	// 성과평가 페이지 접근자 부서정보 가져오기
	public EvalVO getEvaluatorInfo(String emp_id);
	
	// 평가시작된 eval_id와 부서 하위직원 내역 가져오기
	public List<EvalVO> getResultInfoForEval(EvalVO vo);
	
	// 성과평가 상세페이지에서 보여줄 정보가져오기(his_id별)
	public EvalVO getReportInfoForEval(String eval_his_id);
	
	// 성과평가 저장하기
	public void saveResultEval(EvalVO vo);
	
	// 성과관리페이지에서 평가종료로 변경
	public void endEval(EvalVO vo);
	
	// 성과이력조회 이동 후 데이터 가져오기
	public List<EvalVO> getEvalHisInquiry(String emp_id);
	
	// 성과관리 상세페이지에서 수정하기
	public void evalUpdate(EvalVO vo);
	
	
	
	
	
	
}
