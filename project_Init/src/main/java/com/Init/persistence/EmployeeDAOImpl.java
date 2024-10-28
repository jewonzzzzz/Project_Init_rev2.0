package com.Init.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.Init.domain.EmployeeVO;
import com.Init.domain.SettingVO;
import com.Init.service.MessageServiceImpl;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Random;

/**
 *	 MemberDAO 동작을 수행 
 *
 */
// @Repository  : 스프링이 해당클래스를 DAO객체 (Bean)로 인식
//                root-context.xml파일에서 해당객체를 사용하도록 설정

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {

	// 공통변수, 디비 연결, 자원해제
	// 디비 연결객체(SqlSessionFactory)가 필요함 => 의존관계 주입
	//	@Inject
	//	private SqlSessionFactory sqlFactory;
	
	@Inject
	private SqlSession sqlSession; // 자동으로 연결,자원해제,SQL실행,mybatis...
	
	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.Init.mapper.EmployeeMapper";
	
	private static final Logger logger = LoggerFactory.getLogger(MessageServiceImpl.class);

	@Override
	public EmployeeVO checkMember(EmployeeVO vo) {
		EmployeeVO resultVO
		    = sqlSession.selectOne(NAMESPACE + ".loginMember",vo);		
		
		return resultVO;
	}

	@Override
	public EmployeeVO getMember(String emp_id) {
		return sqlSession.selectOne(NAMESPACE + ".getMember",emp_id);
	}

	@Override
	public List<EmployeeVO> getMemberList(String keyword) {
		return sqlSession.selectList(NAMESPACE + ".getSearchedMemberList",keyword);
	}

	@Override
	public List<EmployeeVO> getTeamList(String emp_id) {
		return sqlSession.selectList(NAMESPACE + ".getTeamList",emp_id);
	}

	@Override
	public List<SettingVO> getToolList(String keyword) {
		return sqlSession.selectList(NAMESPACE + ".searchTools",keyword);
	}

	@Override
	public void updateFavoriteTool(SettingVO vo) {
		sqlSession.update(NAMESPACE + ".updateFavoriteTool",vo);
	}

	@Override
	public SettingVO getSetting(String emp_id) {
		return sqlSession.selectOne(NAMESPACE + ".getSetting",emp_id);
	}

	@Override
	public void updateLogout(String emp_id) {
		sqlSession.update(NAMESPACE + ".logout",emp_id);
	}
	
	@Override
	public void updateLogin(String emp_id) {
		sqlSession.update(NAMESPACE + ".login",emp_id);
	}

	@Override
	public void insertFollowEmp(String user_emp_id, String emp_id) {
		Map<String, String> param = new HashMap<String, String>();
	    param.put("user_emp_id", user_emp_id);
	    param.put("emp_id", emp_id);
		sqlSession.insert(NAMESPACE + ".followEmp",param);
	}

	@Override
	public void deleteFollowEmp(String user_emp_id, String emp_id) {
		Map<String, String> param = new HashMap<String, String>();
	    param.put("user_emp_id", user_emp_id);
	    param.put("emp_id", emp_id);
		sqlSession.delete(NAMESPACE + ".unfollowEmp",param);
	}
	
	public void yammyDummy(String emp_id) {
		
		
		Random random = new Random();
		
        LocalDate startDate = LocalDate.of(2023, 1, 1);
        LocalDate endDate = LocalDate.of(2023, 12, 31);
        
        
        List<String> emp_list = sqlSession.selectList(NAMESPACE + ".emp_dummy");
        
        for(String emp : emp_list) {

	        for (LocalDate date = startDate; date.isBefore(endDate); date = date.plusDays(1)) {
	            if (date.getDayOfWeek().getValue() >= 6) {
	                continue;
	            }
	
	            Map<String, Object> param = new HashMap<>();
	            param.put("emp_id", emp);
	            param.put("date", date.toString());
	
	            Integer presence = random.nextInt(365);
	            
	            if(presence > 350) {
	            	param.put("presence", "출장");
	            }else if(351 > presence && presence > 310) {
	                param.put("presence", "휴가");
	            }else if(311 > presence ) {
	                param.put("presence", "출근");
	            }
	
	            if (311>presence) {
	            	
	                int checkInMinute = 44 + random.nextInt(16);
	                String checkIn = String.format("08:%02d:00", checkInMinute);
	                param.put("check_in", checkIn);
	                param.put("working_time", 8);
	
	                int overtimeChance = random.nextInt(100);
	                Integer overtime = null;
	                if (overtimeChance < 10) {
	                    overtime = 1;
	                } else if (overtimeChance < 15) {
	                    overtime = 2;
	                } else if (overtimeChance < 20) {
	                    overtime = 3;
	                }
	                param.put("overtime", overtime);
	            }
	
	            param.put("night_work_time", null);
	            param.put("special_working_time", null);
            
            	sqlSession.insert(NAMESPACE + ".dummy", param);
            }
            
            
        }
    }

}
