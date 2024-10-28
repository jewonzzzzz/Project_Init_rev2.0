package com.Init.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Init.domain.*;
import com.Init.service.MemberService;
import com.Init.service.SalaryService;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.sql.Date;
import java.time.LocalDate;

//http://localhost:8088/member/login
//http://localhost:8088/main/home

@Controller
@RequestMapping("/member")
public class MemberController implements ServletContextAware {

	@Autowired
	private MemberService mService;
	@Autowired
	private SalaryService sService;

	private ServletContext servletContext;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

		@GetMapping("/login")
		public String loginMemberGET() {
			return "member/loginForm";
		}

		@PostMapping("/login")
		public String loginMemberPOST(@ModelAttribute MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		    MemberVO resultVO = mService.memberLoginCheck(vo);
		    
		    if (resultVO == null) {
		        rttr.addFlashAttribute("loginError", "사원번호 또는 비밀번호가 올바르지 않습니다.");
		        return "redirect:/member/login";
		    }
		    
		    // 생년월일을 평문 비밀번호로 변환
		    String birthDate = resultVO.getEmp_birth().toString().replaceAll("-", "");
		    
		    // 입력된 비밀번호를 평문 생년월일과 비교
		    if (vo.getEmp_pw().equals(birthDate)) {
		        session.setAttribute("emp_id", resultVO.getEmp_id());
		        rttr.addFlashAttribute("needPasswordChange", true);
		        return "redirect:/member/firstPass?emp_id=" + resultVO.getEmp_id();  // firstPass.jsp로 이동
		    }
		    
		    // 필수 정보가 하나라도 비어있는지 확인
		    if (resultVO.getEmp_tel() == null || 
		        resultVO.getEmp_email() == null || 
		        resultVO.getEmp_addr() == null) {
		        
		        session.setAttribute("emp_id", resultVO.getEmp_id());
		        return "redirect:/member/update";
		    }
		    
		    session.setAttribute("emp_id", resultVO.getEmp_id());
		    return "redirect:/main/home";
		}

		// firstPass 페이지를 위한 GET 매핑 추가
		@GetMapping("/firstPass")
		public String showFirstPassForm(@RequestParam String emp_id, Model model) {
		    model.addAttribute("emp_id", emp_id);
		    return "member/firstPass";  // firstPass.jsp로 이동
		}
		
		// 퇴직신청 - GET
		@GetMapping("/quit")
		public String quitPage(HttpSession session, Model model) {
		    String emp_id = (String) session.getAttribute("emp_id");
		    // 로그인 체크
		    if(emp_id == null) {
		        return "redirect:/member/login";
		    }
		    
		    MemberVO memberVO = mService.memberInfo(emp_id);
		    model.addAttribute("memberVO", memberVO);
		    
		    return "member/quit";  
		}
	
		// 카카오 로그인
		@PostMapping("/kakaoLogin")
		@ResponseBody
		public Map<String, Object> kakaoLogin(@RequestBody Map<String, String> kakaoUserInfo, HttpSession session) {
		    Map<String, Object> response = new HashMap<>();
		    logger.debug("Received Kakao user info: {}", kakaoUserInfo);
		    
		    try {
		        String email = kakaoUserInfo.get("emp_email");
		        
		        // 이메일로 사원 정보 조회
		        MemberVO member = mService.findMemberByEmail(email);
		        
		        if (member != null) {
		            // 세션에 로그인 정보 저장
		            session.setAttribute("emp_id", member.getEmp_id());
		            response.put("success", true);
		        } else {
		            response.put("success", false);
		            response.put("message", "등록되지 않은 이메일입니다. 관리자에게 문의하세요.");
		        }
		    } catch (Exception e) {
		        logger.error("Kakao login error", e);
		        response.put("success", false);
		        response.put("message", "로그인 처리 중 오류가 발생했습니다.");
		    }
		    
		    return response;
		}
		
	// 비밀번호 찾기
	@GetMapping("/forgotPassword")
    public String showForgotPasswordForm() {
        return "member/forgotPassword";
    }

