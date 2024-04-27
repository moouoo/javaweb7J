package com.spring.javaweb7S.vo;

import lombok.Data;

@Data
public class MedicineVO {
	private int idx;
	private String title;
	private int purchase;
	private int stock;
	private int price;
	private String photo;
	private String content;
	private String pYear;
}
