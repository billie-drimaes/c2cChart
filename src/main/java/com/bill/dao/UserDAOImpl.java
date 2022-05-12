package com.bill.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bill.vo.UserVO; 

@Repository // 현재 클래스를 dao bean으로 등록 
public class UserDAOImpl implements UserDAO {
	
	@Inject
	SqlSession sqlSession; // SqlSession 의존관계 주입
	
	private static final String Namespace = "com.bill.mapper.UserMapper";
	
	@Override
	public String loginCheck(UserVO vo) {
		return sqlSession.selectOne(Namespace+".login_check", vo);
	}
	@Override
	public int idCheck(String userId) throws Exception{
		return sqlSession.selectOne(Namespace+".idCheck", userId);
	}
	
	@Override
	public void register(UserVO uservo) throws Exception{
		sqlSession.insert(Namespace+".user_register", uservo);
	}

}
