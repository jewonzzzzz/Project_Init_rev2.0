package com.Init.persistence;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.Init.domain.BankTransperVO;
import com.Init.domain.CalSalaryFinalVO;
import com.Init.domain.CalSalaryListVO;
import com.Init.domain.MemberInfoForSalaryVO;
import com.Init.domain.SalaryBasicInfoVO;
import com.Init.domain.SalaryPositionJobVO;
import com.Init.domain.WorkflowVO;

@Repository
public class SalaryDAOImpl implements SalaryDAO{

	@Autowired
	private SqlSession sqlSession;
	
	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.Init.mapper.SalaryMapper";
	
	// 급여기본설정 페이지 접속 시 기본정보 출력
	@Override
	public SalaryBasicInfoVO getSalaryBasicInfo() {
		return sqlSession.selectOne(NAMESPACE + ".getSalaryBasicInfo");
	}
	
	// 급여기본설정 없을 시 초기화
	@Override
	public void initSalaryBasicInfo() {
		sqlSession.insert(NAMESPACE + ".initSalaryBasicInfo");
	}
	
	// 급여기본설정 수정
	@Override
	public void updateSalaryBasicInfo(SalaryBasicInfoVO vo) {
		sqlSession.update(NAMESPACE + ".updateSalaryBasicInfo", vo);
	}
	
	// 직급급/직무급 페이지 접속 시 기본정보 출력
	@Override
	public SalaryPositionJobVO getSalaryPositionJobInfo() {
		return sqlSession.selectOne(NAMESPACE + ".getSalaryPositionJobInfo");
	}
	
	// 직급급/직무급 기본설정 없을 시 초기화
	@Override
	public void initSalaryPositionJobInfo() {
		sqlSession.insert(NAMESPACE + ".initSalaryPositionJobInfo");
	}
	
	// 직급급/직무급 수정
	@Override
	public void updatesalaryPositionJobInfo(SalaryPositionJobVO vo) {
		sqlSession.update(NAMESPACE + ".updatesalaryPositionJobInfo", vo);
	}
	
	// 급여내역테이블에서 급여리스트 가져오기
	@Override
	public List<CalSalaryListVO> getCalSalaryList() {
		return sqlSession.selectList(NAMESPACE+".getCalSalaryList");
	}
	
	// 급여형태/연/월 중복작성 막기 위한 급여리스트 존재 조회
	@Override
	public CalSalaryListVO checkCreateSalary(CalSalaryListVO vo) {
		return sqlSession.selectOne(NAMESPACE+".checkCreateSalary", vo);
	}
	
	// 모달창에서 사번으로 직원정보 가져오기
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoToId(String employee_id) {
		return sqlSession.selectList(NAMESPACE + ".getMemberInfoToId", employee_id);
	}
	
	// 이름으로 직원정보 가져오기
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoToName(String employee_name) {
		return sqlSession.selectList(NAMESPACE + ".getMemberInfoToName", employee_name);
	}
	
	// 모달에서 검색된 직원 모달테이블로 이동(근무이력 포함해서 출력)
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoForSalary(MemberInfoForSalaryVO vo) {
		return sqlSession.selectList(NAMESPACE + ".getMemberInfoForSalary", vo);
	}
	
	// 전체 직원정보(해당연월 근무이력) 가져오기
	@Override
	public List<MemberInfoForSalaryVO> getMemberAllInfo(MemberInfoForSalaryVO vo) {
		return sqlSession.selectList(NAMESPACE + ".getMemberAllInfo", vo);
	}
	
	// 급여산출결과 급여내역 테이블에 저장
	@Override
	public void saveCalSalaryList(CalSalaryListVO vo) {
		//salary_info_id 설정(s+연도+00001)
        LocalDate today = LocalDate.now();
        int year = today.getYear();
        String sal_list_id = "sal" +year+"00001";
        
        // 올해 첫 급여리스트번호가 있는지 확인하기
        String checkSalListId = sqlSession.selectOne(NAMESPACE+".checkSalListId", sal_list_id);
        
        if(checkSalListId != null) {
        	//있으면 sal_list_id를 가장 최근에서 +1
        	String getSalListId = sqlSession.selectOne(NAMESPACE+".getSalListId");
        	sal_list_id = "sal"+(Integer.parseInt(getSalListId.substring(3))+1);
        }
        
		//salary_list_subject 설정
		String sal_list_subject = vo.getYear()+"년 "+vo.getMonth()+"월 "+vo.getSal_type()+"내역";
		
		vo.setSal_list_id(sal_list_id);
		vo.setSal_list_subject(sal_list_subject);
		
		sqlSession.insert(NAMESPACE+".saveCalSalaryList", vo);
	}
	
