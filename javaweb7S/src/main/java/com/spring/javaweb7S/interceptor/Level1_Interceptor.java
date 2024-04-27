package com.spring.javaweb7S.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level1_Interceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 0 : (int) session.getAttribute("sLevel");
		
		// 비회원 로그인창으로 보내준다.
		if(level < 1) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/memberNo");
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}

}
