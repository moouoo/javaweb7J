package com.spring.javaweb7S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb7S.vo.ChartVO;
import com.spring.javaweb7S.vo.SurveyContentVO;

public interface ChartDAO {

	public ChartVO getTotalRevenue();

	public ChartVO getTotalExpense();

	public ChartVO getYearRevenue(@Param("year") String year);

	public ChartVO getYearExpense(@Param("year") String year);

	public ChartVO getMemberExpense();

	public ChartVO getMedicineExpense();

	public ChartVO getFeedExpense();

	public ChartVO getSemenExpense();

	public ChartVO getFacilityExpense();

	public ChartVO getregistrationExpense();

	public void setSurveyInput(@Param("vo") SurveyContentVO vo);

	public List<SurveyContentVO> getSurveyContent(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public List<SurveyContentVO> setSurveyContent(@Param("idx") int idx);

	public void setSurveyDelete(@Param("idx") int idx);

	public int totRecCntSurvey();

	public void setSurveyReadNum(@Param("idx") int idx);


}