	@PostMapping(value = "/sendVerificationCode", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<?> sendVerificationCode(@RequestParam String emp_id, @RequestParam String emp_email) {
	    if (mService.isValidEmployee(emp_id, emp_email)) {
	        String verificationCode = generateVerificationCode();
	        // 비동기로 이메일 발송 (결과를 기다리지 않음)
	        mService.sendVerificationEmail(emp_id, emp_email, verificationCode);
	        return ResponseEntity.ok().body("{\"message\": \"인증 코드가 이메일로 전송되었습니다. 잠시 후 이메일을 확인해주세요.\"}");
	    } else {
	        return ResponseEntity.badRequest().body("{\"message\": \"유효하지 않은 사원번호 또는 이메일입니다.\"}");
	    }
	}

	@PostMapping(value = "/verifyCode", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<?> verifyCode(@RequestParam String emp_id, @RequestParam String verificationCode) {
	    boolean isValid = mService.verifyCode(emp_id, verificationCode);
	    if (isValid) {
	        return ResponseEntity.ok().body("{\"message\": \"인증에 성공했습니다.\", \"success\": true}");
	    } else {
	        return ResponseEntity.ok().body("{\"message\": \"잘못된 인증 코드이거나 만료되었습니다.\", \"success\": false}");
	    }
	}

    @GetMapping("/resetPassword")
    public String showResetPasswordForm(@RequestParam String emp_id, Model model) {
        model.addAttribute("emp_id", emp_id);
        return "member/resetPassword";
    }

    @PostMapping(value = "/resetPassword", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ResponseEntity<?> resetPassword(@RequestParam String emp_id, @RequestParam String newPassword) {
        try {
            mService.resetPassword(emp_id, newPassword);
            return ResponseEntity.ok().body("{\"message\": \"비밀번호가 성공적으로 변경되었습니다.\"}");
        } catch (Exception e) {
            logger.error("비밀번호 재설정 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("{\"message\": \"비밀번호 재설정 중 오류가 발생했습니다: " + e.getMessage() + "\"}");
        }
    }

    private String generateVerificationCode() {
        // 6자리 랜덤 숫자 생성
        return String.format("%06d", new Random().nextInt(999999));
    }
    
	@GetMapping("/logout")
	public String logoutMemberGET(HttpSession session) {
		session.invalidate();
		return "redirect:/member/login";
	}

	@GetMapping("/info")
	public String infoMemberGET(HttpSession session, Model model) {
		String emp_id = (String) session.getAttribute("emp_id");
		model.addAttribute("memberVO", mService.memberInfo(emp_id));
		return "member/info";
	}
	// 정보수정 비밀번호 인증
	@PostMapping("/verifyPassword")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> verifyPassword(
	        @RequestParam String emp_id, 
	        @RequestParam String password) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        boolean isValid = mService.verifyPassword(emp_id, password);
	        response.put("success", isValid);
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "비밀번호 확인 중 오류가 발생했습니다.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}

		// 회원정보 수정 - 입력GET
		@RequestMapping(value = "/update", method = RequestMethod.GET)
		public String updateMemberGET(HttpSession session, Model model) {
		    logger.debug("/member/update -> updateMemberGET() 실행");				
		    logger.debug("기존의 회원정보를 DB에서 가져오기");
		    
		    String emp_id = (String) session.getAttribute("emp_id");
		    MemberVO memberVO = mService.memberInfo(emp_id);
		    model.addAttribute("memberVO", memberVO);
		    
		    // 필수 정보가 없는 경우 메시지 표시
		    if (memberVO.getEmp_tel() == null || 
		        memberVO.getEmp_email() == null || 
		        memberVO.getEmp_addr() == null) {
		        model.addAttribute("needInfoUpdate", true);
		    }
		    
		    return "/member/update";
		}
	 			
	 	// 회원정보 수정 - 처리POST
	 	@PostMapping("/update")
	 	@ResponseBody
	 	public ResponseEntity<Map<String, Object>> updateMemberPOST(@ModelAttribute MemberVO vo) {
	 	    logger.debug("updateMemberPOST 실행");
	 	    logger.debug("전달받은 MemberVO: {}", vo);  // 전체 VO 객체 로깅
	 	    logger.debug("emp_id 값: {}", vo.getEmp_id());  // emp_id 값만 따로 로깅
	 			
	 	    Map<String, Object> response = new HashMap<>();
	 	    try {
	 	        int result = mService.memberUpdate(vo);				
	 	        if(result == 0) {	
	 	            response.put("success", false);
	 	            response.put("message", "회원 정보 업데이트 실패");
	 	            return ResponseEntity.ok(response);
	 	        }
	 	        // 수정 성공
	 	        response.put("success", true);
	 	        response.put("message", "회원 정보가 성공적으로 업데이트되었습니다.");
	 	        return ResponseEntity.ok(response);
	 	    } catch (Exception e) {
	 	        response.put("success", false);
	 	        response.put("message", "서버 오류: " + e.getMessage());
	 	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	 	    }
	 	}

	// 비밀번호 수정
	 	@PostMapping("/updatePassword")
	 	@ResponseBody
	 	public ResponseEntity<Map<String, Object>> updatePassword(@RequestParam String emp_id,
	 	        @RequestParam String current_password, @RequestParam String new_password,
	 	        @RequestParam String confirm_password) {

	 	    logger.debug("/member/updatePassword -> updatePassword() 실행");

	 	    Map<String, Object> response = new HashMap<>();

	 	    if (!new_password.equals(confirm_password)) {
	 	        response.put("success", false);
	 	        response.put("message", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
	 	        return ResponseEntity.ok(response);
	 	    }

	 	    try {
	 	        boolean result = mService.updatePassword(emp_id, current_password, new_password);
	 	        if (result) {
	 	            response.put("success", true);
	 	            response.put("message", "비밀번호가 성공적으로 변경되었습니다.");
	 	        } else {
	 	            response.put("success", false);
	 	            response.put("message", "현재 비밀번호가 일치하지 않습니다.");
	 	        }
	 	    } catch (Exception e) {
	 	        response.put("success", false);
	 	        response.put("message", "비밀번호 변경 중 오류가 발생했습니다: " + e.getMessage());
	 	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	 	    }

	 	    return ResponseEntity.ok(response);
	 	}
	 	private boolean isValidPassword(String password) {
	 	    String regex = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";
	 	    return password.matches(regex);
	 	}

	@GetMapping("/account")
	@ResponseBody
	public AccountVO getAccount(@RequestParam("emp_id") String emp_id) {
		return mService.getAccount(emp_id);
	}

	@GetMapping("/license")
	@ResponseBody
	public List<LicenseVO> getEmpLicense(@RequestParam("emp_id") String emp_id) {
		return mService.getEmpLicense(emp_id);
	}

	@GetMapping("/licenseList")
	@ResponseBody
	public List<Map<String, Object>> getLicenseList() {
		List<Map<String, Object>> licenseList = mService.getAllLicenses();
		System.out.println("License List: " + licenseList); // 디버깅용 로그
		return licenseList;
	}

	@PostMapping("/addLicense")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addLicense(@RequestBody LicenseVO licenseVO, HttpSession session) {
		String emp_id = (String) session.getAttribute("emp_id");
		licenseVO.setEmp_id(emp_id);
		Map<String, Object> response = new HashMap<>();
		try {
			boolean isAdded = mService.registerLicense(licenseVO);
			if (isAdded) {
				response.put("success", true);
				response.put("message", "자격증이 성공적으로 추가되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "이미 등록된 자격증입니다.");
			}
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "자격증 추가에 실패했습니다: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@DeleteMapping("/deleteLicense/{licenseId}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deleteLicense(@PathVariable String licenseId, HttpSession session) {
		String emp_id = (String) session.getAttribute("emp_id");
		Map<String, Object> response = new HashMap<>();
		try {
			mService.removeLicense(licenseId, emp_id);
			response.put("success", true);
			response.put("message", "자격증이 성공적으로 삭제되었습니다.");
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "자격증 삭제에 실패했습니다: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@GetMapping("/his_edu")
	@ResponseBody
	public List<His_eduVO> getHis_edu(@RequestParam("emp_id") String emp_id) {
		return mService.getHis_edu(emp_id);
	}

	@GetMapping("/reward")
	@ResponseBody
	public List<RewardVO> getReward(@RequestParam("emp_id") String emp_id) {
		return mService.getReward(emp_id);
	}

	@GetMapping("/eval")
	@ResponseBody
	public List<EvalVO> getEval(@RequestParam("emp_id") String emp_id) {
		return mService.getEval(emp_id);
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@PostMapping("/uploadProfilePicture")
	@ResponseBody
	public String uploadProfilePicture(@RequestParam("emp_profile") MultipartFile file,
			@RequestParam("emp_id") String emp_id) {
		if (file.isEmpty()) {
			return "{\"success\": false, \"message\": \"파일이 비어있습니다.\"}";
		}

		try {
			String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			String uploadDir = servletContext.getRealPath("/profiles");
			logger.debug("uploadDir : "+uploadDir);
			File uploadPath = new File(uploadDir);
			if (!uploadPath.exists()) {
				uploadPath.mkdirs();
			}
			File dest = new File(uploadPath + File.separator + fileName);
			file.transferTo(dest);

			String emp_profile = "/profiles/" + fileName; // 웹에서 접근 가능한 URL
			mService.updateProfilePicture(emp_id, emp_profile);

			return "{\"success\": true, \"newProfilePicUrl\": \"" + emp_profile + "\"}";
		} catch (IOException e) {
			e.printStackTrace();
			return "{\"success\": false, \"message\": \"파일 업로드 중 오류가 발생했습니다.\"}";
		}
	}

	@PostMapping("/account/update")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateAccount(@RequestBody Map<String, String> accountData, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        String emp_id = (String) session.getAttribute("emp_id");
	        
	        // 현재 사원 정보 조회
	        MemberVO memberVO = mService.memberInfo(emp_id);
	        
	        // 새로운 계좌 정보 설정
	        memberVO.setEmp_account_name(accountData.get("emp_account_name"));
	        memberVO.setEmp_account_num(accountData.get("emp_account_num"));
	        memberVO.setEmp_bank_name(accountData.get("emp_bank_name"));
	        
	        // memberUpdate 메서드 재사용 (기존 approval 증가 및 새 데이터 삽입 로직 포함)
	        int result = mService.memberUpdate(memberVO);
	        
	        if(result > 0) {
	            response.put("success", true);
	            response.put("message", "계좌 정보가 성공적으로 업데이트되었습니다.");
	        } else {
	            response.put("success", false);
	            response.put("message", "계좌 정보 업데이트에 실패했습니다.");
	        }
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "계좌 정보 업데이트 중 오류가 발생했습니다: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}

	@GetMapping("/list")
	public String listMembers(@RequestParam(defaultValue = "1") int page, Model model) {
		int pageSize = 8;
		List<MemberVO> members = mService.getPaginatedMembers(page, pageSize);
		int totalMembers = mService.getTotalMembersCount();
		int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

		model.addAttribute("members", members);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		return "member/list";
	}

	@GetMapping("/manager")
	public String listManager(@RequestParam(defaultValue = "1") int page, Model model) {
		int pageSize = 8;
		List<MemberVO> members = mService.getPaginatedMembers(page, pageSize);
		int totalMembers = mService.getTotalMembersCount();
		int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

		model.addAttribute("members", members);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		return "member/manager";
	}

	@GetMapping("/detail/{emp_id}")
	@ResponseBody
	public MemberVO getMemberDetail(@PathVariable String emp_id) {
		MemberVO member = mService.getMemberDetail(emp_id);
		logger.debug("Member detail requested for emp_id: {}, Result: {}", emp_id, member);
		return member;
	}

	// 필터 부분
	@GetMapping("/filterOptions")
	@ResponseBody
	public List<String> getFilterOptions(@RequestParam String filterType) {
		return mService.getFilterOptions(filterType);
	}

	@GetMapping("/filter")
    public String filterMembers(@RequestParam String filterType, 
                                @RequestParam String filterValue,
                                @RequestParam(defaultValue = "1") int page, 
                                @RequestParam(required = false) String pageType, 
                                Model model) {
        int pageSize = 8;
        List<MemberVO> members = mService.getFilteredMembers(filterType, filterValue, page, pageSize);
        int totalMembers = mService.getFilteredMembersCount(filterType, filterValue);
        int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

        model.addAttribute("members", members);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("filterType", filterType);
        model.addAttribute("filterValue", filterValue);

        logger.debug("Filtered members: " + members.size());
        logger.debug("Total filtered members: " + totalMembers);
        logger.debug("Received pageType: " + pageType);

        if ("manager".equals(pageType)) {
            return "member/manager";
        } else {
            return "member/list";
        }
    }

	// 검색기능
	@GetMapping("/search")
    public String searchMembers(@RequestParam String searchType, 
                                @RequestParam String keyword,
                                @RequestParam(defaultValue = "1") int page, 
                                @RequestParam(required = false) String pageType, 
                                Model model) {
        int pageSize = 8;
        List<MemberVO> members = mService.searchMembers(searchType, keyword, page, pageSize);
        int totalMembers = mService.getSearchMembersCount(searchType, keyword);
        int totalPages = (int) Math.ceil((double) totalMembers / pageSize);

        model.addAttribute("members", members);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);

        logger.debug("Searched members: " + members.size());
        logger.debug("Total searched members: " + totalMembers);
        logger.debug("Received pageType: " + pageType);

        if ("manager".equals(pageType)) {
            return "member/manager";
        } else {
            return "member/list";
        }
    }
	
	@GetMapping("/departments")
	@ResponseBody
	public List<Map<String, Object>> getDepartments() {
	    return mService.getDepartmentList();
	}
	
	// 사원 등록
	@PostMapping("/register")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> registerEmployee(@RequestBody MemberVO vo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 사원번호 자동 생성
	        String emp_id = mService.generateEmployeeId();
	        vo.setEmp_id(emp_id);
	        
	        // 비밀번호를 생년월일로 설정
	        String birthDate = vo.getEmp_birth().toString().replaceAll("-", "");
	        vo.setEmp_pw(birthDate);
	        
	        // 사원 등록
	        boolean result = mService.registerEmployee(vo);
	        if (result) {
	            response.put("success", true);
	            response.put("message", "사원이 성공적으로 등록되었습니다.");
	            response.put("emp_id", emp_id);
	        } else {
	            response.put("success", false);
	            response.put("message", "사원 등록에 실패했습니다.");
	        }
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "서버 오류: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
	// 관리자 수정
	@PostMapping("/mupdate")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateEmployeeInfo(@RequestBody MemberVO vo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 날짜 필드 검증
	        if ("퇴직".equals(vo.getEmp_status()) && vo.getEmp_quit_date() == null) {
	            response.put("success", false);
	            response.put("message", "퇴직 상태인 경우 퇴사일은 필수입니다.");
	            return ResponseEntity.ok(response);
	        }
	        
	        if ("휴직".equals(vo.getEmp_status()) && vo.getEmp_break_date() == null) {
	            response.put("success", false);
	            response.put("message", "휴직 상태인 경우 휴직일은 필수입니다.");
	            return ResponseEntity.ok(response);
	        }

	        boolean result = mService.updateEmployeeInfo(vo);
	        if(result) {
	            response.put("success", true);
	            response.put("message", "사원 정보가 성공적으로 업데이트되었습니다.");
	        } else {
	            response.put("success", false);
	            response.put("message", "사원 정보 업데이트에 실패했습니다.");
	        }
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        logger.error("사원 정보 업데이트 중 서버 오류 발생", e);
	        response.put("success", false);
	        response.put("message", "서버 오류: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
	// 결재요청 모달에서 결재요청 시 워크플로우(insert), 인사정보(insert)
	@PostMapping(value = "insertSignInfoForQuit")
	@ResponseBody
	public void insertSignInfo(@RequestBody Map<String, String> signData) {
		logger.debug("signData :"+signData.toString());
		
		// wf_code 설정
        LocalDate today = LocalDate.now();
        int year = today.getYear();
        String wf_code = "wf" +year+"00001";
        
        // 올해 첫 워크플로우번호가 있는지 확인하기
        String checkWfCode = sService.checkWfCode(wf_code);
        
        if(checkWfCode != null) {
        	//있으면 edu_id를 가장 최근 id에서 +1
        	String getWfCode = sService.getWfCode();
        	wf_code = "wf"+(Integer.parseInt(getWfCode.substring(2))+1);
        }
		
		WorkflowVO vo = new WorkflowVO();
		vo.setWf_code(wf_code);
		vo.setWf_type("퇴직");
		vo.setWf_sender(signData.get("wf_sender"));
		vo.setWf_receiver_1st(signData.get("wf_receiver_1st"));
		vo.setWf_receiver_2nd(signData.get("wf_receiver_2nd"));
		vo.setWf_receiver_3rd(signData.get("wf_receiver_3rd"));
		vo.setWf_target(signData.get("emp_id"));
		vo.setWf_title(signData.get("wf_title"));
		vo.setWf_content(signData.get("wf_content"));
		
		//결재정보를 워크플로우 디비에 저장
		sService.insertSalarySignInfoToWorkFlow(vo);
		
		//employee 테이블에 퇴사자 정보 insert(app : -1, 기본정보는 그대로)
		MemberVO mvo = new MemberVO();
		mvo.setEmp_id(signData.get("emp_id"));
		mvo.setReason(signData.get("reason"));
		mvo.setReason_detail(signData.get("reason_detail"));
		mvo.setEmp_quit_date(signData.get("emp_quit_date"));
		
		mService.insertQuitEmployee(mvo);
		
	}
	
	
	
	
	
	
	
	
	
}
//http://localhost:8088/member/login
//http://localhost:8088/member/login
