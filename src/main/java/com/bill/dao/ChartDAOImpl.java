package com.bill.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bill.vo.ChartVO;

@Repository
public class ChartDAOImpl implements ChartDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String Namespace = "com.bill.mapper.ChartMapper";
	
	@Override
	public List<ChartVO> getRpm() throws Exception{
		return sqlSession.selectList(Namespace+".getRpm");
	}
	
	@Override
	public List<ChartVO> getSpeedWithPeriod() throws Exception{
		return sqlSession.selectList(Namespace+".getSpeedWithPeriod");
	}

}
