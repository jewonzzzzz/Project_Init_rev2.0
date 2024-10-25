package com.Init.persistence;

import java.util.HashMap;  
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.Init.domain.AttendanceVO;


/*
 *  MemberDAO 동작을 수행
 */

//@Repository : 스프링이 해당클래스를 DAO객체로 (Bean) 인식
//              root-context.xml 파일에서 해당 객체를 사용하도록 설정  
@Repository
public class AttendanceDAOImpl implements AttendanceDAO {

	// 공통변수, 디비연결, 자원해제
	// 디비연결객체(SqlSessionFactory) 필요 -> 의존관계 주입
	// @Inject
	// private SqlSessionFactory sqlFactory;

	@Inject
	private SqlSession sqlSession; // 자동으로 연결, 자원해제, SQL 실행, Mybatis...

	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.Init.mapper.AttendanceMapper";
	private static final Logger logger = LoggerFactory.getLogger(AttendanceDAOImpl.class);

	@Override
	public List<AttendanceVO> getAllCheckTime(@Param("emp_id") String emp_id) {
		logger.debug("모든 시간 조회 시작 ");

		return sqlSession.selectList(NAMESPACE + ".getAllCheckTime", emp_id);

	}

	@Override
	public void checkIn(String emp_id) {
		sqlSession.insert(NAMESPACE + ".checkIn", emp_id);
	}


	@Override
	public boolean checkIfCheckedIn(String emp_id) {
		Integer result = sqlSession.selectOne(NAMESPACE + ".checkIfCheckedIn", emp_id);
		return result != null && result > 0;
	}

	@Override
	public void recordCheckIn(String emp_id) {
		sqlSession.insert(NAMESPACE + ".recordCheckIn", emp_id);
	}

	@Override
	public int recordCheckout(String emp_id) {
		return sqlSession.update(NAMESPACE + ".recordCheckout", emp_id);
	}

	@Override
	public List<AttendanceVO> getRecentCheckTime(String emp_id) {
		logger.debug("최근 출퇴근 기록 조회 시작: emp_id={}", emp_id);
		List<AttendanceVO> recentAttendanceData = sqlSession.selectList(NAMESPACE + ".getRecentCheckTime", emp_id);
		logger.debug("최근 출퇴근 기록 조회 완료: 기록 수={}", recentAttendanceData.size());
		return recentAttendanceData;
	}

	// 출퇴근 확인용
	@Override
	public AttendanceVO fetchLatestAttendanceRecord(String emp_id) {
		return sqlSession.selectOne(NAMESPACE + ".fetchLatestAttendanceRecord", emp_id);
	}

	@Override
	public AttendanceVO selectLatestCheckOutRecord(String emp_id) {
		// 퇴근 기록만 조회하는 쿼리 실행
		return sqlSession.selectOne(NAMESPACE + ".fetchLatestCheckOutRecord", emp_id);
	}

	@Override
	public void calculateAndUpdateWorkingTime(String emp_id) {
		sqlSession.update(NAMESPACE + ".calculateAndUpdateWorkingTime", emp_id);
	}

	@Override
	public double getWorkingTime(String emp_id) {
		return sqlSession.selectOne(NAMESPACE + ".getWorkingTime", emp_id);

	}

	// 페이징을 위한 새로운 메소드 구현
	@Override
	public List<AttendanceVO> getAllCheckTime(String emp_id, int offset, int size,String date) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_id", emp_id);
		params.put("offset", offset);
		params.put("size", size);
		params.put("date", date);

		return sqlSession.selectList(NAMESPACE + ".getAllCheckTimeWithPaging", params);
	}
	@Override
	public int countAttendance(String emp_id, String date) {
		 Map<String, Object> params = new HashMap<>();
	        params.put("emp_id", emp_id);
	        params.put("date", date);
	        
	        return sqlSession.selectOne(NAMESPACE+".countAttendance", params);
	    }
	
	
	

	@Override
	public int getTotalCheckTimeCount(String emp_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".getTotalCheckTimeCount", emp_id);
	}

	@Override
	public void updateAttendanceRecord(AttendanceVO attendanceVO) {
		logger.debug("Updating Attendance Record: " + attendanceVO);
		sqlSession.update(NAMESPACE + ".updateAttendanceRecord", attendanceVO);
	}

	@Override
	public int deleteAttendance(int attendance_id) {
		return sqlSession.delete(NAMESPACE + ".deleteAttendance", attendance_id);
	}

	public List<AttendanceVO> selectRecentAttendanceRecords(String emp_id) {
		return sqlSession.selectList(NAMESPACE + ".selectRecentAttendanceRecords", emp_id);
	}

	public void updateWorkformStatus(String empId, String workformStatus) {
		Map<String, Object> params = new HashMap<>();
		params.put("emp_id", empId);
		params.put("workform_status", workformStatus);

		sqlSession.update(NAMESPACE + ".updateWorkformStatus", params);
	}
	//수정 
	@Override
	public void insertOvertime(AttendanceVO attendanceVO) {
		sqlSession.insert(NAMESPACE + ".insertOvertime", attendanceVO);
	}
	
	@Override
    public int updateWorkingOutsideTime(AttendanceVO attendanceVO) {
        return sqlSession.update(NAMESPACE+".updateWorkingOutsideTime", attendanceVO);
    }
	

    @Override
    public int updateReturnTime(AttendanceVO attendanceVO) {
        return sqlSession.update(NAMESPACE+".updateReturnTime", attendanceVO);
    }
    @Override
    public List<AttendanceVO> getAttendanceByEmpId(String emp_id
    		) {
        return sqlSession.selectList(NAMESPACE+".getAttendanceByEmpId", emp_id);
    }
    @Override
    public void updateAttendanceA(AttendanceVO attendanceVO) {
        sqlSession.update(NAMESPACE+".updateAttendanceA", attendanceVO);
    }
    @Override
    public void insertBusinessTrip(AttendanceVO attendanceVO) {
    	sqlSession.insert(NAMESPACE + ".insertBusinessTrip", attendanceVO);
    	
    }
    @Override
    public AttendanceVO getEmployee(String emp_id) {
    	 return sqlSession.selectOne(NAMESPACE + ".getEmployee", emp_id);
    	
    }
}
