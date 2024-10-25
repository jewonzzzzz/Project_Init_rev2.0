package com.Init.domain;

import lombok.Data;

@Data
public class CalSalaryListVO {
	private String sal_list_id;
	private String emp_id;
	private String emp_name;
	private String year;
	private String month;
	private String sal_type;
	private String check_in;
	private String sal_list_subject;
	private String sal_list_date;
	private String sal_list_status;
	private double bonus_rate;
}
