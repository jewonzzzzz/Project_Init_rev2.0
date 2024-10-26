package com.Init.service;

import com.Init.domain.*;
import com.Init.persistence.MemberDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.Year;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.mail.SimpleMailMessage;

@Service
public class MemberServiceImpl implements MemberService {

    private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

    @Autowired
    private MemberDAO mdao;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private JavaMailSender mailSender;
    
    private static final String UPLOAD_DIR = "/path/to/upload/directory/";

    @Override
    public MemberVO memberLoginCheck(MemberVO vo) {
        logger.debug("로그인 체크 서비스 실행: {}", vo);
        MemberVO dbMember = mdao.loginMember(vo.getEmp_id()); // emp_id로만 사용자 정보를 조회
        if (dbMember != null && passwordEncoder.matches(vo.getEmp_pw(), dbMember.getEmp_pw())) {
            return dbMember;
        }
        return null;
    }
    // 퇴직신청
    @Override
    public boolean insertQuitEmployee(MemberVO memberVO) {
        try {
        	// 1. 기존 직원 정보 조회
            MemberVO existingEmployee = mdao.getMember(memberVO.getEmp_id()); 
            if(existingEmployee == null) {
                throw new RuntimeException("직원 정보를 찾을 수 없습니다.");
            }
            
            // 2. 신청한 퇴직 사유와 상세사유 설정
            existingEmployee.setReason(memberVO.getReason());
            existingEmployee.setEmp_quit_date(memberVO.getEmp_quit_date());
            existingEmployee.setReason_detail(memberVO.getReason_detail());
            
            // 3. 새로운 레코드 삽입
            return mdao.insertQuitEmployee(existingEmployee) > 0;
        } catch(Exception e) {
            logger.error("퇴직 신청 처리 중 오류 발생", e);
            throw new RuntimeException("퇴직 신청 처리 실패", e);
        }
    }
    
    // 퇴직 승인
    @Override
    public void approveQuit(String emp_id) {
        MemberVO memberVO = new MemberVO();
        memberVO.setEmp_id(emp_id);
        mdao.insertHisMember(memberVO); // 기존 메서드 재사용
    }
    
    // 퇴직 반려
    @Override
    public void rejectQuit(String emp_id) {
        mdao.deleteQuitRequest(emp_id);
    }
    
    // 카카오 로그인
    @Override
    public MemberVO findMemberByEmail(String emp_email) {
        try {
            MemberVO member = mdao.findByEmail(emp_email);
            if (member == null) {
                logger.debug("Email {} not found in the system", emp_email);
                return null;
            }
            return member;
        } catch (Exception e) {
            logger.error("Error finding member by email: {}", emp_email, e);
            throw new RuntimeException("Failed to find member by email", e);
        }
    }
    
    // 비밀번호 찾기
    @Override
    public boolean isValidEmployee(String emp_id, String emp_email) {
        MemberVO member = mdao.getMember(emp_id);
        return member != null && member.getEmp_email().equals(emp_email);
    }
    // 비동기 처리
    @Override
    @Async
    public void sendVerificationEmail(String emp_id, String emp_email, String verificationCode) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(emp_email);
            message.setSubject("비밀번호 재설정 인증 코드");
            message.setText("인증 코드: " + verificationCode);
            mailSender.send(message);

