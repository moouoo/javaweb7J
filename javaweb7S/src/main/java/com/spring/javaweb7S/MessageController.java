package com.spring.javaweb7S;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String listGet(@PathVariable String msgFlag, HttpSession session,
			Model model) {
		String strLevel = (String) session.getAttribute("strLevel");
		
		if(msgFlag.equals("loginOk")) {
			model.addAttribute("msg", strLevel +" 님 환영합니다!!");
			model.addAttribute("url", "/etc/etc");
		}
		else if(msgFlag.equals("loginNo")) {
			model.addAttribute("msg", "등록된 관리자계정이 없습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("livestockInputOk")) {
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/livestock/registrationList");
		}
		else if(msgFlag.equals("livestockInputNo")) {
			model.addAttribute("msg", "등록된 개체번호가 존재합니다. \\n개체번호를 다시 확인해주세요.");
			model.addAttribute("url", "/livestock/registrationList");
		}
		else if(msgFlag.equals("diseaseInputOk")) {
			model.addAttribute("msg", "등록 되었습니다.");
			model.addAttribute("url", "/livestock/disease");
		}
		else if(msgFlag.equals("diseaseInputNo")) {
			model.addAttribute("msg", "등록되어 있는 개체번호가 존재하지 않습니다.");
			model.addAttribute("url", "/livestock/disease");
		}
		else if(msgFlag.equals("shipmentOk")) {
			model.addAttribute("msg", "등록 되었습니다.");
			model.addAttribute("url", "/livestock/livestockShipment");
		}
		else if(msgFlag.equals("shipmentNo")) {
			model.addAttribute("msg", "등록되어 있는 개체번호가 존재하지 않습니다.");
			model.addAttribute("url", "/livestock/livestockShipment");
		}
		else if(msgFlag.equals("memberInputOk")) {
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/asset/memberList");
		}
		else if(msgFlag.equals("memberInputNo")) {
			model.addAttribute("msg", "등록실패.");
			model.addAttribute("url", "/asset/memberList");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "수정되었습니다");
			model.addAttribute("url", "/asset/memberList");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "등록실패");
			model.addAttribute("url", "/asset/memberList");
		}
		else if(msgFlag.equals("estrustInputOk")) {
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/livestock/estrus");
		}
		else if(msgFlag.equals("estrustInputNo")) {
			model.addAttribute("msg", "존재하지않는 개체번호입니다.\\n다시 확인해주세요.");
			model.addAttribute("url", "/livestock/estrus");
		}
		else if(msgFlag.equals("medicineInputOk")) {
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/asset/medicine");
		}
		else if(msgFlag.equals("medicineInputNo")) {
			model.addAttribute("msg", "등록에 실패하였습니다.");
			model.addAttribute("url", "/asset/medicine");
		}
		else if(msgFlag.equals("medicineRestockOk")) {
			model.addAttribute("msg", "재입고 되었습니다.");
			model.addAttribute("url", "/asset/medicine");
		}
		else if(msgFlag.equals("medicineRestockNo")) {
			model.addAttribute("msg", "재입고 실패.");
			model.addAttribute("url", "/asset/medicine");
		}
		else if(msgFlag.equals("feedInputOk")) {
			model.addAttribute("msg", "동이 추가되었습니다.");
			model.addAttribute("url", "/asset/feed");
		}
		else if(msgFlag.equals("feedInputNo")) {
			model.addAttribute("msg", "동 추가 실패.");
			model.addAttribute("url", "/asset/feed");
		}
		else if(msgFlag.equals("feedUpdateOk")) {
			model.addAttribute("msg", "수정되었습니다");
			model.addAttribute("url", "/asset/feed");
		}
		else if(msgFlag.equals("feedOlderOk")) {
			model.addAttribute("msg", "기록되었습니다.");
			model.addAttribute("url", "/asset/feed");
		}
		else if(msgFlag.equals("semenInputOk")) {
			model.addAttribute("msg", "등록 되었습니다. \\n만약 등록이 되지 않았다면 정액번호가 정확한지 확인해주세요");
			model.addAttribute("url", "/asset/semen");
		}
		else if(msgFlag.equals("semenRestockOk")) {
			model.addAttribute("msg", "재입고 되었습니다.");
			model.addAttribute("url", "/asset/semen");
		}
		else if(msgFlag.equals("birthInputOk")) {
			model.addAttribute("msg", "등록되었습니다.");
			model.addAttribute("url", "/livestock/birth");
		}
		else if(msgFlag.equals("birthInputNo")) {
			model.addAttribute("msg", "등록되어있는 개체번호가 존재하지 않습니다.");
			model.addAttribute("url", "/livestock/birth");
		}
		else if(msgFlag.equals("loginInputOk")) {
			model.addAttribute("msg", "계정이 추가되었습니다.");
			model.addAttribute("url", "/etc/loginM");
		}
		else if(msgFlag.equals("facilityInputOk")) {
			model.addAttribute("msg", "시설(장비)가 기록되었습니다.");
			model.addAttribute("url", "/asset/facility");
		}
		else if(msgFlag.equals("logout")) {
			model.addAttribute("msg", "로그아웃되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인 후 이용해주세요");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "해당 페이지에 접근할수있는 권한이 없습니다.");
			model.addAttribute("url", "/etc/etc");
		}
		
		
		
		
		return "include/message";
	}
	
	
}
