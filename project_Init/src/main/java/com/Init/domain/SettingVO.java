package com.Init.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class SettingVO {
	private String emp_id;
	private String tool_id;
	private String tool_name;
	private String tool_url;
	private String tool_id_1;
	private String tool_name_1;
	private String tool_url_1;
	private String tool_id_2;
	private String tool_name_2;
	private String tool_url_2;
	private String tool_id_3;
	private String tool_name_3;
	private String tool_url_3;
	private String tool_id_4;
	private String tool_name_4;
	private String tool_url_4;
	private List<EmployeeVO> favorite_emp;
	private List<Integer> favorite_room_id;
	private boolean log_on;
}
