package com.spring.javaweb7S;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb7S.service.LoginService;
import com.spring.javaweb7S.vo.ChatVO;
import com.spring.javaweb7S.vo.LoginVO;

@Controller
@RequestMapping("/etc")
public class EtcController {
	
	@Autowired
	LoginService loginservice;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/etc", method = RequestMethod.GET)
	public String etcGet(Model model, HttpSession session, HttpServletRequest request) throws Exception {
		String temp = Temp();
		
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(temp);
		// Top레벨 단계인 response 키를 가지고 데이터를 파싱합니다.
		JSONObject parse_response = (JSONObject) obj.get("response");
		// response 로 부터 body 찾아옵니다.
		JSONObject parse_body = (JSONObject) parse_response.get("body");
		// body 로 부터 items 받아옵니다.
		JSONObject parse_items = (JSONObject) parse_body.get("items");
		
		// items로 부터 itemlist 를 받아오기 itemlist : 뒤에 [ 로 시작하므로 jsonarray이다
		JSONArray parse_item = (JSONArray) parse_items.get("item");
		
	//	String category = "";
	//	String fcstTime = "";
	//	String fcstValue = "";
	//	String fcstDate = "";
		
		JSONObject weather; // parse_item은 배열형태이기 때문에 하나씩 데이터를 하나씩 가져올때 사용합니다.
		List<JSONObject> Weatherlist = new ArrayList<>();
		
		// 필요한 데이터만 가져오려고합니다.
	//	System.out.println("size+++++++++++++++++++"+parse_item.size());
		for(int i = 0 ; i < parse_item.size(); i++)
		{
			weather = (JSONObject) parse_item.get(i);
			Weatherlist.add(weather);
			
	//		cateArr[i]=weather.get("category").toString();
	//		timeArr[i]=weather.get("fcstTime").toString();
	//		valArr[i]=weather.get("fcstValue").toString();
	//		dateArr[i]=weather.get("fcstDate").toString();
	//		category = (String)weather.get("category");
	//		fcstDate = (String)weather.get("fcstDate");
	//		fcstTime = (String)weather.get("fcstTime");
	//		fcstValue  = (String)weather.get("fcstValue");
	
		}
		
		
		model.addAttribute("list", Weatherlist);
	
		
	//	 System.out.println("obj============="+obj);
	//	 System.out.println("parse_item============="+parse_item);
		
		
			
		return "etc/etc";
	}
		
	
	public String Temp() throws IOException {
		// 오늘날짜
		LocalDate today = LocalDate.now();
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String formattedDate = today.format(dateFormatter);
//		System.out.println(formattedDate);
		
		// 특정시간
//		LocalTime currentTime = LocalTime.now();
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HHmm");
//		String formattedTime = currentTime.format(formatter);
//		System.out.println(formattedTime);
		
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=mYm1Ygwy1SOXt3%2BYDJN559xHsElwPqijtENi5JNheDnCuoe0254nzPE1JRYk3CQTCRjaWmevsWk34v%2F6JWtG7w%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("288", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(formattedDate, "UTF-8")); /*‘오늘날짜'발표*/
        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("0200", "UTF-8")); /*11시 발표*/
        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode("68", "UTF-8")); /*예보지점의 X 좌표값*/
        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode("107", "UTF-8")); /*예보지점의 Y 좌표값*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
//        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
//        System.out.println(sb.toString());
    
	    return sb.toString();
	    }
		
	
	// 아이디관리 : 기본 폼
	@RequestMapping(value = "/loginM", method = RequestMethod.GET)
	public String loginM(Model model) {
		List<LoginVO> vos = loginservice.getMember2();
		
		model.addAttribute("vos", vos);
		
		return "etc/loginM";
	}
	
	// 아이디관리 : 아이디중복확인
	@ResponseBody
	@RequestMapping(value = "/midCheck", method = RequestMethod.POST)
	public String midCheck(String mid, LoginVO vo) {
		
		vo = loginservice.getMidCheck(mid);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	// 아이디관리 : 아이디추가
	@RequestMapping(value = "/memberInput", method = RequestMethod.POST)
	public String memberInput(LoginVO vo, String pwd) {
		
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(pwd));
		
		int res = loginservice.setloginInput(vo);
		
		if(res == 1) return "redirect:/message/loginInputOk";
		else return "redirect:/message/loginInputNo";
	}
	
	// 	아이디관리 : 삭제
	@ResponseBody
	@RequestMapping(value = "/loginDelete", method = RequestMethod.POST)
	public String loginDelete(int idx) {
		loginservice.setlognDelete(idx);
		return "";
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/message/logout";
	}
	
	// 특이사항기록
	@ResponseBody
	@RequestMapping(value = "/chatMessage", method = RequestMethod.POST)
	public String chatMessage(ChatVO vo, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("strLevel");
		
		vo.setMid(mid);
		
		loginservice.setChatMessageInput(vo);
		
		return "";
	}
	
	// 특이사항 기록 창
	@RequestMapping(value = "/chatMessage", method = RequestMethod.GET)
	public String chatMessage(Model model) {
		List<ChatVO> vos = loginservice.getChatMessage();
		model.addAttribute("vos", vos);
		return "etc/chatMessage";
	}
	
	// 연습
	@RequestMapping(value = "/aaa", method = RequestMethod.GET)
	public String aaa() {
		return "etc/aaa";
	}
}
