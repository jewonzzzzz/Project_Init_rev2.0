package com.Init.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class EvalVO {
	private String eval_his_id;
	private String eval_id;
	private String emp_id;
	private String emp_name;
	private String emp_position;
	private String emp_dnum;
	private String eval_type;
	private String eval_name;
	private String year;
	private String branch;
	private String eval_report_start;
	private String eval_report_end;
	private String eval_start_date;
	private String eval_end_date;
	private String eval_status;
	private String evaluator;
	private String content;
	private int score_perform;
	private int score_attendance;
	private int score_develop;
	private double score_total;
	private String eval_grade;
	private String eval_his_status;
	private String eval_comment;
}
