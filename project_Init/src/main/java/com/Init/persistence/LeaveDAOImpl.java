package com.Init.persistence;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.Init.domain.LeaveVO;

//@Repository : 스프링이 해당클래스를 DAO객체로 (Bean) 인식
//              root-context.xml 파일에서 해당 객체를 사용하도록 설정  
@Repository
public class LeaveDAOImpl implements LeaveDAO {

	@Inject
	private SqlSession sqlSession; // 자동으로 연결, 자원해제, SQL 실행, Mybatis...

	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.Init.mapper.LeaveMapper";
	private static final Logger logger = LoggerFactory.getLogger(LeaveDAOImpl.class);

	@Override
	public List<LeaveVO> getAllLeaves(String emp_id, String leave_start_date, String annual_leave_start_date) {
		  Map<String, Object> params = new HashMap<>();
	        params.put("emp_id", emp_id);
	        params.put("leave_start_date", leave_start_date);
	        params.put("annual_leave_start_date", annual_leave_start_date);
	        
	        logger.debug("emp_id: " + emp_id);
	        logger.debug("leave_start_date: " + leave_start_date);
	        logger.debug("annual_leave_start_date: " + annual_leave_start_date);
		
		
		return sqlSession.selectList(NAMESPACE + ".getAllLeaves", params);
	}

	@Override
	public LeaveVO selectLeaveById(int leave_id) {
		return sqlSession.selectOne(NAMESPACE + ".selectLeaveById", leave_id);
	}

	@Override
	public void updateLeave(int leave_id, LeaveVO leaveData) {
		leaveData.setLeave_id(leave_id); // leaveId를 VO에 설정
		sqlSession.update(NAMESPACE + ".updateLeave", leaveData);
	}

	@Override
	public List<LeaveVO> findLeaves(String emp_id, int size, int offset) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_id", emp_id);
		params.put("size", size);
		params.put("offset", offset);
		return sqlSession.selectList(NAMESPACE + ".findLeaves", params);
	}

	@Override
	public int getTotalLeavesCount(String emp_id) {
		return sqlSession.selectOne(NAMESPACE + ".getTotalLeavesCount", emp_id);
	}

	@Override
	public void deleteLeave(int leave_id) {
		int affectedRows = sqlSession.delete(NAMESPACE + ".deleteLeave", leave_id);
		// affectedRows는 삭제된 행의 수입니다.
		if (affectedRows == 0) {
			throw new RuntimeException("삭제된 행이 없습니다.");
		}
	}

	public List<LeaveVO> selectLeaveInfo(String emp_id) {
		return sqlSession.selectList(NAMESPACE + ".getLeaveInfo", emp_id);
	}

	@Override
	public LeaveVO getLeaveByEmpId(String emp_id) {
		return sqlSession.selectOne(NAMESPACE + ".getLeaveByEmpId", emp_id);
	}

	@Override
	public void updateLeaveA(LeaveVO leaveVO) {
		sqlSession.update(NAMESPACE + ".updateLeaveA", leaveVO);
	}

	@Override
	public void insertLeaveRequest(LeaveVO leaveVO) {
		sqlSession.insert(NAMESPACE + ".insertLeaveRequest", leaveVO);
	}

	@Override
	public void insertLeaveRequestA(LeaveVO leaveVO) {
		sqlSession.insert(NAMESPACE + ".insertLeaveRequestA", leaveVO);
	}
	@Override
	public List<LeaveVO> findLeaveByEmpId(String emp_id) {
		return sqlSession.selectList(NAMESPACE+".findLeaveByEmpId", emp_id);
		
	}
	  @Override
	    public void updateLeaveInfo(LeaveVO leaveVO) {
	        sqlSession.update(NAMESPACE+".updateLeaveInfo", leaveVO); // 매퍼 쿼리 호출
	    }
	
	  // 사원의 입사일을 조회하는 메서드
	    @Override
	    public List<LeaveVO> getEmpStartDate(String emp_id){
	        return sqlSession.selectList(NAMESPACE + ".getEmpStartDate", emp_id);
	    }

	    // 연차 생성 및 업데이트 메서드
	    @Override
	    public void updateAnnualLeave(String emp_id) {
	        sqlSession.update(NAMESPACE + ".updateAnnualLeave", emp_id);
	    }
	    @Override
	    public void insertAnnualLeave(String emp_id) {
	        sqlSession.insert(NAMESPACE +".insertAnnualLeave", emp_id);
	    }
	    // 사원의 입사일을 조회하는 메서드
	    @Override
	    public List<LeaveVO> getStartDate(String emp_id){
	        return sqlSession.selectList(NAMESPACE + ".getEmpStartDate", emp_id);
	    }
	    @Override
	    public LeaveVO getLatestLeaveInfo(String emp_id) {
	        return sqlSession.selectOne(NAMESPACE+".getLatestLeaveInfo",emp_id);
	    }
	    @Override
	    public void updateAnnualLeaveA(int leave_id) {
	        sqlSession.update(NAMESPACE+".updateAnnualLeaveA",leave_id);
	    }
	    
	    
}
