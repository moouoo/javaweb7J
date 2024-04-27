package com.spring.javaweb7S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb7S.vo.ChatVO;
import com.spring.javaweb7S.vo.LoginVO;

public interface LoginDAO {

	public LoginVO getLoginCheck(@Param("mid") String mid);

	public List<LoginVO> getMember2();

	public LoginVO getMidCheck(@Param("mid") String mid);

	public int setloginInput(@Param("vo") LoginVO vo);

	public void setlognDelete(@Param("idx") int idx);

	public void setChatMessageInput(@Param("vo") ChatVO vo);

	public List<ChatVO> getChatMessage();


	
}
