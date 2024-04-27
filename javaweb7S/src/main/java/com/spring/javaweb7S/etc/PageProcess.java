package com.spring.javaweb7S.etc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb7S.dao.AssetDAO;
import com.spring.javaweb7S.dao.ChartDAO;
import com.spring.javaweb7S.dao.LivestockDAO;

@Service
public class PageProcess {
	
	@Autowired
	LivestockDAO livestockdao;
	
	@Autowired
	AssetDAO assetdao;
	
	@Autowired
	ChartDAO chartdao;
	
	public PageVO totRecCnt(int page, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("livestock")) {
			if(part.equals("")) totRecCnt = livestockdao.totRecCnt();
			else {
				search = part;
				totRecCnt = livestockdao.totRecCntSearch(search, searchString);
			}
		}
		else if(section.equals("asset")) totRecCnt = assetdao.totRecCnt();
		else if(section.equals("livestockShipment")) totRecCnt = livestockdao.totRecCntShipment();
		else if(section.equals("survey")) totRecCnt = chartdao.totRecCntSurvey();
		
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (page - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (page - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPage(page);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}
	
}
