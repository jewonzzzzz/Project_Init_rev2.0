package com.Init.domain;

import lombok.Data;

@Data
public class SalaryBasicInfoVO {
	private int sal_basic_id;
	private int hourwage;
	private double incometax_rate1;
	private double incometax_rate2;
	private double incometax_rate3;
	private double incometax_rate4;
	private double incometax_rate5;
	private double incometax_rate6;
	private double incometax_rate7;
	private double incometax_rate8;
	private double pension_rate;
	private double heal_ins_rate;
	private double long_ins_rate;
	private double emp_ins_rate;
}
