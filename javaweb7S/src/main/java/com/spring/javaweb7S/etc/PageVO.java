package com.spring.javaweb7S.etc;

import lombok.Data;

@Data
public class PageVO {
	private int page;
	private int pageSize;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo;
	private int curBlock;
	private int blockSize;
	private int lastBlock;
	
	private String part;
	private String search;
	private String searchString;
}