package com.Init.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.domain.BankTransperVO;
import com.Init.domain.CalSalaryFinalVO;
import com.Init.domain.CalSalaryListVO;
import com.Init.domain.MemberInfoForSalaryVO;
import com.Init.domain.SalaryBasicInfoVO;
import com.Init.domain.SalaryPositionJobVO;
import com.Init.domain.WorkflowVO;
import com.Init.persistence.SalaryDAO;

@Service
public class SalaryServiceImpl implements SalaryService{

	@Autowired
	private SalaryDAO sdao;
	
	// 급여기본설정 페이지 접속 시 기본정보 출력
	@Override
	public SalaryBasicInfoVO getSalaryBasicInfo() {
		return sdao.getSalaryBasicInfo();
	}
	
	// 급여기본설정 없을 시 초기화
	@Override
	public void initSalaryBasicInfo() {
		sdao.initSalaryBasicInfo();
	}
	
	// 급여기본설정 수정
	@Override
	public void updateSalaryBasicInfo(SalaryBasicInfoVO vo) {
		sdao.updateSalaryBasicInfo(vo);
	}
	
	// 직급급/직무급 페이지 접속 시 기본정보 출력
	@Override
	public SalaryPositionJobVO getSalaryPositionJobInfo() {
		return sdao.getSalaryPositionJobInfo();
	}
	
	// 직급급/직무급 기본설정 없을 시 초기화
	@Override
	public void initSalaryPositionJobInfo() {
		sdao.initSalaryPositionJobInfo();
	}
	
	// 직급급/직무급 수정
	@Override
	public void updatesalaryPositionJobInfo(SalaryPositionJobVO vo) {
		sdao.updatesalaryPositionJobInfo(vo);
	}
	
	// 급여내역테이블에서 급여리스트 가져오기
	@Override
	public List<CalSalaryListVO> getCalSalaryList() {
		return sdao.getCalSalaryList();
	}
	
	// 급여형태/연/월 중복작성 막기 위한 급여리스트 존재 조회
	@Override
	public CalSalaryListVO checkCreateSalary(CalSalaryListVO vo) {
		return sdao.checkCreateSalary(vo);
	}
	
	// 모달창에서 사번으로 직원정보 가져오기
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoToId(String employee_id) {
		return sdao.getMemberInfoToId(employee_id);
	}
	
	// 이름으로 직원정보 가져오기
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoToName(String employee_name) {
		return sdao.getMemberInfoToName(employee_name);
	}
	
	// 모달에서 검색된 직원 모달테이블로 이동(근무이력 포함해서 출력)
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoForSalary(MemberInfoForSalaryVO vo) {
		return sdao.getMemberInfoForSalary(vo);
	}
	
	// 전체 직원정보(해당연월 근무이력) 가져오기
	@Override
	public List<MemberInfoForSalaryVO> getMemberAllInfo(MemberInfoForSalaryVO vo) {
		return sdao.getMemberAllInfo(vo);
	}
	
	// 급여산출하기
	@Override
	public List<CalSalaryFinalVO> calSalary(List<String> employeeIds, CalSalaryListVO vo) {
		return sdao.calSalary(employeeIds, vo);
	}
	
	// 급여산출결과 급여내역 테이블에 저장
	@Override
	public void saveCalSalaryList(CalSalaryListVO vo) {
		sdao.saveCalSalaryList(vo);
	}
	
	// 급여산출결과 급여상세 테이블에 저장
	@Override
	public void saveCalSalaryFinal(List<CalSalaryFinalVO> CalSalaryFinalInfo) {
		sdao.saveCalSalaryFinal(CalSalaryFinalInfo);
	}
	
	// 급여내역테이블 삭제시 급여내역 및 상세테이블 삭제
	@Override
	public void deleteSalaryInfo(String sal_list_id) {
		sdao.deleteSalaryInfo(sal_list_id);
	}
	
	// 급여내역리스트 상태 최종확정으로 변경
	@Override
	public void confirmSalaryList(String sal_list_id) {
		sdao.confirmSalaryList(sal_list_id);
	}
	
	// 급여내역테이블 조회시 급여상세내역 가져오기
	@Override
	public List<CalSalaryFinalVO> getCalSalaryFinalListForView(String sal_list_id) {
		return sdao.getCalSalaryFinalListForView(sal_list_id);
	}
	
	// 급여내역테이블 조회시 급여정보(형태/연/월) 가져오기
	@Override
	public CalSalaryListVO getCalSalaryListForView(String sal_list_id) {
		return sdao.getCalSalaryListForView(sal_list_id);
	}
	
	// 급여조회(사번)하기 급여정보(연/월/사번)
	@Override
	public List<CalSalaryFinalVO> getSalaryInquiryForManageToId(CalSalaryListVO vo) {
		return sdao.getSalaryInquiryForManageToId(vo);
	}
	
	// 급여조회(이름)하기 급여정보(연/월/이름)
	@Override
	public List<CalSalaryFinalVO> getSalaryInquiryForManageToName(CalSalaryListVO vo) {
		return sdao.getSalaryInquiryForManageToName(vo);
	}
	
	// 급여조회(관리자) : 상세보기 클릭 시 상세급여 가져오기
	@Override
	public CalSalaryFinalVO getSalaryDetail(int sal_final_id) {
		return sdao.getSalaryDetail(sal_final_id);
	}
	
	// 엑셀내려받기 클릭 시 은행이체양식용 정보 가져오기
	@Override
	public List<BankTransperVO> excelDownload(String sal_list_id) {
		return sdao.excelDownload(sal_list_id);
	}
	
	// 결재요청 눌렀을 때 사번으로 직원정보 가져오기
	@Override
	public MemberInfoForSalaryVO getMemberInfoForSignToId(String emp_id) {
		return sdao.getMemberInfoForSignToId(emp_id);
	}
	
	// 결재요청 눌렀을 때 사원정보로 본부장 및 부서원 정보가져오기
	@Override
	public MemberInfoForSalaryVO getMemberInfoForSignToBnum(MemberInfoForSalaryVO vo) {
		return sdao.getMemberInfoForSignToBnum(vo);
	}
	
	// 결재요청 눌렀을 때 사원정보로 부서원 정보가져오기
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoForSignToDname(MemberInfoForSalaryVO vo) {
		return sdao.getMemberInfoForSignToDname(vo);
	}
	
	// 결재요청 시 급여내역리스트 상태(결재중) 변경
	@Override
	public void updateCalSalaryListForSigning(String sal_list_id) {
		sdao.updateCalSalaryListForSigning(sal_list_id);
	}
	
	// 결재요청 시 워크플로우에 신규 내용 추가
	@Override
	public void insertSalarySignInfoToWorkFlow(WorkflowVO vo) {
		sdao.insertSalarySignInfoToWorkFlow(vo);
	}
	
	// 올해 첫 워크플로우 번호가 있는지 확인
	@Override
	public String checkWfCode(String wf_code) {
		return sdao.checkWfCode(wf_code);
	}
	
	// 가장 최근의 워크플로우 번호 가져오기
	@Override
	public String getWfCode() {
		return sdao.getWfCode();
	}
	
	// 결재완료 시 급여내역리스트 상태를 결재완료로 변경
	@Override
	public void whenSalarySignComplete(String sal_list_id) {
		sdao.whenSalarySignComplete(sal_list_id);
	}
	
	// 결재반려 시 급여내역리스트 상태를 반려로 변경
	@Override
	public void whenSalarySignReject(String sal_list_id) {
		sdao.whenSalarySignReject(sal_list_id);
	}
	
	
}
