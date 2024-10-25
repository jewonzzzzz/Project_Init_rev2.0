package com.Init.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.Init.domain.AttendanceVO;
import com.Init.domain.LeaveVO;
import com.Init.persistence.AttendanceDAO;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	private static final Logger logger = LoggerFactory.getLogger(AttendanceServiceImpl.class);

	@Inject
	private AttendanceDAO attendanceDAO;

	@Override
	public List<AttendanceVO> getAllCheckTime(String emp_id) {
		logger.debug("service 동작 ");

		return attendanceDAO.getAllCheckTime(emp_id);
	}

	@Override
	public void checkIn(String emp_id) {
		// 출근 기록을 저장하는 로직

		attendanceDAO.checkIn(emp_id);
	}

	// QR출근 처리
	@Override
	public void recordCheckIn(String emp_id) {
		try {
			attendanceDAO.recordCheckIn(emp_id);
		} catch (Exception e) {
			throw new RuntimeException("출근 기록 중 오류가 발생했습니다.", e);

		}
	}

	@Override
	public void recordCheckout(String emp_id) {
		try {
			int result = attendanceDAO.recordCheckout(emp_id);
			if (result == 0) {
				// 업데이트된 행이 없는 경우 (체크인 기록이 없음)
				throw new RuntimeException("체크인 기록이 존재하지 않아 체크아웃을 수행할 수 없습니다.");
			}
			// 체크아웃 성공 시 추가 처리 로직이 필요할 경우 여기에 작성
		} catch (Exception e) {
			// 예외 처리
			throw new RuntimeException("체크아웃 기록 중 오류가 발생했습니다.", e);
		}
	}

	// 출근했는지에대한 로직
	@Override
	public boolean checkIfCheckedIn(String emp_id) {
		return attendanceDAO.checkIfCheckedIn(emp_id);
	}

	// 최근 출퇴근 기록 조회
	@Override
	public List<AttendanceVO> getRecentCheckTime(String emp_id) {
		return attendanceDAO.getRecentCheckTime(emp_id);
	}

	@Override
	public AttendanceVO fetchLatestAttendanceRecord(String emp_id) {
		return attendanceDAO.fetchLatestAttendanceRecord(emp_id);
	}

	@Override
	public AttendanceVO fetchLatestCheckOutRecord(String emp_id) {
		// 퇴근 기록만 조회
		return attendanceDAO.selectLatestCheckOutRecord(emp_id);
	}

	public void calculateAndUpdateWorkingTime(String emp_id) {
		attendanceDAO.calculateAndUpdateWorkingTime(emp_id);
	}

	public double getLatestWorkingTime(String emp_id) {
		return attendanceDAO.getWorkingTime(emp_id);
	}

	// 페이징을 위한 새로운 메소드 구현
	@Override
	public List<AttendanceVO> getAllCheckTime(String emp_id, int offset, int size, String date) {
		return attendanceDAO.getAllCheckTime(emp_id, offset, size,date);
	}
	
    @Override
    public int countAttendance(String emp_id, String date) {
        return attendanceDAO.countAttendance(emp_id, date);
    }

	public int getTotalCheckTimeCount(String emp_id) {
		return attendanceDAO.getTotalCheckTimeCount(emp_id);
	}

	@Override
	public void updateAttendanceRecord(AttendanceVO attendanceVO) {
		logger.debug("Before updating attendance record.");
		attendanceDAO.updateAttendanceRecord(attendanceVO);
		logger.debug("After updating attendance record.");
	}

	@Override
	public boolean deleteAttendance(int attendance_id) {
		return attendanceDAO.deleteAttendance(attendance_id) > 0;
	}

	@Override
	public List<AttendanceVO> fetchRecentAttendanceRecords(String emp_id) {
		return attendanceDAO.selectRecentAttendanceRecords(emp_id);
	}

	@Override
	public void updateWorkformStatus(String emp_id, String workform_status) {
		// DAO를 호출하여 근무 상태를 업데이트
		attendanceDAO.updateWorkformStatus(emp_id, workform_status);
	}

	@Override
	public void submitOvertime(AttendanceVO attendanceVO) {
		attendanceDAO.insertOvertime(attendanceVO);
	}

	@Override
	public void updateWorkingOutsideTime(AttendanceVO attendanceVO) {
		attendanceDAO.updateWorkingOutsideTime(attendanceVO);
	}

	@Override
	public void updateReturnTime(AttendanceVO attendanceVO) {
		attendanceDAO.updateReturnTime(attendanceVO);
	}

    @Override
    public List<AttendanceVO> getAttendanceByEmpId(String emp_id) {
        return attendanceDAO.getAttendanceByEmpId(emp_id);
    }
    @Override
    public void updateAttendanceRecordA(AttendanceVO attendanceVO) {
        attendanceDAO.updateAttendanceA(attendanceVO); // DAO 호출
    }
    @Override
    public void applyBusinessTrip(AttendanceVO attendanceVO) {
        // 필요한 데이터 검증 및 처리 로직 추가
        attendanceDAO.insertBusinessTrip(attendanceVO);
    }
    @Override
    public AttendanceVO getEmployee(String emp_id) {
        return attendanceDAO.getEmployee(emp_id);
    }
    
   
    
    
}