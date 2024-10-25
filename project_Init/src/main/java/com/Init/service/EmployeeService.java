package com.Init.service;

import java.util.List;

import com.Init.domain.EmployeeVO;
import com.Init.domain.SettingVO;

public interface EmployeeService {
	
	public EmployeeVO memberLogin(EmployeeVO vo);
	
	public EmployeeVO memberInfo(String userid);
	
	public List<EmployeeVO> memberSearch(String keyword);
	
	public List<EmployeeVO> getTeammate(String emp_id);
	
	public List<SettingVO> searchTools(String keyword);
	
	public void settingFavoriteTool(SettingVO vo);
	
	public SettingVO showSetting(String emp_id);
	
	public void userLogout(String emp_id);
	
	public void userLogin(String emp_id);
	
	public void followEmp(String user_emp_id,String emp_id);
	
	public void unFollowEmp(String user_emp_id,String emp_id);
}