	// 급여산출결과 급여상세 테이블에 저장
	@Override
	public void saveCalSalaryFinal(List<CalSalaryFinalVO> CalSalaryFinalInfo) {
		// 받아온 List 정보를 순차적으로 접근하면서 저장
		for(CalSalaryFinalVO calSalaryFinalInfo : CalSalaryFinalInfo) {
			sqlSession.insert(NAMESPACE+".saveCalSalaryFinal", calSalaryFinalInfo);
		}
	}
	
	// 급여내역테이블 삭제시 급여내역 및 상세테이블 삭제
	@Override
	public void deleteSalaryInfo(String sal_list_id) {
		sqlSession.delete(NAMESPACE+".deleteCalSalaryList", sal_list_id);
		sqlSession.delete(NAMESPACE+".deleteCalSalaryFinal", sal_list_id);
	}
	
	// 급여내역리스트 상태 최종확정으로 변경
	@Override
	public void confirmSalaryList(String sal_list_id) {
		sqlSession.update(NAMESPACE+".confirmSalaryList", sal_list_id);
	}
	
	// 급여내역테이블 조회시 급여상세내역 가져오기
	@Override
	public List<CalSalaryFinalVO> getCalSalaryFinalListForView(String sal_list_id) {
		return sqlSession.selectList(NAMESPACE+".getCalSalaryFinalListForView", sal_list_id);
	}
	
	// 급여내역테이블 조회시 급여정보(형태/연/월) 가져오기
	@Override
	public CalSalaryListVO getCalSalaryListForView(String sal_list_id) {
		return sqlSession.selectOne(NAMESPACE+".getCalSalaryListForView", sal_list_id);
	}
	
	// 급여조회(사번)하기 급여정보(연/월/사번)
	@Override
	public List<CalSalaryFinalVO> getSalaryInquiryForManageToId(CalSalaryListVO vo) {
		return sqlSession.selectList(NAMESPACE+".getSalaryInquiryForManageToId", vo);
	}
	
	// 급여조회(이름)하기 급여정보(연/월/이름)
	@Override
	public List<CalSalaryFinalVO> getSalaryInquiryForManageToName(CalSalaryListVO vo) {
		return sqlSession.selectList(NAMESPACE+".getSalaryInquiryForManageToName", vo);
	}
	
	// 급여조회(관리자) : 상세보기 클릭 시 상세급여 가져오기
	@Override
	public CalSalaryFinalVO getSalaryDetail(int sal_final_id) {
		return sqlSession.selectOne(NAMESPACE+".getSalaryDetail", sal_final_id);
	}
	
	// 엑셀내려받기 시 은행양식 정보 가져오기
	@Override
	public List<BankTransperVO> excelDownload(String sal_list_id) {
		return sqlSession.selectList(NAMESPACE+".excelDownload", sal_list_id);
	}
	
	// 결재요청 버튼 눌렀을 때 해당직원 정보 가져오기(본부+부서)
	@Override
	public MemberInfoForSalaryVO getMemberInfoForSignToId(String emp_id) {
		return sqlSession.selectOne(NAMESPACE+".getMemberInfoForSignToId", emp_id);
	}
	
	// 결재요청 눌렀을 때 사원정보로 본부장 및 부서원 정보가져오기
	@Override
	public MemberInfoForSalaryVO getMemberInfoForSignToBnum(MemberInfoForSalaryVO vo) {
		return sqlSession.selectOne(NAMESPACE+".getMemberInfoForSignToBnum", vo);
	}
	
	// 결재요청 눌렀을 때 사원정보로 부서원 정보가져오기
	@Override
	public List<MemberInfoForSalaryVO> getMemberInfoForSignToDname(MemberInfoForSalaryVO vo) {
		return sqlSession.selectList(NAMESPACE+".getMemberInfoForSignToDname", vo);
	}
	
	// 결재요청 시 급여내역리스트 상태(결재중) 변경
	@Override
	public void updateCalSalaryListForSigning(String sal_list_id) {
		sqlSession.update(NAMESPACE+".updateCalSalaryListForSigning", sal_list_id);
	}
	
