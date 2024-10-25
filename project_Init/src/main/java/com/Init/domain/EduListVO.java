package com.Init.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EduListVO {
	private int edu_his_id;
	private String edu_id;
	private String emp_id;
	private String emp_name;
	private String emp_bnum;
	private String dname;
	private String edu_type;
	private String edu_name;
	private String edu_teacher;
	private String edu_place;
	private String edu_content;
	private String edu_start_date;
	private String edu_end_date;
	private String edu_apply_start;
	private String edu_apply_end;
	private String edu_complete_date;
	private MultipartFile edu_thumbnail;
	private String edu_thumbnail_src;
	private String edu_status;
	private String edu_list_status;
	private int edu_personnel;
}