            // 인증 코드 저장 및 만료 시간 설정 (10분)
            Timestamp expiryTime = new Timestamp(System.currentTimeMillis() + 10 * 60 * 1000);
            mdao.saveVerificationCode(emp_id, verificationCode, expiryTime);
        } catch (Exception e) {
            logger.debug("Error sending verification email", e);
        }
    }
    
    // 인증코드
    @Override
    public boolean verifyCode(String emp_id, String verificationCode) {
        VerificationCode storedCode = mdao.getVerificationCode(emp_id);
        if (storedCode != null) {
            boolean isValid = storedCode.getCode().equals(verificationCode) 
                              && storedCode.getExpiryTime().after(new Date());
            if (isValid) {
                mdao.deleteVerificationCode(emp_id);
                return true;
            }
        }
        return false;
    }
    
    // 비밀번호 재설정
    @Override
    public void resetPassword(String emp_id, String newPassword) {
        String encodedPassword = passwordEncoder.encode(newPassword);
        int updatedRows = mdao.resetPassword(emp_id, encodedPassword);
        if (updatedRows == 0) {
            throw new RuntimeException("비밀번호 재설정에 실패했습니다.");
        }
    }

        @Override
        public MemberVO memberInfo(String emp_id) {
            logger.debug("회원 정보 조회 서비스 실행: {}", emp_id);
            
            try {
                // approval이 0인 현재 유효한 데이터만 조회
                MemberVO member = mdao.getMember(emp_id);
                if (member != null) {
                    return member;
                }
                logger.error("존재하지 않는 사원입니다.");
                return null;
            } catch (Exception e) {
                logger.error("회원 정보 조회 중 오류 발생", e);
                throw e;
            }
        }
    
    // 정보수정 비밀번호 인증
    @Override
    public boolean verifyPassword(String emp_id, String password) {
        MemberVO member = mdao.getMember(emp_id);
        if (member != null) {
            return passwordEncoder.matches(password, member.getEmp_pw());
        }
        return false;
    }

    @Override
    @Transactional
    public int memberUpdate(MemberVO uvo) {
        logger.debug("memberUpdate(MemberVO uvo) 실행");
        
        try {
            // 1. 기존 데이터 존재 여부 확인
            MemberVO existingMember = mdao.getMember(uvo.getEmp_id());
            if (existingMember == null) {
                logger.error("존재하지 않는 사원입니다.");
                return 0;
            }

            // 2. 필수 필드 검증
            if (uvo.getEmp_position() == null || uvo.getEmp_status() == null || 
                uvo.getEmp_job() == null) {
                logger.error("필수 필드가 누락되었습니다.");
                return 0;
            }

            // 3. 모든 approval 값 증가 (먼저 실행)
            mdao.insertHisMember(uvo);

            // 4. 새로운 데이터 삽입 (approval = 0)
            int result = mdao.updateMember(uvo);
            
            if(result > 0) {
                logger.debug("회원정보 수정 성공");
                return 1;
            } else {
                logger.error("회원정보 수정 실패");
                return 0;
            }
            
        } catch (Exception e) {
            logger.error("회원정보 수정 중 오류 발생", e);
            throw new RuntimeException("회원정보 수정 실패", e);
        }
    }

    @Override
    public AccountVO getAccount(String emp_id) {
        return mdao.getAccount(emp_id);
    }

    @Override
    public List<LicenseVO> getEmpLicense(String emp_id) {
        return mdao.getEmpLicense(emp_id);
    }
    
    // 자격증 추가
    @Override
    public List<Map<String, Object>> getAllLicenses() {
        return mdao.getLicenseList();
    }

    @Override
    public void removeLicense(String licenseId, String emp_id) {
        mdao.deleteLicense(licenseId, emp_id);
    }
    
    @Override
    public boolean registerLicense(LicenseVO licenseVO) {
        // 이미 존재하는 자격증인지 확인
        List<LicenseVO> existingLicenses = mdao.getEmpLicense(licenseVO.getEmp_id());
        for (LicenseVO license : existingLicenses) {
            if (license.getLi_id().equals(licenseVO.getLi_id())) {
                // 이미 동일한 자격증이 존재함
                return false;
            }
        }
        // 중복이 아니면 자격증 추가
        mdao.addLicense(licenseVO);
        return true;
    }

    @Override
    public List<His_eduVO> getHis_edu(String emp_id) {
        return mdao.getHis_edu(emp_id);
    }

    @Override
    public List<RewardVO> getReward(String emp_id) {
        return mdao.getReward(emp_id);
    }

    @Override
    public List<EvalVO> getEval(String emp_id) {
        return mdao.getEval(emp_id);
    }
    
	@Override
    public void updateProfilePicture(String emp_id, String emp_profile) {
        mdao.updateProfilePicture(emp_id, emp_profile);
    }
    
    @Override
    public void updateAccountInfo(MemberVO memberVO) throws Exception {
        mdao.updateAccount(memberVO);
    }
    
    // 회원 목록 조회
    @Override
    public List<MemberVO> getPaginatedMembers(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return mdao.getPaginatedMembers(offset, pageSize);
    }

    @Override
    public int getTotalMembersCount() {
        return mdao.getTotalMembersCount();
    }

    @Override
    public MemberVO getMemberDetail(String emp_id) {
        return mdao.getMemberDetail(emp_id);
    }
    
    // 필터 부분
    @Override
    public List<String> getFilterOptions(String filterType) {
        return mdao.getFilterOptions(filterType);
    }

    @Override
    public List<MemberVO> getFilteredMembers(String filterType, String filterValue, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return mdao.getFilteredMembers(filterType, filterValue, offset, pageSize);
    }

    @Override
    public int getFilteredMembersCount(String filterType, String filterValue) {
        return mdao.getFilteredMembersCount(filterType, filterValue);
    }
    
    // 검색기능
    @Override
    public List<MemberVO> searchMembers(String searchType, String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return mdao.searchMembers(searchType, keyword, offset, pageSize);
    }

    @Override
    public int getSearchMembersCount(String searchType, String keyword) {
        return mdao.getSearchMembersCount(searchType, keyword);
    }
    
    // 비밀번호 수정
    @Override
    @Transactional
    public boolean updatePassword(String emp_id, String currentPassword, String newPassword) throws Exception {
        MemberVO member = mdao.getMember(emp_id);
        if (member != null && passwordEncoder.matches(currentPassword, member.getEmp_pw())) {
            String encodedNewPassword = passwordEncoder.encode(newPassword);
            member.setEmp_pw(encodedNewPassword);
            mdao.updatePassword(member);
            return true;
        }
        return false;
    }
    
    // 부서목록
    @Override
    public List<Map<String, Object>> getDepartmentList() {
    	return mdao.getDeptInfo();
    }
    
    // 사원 등록
    @Override
    public String generateEmployeeId() {
        String year = String.format("%02d", Year.now().getValue() % 100);
        int sequence = mdao.getNextEmployeeSequence();
        return year + String.format("%04d", sequence);
    }

    @Override
    @Transactional
    public boolean registerEmployee(MemberVO vo) {
        try {
            String emp_id = generateEmployeeId();
            vo.setEmp_id(emp_id);
            
            // 비밀번호를 생년월일로 설정하고 암호화
            String birthDate = vo.getEmp_birth().toString().replaceAll("-", "");
            vo.setEmp_pw(passwordEncoder.encode(birthDate));
            
            insertMember(vo);
            return true;
        } catch (Exception e) {
            logger.error("사원 등록 중 오류 발생", e);
            return false;
        }
    }
    
    @Override
    public void insertMember(MemberVO vo) {
        mdao.insertMember(vo);
    }
    
    // 관리자 수정
    @Override
    @Transactional
    public boolean updateEmployeeInfo(MemberVO vo) {
        logger.debug("updateEmployeeInfo(MemberVO vo) 실행");
        
        try {
            // 1. 기존 데이터 존재 여부 확인
            MemberVO existingMember = mdao.getMember(vo.getEmp_id());
            if (existingMember == null) {
                logger.error("존재하지 않는 사원입니다.");
                return false;
            }

            // 2. 필수 필드 검증
            if (vo.getEmp_position() == null || vo.getEmp_status() == null || 
                vo.getEmp_job() == null) {
                logger.error("필수 필드가 누락되었습니다.");
                return false;
            }

            // 3. 모든 approval 값 증가 (먼저 실행)
            mdao.insertEmployeeHistory(vo);

            // 4. 새로운 데이터 삽입 (approval = 0)
            int result = mdao.updateEmployee(vo);
            
            if(result > 0) {
                logger.debug("관리자 수정 성공");
                return true;
            } else {
                logger.error("관리자 수정 실패");
                return false;
            }
            
        } catch (Exception e) {
            logger.error("관리자 수정 중 오류 발생", e);
            throw new RuntimeException("관리자 수정 실패", e);
        }
    }
}
