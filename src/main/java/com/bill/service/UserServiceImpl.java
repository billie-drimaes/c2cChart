package com.bill.service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.bill.vo.UserVO;
import com.bill.dao.UserDAO;

@Service // service bean으로 등록
public class UserServiceImpl implements UserService{
	
	@Inject
	UserDAO userDao;
	
	@Override
	public String loginCheck(UserVO vo, HttpSession session) {
		String name = userDao.loginCheck(vo);
		 if (name != null) { // 세션 변수 저장
			 session.setAttribute("userid", vo.getUserId());
			 session.setAttribute("name", name);
		}
		 return name; 
	}
	

}
