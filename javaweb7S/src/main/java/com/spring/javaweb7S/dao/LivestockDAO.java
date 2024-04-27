package com.spring.javaweb7S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb7S.vo.BirthVO;
import com.spring.javaweb7S.vo.DiseaseVO;
import com.spring.javaweb7S.vo.EstrusVO;
import com.spring.javaweb7S.vo.LivestockShipmentVO;
import com.spring.javaweb7S.vo.RegistrationPlusVO;
import com.spring.javaweb7S.vo.RegistrationVO;

public interface LivestockDAO {

	public List<RegistrationVO> getLivestock(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setLivestock(@Param("cNum") String cNum, @Param("birthday") String birthday, @Param("etc") String etc, @Param("gender") String gender, @Param("price") int price);

	public int totRecCnt();

	public List<RegistrationVO> getListSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public ArrayList<DiseaseVO> getDiseaseInput(@Param("cNum") String cNum, @Param("ym") String ym);

	public List<RegistrationVO> getLivestock();

	public int setDisease(@Param("cNum") String cNum, @Param("dType") String dType, @Param("content") String content, @Param("dBirth") String dBirth);

	public ArrayList<DiseaseVO> getDisease(@Param("ymd") String ymd);

	public int setLivestockShipment(@Param("cNum") String cNum, @Param("price") String price, @Param("sYear") String sYear);

	public void setLivestockDelete(@Param("cNum") String cNum);

	public List<LivestockShipmentVO> getLivestockShipment(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setdiseaseUpdateOk(@Param("vo") DiseaseVO vo);

	public void setdiseaseDeleteOk(@Param("idx") int idx);

	public ArrayList<DiseaseVO> getDiseaseCheck(@Param("ym") String ym);

	public void setRegistrationUpdate(@Param("vo") RegistrationVO vo);

	public void setRegistrationDelete(@Param("idx") int idx);

	public List<EstrusVO> getEstrusList(@Param("ym") String ym);

	public List<EstrusVO> getEstrusDetail(@Param("ymd") String ymd);

	public void setEstrusUpdateOk(@Param("vo") EstrusVO vo);

	public void estrusDeleteOk(@Param("idx") int idx);

	public int estrusInput(@Param("vo") EstrusVO vo);

	public List<EstrusVO> getEstrus();

	public List<BirthVO> getBirth(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setBirthInput(@Param("vo") BirthVO vo, @Param("cNum") String cNum);

	public void setBirthDelete(@Param("idx") int idx);

	public void setRegistrationPlus(@Param("vo2") RegistrationPlusVO vo2);

	public int totRecCntShipment();

	public RegistrationVO setRegistrationCNumCheck(@Param("vo") RegistrationVO vo);

	


	
}
