package com.spring.javaweb7S;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb7S.etc.PageProcess;
import com.spring.javaweb7S.etc.PageVO;
import com.spring.javaweb7S.service.LivestockService;
import com.spring.javaweb7S.vo.BirthVO;
import com.spring.javaweb7S.vo.DiseaseVO;
import com.spring.javaweb7S.vo.EstrusVO;
import com.spring.javaweb7S.vo.LivestockShipmentVO;
import com.spring.javaweb7S.vo.RegistrationPlusVO;
import com.spring.javaweb7S.vo.RegistrationVO;

@Controller
@RequestMapping("/livestock")
public class LivestockController {
	
	@Autowired
	LivestockService livestockService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 가축목록 출력
	@RequestMapping(value = "/registrationList", method = RequestMethod.GET)
	public String registrationListGet(RegistrationVO vo, Model model, DiseaseVO dVo,
			@RequestParam(name="page", defaultValue = "1", required=false) int page,
			@RequestParam(name="pageSize", defaultValue = "20", required=false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(page, pageSize, "livestock", "", "");
		
		List<RegistrationVO> vos = new ArrayList<RegistrationVO>();
		vos = livestockService.getLivestock(pageVO.getStartIndexNo(), pageSize);
		
		
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "livestock/registrationList";
	}
	
	// 개체번호 등록
	@RequestMapping(value = "/registrationList", method = RequestMethod.POST)
	public String registrationListPost(RegistrationVO vo, Model model, RegistrationPlusVO vo2,
			@RequestParam(name = "cNum", defaultValue = "", required = false) String cNum,
			@RequestParam(name = "birthday", defaultValue = "", required = false) String birthday,
			@RequestParam(name = "etc", defaultValue = "", required = false) String etc,
			@RequestParam(name = "gender", defaultValue = "", required = false) String gender,
			@RequestParam(name = "price", defaultValue = "", required = false) int price
			) {
		
		vo = livestockService.setRegistrationCNumCheck(vo);
		
		if(vo == null) {
			livestockService.setRegistrationPlus(vo2);
			livestockService.setLivestock(cNum, birthday, etc, gender, price);
			
			return "redirect:/message/livestockInputOk";
		}
		else return "redirect:/message/livestockInputNo";
	}
	
	//개체번호 삭제
	@ResponseBody
	@RequestMapping(value = "/registrationDelete", method = RequestMethod.POST)
	public String registrationDeletePost(int idx) {
		livestockService.setRegistrationDelete(idx);
		return "";
	}
	
	// 개체 검색처리
	@RequestMapping(value = "/registrationSearch", method = RequestMethod.GET)
	public String boardSearchGet(String search, String searchString,
			@RequestParam(name="page", defaultValue = "1", required=false) int page,
			@RequestParam(name="pageSize", defaultValue = "20", required=false) int pageSize,
			Model model) {		// search = search+"/"+searchString
		
		PageVO pageVO = pageProcess.totRecCnt(page, pageSize, "livestock", search, searchString);
		
		List<RegistrationVO> vos = livestockService.getListSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);
		
		String searchTitle = "";
		if(pageVO.getSearch().equals("cNum")) searchTitle = "개체번호";
		else searchTitle = "생년월일";
//		else if(pageVO.getSearch().equals("birthday")) searchTitle = "생년월일";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		
		return "livestock/registrationSearch";
		
	}
	
