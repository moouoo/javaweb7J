package com.spring.javaweb7S;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb7S.service.LoginService;
import com.spring.javaweb7S.vo.LoginVO;


@Controller
public class HomeController {

	@Autowired
	LoginService loginservice;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = ("/"), method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = ("/"), method = RequestMethod.POST)
	public String homePost(Model model, HttpSession session, LoginVO vo,
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			@RequestParam(name="pwd", defaultValue = "", required=false) String pwd
			) {
		
		vo = loginservice.getLoginCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			String strLevel = "";
			if(vo.getLevel() == 1) strLevel = "관리자";
			else if(vo.getLevel() == 2) strLevel = "농장주";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			return "redirect:/message/loginOk";
		}
		else return "redirect:/message/loginNo";
	}
	
}
