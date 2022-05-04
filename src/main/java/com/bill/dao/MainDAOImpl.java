package com.bill.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bill.vo.MainVO;

@Repository
public class MainDAOImpl implements MainDAO{
    
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.bill.mapper.MainMapper";

	@Override
	public int selectTotalCnt(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".selectTotalCnt", param);
	}

	@Override
	public List<MainVO> selectList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace + ".selectList", param);
	}

    
}
