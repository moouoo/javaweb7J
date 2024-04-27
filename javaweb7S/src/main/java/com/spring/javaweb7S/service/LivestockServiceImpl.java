package com.spring.javaweb7S.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaweb7S.dao.LivestockDAO;
import com.spring.javaweb7S.vo.BirthVO;
import com.spring.javaweb7S.vo.DiseaseVO;
import com.spring.javaweb7S.vo.EstrusVO;
import com.spring.javaweb7S.vo.LivestockShipmentVO;
import com.spring.javaweb7S.vo.RegistrationPlusVO;
import com.spring.javaweb7S.vo.RegistrationVO;

@Service
public class LivestockServiceImpl implements LivestockService {

	@Autowired
	LivestockDAO livestockdao;

	@Override
	public List<RegistrationVO> getLivestock(int startIndexNo, int pageSize) {
		return livestockdao.getLivestock(startIndexNo, pageSize);
	}

	@Override
	public int setLivestock(String cNum, String birthday, String etc, String gender, int price) {
		return livestockdao.setLivestock(cNum, birthday, etc, gender, price);
	}

	@Override
	public List<RegistrationVO> getListSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return livestockdao.getListSearch(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public int setDisease(String cNum, String dType, String content, String dBirth) {
		return livestockdao.setDisease(cNum, dType, content, dBirth);
	}

	@Override
	public ArrayList<DiseaseVO> getDisease(String ymd) {
		return livestockdao.getDisease(ymd);
	}

	@Override
	public int setLivestockShipment(String cNum, String price, String sYear) {
		return livestockdao.setLivestockShipment(cNum, price, sYear);
	}

	@Override
	public void setLivestockDelete(String cNum) {
		livestockdao.setLivestockDelete(cNum);
	}

	@Override
	public List<LivestockShipmentVO> getLivestockShipment(int startIndexNo, int pageSize) {
		return livestockdao.getLivestockShipment(startIndexNo, pageSize);
	}

	@Override
	public void setdiseaseUpdateOk(DiseaseVO vo) {
		livestockdao.setdiseaseUpdateOk(vo);
	}

	@Override
	public void setdiseaseDeleteOk(int idx) {
		livestockdao.setdiseaseDeleteOk(idx);
	}

	@Override
	public ArrayList<DiseaseVO> getDiseaseCheck(String ym) {
		return livestockdao.getDiseaseCheck(ym);
	}

	@Override
	public void setRegistrationUpdate(RegistrationVO vo) {
		livestockdao.setRegistrationUpdate(vo);
	}

	@Override
	public void setRegistrationDelete(int idx) {
		livestockdao.setRegistrationDelete(idx);
	}

	@Override
	public List<EstrusVO> getEstrus() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	      
	    // 오늘 날짜 저장시켜둔다.(calToday변수, 년(toYear), 월(toMonth), 일(toDay))
	    Calendar calToday = Calendar.getInstance();
	    int toYear = calToday.get(Calendar.YEAR);
	    int toMonth = calToday.get(Calendar.MONTH);
	    int toDay = calToday.get(Calendar.DATE);
	            
	    // 화면에 보여줄 해당 '년(yy)/월(mm)'을 셋팅하는 부분(처음에는 오늘 년도와 월을 가져오지만, '이전/다음'버튼 클릭하면 해당 년과 월을 가져오도록 한다.
	    Calendar calView = Calendar.getInstance();
	    int yy = request.getParameter("yy")==null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
	    int mm = request.getParameter("mm")==null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
	     
	    if(mm < 0) { // 1월에서 전월 버튼을 클릭시에 실행
	       yy--;
	       mm = 11;
	    }
	    if(mm > 11) { // 12월에서 다음월 버튼을 클릭시에 실행
	       yy++;
	       mm = 0;
	    }
	    calView.set(yy, mm, 1);      // 현재 '년/월'의 1일을 달력의 날짜로 셋팅한다.
	     
	    int startWeek = calView.get(Calendar.DAY_OF_WEEK);                    // 해당 '년/월'의 1일에 해당하는 요일값을 숫자로 가져온다.
	    int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);  // 해당월의 마지막일자(getActualMaxximum메소드사용)를 구한다.
	     
	    // 화면에 보여줄 년월기준 전년도/다음년도를 구하기 위한 부분
	    int prevYear = yy;           // 전년도
	    int prevMonth = (mm) - 1; // 이전월
	    int nextYear = yy;           // 다음년도
	    int nextMonth = (mm) + 1; // 다음월
	    
	    if(prevMonth == -1) {  // 1월에서 전월 버튼을 클릭시에 실행..
	       prevYear--;
	       prevMonth = 11;
	    }
	    
