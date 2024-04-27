package com.spring.javaweb7S;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb7S.etc.PageProcess;
import com.spring.javaweb7S.etc.PageVO;
import com.spring.javaweb7S.service.AssetService;
import com.spring.javaweb7S.vo.FacilityVO;
import com.spring.javaweb7S.vo.FeedOlderVO;
import com.spring.javaweb7S.vo.FeedVO;
import com.spring.javaweb7S.vo.MedicinePlusVO;
import com.spring.javaweb7S.vo.MedicineVO;
import com.spring.javaweb7S.vo.Member2VO;
import com.spring.javaweb7S.vo.SemenPlusVO;
import com.spring.javaweb7S.vo.SemenVO;

@Controller
@RequestMapping("/asset")
public class AssetController {
	
	@Autowired
	AssetService assetService;

	@Autowired
	PageProcess pageProcess;
	
	// 인력관리 목록
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model, Member2VO vo,
			@RequestParam(name="page", defaultValue = "1", required=false) int page,
			@RequestParam(name="pageSize", defaultValue = "20", required=false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(page, pageSize, "asset", "", "");
		
		List<Member2VO> vos = new ArrayList<Member2VO>();
		vos = assetService.getMemberList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "asset/memberList";
	}
	
	// 인력관리 등록
	@RequestMapping(value = "/memberList", method = RequestMethod.POST)
	public String memberListPost(MultipartFile fName, Member2VO vo) {
		
		// 사진파일이 업로드되었스면 사진파일을 서버시스템에 저장시켜준다.(서비스객체에서 수행처리한다)
		// 체크가 완료되면 vo에 담긴 자료를 DB에 저장시켜준다.(인력등록)
		int res = assetService.setMemberInputOk(fName, vo);
		
		if(res == 1) return "redirect:/message/memberInputOk";
		else return "redirect:/message/memberInputNo";
	}
	
	// 인력관리 수정
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePost(Member2VO vo, MultipartFile fName) {
		
		int res = assetService.setMemberUpdate(fName, vo);
		
		if(res == 1) return "redirect:/message/memberUpdateOk";
		else return "redirect:/message/memberUpdateNo";
	}
	
	// 인력관리 삭제
	@ResponseBody
	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String memberDeletePost(int idx) {
		assetService.memberDelete(idx);
		return "";
	}
	
	//	약품관리 기본 페이지
	@RequestMapping(value = "/medicine", method = RequestMethod.GET)
	public String medicineGet(Model model, MedicineVO vo) {
		
		List<MedicineVO> vos = new ArrayList<MedicineVO>();
		vos = assetService.getMedicineList();
		
		model.addAttribute("vos", vos);
		return "asset/medicine";
	}
	
	// 약품관리 - 약품등록
	@RequestMapping(value = "/medicineInput", method = RequestMethod.POST)
	public String medicineInputPost(MultipartFile fName, MedicineVO vo) {
		
		int res = assetService.setMedicineInput(fName, vo);
		
		if(res == 1) return "redirect:/message/medicineInputOk";
		else return "redirect:/message/medicineInputNo";
	}
	
	// 약품관리 - 약품 재입고
	@RequestMapping(value = "/medicineRestock", method = RequestMethod.POST)
	public String medicineRestockPost(MedicineVO vo, String title2, MedicinePlusVO vo2,
			@RequestParam(name="title2", defaultValue = "", required=false) String title
			) {
		
		vo.setTitle(title);
		vo2.setTitle(title);
		
		assetService.setMedicinePlus(vo2);
		int res = assetService.setMedicineRestock(vo);
		res = 1;
		
		if(res == 1) return "redirect:/message/medicineRestockOk";
		else return "redirect:/message/medicineRestockNo";
	}
	
	// 약품관리 - 사용버튼눌러 재고량 줄이기
	@ResponseBody
	@RequestMapping(value = "/medicineUseCheck", method = RequestMethod.POST)
	public String medicineUseCheckPost(String title, int stock) {
		assetService.medicineUseCheck(title, stock);
		return "";
	}
	
