package com.spring.javaweb7S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.javaweb7S.dao.LoginDAO;
import com.spring.javaweb7S.vo.ChatVO;
import com.spring.javaweb7S.vo.LoginVO;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	LoginDAO logindao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Override
	public LoginVO getLoginCheck(String mid) {
		return logindao.getLoginCheck(mid);
	}

	@Override
	public List<LoginVO> getMember2() {
		return logindao.getMember2();
	}

	@Override
	public LoginVO getMidCheck(String mid) {
		return logindao.getMidCheck(mid);
	}

	@Override
	public int setloginInput(LoginVO vo) {
		return logindao.setloginInput(vo);
	}

	@Override
	public void setlognDelete(int idx) {
		logindao.setlognDelete(idx);
	}

	@Override
	public void setChatMessageInput(ChatVO vo) {
		logindao.setChatMessageInput(vo);
	}

	@Override
	public List<ChatVO> getChatMessage() {
		return logindao.getChatMessage();
	}

}
