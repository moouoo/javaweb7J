package com.spring.javaweb7S.vo;

import lombok.Data;

@Data
public class FeedVO {
	private int idx;
	private String dIdx;
	private String stages;
	private int dIntake;
	private int bFeeding;
	
	private int tKg;	// 총 량
	private int sKg;	// 재고량
	private int nKg;	// 필요량
}
