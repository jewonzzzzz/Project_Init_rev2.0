package com.Init.persistence;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.Init.domain.LeaveVO;


public interface LeaveDAO {

	List<LeaveVO> getAllLeaves(String emp_id, String leave_start_date, String annual_leave_start_date);

	LeaveVO selectLeaveById(int leave_id);

	void updateLeave(int leaveId, LeaveVO leaveData);

	List<LeaveVO> findLeaves(@Param("emp_id") String emp_id, @Param("size") int size, @Param("offset") int offset);

	int getTotalLeavesCount(String emp_id);

	void deleteLeave(int leave_id);

	List<LeaveVO> selectLeaveInfo(String emp_id);

	
	LeaveVO getLeaveByEmpId(String emp_id); // 사원의 연차 정보를 가져오는 메서드

	void insertLeaveRequest(LeaveVO leaveVO);

	void updateLeaveA(LeaveVO leave);

	void insertLeaveRequestA(LeaveVO leaveVO);

	List<LeaveVO> findLeaveByEmpId(String emp_id);

	void updateLeaveInfo(LeaveVO leaveVO);
	
	  // 사원의 입사일을 조회하는 메서드
	List<LeaveVO> getEmpStartDate(String emp_id) ;

    // 연차 생성 및 업데이트 메서드
    void updateAnnualLeave(String emp_id) ;
    
    void insertAnnualLeave(String emp_id);
    
    public List<LeaveVO> getStartDate(String emp_id);
    
    public LeaveVO getLatestLeaveInfo(String emp_id);
    
   

	void updateAnnualLeaveA(int leave_id);
    
    
}