	// 사료관리 - 기본 페이지
	@RequestMapping(value = "/feed", method = RequestMethod.GET)
	public String feedGet(FeedVO vo, Model model) {
		List<Integer> sKgList = new ArrayList<>();
		List<Integer> nKgList = new ArrayList<>();
		
		int sKg = 0;
		int nKg = 0;
		int tKg = 0;
		
		List<FeedVO> vos = assetService.getFeed();
		
		for (FeedVO vo1 : vos) {
		    int bFeeding = vo1.getBFeeding(); // bFeeding 값을 추출
		    int dIntake = vo1.getDIntake(); // dIntake 값을 추출
		    
//		    System.out.println("bFeeding: " + bFeeding + ", dIntake: " + dIntake);
		    tKg = bFeeding * dIntake * 7;
		    
//		    System.out.println("============" + tKg);
		    
		    Calendar cal = Calendar.getInstance();
		    int feedweek = cal.get(Calendar.DAY_OF_WEEK);
		    
		    if(feedweek == 1) {
		    	nKg = tKg * 7 / 7;
		    	sKg = tKg * 0 / 7;
		    }
		    else if(feedweek == 2) {
		    	nKg = tKg * 1 / 7;
		    	sKg = tKg * 6 / 7;
		    }
		    else if(feedweek == 3) {
		    	nKg = tKg * 2 / 7;
		    	sKg = tKg * 5 / 7;
		    }
		    else if(feedweek == 4) {
		    	nKg = tKg * 3 / 7;
		    	sKg = tKg * 4 / 7;
		    }
		    else if(feedweek == 5) {
		    	nKg = tKg * 4 / 7;
		    	sKg = tKg * 3 / 7;
		    }
		    else if(feedweek == 6) {
		    	nKg = tKg * 5 / 7;
		    	sKg = tKg * 2 / 7;
		    }
		    else if(feedweek == 7) {
		    	nKg = tKg * 6 / 7;
		    	sKg = tKg * 1 / 7;
		    }
		    
		    nKgList.add(nKg);
		    sKgList.add(sKg);
		    
		}
		
		model.addAttribute("nKgList", nKgList);
		model.addAttribute("sKgList", sKgList);
		model.addAttribute("vos", vos);
		
		return "asset/feed";
	}
	
	// 사료관리 - 동 추가 작업
	@RequestMapping(value = "/feedInput", method = RequestMethod.POST)
	public String feedInputPost(FeedVO vo) {
		int res = assetService.setFeedInput(vo);
		
		if(res == 1) return "redirect:/message/feedInputOk";
		else return "redirect:/message/feedInputNo";
	}
	
	// 사료관리 - 동 수정하기
	@RequestMapping(value = "/feedUpdate", method = RequestMethod.POST)
	public String feedUpdatePost(FeedVO vo, String dIdx1, String stages1, int dIntake1, int bFeeding1,
			@RequestParam(name="dIdx1", defaultValue = "", required=false) String dIdx,
			@RequestParam(name="stages1", defaultValue = "", required=false) String stages,
			@RequestParam(name="dIntake1", defaultValue = "", required=false) int dIntake,
			@RequestParam(name="bFeeding1", defaultValue = "", required=false) int bFeeding
			) {
		
		vo.setDIdx(dIdx);
		vo.setStages(stages);
		vo.setDIntake(dIntake);
		vo.setBFeeding(bFeeding);
		
		int res = assetService.setFeedUpdate(vo);
		
		res = 1;
		
		if(res == 1) return "redirect:/message/feedUpdateOk";
		else return "redirect:/message/feedUpdateNo";
	}
	