	// 결재요청 시 워크플로우에 신규 내용 추가
	@Override
	public void insertSalarySignInfoToWorkFlow(WorkflowVO vo) {
		sqlSession.insert(NAMESPACE+".insertSalarySignInfoToWorkFlow", vo);
	}
	
	// 올해 첫 워크플로우 번호가 있는지 확인
	@Override
	public String checkWfCode(String wf_code) {
		return sqlSession.selectOne(NAMESPACE+".checkWfCode", wf_code);
	}
	
	// 가장 최근의 워크플로우 번호 가져오기
	@Override
	public String getWfCode() {
		return sqlSession.selectOne(NAMESPACE+".getWfCode");
	}
	
	// 결재완료 시 급여내역리스트 상태를 결재완료로 변경
	@Override
	public void whenSalarySignComplete(String sal_list_id) {
		sqlSession.update(NAMESPACE+".whenSalarySignComplete", sal_list_id);
	}
	
	// 결재반려 시 급여내역리스트 상태를 반려로 변경
	@Override
	public void whenSalarySignReject(String sal_list_id) {
		sqlSession.update(NAMESPACE+".whenSalarySignReject", sal_list_id);
	}
	
	
	
	// 급여산출하기
	@Override
	public List<CalSalaryFinalVO> calSalary(List<String> employeeIds, CalSalaryListVO vo) {
		
		// 급여 기본정보 가져오기
				SalaryBasicInfoVO basciInfo = sqlSession.selectOne(NAMESPACE + ".getSalaryBasicInfo");
				double pension_rate = basciInfo.getPension_rate();
				double heal_ins_rate = basciInfo.getHeal_ins_rate();
				double long_ins_rate = basciInfo.getLong_ins_rate();
				double emp_ins_rate = basciInfo.getEmp_ins_rate();
				
				// 직급급/직무급 정보 가져오기
				SalaryPositionJobVO positionJobInfo = sqlSession.selectOne(NAMESPACE + ".getSalaryPositionJobInfo");

				// 급여형태에 따른 분류(월급여/성과급/상여금)
				String sal_type = vo.getSal_type();
				
				//salary_info_id 설정(s+연도+00001)
	            LocalDate today = LocalDate.now();
	            int year = today.getYear();
	            String sal_list_id = "sal" +year+"00001";
	            
	            // 올해 첫 급여리스트번호가 있는지 확인하기
	            String checkSalListId = sqlSession.selectOne(NAMESPACE+".checkSalListId", sal_list_id);
	            
	            if(checkSalListId != null) {
	            	//있으면 sal_list_id를 가장 최근에서 +1
	            	String getSalListId = sqlSession.selectOne(NAMESPACE+".getSalListId");
	            	sal_list_id = "sal"+(Integer.parseInt(getSalListId.substring(3))+1);
	            }
				
				switch (sal_type) {
				case "월급여":
					
					//최종 반환할 CalSalaryFinalVO 리스트 생성
					List<CalSalaryFinalVO> calSalaryFinalList = new ArrayList<CalSalaryFinalVO>();
					
					for (String emp_id : employeeIds) {
						// 직원정보 가져오기
						vo.setEmp_id(emp_id);
						MemberInfoForSalaryVO memberInfo = sqlSession.selectOne(NAMESPACE + ".getMemberInfoForSalary",
								vo);
						
						// 공통사항 계산
						SalaryCalculrator salaryCalculrator = new SalaryCalculrator();
						String emp_position = memberInfo.getEmp_position();
						String emp_job = memberInfo.getEmp_job();
						String dgrade = "해당없음";
						
						int sal_position = salaryCalculrator.checkRankSalary(emp_position, positionJobInfo);
						int sal_job = salaryCalculrator.checkDutySalary(emp_job, positionJobInfo);
						int sal_allow = (salaryCalculrator.calAllow(sal_position, sal_job, memberInfo)/1000)*1000;
						int sal_total_basic = sal_position + sal_job;
						int sal_month = sal_total_basic + sal_allow;
						int incometax = (salaryCalculrator.calIncomeTax(sal_month, basciInfo)/1000)*10;
						int pension = ((int)(sal_month * pension_rate)/1000)*10;
						int heal_ins = ((int)(sal_month * heal_ins_rate)/1000)*10;
						int long_ins = ((int)(heal_ins * long_ins_rate)/1000)*10;
						int emp_ins = ((int)(sal_month * emp_ins_rate)/1000)*10;
						int sal_total_before = sal_month;
						int sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
						int sal_total_after = sal_total_before - sal_total_deduct;
						
						CalSalaryFinalVO calSalaryFinalInfo = new CalSalaryFinalVO();
						// 근무유형(WorkType) 분류(통상,교대,시급)
						switch (memberInfo.getEmp_work_type()) {
						case "통상근무":
						case "교대근무":
							calSalaryFinalInfo.setSal_list_id(sal_list_id);
							calSalaryFinalInfo.setEmp_id(memberInfo.getEmp_id());
							calSalaryFinalInfo.setEmp_name(memberInfo.getEmp_name());
							calSalaryFinalInfo.setDname(memberInfo.getDname());
							calSalaryFinalInfo.setEmp_position(memberInfo.getEmp_position());
							calSalaryFinalInfo.setEmp_job(memberInfo.getEmp_job());
							calSalaryFinalInfo.setEmp_work_type(memberInfo.getEmp_work_type());;
							calSalaryFinalInfo.setDgrade(dgrade);
							
							calSalaryFinalInfo.setSal_position(sal_position);
							calSalaryFinalInfo.setSal_job(sal_job);
							calSalaryFinalInfo.setSal_allow(sal_allow);
							calSalaryFinalInfo.setSal_total_basic(sal_total_basic);
							calSalaryFinalInfo.setSal_month(sal_month);
							calSalaryFinalInfo.setIncometax(incometax);
							calSalaryFinalInfo.setPension(pension);
							calSalaryFinalInfo.setHeal_ins(heal_ins);
							calSalaryFinalInfo.setLong_ins(long_ins);
							calSalaryFinalInfo.setEmp_ins(emp_ins);
							calSalaryFinalInfo.setSal_total_before(sal_total_before);
							calSalaryFinalInfo.setSal_total_deduct(sal_total_deduct);
							calSalaryFinalInfo.setSal_total_after(sal_total_after);
							
							calSalaryFinalList.add(calSalaryFinalInfo);
							break;

						case "시급제":
							sal_position = 0;
							sal_job = 0;
							sal_allow = basciInfo.getHourwage() * memberInfo.getOvertime();
							sal_total_basic = basciInfo.getHourwage()* memberInfo.getWorking_time();
							sal_month = sal_total_basic + sal_allow;
							incometax = (salaryCalculrator.calIncomeTax(sal_month, basciInfo)/1000)*10;
							pension = ((int)(sal_month * pension_rate)/1000)*10;
							heal_ins = ((int)(sal_month * heal_ins_rate)/1000)*10;
							long_ins = ((int)(heal_ins * long_ins_rate)/1000)*10;
							emp_ins = ((int)(sal_month * emp_ins_rate)/1000)*10;
							sal_total_before = sal_month;
							sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
							sal_total_after = sal_total_before - sal_total_deduct;
							
							calSalaryFinalInfo.setSal_list_id(sal_list_id);
							calSalaryFinalInfo.setEmp_id(memberInfo.getEmp_id());
							calSalaryFinalInfo.setEmp_name(memberInfo.getEmp_name());
							calSalaryFinalInfo.setDname(memberInfo.getDname());
							calSalaryFinalInfo.setEmp_position(memberInfo.getEmp_position());
							calSalaryFinalInfo.setEmp_job(memberInfo.getEmp_job());
							calSalaryFinalInfo.setEmp_work_type(memberInfo.getEmp_work_type());
							calSalaryFinalInfo.setDgrade(dgrade);
							
							calSalaryFinalInfo.setSal_position(sal_position);
							calSalaryFinalInfo.setSal_job(sal_job);
							calSalaryFinalInfo.setSal_allow(sal_allow);
							calSalaryFinalInfo.setSal_total_basic(sal_total_basic);
							calSalaryFinalInfo.setSal_month(sal_month);
							calSalaryFinalInfo.setIncometax(incometax);
							calSalaryFinalInfo.setPension(pension);
							calSalaryFinalInfo.setHeal_ins(heal_ins);
							calSalaryFinalInfo.setLong_ins(long_ins);
							calSalaryFinalInfo.setEmp_ins(emp_ins);
							calSalaryFinalInfo.setSal_total_before(sal_total_before);
							calSalaryFinalInfo.setSal_total_deduct(sal_total_deduct);
							calSalaryFinalInfo.setSal_total_after(sal_total_after);
							
							calSalaryFinalList.add(calSalaryFinalInfo);
							break;
						}//switch 근무유형
					}//for
					return calSalaryFinalList;
					
				case "성과급":
					
					//최종 반환할 CalSalaryFinalVO 리스트 생성
					List<CalSalaryFinalVO> calSalaryFinalList2 = new ArrayList<CalSalaryFinalVO>();
					
					for (String emp_id : employeeIds) {
						// 직원정보 가져오기
						vo.setEmp_id(emp_id);
						MemberInfoForSalaryVO memberInfo = sqlSession.selectOne(NAMESPACE + ".getMemberInfoForSalary",
								vo);
						
						// 공통사항 계산
						SalaryCalculrator salaryCalculrator = new SalaryCalculrator();
						String emp_position = memberInfo.getEmp_position();
						String emp_job = memberInfo.getEmp_job();
						String dgrade = memberInfo.getDgrade();
						double perform_rate = memberInfo.getPerform_rate();
						
						int sal_position = salaryCalculrator.checkRankSalary(emp_position, positionJobInfo);
						int sal_job = salaryCalculrator.checkDutySalary(emp_job, positionJobInfo);
						int sal_total_basic = sal_position + sal_job;
						int sal_perform = ((int)(sal_total_basic * perform_rate)/1000)*10;
						int incometax = (salaryCalculrator.calIncomeTax(sal_perform, basciInfo)/1000)*10;
						int pension = ((int)(sal_perform * pension_rate)/1000)*10;
						int heal_ins = ((int)(sal_perform * heal_ins_rate)/1000)*10;
						int long_ins = ((int)(heal_ins * long_ins_rate)/1000)*10;
						int emp_ins = ((int)(sal_perform * emp_ins_rate)/1000)*10;
						int sal_total_before = sal_perform;
						int sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
						int sal_total_after = sal_total_before - sal_total_deduct;
						
						CalSalaryFinalVO calSalaryFinalInfo = new CalSalaryFinalVO();
						// 근무유형(WorkType) 분류(통상,교대,시급)
						switch (memberInfo.getEmp_work_type()) {
						case "통상근무":
						case "교대근무":
							calSalaryFinalInfo.setSal_list_id(sal_list_id);
							calSalaryFinalInfo.setEmp_id(memberInfo.getEmp_id());
							calSalaryFinalInfo.setEmp_name(memberInfo.getEmp_name());
							calSalaryFinalInfo.setDname(memberInfo.getDname());
							calSalaryFinalInfo.setEmp_position(memberInfo.getEmp_position());
							calSalaryFinalInfo.setEmp_job(memberInfo.getEmp_job());
							calSalaryFinalInfo.setEmp_work_type(memberInfo.getEmp_work_type());
							calSalaryFinalInfo.setDgrade(dgrade);
							calSalaryFinalInfo.setPerform_rate(perform_rate);
							
							calSalaryFinalInfo.setSal_position(sal_position);
							calSalaryFinalInfo.setSal_job(sal_job);
							calSalaryFinalInfo.setSal_total_basic(sal_total_basic);
							calSalaryFinalInfo.setSal_perform(sal_perform);
							calSalaryFinalInfo.setIncometax(incometax);
							calSalaryFinalInfo.setPension(pension);
							calSalaryFinalInfo.setHeal_ins(heal_ins);
							calSalaryFinalInfo.setLong_ins(long_ins);
							calSalaryFinalInfo.setEmp_ins(emp_ins);
							calSalaryFinalInfo.setSal_total_before(sal_total_before);
							calSalaryFinalInfo.setSal_total_deduct(sal_total_deduct);
							calSalaryFinalInfo.setSal_total_after(sal_total_after);
							
							calSalaryFinalList2.add(calSalaryFinalInfo);
							break;

						case "시급제":
							sal_position = 0;
							sal_job = 0;
							sal_total_basic = basciInfo.getHourwage()* memberInfo.getWorking_time();
							sal_perform = ((int)(sal_total_basic * perform_rate)/1000)*10;
							incometax = (salaryCalculrator.calIncomeTax(sal_perform, basciInfo)/1000)*10;
							pension = ((int)(sal_perform * pension_rate)/1000)*10;
							heal_ins = ((int)(sal_perform * heal_ins_rate)/1000)*10;
							long_ins = ((int)(heal_ins * long_ins_rate)/1000)*10;
							emp_ins = ((int)(sal_perform * emp_ins_rate)/1000)*10;
							sal_total_before = sal_perform;
							sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
							sal_total_after = sal_total_before - sal_total_deduct;
							
							calSalaryFinalInfo.setSal_list_id(sal_list_id);
							calSalaryFinalInfo.setEmp_id(memberInfo.getEmp_id());
							calSalaryFinalInfo.setEmp_name(memberInfo.getEmp_name());
							calSalaryFinalInfo.setDname(memberInfo.getDname());
							calSalaryFinalInfo.setEmp_position(memberInfo.getEmp_position());
							calSalaryFinalInfo.setEmp_job(memberInfo.getEmp_job());
							calSalaryFinalInfo.setEmp_work_type(memberInfo.getEmp_work_type());
							calSalaryFinalInfo.setDgrade(dgrade);
							calSalaryFinalInfo.setPerform_rate(perform_rate);
							
							calSalaryFinalInfo.setSal_position(sal_position);
							calSalaryFinalInfo.setSal_job(sal_job);
							calSalaryFinalInfo.setSal_total_basic(sal_total_basic);
							calSalaryFinalInfo.setSal_perform(sal_perform);
							calSalaryFinalInfo.setIncometax(incometax);
							calSalaryFinalInfo.setPension(pension);
							calSalaryFinalInfo.setHeal_ins(heal_ins);
							calSalaryFinalInfo.setLong_ins(long_ins);
							calSalaryFinalInfo.setEmp_ins(emp_ins);
							calSalaryFinalInfo.setSal_total_before(sal_total_before);
							calSalaryFinalInfo.setSal_total_deduct(sal_total_deduct);
							calSalaryFinalInfo.setSal_total_after(sal_total_after);
							
							calSalaryFinalList2.add(calSalaryFinalInfo);
							break;
						}//switch 근무유형
					}//for
					return calSalaryFinalList2;
					
					
				case "상여금":
					//최종 반환할 CalSalaryFinalVO 리스트 생성
					List<CalSalaryFinalVO> calSalaryFinalList3 = new ArrayList<CalSalaryFinalVO>();
					
					for (String emp_id : employeeIds) {
						// 직원정보 가져오기
						vo.setEmp_id(emp_id);
						MemberInfoForSalaryVO memberInfo = sqlSession.selectOne(NAMESPACE + ".getMemberInfoForSalary",
								vo);
						
						// 공통사항 계산
						SalaryCalculrator salaryCalculrator = new SalaryCalculrator();
						String emp_position = memberInfo.getEmp_position();
						String emp_job = memberInfo.getEmp_job();
						double bonus_rate = vo.getBonus_rate();
						String dgrade = "해당없음";
						
						int sal_position = salaryCalculrator.checkRankSalary(emp_position, positionJobInfo);
						int sal_job = salaryCalculrator.checkDutySalary(emp_job, positionJobInfo);
						int sal_total_basic = sal_position + sal_job;
						int sal_bonus = ((int)(sal_total_basic * bonus_rate)/1000)*10;
						int incometax = (salaryCalculrator.calIncomeTax(sal_bonus, basciInfo)/1000)*10;
						int pension = ((int)(sal_bonus * pension_rate)/1000)*10;
						int heal_ins = ((int)(sal_bonus * heal_ins_rate)/1000)*10;
						int long_ins = ((int)(heal_ins * long_ins_rate)/1000)*10;
						int emp_ins = ((int)(sal_bonus * emp_ins_rate)/1000)*10;
						int sal_total_before = sal_bonus;
						int sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
						int sal_total_after = sal_total_before - sal_total_deduct;
						
						CalSalaryFinalVO calSalaryFinalInfo = new CalSalaryFinalVO();
						// 근무유형(WorkType) 분류(통상,교대,시급)
						switch (memberInfo.getEmp_work_type()) {
						case "통상근무":
						case "교대근무":
							calSalaryFinalInfo.setSal_list_id(sal_list_id);
							calSalaryFinalInfo.setEmp_id(memberInfo.getEmp_id());
							calSalaryFinalInfo.setEmp_name(memberInfo.getEmp_name());
							calSalaryFinalInfo.setDname(memberInfo.getDname());
							calSalaryFinalInfo.setEmp_position(memberInfo.getEmp_position());
							calSalaryFinalInfo.setEmp_job(memberInfo.getEmp_job());
							calSalaryFinalInfo.setEmp_work_type(memberInfo.getEmp_work_type());
							calSalaryFinalInfo.setBonus_rate(bonus_rate);
							calSalaryFinalInfo.setDgrade(dgrade);
							
							calSalaryFinalInfo.setSal_position(sal_position);
							calSalaryFinalInfo.setSal_job(sal_job);
							calSalaryFinalInfo.setSal_total_basic(sal_total_basic);
							calSalaryFinalInfo.setSal_bonus(sal_bonus);
							calSalaryFinalInfo.setIncometax(incometax);
							calSalaryFinalInfo.setPension(pension);
							calSalaryFinalInfo.setHeal_ins(heal_ins);
							calSalaryFinalInfo.setLong_ins(long_ins);
							calSalaryFinalInfo.setEmp_ins(emp_ins);
							calSalaryFinalInfo.setSal_total_before(sal_total_before);
							calSalaryFinalInfo.setSal_total_deduct(sal_total_deduct);
							calSalaryFinalInfo.setSal_total_after(sal_total_after);
							
							calSalaryFinalList3.add(calSalaryFinalInfo);
							break;

						case "시급제":
							sal_position = 0;
							sal_job = 0;
							sal_total_basic = basciInfo.getHourwage()* memberInfo.getWorking_time();
							sal_bonus = ((int)(sal_total_basic * bonus_rate)/1000)*10;
							incometax = (salaryCalculrator.calIncomeTax(sal_bonus, basciInfo)/1000)*10;
							pension = ((int)(sal_bonus * pension_rate)/1000)*10;
							heal_ins = ((int)(sal_bonus * heal_ins_rate)/1000)*10;
							long_ins = ((int)(heal_ins * long_ins_rate)/1000)*10;
							emp_ins = ((int)(sal_bonus * emp_ins_rate)/1000)*10;
							sal_total_before = sal_bonus;
							sal_total_deduct = incometax + pension + heal_ins + long_ins + emp_ins;
							sal_total_after = sal_total_before - sal_total_deduct;
							
							calSalaryFinalInfo.setSal_list_id(sal_list_id);
							calSalaryFinalInfo.setEmp_id(memberInfo.getEmp_id());
							calSalaryFinalInfo.setEmp_name(memberInfo.getEmp_name());
							calSalaryFinalInfo.setDname(memberInfo.getDname());
							calSalaryFinalInfo.setEmp_position(memberInfo.getEmp_position());
							calSalaryFinalInfo.setEmp_job(memberInfo.getEmp_job());
							calSalaryFinalInfo.setEmp_work_type(memberInfo.getEmp_work_type());
							calSalaryFinalInfo.setBonus_rate(bonus_rate);
							calSalaryFinalInfo.setDgrade(dgrade);
							
							calSalaryFinalInfo.setSal_position(sal_position);
							calSalaryFinalInfo.setSal_job(sal_job);
							calSalaryFinalInfo.setSal_total_basic(sal_total_basic);
							calSalaryFinalInfo.setSal_bonus(sal_bonus);
							calSalaryFinalInfo.setIncometax(incometax);
							calSalaryFinalInfo.setPension(pension);
							calSalaryFinalInfo.setHeal_ins(heal_ins);
							calSalaryFinalInfo.setLong_ins(long_ins);
							calSalaryFinalInfo.setEmp_ins(emp_ins);
							calSalaryFinalInfo.setSal_total_before(sal_total_before);
							calSalaryFinalInfo.setSal_total_deduct(sal_total_deduct);
							calSalaryFinalInfo.setSal_total_after(sal_total_after);
							
							calSalaryFinalList3.add(calSalaryFinalInfo);
							break;
						}//switch 근무유형
					}//for
					return calSalaryFinalList3;
				}//switch 급여형태
				return null;
	}//급여산출DAO
	
	
}//SalaryDAOImpl

	
	//통상근무
	class SalaryCalculrator {
		
		// 직급급 확인
		public int checkRankSalary(String emp_position, SalaryPositionJobVO positionJobInfo) {
			switch (emp_position) {
			case "사장":
				return positionJobInfo.getSal_position_ceo();
			case "부사장":
				return positionJobInfo.getSal_position_vice();
			case "본부장":
				return positionJobInfo.getSal_position_director();
			case "부장":
				return positionJobInfo.getSal_position_depart();
			case "팀장":
				return positionJobInfo.getSal_position_team();
			case "과장":
				return positionJobInfo.getSal_position_manager();
			case "대리":
				return positionJobInfo.getSal_position_assist();
			case "사원":
				return positionJobInfo.getSal_position_staff();
			default:
				return 0;
			}
		}

		// 직무급 확인
		public int checkDutySalary(String emp_job, SalaryPositionJobVO positionJobInfo) {
			switch (emp_job) {
			case "직무1":
				return positionJobInfo.getSal_job1();
			case "직무2":
				return positionJobInfo.getSal_job2();
			case "직무3":
				return positionJobInfo.getSal_job3();
			case "직무4":
				return positionJobInfo.getSal_job4();
			case "직무5":
				return positionJobInfo.getSal_job5();
			case "직무6":
				return positionJobInfo.getSal_job6();
			case "직무7":
				return positionJobInfo.getSal_job7();
			case "직무8":
				return positionJobInfo.getSal_job8();
			case "직무9":
				return positionJobInfo.getSal_job9();
			case "직무10":
				return positionJobInfo.getSal_job10();
			default:
				return 0;
			}
		}
		
		// 수당계산(초과,야간 = 50%, 특근 = 100%)
		public int calAllow(int sal_position, int sal_job, MemberInfoForSalaryVO memberInfo) {
			//통상임금 계산
			int nomalWage = (sal_position + sal_job)/209;
			System.out.println("nomalWage:"+nomalWage);
			int sal_allow = (int)((nomalWage*(memberInfo.getOvertime() + memberInfo.getNight_work_time())*0.5) + 
					(nomalWage*memberInfo.getSpecial_working_time()));
			System.out.println("Overtime:" +memberInfo.getOvertime());
			System.out.println("Nighttime:" +memberInfo.getNight_work_time());
			
			System.out.println("sal_allow :" +sal_allow);
			return sal_allow;
		}
		
		//소득세 계산
		public int calIncomeTax(int sal_total_before, SalaryBasicInfoVO basciInfo) {
			if(sal_total_before*12 < 14000000) {
				return (int)(sal_total_before * basciInfo.getIncometax_rate1());
			} else if(sal_total_before*12 < 50000000) {
				return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
						(sal_total_before-14000000/12)*basciInfo.getIncometax_rate2());
			} else if(sal_total_before < (int)88000000/12) {
				return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
						(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
						(sal_total_before - 50000000/12)*basciInfo.getIncometax_rate3());
			} else if(sal_total_before < (int)150000000/12) {
				return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
						(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
						(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
						(sal_total_before - 88000000/12)*basciInfo.getIncometax_rate4());
			} else if(sal_total_before < (int)300000000/12) {
				return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
						(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
						(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
						(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
						(sal_total_before - 150000000/12)*basciInfo.getIncometax_rate5());
			} else if(sal_total_before < (int)500000000/12) {
				return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
						(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
						(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
						(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
						(300000000/12 - 150000000/12)*basciInfo.getIncometax_rate5() +
						(sal_total_before - 300000000/12)*basciInfo.getIncometax_rate6());
			} else if(sal_total_before < (int)1000000000/12) {
				return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
						(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
						(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
						(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
						(300000000/12 - 150000000/12)*basciInfo.getIncometax_rate5() +
						(500000000/12 - 300000000/12)*basciInfo.getIncometax_rate6() +
						(sal_total_before - 500000000/12)*basciInfo.getIncometax_rate7());
			} else {
				return (int)(((14000000/12)*basciInfo.getIncometax_rate1()) + 
						(50000000/12 - 14000000/12)*basciInfo.getIncometax_rate2() +
						(88000000/12 - 50000000/12)*basciInfo.getIncometax_rate3() +
						(150000000/12 - 88000000/12)*basciInfo.getIncometax_rate4() +
						(300000000/12 - 150000000/12)*basciInfo.getIncometax_rate5() +
						(500000000/12 - 300000000/12)*basciInfo.getIncometax_rate6() +
						(1000000000/12 - 500000000/12)*basciInfo.getIncometax_rate7() +
						(sal_total_before - 1000000000/12)*basciInfo.getIncometax_rate8());
			}
		}

	}
