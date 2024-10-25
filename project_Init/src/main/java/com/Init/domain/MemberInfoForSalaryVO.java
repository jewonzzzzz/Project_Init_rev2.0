package com.Init.domain;

import lombok.Data;

@Data
public class MemberInfoForSalaryVO {
	private String emp_id;
	private String emp_name;
	private String dname;
	private String dgrade;
	private String emp_bnum;
	private String emp_position;
	private String emp_job;
	private String emp_work_type;
	private String check_in;
	private double perform_rate;
	private int working_time;
	private int overtime;
	private int night_work_time;
	private int special_working_time;
}