	// 사료관리 : 주문기록
	@RequestMapping(value = "/feedOlder", method = RequestMethod.POST)
	public String feedOlderPost(FeedOlderVO vo, String stages2,
			@RequestParam(name="stages2", defaultValue = "", required=false) String stages
			) {
		
		vo.setStages(stages);
		
		int res = assetService.setFeedOlder(vo);
		
		res = 1;
		
		if(res == 1) return "redirect:/message/feedOlderOk";
		else return "redirect:/message/feedOlderNo";
	}
	
	// 정액관리 : 기본 페이지
	@RequestMapping(value = "/semen", method = RequestMethod.GET)
	public String semenGet(SemenVO vo, Model model) {
		
		List<SemenVO> vos = assetService.getSemen();
		
		model.addAttribute("vos", vos);
		
		return "asset/semen";
	}
	
	// 정액관리 : 정액등록
	@RequestMapping(value = "/semenInput", method = RequestMethod.POST)
	public String semenInputPost(SemenVO vo) {
		
		int res = assetService.setSemenInput(vo);
		res = 1;
		
		if(res == 1) return "redirect:/message/semenInputOk";
		else return "redirect:/message/semenInputNo";
	}
	
	// 정액관리 : 정액삭제
	@ResponseBody
	@RequestMapping(value = "/semenDelete", method = RequestMethod.POST)
	public String semenDeletePost(int idx) {
		assetService.setSemenDelete(idx);
		return "";
	}
	
	// 정액관리 : 정액입고
	@RequestMapping(value = "/semenPlus", method = RequestMethod.POST)
	public String semenPlus(String sNum3, SemenPlusVO vo, SemenVO vo2,
			@RequestParam(name="sNum3", defaultValue = "", required=false) String sNum
			) {
		
		vo.setSNum(sNum);
		vo2.setSNum(sNum);
		
		assetService.setSemenPlus(vo);
		assetService.setSemenRestock(vo2);
		
		return "redirect:/message/semenRestockOk";
	}
	
	// 정액관리 : 정액사용
	@ResponseBody
	@RequestMapping(value = "/semenUse", method = RequestMethod.POST)
	public String semenUse(String sNum, int stock) {
		assetService.setSemenUse(sNum, stock);
		return "";
	}
	
	// 정액관리 : 정액분류
	@RequestMapping(value = "/semenArr", method = RequestMethod.GET)
	public String semenArr(Model model,
			@RequestParam(name="semenA", defaultValue = "", required=false) String semenA
			) {
		List<SemenVO> vos = assetService.getSemenArr(semenA);
		
		model.addAttribute("vos", vos);
		model.addAttribute("semenA", semenA);
		
		return "asset/semen";
	}
	
	// 시설기록 : 기본 폼
	@RequestMapping(value = "/facility", method = RequestMethod.GET)
	public String facility(Model model,
			@RequestParam(name="page", defaultValue = "1", required=false) int page,
			@RequestParam(name="pageSize", defaultValue = "20", required=false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(page, pageSize, "asset", "", "");
		
		List<FacilityVO> vos = assetService.getFacility(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "asset/facility";
	}
	
	// 시설기록 : 등록하기
	@RequestMapping(value = "/facilityInput", method = RequestMethod.POST)
	public String facilityInput(FacilityVO vo) {
		int res = assetService.setFacilityInput(vo);
		
		if(res == 1) return "redirect:/message/facilityInputOk";
		else return "redirect:/message/facilityInputNo";
	}
	
	// 시설기록 : 삭제하기
	@ResponseBody
	@RequestMapping(value = "/facilityDelete", method = RequestMethod.POST)
	public String facilityDelete(int idx) {
		assetService.setFacilityDelete(idx);
		return "";
	}
	
	// 시설기록 : 수정하기
	@ResponseBody
	@RequestMapping(value = "/facilityUpdate", method = RequestMethod.POST)
	public String facilityUpdate(FacilityVO vo) {
		assetService.setFacilityUpdate(vo);
		return "";
	}
}
