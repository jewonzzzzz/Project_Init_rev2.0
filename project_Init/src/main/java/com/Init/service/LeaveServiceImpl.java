package com.Init.service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.domain.LeaveVO;
import com.Init.persistence.LeaveDAO;

@Service
public class LeaveServiceImpl implements LeaveService {

	private static final Logger logger = LoggerFactory.getLogger(LeaveServiceImpl.class);

	@Inject
	private LeaveDAO leaveDAO;

	@Autowired
	private LeaveService leaveService;

	@Override
	public List<LeaveVO> getAllLeaves(String emp_id, String leave_start_date, String annual_leave_start_date) {
		// 로그 출력
		logger.debug("emp_id: " + emp_id);
		logger.debug("leave_start_date: " + leave_start_date);
		logger.debug("annual_leave_start_date: " + annual_leave_start_date);

		// DAO 호출, 각 인자를 직접 전달
		return leaveDAO.getAllLeaves(emp_id, leave_start_date, annual_leave_start_date); // 세 개의 String 인자를 사용
	}

	@Override
	public LeaveVO getLeaveById(int leave_id) {
		return leaveDAO.selectLeaveById(leave_id);
	}

	@Override
	public void updateLeave(int leave_id, LeaveVO leaveData) {
		leaveDAO.updateLeave(leave_id, leaveData);
	}

	@Override
	public void deleteLeave(int leave_id) {
		leaveDAO.deleteLeave(leave_id);
	}

	@Override
	public List<LeaveVO> getLeaveInfo(String emp_id) {
		logger.debug("emp_id를 반환되는지 : " + emp_id);
		return leaveDAO.selectLeaveInfo(emp_id);

	}

	@Override
	public void useAnnualLeave(LeaveVO leaveVO) {

		// 4. 데이터베이스에 연차 신청 요청 저장
		leaveDAO.insertLeaveRequest(leaveVO); // 연차 사용 요청 저장

	}

	// 휴가 신청서
	@Override
	public void submitLeaveRequest(LeaveVO leaveVO) {
		leaveDAO.insertLeaveRequestA(leaveVO); // DAO 메서드 호출
	}

	@Override
	public List<LeaveVO> getLeaveStatus(String emp_id) {
		// Mapper를 통해 데이터베이스에서 정보를 조회
		return leaveDAO.findLeaveByEmpId(emp_id);
	}

	@Override
	public void generateAnnualLeave(String emp_id) {

		leaveDAO.insertAnnualLeave(emp_id);

	}

	// 연차 조회
	@Override
	public List<LeaveVO> getAnnualLeaveByEmpId(String emp_id) {

		return leaveDAO.getEmpStartDate(emp_id);
	}

	@Override
	public LeaveVO getLatestLeaveInfo(String emp_id) {
		return leaveDAO.getLatestLeaveInfo(emp_id);
	}
	
	@Override
	public void updateAnnualLeaveA(int leave_id) {
		leaveDAO.updateAnnualLeaveA(leave_id);
	}

}