	    if(nextMonth == 12) {  // 12월에서 다음월 버튼을 클릭시에 실행..
	       nextYear++;
	       nextMonth = 0;
	    }
	    
	    // 현재달력에서 앞쪽의 빈공간은 '이전달력'을 보여주고, 뒷쪽의 남은공간은 '다음달력'을 보여주기위한 처리부분(아래 6줄)
	    Calendar calPre = Calendar.getInstance(); // 이전달력
	    calPre.set(prevYear, prevMonth, 1);           // 이전 달력 셋팅
	    int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);  // 해당월의 마지막일자를 구한다.
	    
	    Calendar calNext = Calendar.getInstance();// 다음달력
	    calNext.set(nextYear, nextMonth, 1);        // 다음 달력 셋팅
	    int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);  // 다음달의 1일에 해당하는 요일값을 가져온다.
	    
	    // sql에 등록된 dataformat의 비교형식을 맞춰주기위한 날짜형식변환작업
	    // 해당 년월의 형식 변환?  2023-1 ===>>  2023-01
	    String ym = "";
	    int intMM = mm + 1;
	    if(intMM >= 1 && intMM <= 9) ym = yy + "-0" + (mm + 1);
	    else ym = yy + "-" + (mm + 1);
	    
	    // 스케줄에 등록되어 있는 일정들을 가져오기
	    List<EstrusVO> vos = livestockdao.getEstrusList(ym);
	    request.setAttribute("vos", vos);
	    
	    /* ---------  아래는  앞에서 처리된 값들을 모두 request객체에 담는다.  -----------------  */
	    
	    // 오늘기준 달력...
	    request.setAttribute("toYear", toYear);
	    request.setAttribute("toMonth", toMonth);
	    request.setAttribute("toDay", toDay);
	    
	    // 화면에 보여줄 해당 달력...
	    request.setAttribute("yy", yy);
	    request.setAttribute("mm", mm);
	    request.setAttribute("startWeek", startWeek);
	    request.setAttribute("lastDay", lastDay);
	    
	    // 화면에 보여줄 해당 달력 기준의 전년도, 전월, 다음년도, 다음월 ...
	    request.setAttribute("prevYear", prevYear);
	    request.setAttribute("prevMonth", prevMonth);
	    request.setAttribute("nextYear", nextYear);
	    request.setAttribute("nextMonth", nextMonth);
      
	    // 현재 달력의 '앞/뒤' 빈공간을 채울, 이전달의 뒷부분과 다음달의 앞부분을 보여주기위해 넘겨주는 변수
	    request.setAttribute("preLastDay", preLastDay);            // 이전달의 마지막일자를 기억하고 있는 변수
	    request.setAttribute("nextStartWeek", nextStartWeek);   // 다음달의 1일에 해당하는 요일을 기억하고있는 변수
	    
	    return livestockdao.getEstrus();
		  
	}

	@Override
	public List<EstrusVO> getEstrusDetail(String ymd) {
		String mm = "", dd = "";
		String[] ymdArr = ymd.split("-");
		
		if(ymd.length() != 10) {
			if(ymdArr[1].length() == 1) mm = "0" + ymdArr[1];
			else mm = ymdArr[1];
			if(ymdArr[2].length() == 1) dd = "0" + ymdArr[2];
			else dd = ymdArr[2];
			ymd = ymdArr[0] + "-" + mm + "-" + dd;
		}
		return livestockdao.getEstrusDetail(ymd);
	}

	@Override
	public void setEstrusUpdateOk(EstrusVO vo) {
		livestockdao.setEstrusUpdateOk(vo);
	}

	@Override
	public void estrusDeleteOk(int idx) {
		livestockdao.estrusDeleteOk(idx);
	}

	@Override
	public int estrusInput(EstrusVO vo) {
		return livestockdao.estrusInput(vo);
	}

	@Override
	public List<BirthVO> getBirth(int startIndexNo, int pageSize) {
		return livestockdao.getBirth(startIndexNo, pageSize);
	}

	@Override
	public int setBirthInput(BirthVO vo, String cNum) {
		return livestockdao.setBirthInput(vo, cNum);
	}

	@Override
	public void setBirthDelete(int idx) {
		livestockdao.setBirthDelete(idx);
	}

	@Override
	public void setRegistrationPlus(RegistrationPlusVO vo2) {
		livestockdao.setRegistrationPlus(vo2);
	}

	@Override
	public RegistrationVO setRegistrationCNumCheck(RegistrationVO vo) {
		return livestockdao.setRegistrationCNumCheck(vo);
	}

	


	
}
