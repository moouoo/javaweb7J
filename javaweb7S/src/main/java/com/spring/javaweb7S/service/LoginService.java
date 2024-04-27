package com.spring.javaweb7S.service;

import java.util.List;

import com.spring.javaweb7S.vo.ChatVO;
import com.spring.javaweb7S.vo.LoginVO;

public interface LoginService {

	public LoginVO getLoginCheck(String mid);

	public List<LoginVO> getMember2();

	public LoginVO getMidCheck(String mid);

	public int setloginInput(LoginVO vo);

	public void setlognDelete(int idx);

	public void setChatMessageInput(ChatVO vo);

	public List<ChatVO> getChatMessage();


	
}
