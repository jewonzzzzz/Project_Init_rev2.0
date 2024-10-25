package com.Init.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.domain.EduListVO;
import com.Init.persistence.EduDAO;

@Service
public class EduServiceImpl implements EduService {

	@Autowired
	private EduDAO edao;
	
	// 올해 첫 교육번호 있는지 확인하기
	@Override
	public String checkEduId(String edu_id) {
		return edao.checkEduId(edu_id);
	}
	
	// 가장 최근의 교육번호 가져오기
	@Override
	public String getEduId() {
		return edao.getEduId();
	}
	
	
	// 교육 생성 정보 저장하기
	@Override
	public void saveEduInfo(EduListVO vo) {
		edao.saveEduInfo(vo);
	}
	
	// 교육 등록내역 가져오기
	@Override
	public List<EduListVO> getEduList() {
		return edao.getEduList();
	}
	
	// edu_id로 교육정보 가져오기
	@Override
	public EduListVO getEduListToId(String edu_id) {
		return edao.getEduListToId(edu_id);
	}
	
	// 교육정보 수정하기
	@Override
	public void updateEudInfo(EduListVO vo) {
		edao.updateEudInfo(vo);
	}
	
	// 신청가능 교육 가져오기
	@Override
	public List<EduListVO> getEduApplyInfo(String emp_id) {
		return edao.getEduApplyInfo(emp_id);
	}
	
	// 신청완료 시 교육이력테이블에 저장하기
	@Override
	public void saveEduApplyInfo(EduListVO vo) {
		edao.saveEduApplyInfo(vo);
	}
	
	// 교육이력관리(직원) 페이지 이동시 교육이력정보 가져오기
	@Override
	public List<EduListVO> getEduHisInfoForEmp(String emp_id) {
		return edao.getEduHisInfoForEmp(emp_id);
	}
	
	// 교육이력관리(직원)에서 교육 취소하기
	@Override
	public void cancelEduApplyInfoForEmp(EduListVO vo) {
		edao.cancelEduApplyInfoForEmp(vo);
	}
	
	// 교육이력관리(관리자) 페이지 이동 시 기본정보(신청완료건) 보여주기
	@Override
	public List<EduListVO> getEduApplyInfoForManagerBase() {
		return edao.getEduApplyInfoForManagerBase();
	}
	
	// 교육이력관리(관리자)에서 조회(교육명)
	@Override
	public List<EduListVO> eduInquiryToEduName(String edu_name) {
		return edao.eduInquiryToEduName(edu_name);
	}
	
	// 교육이력관리(관리자)에서 조회(사번)
	@Override
	public List<EduListVO> eduInquiryToEmpId(String emp_id) {
		return edao.eduInquiryToEmpId(emp_id);
	}
	
	// 교육이력관리(관리자)에서 조회(이름)
	@Override
	public List<EduListVO> eduInquiryToEmpName(String emp_name) {
		return edao.eduInquiryToEmpName(emp_name);
	}
	
	// 교육등록관리에서 교육정보 삭제
	@Override
	public void deledteEduInfo(String edu_id) {
		edao.deledteEduInfo(edu_id);
	}
	
	// 교육관리에서 신청자명단 클릭 시 신청자명단 가져오기
	@Override
	public List<EduListVO> getEduPersonInfo(String edu_id) {
		return edao.getEduPersonInfo(edu_id);
	}
	
	// 교육관리에서 교육확정하기(교육리스트 + 교육이력리스트)
	@Override
	public void confirmEduInfo(EduListVO vo) {
		// 교육리스트 교육확정
		edao.confirmEduInfo(vo);
		// 교육이력리스트 교육확정
		edao.confirmEduApplyInfo(vo);
	}
	
	// 교육관리에서 교육종료하기
	@Override
	public void endEduInfo(EduListVO vo) {
		edao.endEduInfo(vo);
	}
	
	// 이수처리 버튼 시 직원정보리스트 받아와서 교육이수로 변경하기
	@Override
	public void completeEduInfo(List<String> completeEudIds) {
		edao.completeEduInfo(completeEudIds);
	}
	
	// 미이수처리 버튼 시 직원정보리스트 받아와서 교육미이수로 변경하기
	@Override
	public void nonCompleteEduInfo(List<String> nonCompleteEudIds) {
		edao.nonCompleteEduInfo(nonCompleteEudIds);
	}
	
	// 결재요청 시 교육리스트 상태를 결재중으로 변경
	@Override
	public void updateEduListForSigning(String edu_id) {
		edao.updateEduListForSigning(edu_id);
	}
	
	// 결재완료 시 교육리스트 상태를 결재완료로 변경
	@Override
	public void whenEduSignComplete(String edu_id) {
		edao.whenEduSignComplete(edu_id);
	}
	
	// 결재반려 시 교육리스트 상태를 반려로 변경
	@Override
	public void whenEduSignReject(String edu_id) {
		edao.whenEduSignReject(edu_id);
	}
	
	// 교육신청명단에서 엑셀 내려받기 시 직원정보 가져오기
	@Override
	public List<EduListVO> downloadEduPersonInfo(List<String> empIds) {
		return edao.downloadEduPersonInfo(empIds);
	}
	
	
}
