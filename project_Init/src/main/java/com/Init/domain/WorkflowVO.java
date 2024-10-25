package com.Init.domain;

import java.sql.Timestamp;

import org.springframework.stereotype.Repository;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
public class WorkflowVO {
	
	private String wf_code;  // getUserid();
	private String wf_type;
	private String wf_target;
	private String wf_title;
	private String wf_content;
	private Timestamp wf_create_date;
	private String wf_file;
	private String wf_progress;
	private String wf_status;
	private String wf_sender;
	private String wf_receiver;
	private String wf_receiver_1st;
	private String wf_receiver_2nd;
	private String wf_receiver_3rd;
	private String wf_comment;
	private String wf_comment_1st;
	private String wf_comment_2nd;
	private String wf_comment_3rd;
	private String wf_result;
	private String wf_result_1st;
	private String wf_result_2nd;
	private String wf_result_3rd;
	private Timestamp wf_result_date;
	private Timestamp wf_last_result_date;
	private Timestamp wf_result_date_1st;
	private Timestamp wf_result_date_2nd;
	private Timestamp wf_result_date_3rd;
	
	private String sender_name;
	private String sender_job;
    private String sender_dnum;
    private String sender_bnum;
    private String sender_position;
    private String sender_profile;
    
	private String receiver_name;
	private String receiver_job;
    private String receiver_dnum;
    private String receiver_bnum;
    private String receiver_position;
    private String receiver_profile;
	
	private String receiver_name_1st;
	private String receiver_job_1st;
    private String receiver_dnum_1st;
    private String receiver_bnum_1st;
    private String receiver_position_1st;
    private String receiver_profile_1st;
    
    private String receiver_name_2nd;
    private String receiver_job_2nd;
    private String receiver_dnum_2nd;
    private String receiver_bnum_2nd;
    private String receiver_position_2nd;
    private String receiver_profile_2nd;
    
    private String receiver_name_3rd;
    private String receiver_job_3rd;
    private String receiver_dnum_3rd;
    private String receiver_bnum_3rd;
    private String receiver_position_3rd;
    private String receiver_profile_3rd;

}
