package com.spring.javaweb7S.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level2_Interceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 0 : (int) session.getAttribute("sLevel");
		
		// 농장주가 아니면 로그인창으로 보내준다.
		if(level != 2) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/adminNo");
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}

}
