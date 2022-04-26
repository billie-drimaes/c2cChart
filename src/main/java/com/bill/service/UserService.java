package com.bill.service;

import com.bill.vo.UserVO;

import javax.servlet.http.HttpSession;

public interface UserService {
	 public String loginCheck(UserVO vo, HttpSession session);
}
