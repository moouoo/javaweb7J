package com.spring.javaweb7S.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb7S.vo.FacilityVO;
import com.spring.javaweb7S.vo.FeedOlderVO;
import com.spring.javaweb7S.vo.FeedVO;
import com.spring.javaweb7S.vo.MedicinePlusVO;
import com.spring.javaweb7S.vo.MedicineVO;
import com.spring.javaweb7S.vo.Member2VO;
import com.spring.javaweb7S.vo.SemenPlusVO;
import com.spring.javaweb7S.vo.SemenVO;

public interface AssetService {

	public int setMemberInputOk(MultipartFile fName, Member2VO vo);

	public List<Member2VO> getMemberList(int startIndexNo, int pageSize);

	public int setMemberUpdate(MultipartFile fName, Member2VO vo);

	public void memberDelete(int idx);

	public List<MedicineVO> getMedicineList();

	public int setMedicineInput(MultipartFile fName, MedicineVO vo);

	public int setMedicineRestock(MedicineVO vo);

	public void setMedicinePlus(MedicinePlusVO vo2);

	public void medicineUseCheck(String title, int stock);

	public List<FeedVO> getFeed();

	public int setFeedInput(FeedVO vo);

	public int setFeedUpdate(FeedVO vo);

	public int setFeedOlder(FeedOlderVO vo);

	public List<SemenVO> getSemen();

	public int setSemenInput(SemenVO vo);

	public void setSemenDelete(int idx);

	public void setSemenPlus(SemenPlusVO vo);

	public void setSemenRestock(SemenVO vo2);

	public void setSemenUse(String sNum, int stock);

	public List<SemenVO> getSemenArr(String semenA);

	public List<FacilityVO> getFacility(int startIndexNo, int pageSize);

	public int setFacilityInput(FacilityVO vo);

	public void setFacilityDelete(int idx);

	public void setFacilityUpdate(FacilityVO vo);






	
}
