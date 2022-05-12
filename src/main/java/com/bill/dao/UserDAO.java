package com.bill.dao;

import com.bill.vo.UserVO;


public interface UserDAO {
	
	public String loginCheck(UserVO vo);
	
	public int idCheck(String userId) throws Exception;

	public void register(UserVO uservo) throws Exception;


}
