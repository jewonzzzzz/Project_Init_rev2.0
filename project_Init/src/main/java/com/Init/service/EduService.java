package com.Init.service;

import java.util.List;

import com.Init.domain.EduListVO;

public interface EduService {
	
	// 올해 첫 교육번호 있는지 확인하기
	public String checkEduId(String edu_id);
	
	// 가장 최근의 교육번호 가져오기
	public String getEduId();
	
	// 교육 생성 정보 저장하기
	public void saveEduInfo(EduListVO vo);
	
	// 교육 등록내역 가져오기
	public List<EduListVO> getEduList();
	
	// edu_id로 교육정보 가져오기
	public EduListVO getEduListToId(String edu_id);
	
	// 교육정보 수정하기
	public void updateEudInfo(EduListVO vo);
	
	// 신청가능 교육 가져오기
	public List<EduListVO> getEduApplyInfo(String emp_id);
	
	// 신청완료 시 교육이력테이블에 저장하기
	public void saveEduApplyInfo(EduListVO vo);
	
	// 교육이력관리(직원) 페이지 이동시 교육이력정보 가져오기
	public List<EduListVO> getEduHisInfoForEmp(String emp_id);
	
	// 교육이력관리(직원)에서 교육 취소하기
	public void cancelEduApplyInfoForEmp(EduListVO vo);
	
	// 교육이력관리(관리자) 페이지 이동 시 기본정보(신청완료건) 보여주기
	public List<EduListVO> getEduApplyInfoForManagerBase();
	
	// 교육이력관리(관리자)에서 조회(교육명)
	public List<EduListVO> eduInquiryToEduName(String edu_name);
	
	// 교육이력관리(관리자)에서 조회(사번)
	public List<EduListVO> eduInquiryToEmpId(String emp_id);
	
	// 교육이력관리(관리자)에서 조회(이름)
	public List<EduListVO> eduInquiryToEmpName(String emp_name);
	
	// 교육등록관리에서 교육정보 삭제
	public void deledteEduInfo(String edu_id);
	
	// 교육관리에서 신청자명단 클릭 시 신청자명단 가져오기
	public List<EduListVO> getEduPersonInfo(String edu_id);
	
	// 교육관리에서 교육확정하기
	public void confirmEduInfo(EduListVO vo);
	
	// 교육관리에서 교육종료하기
	public void endEduInfo(EduListVO vo);
	
	// 이수처리 버튼 시 직원정보리스트 받아와서 교육이수로 변경하기
	public void completeEduInfo(List<String> completeEudIds);
	
	// 미이수처리 버튼 시 직원정보리스트 받아와서 교육미이수로 변경하기
	public void nonCompleteEduInfo(List<String> nonCompleteEudIds);
	
	// 결재요청 시 교육리스트 상태를 결재중으로 변경
	public void updateEduListForSigning(String edu_id);
	
	// 결재완료 시 교육리스트 상태를 결재완료로 변경
	public void whenEduSignComplete(String edu_id);
	
	// 결재반려 시 교육리스트 상태를 반려로 변경
	public void whenEduSignReject(String edu_id);
	
	// 교육신청명단에서 엑셀 내려받기 시 직원정보 가져오기
	public List<EduListVO> downloadEduPersonInfo(List<String> empIds);
	
}
