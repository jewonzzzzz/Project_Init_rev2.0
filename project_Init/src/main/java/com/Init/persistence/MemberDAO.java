package com.Init.persistence;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.Init.domain.AccountVO;
import com.Init.domain.EvalVO;
import com.Init.domain.His_eduVO;
import com.Init.domain.LicenseVO;
import com.Init.domain.MemberVO;
import com.Init.domain.RewardVO;
import com.Init.domain.VerificationCode;

public interface MemberDAO {

	// 로그인
	public MemberVO loginMember(MemberVO vo);
	public MemberVO loginMember(String emp_id); // 암호화 때문에 아이디로만 조회
	
	// 카카오 로그인
	MemberVO findByEmail(String emp_email);
	
	// 비밀번호 찾기
	boolean isValidEmployee(String emp_id, String emp_email);
    boolean verifyCode(String emp_id, String verificationCode);
    int resetPassword(String emp_id, String newPassword);
    VerificationCode getVerificationCode(String emp_id);
    void saveVerificationCode(String emp_id, String code, Date expiryTime);
    void deleteVerificationCode(String emp_id);
	
	// 사용자 정보조회
	public MemberVO getMember(String emp_id);
	// 정보수정 이력
	void insertHisMember(MemberVO uvo);
	// 정보수정
	public int updateMember(MemberVO uvo);
	
	// 계좌 정보 가져오기
    AccountVO getAccount(String emp_id);

    // 자격증 정보 가져오기
    List<LicenseVO> getEmpLicense(String emp_id);

    // 교육이력 정보 가져오기
    List<His_eduVO> getHis_edu(String emp_id);

    // 포상/징계 정보 가져오기
    List<RewardVO> getReward(String emp_id);

    // 인사평가 정보 가져오기
    List<EvalVO> getEval(String emp_id);
    
    // 모달창 계좌정보 수정
    void updateAccount(MemberVO memberVO) throws Exception;
    
    // 프로필 이미지 URL 저장
    void updateProfilePicture(String emp_id, String emp_profile);
    
    // 회원 목록 조회
    List<MemberVO> getPaginatedMembers(int offset, int pageSize);
    int getTotalMembersCount();
    MemberVO getMemberDetail(String emp_id);
    
    // 자격증 추가
    List<Map<String, Object>> getLicenseList();
    void addLicense(LicenseVO licenseVO);
    void deleteLicense(String licenseId, String emp_id);
    
    // 필터 부분
    List<String> getFilterOptions(String filterType);
    List<MemberVO> getFilteredMembers(String filterType, String filterValue, int offset, int pageSize);
    int getFilteredMembersCount(String filterType, String filterValue);
    
    // 검색기능
    List<MemberVO> searchMembers(String searchType, String keyword, int offset, int pageSize);
    int getSearchMembersCount(String searchType, String keyword);
    
    // 비밀번호 수정
    void updatePassword(MemberVO member);
    
    // 부서목록
    List<Map<String, Object>> getDeptInfo();
    
    // 관리자 수정
    int updateEmployee(MemberVO vo);
    void insertEmployeeHistory(MemberVO vo);
    
    // 사원 등록
    void insertMember(MemberVO vo);
    int getNextEmployeeSequence();
    
    // 퇴직신청
    int insertQuitEmployee(MemberVO memberVO);
    
    // 퇴직신청 반려시
    void deleteQuitRequest(String emp_id);
    
    
    
    
}
