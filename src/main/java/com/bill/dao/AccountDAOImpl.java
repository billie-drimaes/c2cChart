package com.bill.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bill.vo.AccountVO;

@Repository
public class AccountDAOImpl implements AccountDAO{
    
	@Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.bill.mapper.AccountMapper";

	@Override
	public int selectAdminTotalCnt(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".selectAdminTotalCnt", param);
	}

	@Override
	public List<AccountVO> selectAdminList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace + ".selectAdminList", param);
	}

	@Override
	public int selectDriverTotalCnt(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".selectDriverTotalCnt", param);
	}

	@Override
	public List<AccountVO> selectDriverList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace + ".selectDriverList", param);
	}

	@Override
	public int selectCarTotalCnt(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(Namespace + ".selectCarTotalCnt", param);
	}

	@Override
	public List<AccountVO> selectCarList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace + ".selectCarList", param);
	}

    
}
