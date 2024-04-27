package com.spring.javaweb7S.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaweb7S.vo.BirthVO;
import com.spring.javaweb7S.vo.DiseaseVO;
import com.spring.javaweb7S.vo.EstrusVO;
import com.spring.javaweb7S.vo.LivestockShipmentVO;
import com.spring.javaweb7S.vo.RegistrationPlusVO;
import com.spring.javaweb7S.vo.RegistrationVO;

public interface LivestockService {

	public List<RegistrationVO> getLivestock(int startIndexNo, int pageSize);

	public int setLivestock(String cNum, String birthday, String etc, String gender, int price);

	public List<RegistrationVO> getListSearch(int startIndexNo, int pageSize, String search, String searchString);

	public int setDisease(String cNum, String dType, String content, String dBirth);

	public ArrayList<DiseaseVO> getDisease(String ymd);

	public int setLivestockShipment(String cNum, String price, String sYear);

	public void setLivestockDelete(String cNum);

	public List<LivestockShipmentVO> getLivestockShipment(int startIndexNo, int pageSize);

	public void setdiseaseUpdateOk(DiseaseVO vo);

	public void setdiseaseDeleteOk(int idx);

	public ArrayList<DiseaseVO> getDiseaseCheck(String ym);

	public void setRegistrationUpdate(RegistrationVO vo);

	public void setRegistrationDelete(int idx);

	public List<EstrusVO> getEstrus();

	public List<EstrusVO> getEstrusDetail(String ymd);

	public void setEstrusUpdateOk(EstrusVO vo);

	public void estrusDeleteOk(int idx);

	public int estrusInput(EstrusVO vo);

	public List<BirthVO> getBirth(int startIndexNo, int pageSize);

	public int setBirthInput(BirthVO vo, String cNum);

	public void setBirthDelete(int idx);

	public void setRegistrationPlus(RegistrationPlusVO vo2);

	public RegistrationVO setRegistrationCNumCheck(RegistrationVO vo);




}
