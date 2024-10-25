package com.Init.domain;

import java.sql.Date;
import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class AttendanceVO {
	
	
	private String emp_profile;
	private String emp_job;

	private String emp_position;

	private String emp_name;

    private int attendance_id; // 출근번호
    private String emp_cid;// 부서번호
    
    private String emp_id; // 사원 번호 
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss" ,timezone = "Asia/Seoul")
    private Timestamp check_in; // 출근시간
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Asia/Seoul")
    private Timestamp check_out; // 퇴근 시간
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Asia/Seoul")
    private Timestamp WorkingOutside_time; // 외출 시간
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Asia/Seoul")
    private Timestamp return_time; // 복귀시간
    
    private int status; // 결재 상태
    
    private int overtime; // 초과 시간
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date created_at; //신청일
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Asia/Seoul")
    private Timestamp new_check_in; // 수정할 출근 날짜
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Asia/Seoul")
    private Timestamp new_check_out; // 수정할 퇴근 날짜 
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Asia/Seoul")
    private Timestamp new_WorkingOutside_time; // 수정할 외근 날짜
    
    private int working_time; // 근무한 시간
    private int night_work_time; // 야근 시간
    private int special_working_time;  //특근 시간
    
    private String modified_reason; //신청이유
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Asia/Seoul")
    private Timestamp modified_time; //수정한 시간
    
    private String modified_person; // 수정인
    private String workform_status; // 근무형태
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date businessDate;//출장 날짜
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date business_endDate;//출장 날짜
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date educationDate; // 교육 출장 날짜
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd",timezone = "Asia/Seoul")
    private Date education_endDate; // 교육 출장 날짜
    
   
}
