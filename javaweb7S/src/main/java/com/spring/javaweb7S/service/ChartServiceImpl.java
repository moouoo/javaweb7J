package com.spring.javaweb7S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb7S.dao.ChartDAO;
import com.spring.javaweb7S.vo.ChartVO;
import com.spring.javaweb7S.vo.SurveyContentVO;

@Service
public class ChartServiceImpl implements ChartService {

	@Autowired
	ChartDAO chartdao;
	
	@Override
	public ChartVO getTotalRevenue() {
		return chartdao.getTotalRevenue();
	}

	@Override
	public ChartVO getTotalExpense() {
		return chartdao.getTotalExpense();
	}

	@Override
	public ChartVO getYearRevenue(String year) {
		return chartdao.getYearRevenue(year);
	}

	@Override
	public ChartVO getYearExpense(String year) {
		return chartdao.getYearExpense(year);
	}

	@Override
	public ChartVO getMemberExpense() {
		return chartdao.getMemberExpense();
	}

	@Override
	public ChartVO getMedicineExpense() {
		return chartdao.getMedicineExpense();
	}

	@Override
	public ChartVO getFeedExpense() {
		return chartdao.getFeedExpense();
	}

	@Override
	public ChartVO getSemenExpense() {
		return chartdao.getSemenExpense();
	}

	@Override
	public ChartVO getFacilityExpense() {
		return chartdao.getFacilityExpense();
	}

	@Override
	public ChartVO getregistrationExpense() {
		return chartdao.getregistrationExpense();
	}

	@Override
	public void setSurveyInput(SurveyContentVO vo) {
		chartdao.setSurveyInput(vo);
	}

	@Override
	public List<SurveyContentVO> getSurveyContent(int startIndexNo, int pageSize) {
		return chartdao.getSurveyContent(startIndexNo ,pageSize);
	}

	@Override
	public List<SurveyContentVO> setSurveyContent(int idx) {
		return chartdao.setSurveyContent(idx);
	}

	@Override
	public void setSurveyDelete(int idx) {
		chartdao.setSurveyDelete(idx);
	}

	@Override
	public void setSurveyReadNum(int idx) {
		chartdao.setSurveyReadNum(idx);
	}

	
}
