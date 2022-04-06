package com.bill.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("carDAO")
public class CarDAO {
	  @Autowired
	  private SqlSession sqlSession;
	  private String Namespace = "com.bill.mappers.carMapper";
	         
	/*
	 * public List<UserVO> selectUser() throws Exception { return
	 * sqlSession.selectList(Namespace+".selectUser"); }
	 */


}