	// 질병관리 달력 양식
	@RequestMapping(value = "/disease", method = RequestMethod.GET)
	public String diseaseGet(DiseaseVO vo, HttpServletRequest request
			) {
		
		Calendar calendar = Calendar.getInstance();
	 	int year = calendar.get(Calendar.YEAR);
	 	int month = calendar.get(Calendar.MONTH); //월은 0부터 시작하기 때문에 사실상 month의 값은 -1되어서 나온다.
	 	int day = calendar.get(Calendar.DAY_OF_MONTH);
		
	 // 화면에 보여줄 해당 '년/월'을 셋팅
 		Calendar cal = Calendar.getInstance();
 			int yy = request.getParameter("yy")==null? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
 			int mm = request.getParameter("mm")==null? cal.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
 			
 			if(mm < 0) {
 				yy--;
 				mm = 11;
 			}
 			if(mm > 11) {
 				yy++;
 				mm = 0;
 			}
 			
 			// 현재 달의 첫째 날짜로 설정
		    cal.set(yy, mm, 1);
		    
		    int startWeek = cal.get(Calendar.DAY_OF_WEEK);  //(일(1) ~ 토(7)), // 앞에서 셋팅한 해당 '년/월'의 1일에 해당하는 요일 값을 숫자로 가져온다.
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 해당 '년/월'의 마지막 일자를 가져온다.
		    
			// 출력된 달력의 '앞쪽/뒤쪽'의 빈공간에 해당월의 '이전/다음'의 날짜를 채워보자.
			int prevYear = yy;
			int prevMonth = (mm) - 1;
			int nextYear = yy;
			int nextMonth = (mm) + 1;
			
			if(prevMonth == -1) {
				prevYear--;
				prevMonth = 11;
			}
			if(nextMonth == 12) {
				nextYear++;
				nextMonth = 0;
			}
		
			// 현재 월의 이전월에 해당하는 마지막 날짜(30일)을 구한다.
			Calendar calPre = Calendar.getInstance();
			calPre.set(prevYear, prevMonth, 1);
			int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			// sql에 등록된 dateformat의 비교형식을 맞춰주기위한 날짜변환작업 => 2023-1 -> 2023-01 
			// 해당 '년/월'에 존재하는 일정을 DB에서 가져온다.
			String ym = "";
			if((mm+1) < 10) {
				ym = yy + "-0" + (mm+1);
			}
			else {
				ym = yy + "-" + (mm + 1);
			}
			
			ArrayList<DiseaseVO> vos = livestockService.getDiseaseCheck(ym);
			request.setAttribute("vos", vos);
			
			
			// 다음월의 1일에 해당하는 요일의 숫자값을 구한다.
			Calendar calNext = Calendar.getInstance();
			calNext.set(nextYear, nextMonth, 1);
			int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
			
			// 현재달의 '전월/다음월'의 날짜 표시를 위한 변수...
			request.setAttribute("prevYear", prevYear);
			request.setAttribute("prevMonth", prevMonth);
			request.setAttribute("nextYear", nextYear);
			request.setAttribute("nextMonth", nextMonth);
			request.setAttribute("preLastDay", preLastDay);
			request.setAttribute("nextStartWeek", nextStartWeek);
			
			// 화면에 보여줄 달력의 해당 내역(년/월/요일숫자..) 저장소에 저장하여 넘겨준다.
			request.setAttribute("yy", yy);
			request.setAttribute("mm", mm);
			request.setAttribute("startWeek", startWeek);
			request.setAttribute("lastDay", lastDay);
			
			// 오늘 날짜를 저장소에 담아서 넘겨준다.
			request.setAttribute("toYear", year);
			request.setAttribute("toMonth", month);
			request.setAttribute("toDay", day);
			
		
		return "livestock/disease";
	}
	
	// 질병등록
	@RequestMapping(value = "/disease", method = RequestMethod.POST)
	public String diseasePost(DiseaseVO vo, Model model,
			@RequestParam(name = "cNum", defaultValue = "", required = false) String cNum,
			@RequestParam(name = "dType", defaultValue = "", required = false) String dType,
			@RequestParam(name = "content", defaultValue = "", required = false) String content,
			@RequestParam(name = "dBirth", defaultValue = "", required = false) String dBirth
			) {
		
		int res = livestockService.setDisease(cNum, dType, content, dBirth);
		
		
		
		if (res == 1) return "redirect:/message/diseaseInputOk";
		else return "redirect:/message/diseaseInputNo";
	}
	
	// 질병상세내역
	@RequestMapping(value = "/diseaseDetail", method = RequestMethod.GET)
	public String diseaseDetailGet(Model model,
			@RequestParam(name = "ymd", defaultValue = "", required = false) String ymd
			
			) {
		String[] ymds = ymd.split("-");
		if(ymds[1].length() == 1) ymds[1] = "0" + ymds[1];
		if(ymds[2].length() == 1) ymds[2] = "0" + ymds[2];
		
		ymd = ymds[0] + "-" + ymds[1] + "-" + ymds[2];
		
		ArrayList<DiseaseVO> vos = livestockService.getDisease(ymd);
		
		model.addAttribute("vos", vos);
		model.addAttribute("ymd", ymd);
		model.addAttribute("scheduleCnt", vos.size());
		
		return "livestock/diseaseDetail";
	}
	
	// 질병수정하기
	@ResponseBody
	@RequestMapping(value = "/diseaseUpdateOk", method = RequestMethod.POST)
	public String diseaseUpdateOkPost(DiseaseVO vo) {
		livestockService.setdiseaseUpdateOk(vo);
		return "";
	}
	
