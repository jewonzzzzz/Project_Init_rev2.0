package com.Init.domain;

import java.sql.Date;
import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class LeaveVO {
	
	// 입사일 
	private Date emp_start_date;
    // 휴가번호
    private int leave_id; // leaveId

    // 사원 번호
    private String emp_id; // emp_id

    // 휴가 유형 
    private String leave_type; // leaveType

    // 휴가 시작일
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date leave_start_date; 

    
    // 연차 관련 필드
    private int annual_leave; // annualLeave
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd" ,timezone = "Asia/Seoul")
    private Date annual_leave_start_date; // annualLeaveStartDate
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd" ,timezone = "Asia/Seoul")
    private Date end_annual_leave; 

    // 총 연차 일수 관련 필드
    private int used_annual_leave;  //  사용 연차
    private int total_annual_leave;  // 총 나의 연차
    private int remaining_annual_leave; //잔여 연차
    private int lgrant; // 연차 부여 
    private int expiry; // 연차 소멸
    private int adjustment; // 연차 조정
  
    // 휴가 상태 
    private int leave_status; 
   
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Timestamp adjustmentDate; // 연차 조정,사용,부여,소멸 시  날짜 디폴트로 입력되야됨

    // 휴가 종료일
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date end_leave_date; 

    // 승인 날짜
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date approval_date; 

    // 신청 사유
    private String reason; 

    // 신청 날짜
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date requested_at; 

    // 총 휴가 일수 관련 필드
    private int total_leave_days; 
   
    
    
    
    
    
   
    
    
}
