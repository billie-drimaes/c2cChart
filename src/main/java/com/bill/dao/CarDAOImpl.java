package com.bill.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bill.vo.CarLogVO;
import com.bill.vo.CarMainVO;

@Repository
public class CarDAOImpl implements CarDAO{
    
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.bill.mapper.CarMapper";

	@Override
	public List<CarMainVO> selectCar() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace+".selectCar");
	}

	@Override
	public List<CarMainVO> selectTrip() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace+".selectTrip");
	}
	
	
	@Override
	public List<CarMainVO> selectTrip(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("param==> " + param);
		return sqlSession.selectList(Namespace+".selectCarTrip");
	}

	@Override
	public List<CarLogVO> selectLog() throws Exception {
		return sqlSession.selectList(Namespace+".selectLog");
	}

    
}