	// 질병관리삭제하기
	@ResponseBody
	@RequestMapping(value = "/diseaseDeleteOk", method = RequestMethod.POST)
	public String diseaseDeleteOkPost(int idx) {
		livestockService.setdiseaseDeleteOk(idx);
		return "";
	}
	
	// 출하목록 - get
	@RequestMapping(value = "/livestockShipment", method = RequestMethod.GET)
	public String livestockShipmentGet(RegistrationVO vo, Model model,
			@RequestParam(name="page", defaultValue = "1", required=false) int page,
			@RequestParam(name="pageSize", defaultValue = "20", required=false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(page, pageSize, "livestockShipment", "", "");
		
		List<LivestockShipmentVO> vos = new ArrayList<LivestockShipmentVO>();
		vos = livestockService.getLivestockShipment(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "livestock/livestockShipment";
	}
	
	// 출하등록
	@RequestMapping(value = "/livestockShipment", method = RequestMethod.POST)
	public String livestockShipmentPost(LivestockShipmentVO vo,
			@RequestParam(name = "cNum", defaultValue = "", required = false) String cNum,
			@RequestParam(name = "price", defaultValue = "", required = false) String price,
			@RequestParam(name = "sYear", defaultValue = "", required = false) String sYear
			) {
		
		int res = livestockService.setLivestockShipment(cNum, price, sYear);
		livestockService.setLivestockDelete(cNum);
		
		if(res == 1) return "redirect:/message/shipmentOk";
		else return "redirect:/message/shipmentNo";
	}
	
	// 가축등록 수정
	@ResponseBody
	@RequestMapping(value = "/registrationUpdateOk", method = RequestMethod.POST)
	public String registrationUpdateOkPost(RegistrationVO vo) {
		livestockService.setRegistrationUpdate(vo);
		return "";
	}
	
	// 발정관리 기본 페이지
	@RequestMapping(value = "/estrus", method = RequestMethod.GET)
	public String estrusGet(Model model) {
		List<EstrusVO> vos = livestockService.getEstrus();
		
		model.addAttribute("vos", vos);
		return "livestock/estrus";
	}
	
	// 발정관리 상세내용
	@RequestMapping(value = "/estrusDetail", method = RequestMethod.GET)
	public String estrusDetailGet(Model model, String ymd) {
		List<EstrusVO> vos = livestockService.getEstrusDetail(ymd);
		
		model.addAttribute("vos", vos);
		model.addAttribute("ymd", ymd);
		model.addAttribute("estrusCnt", vos.size());
		
		return "livestock/estrusDetail";
	}
	
	// 발정관리 수정하기
	@ResponseBody
	@RequestMapping(value = "/estrusUpdateOk", method = RequestMethod.POST)
	public String estrusUpdateOkPost(EstrusVO vo) {
		livestockService.setEstrusUpdateOk(vo);
		return "";
	}
	
	// 발정관리 삭제하기
	@ResponseBody
	@RequestMapping(value = "/estrusDeleteOk", method = RequestMethod.POST)
	public String estrusDeleteOk(int idx) {
		livestockService.estrusDeleteOk(idx);
		return "";
	}
	
	// 발정관리 등록
	@RequestMapping(value = "/estrus", method = RequestMethod.POST)
	public String estrusInputPost(EstrusVO vo) {
		System.out.println(vo);
		int res = livestockService.estrusInput(vo);
		
		if(res == 1) return "redirect:/message/estrustInputOk";
		else return "redirect:/message/estrustInputNo";
	}
	
	// 출산관리 :  기본홈
	@RequestMapping(value = "/birth", method = RequestMethod.GET)
	public String birth(Model model,
			@RequestParam(name="page", defaultValue = "1", required=false) int page,
			@RequestParam(name="pageSize", defaultValue = "20", required=false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(page, pageSize, "livestock", "", "");
		
		List<BirthVO> vos = livestockService.getBirth(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "livestock/birth";
	}
	
	// 출산관리 : 출산예정일 등록하기
	@RequestMapping(value = "/birthInput", method = RequestMethod.POST)
	public String birthInput(BirthVO vo,
			@RequestParam(name = "cNum", defaultValue = "", required = false) String cNum
			) {
		
		int res = livestockService.setBirthInput(vo, cNum);
		
		if(res == 1) return "redirect:/message/birthInputOk";
		else return "redirect:/message/birthInputNo";
	}
	
	//출산관리 : 출산예정 삭제하기
	@ResponseBody
	@RequestMapping(value = "/birthDelete", method = RequestMethod.POST)
	public String birthDelete(int idx) {
		livestockService.setBirthDelete(idx);
		return "";
	}
}
