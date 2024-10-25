package com.Init.service;

import java.io.IOException; 
import java.util.List;

import com.Init.domain.AttendanceVO;


public interface AttendanceService {

	public List<AttendanceVO> getAllCheckTime(String emp_id);

//	public void checkIn(AttendanceVO attendance);
//	public void checkOut(AttendanceVO attendance);
//	
//	
	boolean checkIfCheckedIn(String emp_id);

	void recordCheckIn(String emp_id);

	void recordCheckout(String emp_id);

	public List<AttendanceVO> getRecentCheckTime(String emp_id);

	AttendanceVO fetchLatestAttendanceRecord(String emp_id);

	AttendanceVO fetchLatestCheckOutRecord(String emp_id);

	public void calculateAndUpdateWorkingTime(String emp_id);

	public double getLatestWorkingTime(String emp_id);

	// 페이징을 위한 새로운 메소드
	List<AttendanceVO> getAllCheckTime(String emp_id, int offset, int size, String date);
	
int countAttendance(String emp_id, String date);

	public int getTotalCheckTimeCount(String emp_id);

	void updateAttendanceRecord(AttendanceVO attendanceVO);

	public boolean deleteAttendance(int attendance_id);

	public List<AttendanceVO> fetchRecentAttendanceRecords(String emp_id);

	void checkIn(String emp_id);

	public void updateWorkformStatus(String emp_id, String workform_Status);

	public void submitOvertime(AttendanceVO attendanceVO);
	
	// 외출 시간 업데이트
    void updateWorkingOutsideTime(AttendanceVO attendanceVO);
    
    // 복귀 시간 업데이트
    void updateReturnTime(AttendanceVO attendanceVO);

	public List<AttendanceVO> getAttendanceByEmpId(String emp_id);

	public void updateAttendanceRecordA(AttendanceVO attendanceVO);

	public void applyBusinessTrip(AttendanceVO attendanceVO);

	public AttendanceVO getEmployee(String emp_id);
    
	
	
}
