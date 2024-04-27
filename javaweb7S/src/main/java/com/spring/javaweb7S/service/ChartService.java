package com.spring.javaweb7S.service;

import java.util.List;

import com.spring.javaweb7S.vo.ChartVO;
import com.spring.javaweb7S.vo.SurveyContentVO;

public interface ChartService {

	public ChartVO getTotalRevenue();

	public ChartVO getTotalExpense();

	public ChartVO getYearRevenue(String year);

	public ChartVO getYearExpense(String year);

	public ChartVO getMemberExpense();

	public ChartVO getMedicineExpense();

	public ChartVO getFeedExpense();

	public ChartVO getSemenExpense();

	public ChartVO getFacilityExpense();

	public ChartVO getregistrationExpense();

	public void setSurveyInput(SurveyContentVO vo);

	public List<SurveyContentVO> getSurveyContent(int startIndexNo, int pageSize);

	public List<SurveyContentVO> setSurveyContent(int idx);

	public void setSurveyDelete(int idx);

	public void setSurveyReadNum(int idx);


	
}
