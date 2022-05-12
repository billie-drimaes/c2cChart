package com.bill.dao;

import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.bill.vo.CarsMainVO;

@Repository
public class CarsDAOImpl implements CarsDAO{
    
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.bill.mapper.CarsMapper";

	@Override
	public List<CarsMainVO> selectCars(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("param==> " + param);
		return sqlSession.selectList(Namespace+".selectCars", param);
	}
    
}
