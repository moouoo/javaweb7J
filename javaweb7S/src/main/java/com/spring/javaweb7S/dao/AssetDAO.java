package com.spring.javaweb7S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb7S.vo.FacilityVO;
import com.spring.javaweb7S.vo.FeedOlderVO;
import com.spring.javaweb7S.vo.FeedVO;
import com.spring.javaweb7S.vo.MedicinePlusVO;
import com.spring.javaweb7S.vo.MedicineVO;
import com.spring.javaweb7S.vo.Member2VO;
import com.spring.javaweb7S.vo.SemenPlusVO;
import com.spring.javaweb7S.vo.SemenVO;

public interface AssetDAO {

	public void setMemberInputOk(@Param("vo") Member2VO vo);

	public List<Member2VO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCnt();

	public int setMemberUpdateOk(@Param("vo") Member2VO vo);

	public void memberDelete(@Param("idx") int idx);

	public List<MedicineVO> getMedicineList();

	public void setMedicineInput(@Param("vo") MedicineVO vo);

	public int setMedicineRestock(@Param("vo") MedicineVO vo);

	public void setMedicinePlus(@Param("vo2") MedicinePlusVO vo2);

	public void medicineUseCheck(@Param("title") String title, @Param("stock") int stock);

	public List<FeedVO> getFeed();

	public int setFeedInput(@Param("vo") FeedVO vo);

	public int setFeedUpdate(@Param("vo") FeedVO vo);

	public int setFeedOlder(@Param("vo") FeedOlderVO vo);

	public List<SemenVO> getSemen();

	public int setSemenInput(@Param("vo") SemenVO vo);

	public void setSemenDelete(@Param("idx") int idx);

	public void setSemenPlus(@Param("vo") SemenPlusVO vo);

	public void setSemenRestock(@Param("vo2") SemenVO vo2);

	public void setSemenUse(@Param("sNum") String sNum, @Param("stock") int stock);

	public List<SemenVO> getSemenArr(@Param("semenA") String semenA);

	public List<FacilityVO> getFacility(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setFacilityInput(@Param("vo") FacilityVO vo);

	public void setFacilityDelete(@Param("idx") int idx);

	public void setFacilityUpdate(@Param("vo") FacilityVO vo);








	
}
