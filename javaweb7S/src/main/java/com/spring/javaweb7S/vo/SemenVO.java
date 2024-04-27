package com.spring.javaweb7S.vo;

import lombok.Data;

@Data
public class SemenVO {
	private int idx;
	private String sNum;
	private String nTank;
	private double EMA;
	private double MS;
	private double BF;
	private double CW;
	private int stock;
	
	private int purchase;
}
