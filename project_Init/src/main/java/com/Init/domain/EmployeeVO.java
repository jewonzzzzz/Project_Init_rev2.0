package com.Init.domain;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Repository;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
public class EmployeeVO {
	
//	private String Uid;
	//private String uId; //getUId() (x)
	//private String userId; //getUserId() (o)
	
	private String emp_id;
	private String emp_cid;
	private String emp_pw;
	private String emp_profile;
	private String emp_name;
	private Date emp_birth;
	private String emp_gender;
	private String emp_tel;
	private String emp_email;
	private String emp_addr;
	private String emp_dnum;
	private String emp_dname;
	private String emp_position;
	private String emp_job;
	private String emp_status;
	private String emp_bnum;
	private String emp_work_type;
	private int emp_salary;
	private String emp_account_num;
	private String emp_bank_name;
	private String emp_account_name;
	private Date emp_start_date;
	private Date emp_break_date;
	private Date emp_restart_date;
	private Date emp_quit_date;
	private String emp_power;
	private String emp_level;
	
	private boolean log_on;
}
