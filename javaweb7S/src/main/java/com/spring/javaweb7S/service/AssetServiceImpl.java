package com.spring.javaweb7S.service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb7S.dao.AssetDAO;
import com.spring.javaweb7S.etc.JavawebProvide;
import com.spring.javaweb7S.vo.FacilityVO;
import com.spring.javaweb7S.vo.FeedOlderVO;
import com.spring.javaweb7S.vo.FeedVO;
import com.spring.javaweb7S.vo.MedicinePlusVO;
import com.spring.javaweb7S.vo.MedicineVO;
import com.spring.javaweb7S.vo.Member2VO;
import com.spring.javaweb7S.vo.SemenPlusVO;
import com.spring.javaweb7S.vo.SemenVO;

@Service
public class AssetServiceImpl implements AssetService {
	
	@Autowired
	AssetDAO assetdao;

	@Override
	public int setMemberInputOk(MultipartFile fName, Member2VO vo) {
		int res = 0;
		
		try {
			String oFileName = fName.getOriginalFilename();
			
			if(oFileName.equals("")) {
				vo.setPhoto("noimage.jpeg");
			}
			else {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(fName, saveFileName, "member");
				
				vo.setPhoto(saveFileName);
			}
			assetdao.setMemberInputOk(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}


	@Override
	public List<Member2VO> getMemberList(int startIndexNo, int pageSize) {
		return assetdao.getMemberList(startIndexNo, pageSize);
	}


	@Override
	public int setMemberUpdate(MultipartFile fName, Member2VO vo) {
		int res = 0;
		
		try {
			String oFileName = fName.getOriginalFilename();
			
			if(oFileName.equals("")) {
				vo.setPhoto("noimage.jpeg");
			}
			else {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(fName, saveFileName, "images");
				
				vo.setPhoto(saveFileName);
			}
			assetdao.setMemberUpdateOk(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public void memberDelete(int idx) {
		assetdao.memberDelete(idx);
	}

	@Override
	public List<MedicineVO> getMedicineList() {
		return assetdao.getMedicineList();
	}


	@Override
	public int setMedicineInput(MultipartFile fName, MedicineVO vo) {
		int res = 0;
		
		try {
			String oFileName = fName.getOriginalFilename();
			if(oFileName.equals("")) {
				vo.setPhoto("noimage.jpeg");
			}
			else {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(fName, saveFileName, "medicine");
				
				vo.setPhoto(saveFileName);
			}
			assetdao.setMedicineInput(vo);
			
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int setMedicineRestock(MedicineVO vo) {
		return assetdao.setMedicineRestock(vo);
	}
	
	@Override
	public void setMedicinePlus(MedicinePlusVO vo2) {
		assetdao.setMedicinePlus(vo2);
	}

	@Override
	public void medicineUseCheck(String title, int stock) {
		assetdao.medicineUseCheck(title, stock);
	}

	@Override
	public List<FeedVO> getFeed() {
		return assetdao.getFeed();
	}


	@Override
	public int setFeedInput(FeedVO vo) {
		return assetdao.setFeedInput(vo);
	}

	@Override
	public int setFeedUpdate(FeedVO vo) {
		return assetdao.setFeedUpdate(vo);
	}

	@Override
	public int setFeedOlder(FeedOlderVO vo) {
		return assetdao.setFeedOlder(vo);
	}

	@Override
	public List<SemenVO> getSemen() {
		return assetdao.getSemen();
	}

	@Override
	public int setSemenInput(SemenVO vo) {
		return assetdao.setSemenInput(vo);
	}

	@Override
	public void setSemenDelete(int idx) {
		assetdao.setSemenDelete(idx);
	}


	@Override
	public void setSemenPlus(SemenPlusVO vo) {
		assetdao.setSemenPlus(vo);
	}


	@Override
	public void setSemenRestock(SemenVO vo2) {
		assetdao.setSemenRestock(vo2);
	}


	@Override
	public void setSemenUse(String sNum, int stock) {
		assetdao.setSemenUse(sNum, stock);
	}


	@Override
	public List<SemenVO> getSemenArr(String semenA) {

		return assetdao.getSemenArr(semenA);
		
	}

	@Override
	public List<FacilityVO> getFacility(int startIndexNo, int pageSize) {
		return assetdao.getFacility(startIndexNo, pageSize);
	}


	@Override
	public int setFacilityInput(FacilityVO vo) {
		return assetdao.setFacilityInput(vo);
	}


	@Override
	public void setFacilityDelete(int idx) {
		assetdao.setFacilityDelete(idx);
	}


	@Override
	public void setFacilityUpdate(FacilityVO vo) {
		assetdao.setFacilityUpdate(vo);
	}





}
