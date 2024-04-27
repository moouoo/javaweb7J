package com.spring.javaweb7S.vo;

import lombok.Data;

@Data
public class ChartVO {
	private int revenue;	// 수익
	private int expense;	// 비용
	
	private int yRevenue;	// 년도 별 수익
	private int yExpense;	// 년도 별 비용
	
	private int registP;	// 가축등록비용
	private int memberP;	// 인력비용
	private int medicineP;	// 약품비용
	private int feedP;		// 사료비용
	private int semenP;		// 정액비용
	private int facilityP;	// 시설비용
	
}
