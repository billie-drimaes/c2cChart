package com.bill.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bill.dao.AccountDAO;
import com.bill.vo.AccountVO;

@Service
public class AccountServiceImpl implements AccountService {

	@Inject
	private AccountDAO dao;

	@Override
	public int selectAdminTotalCnt(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectAdminTotalCnt(param);
	}

	@Override
	public List<AccountVO> selectAdminList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectAdminList(param);
	}

	@Override
	public int selectDriverTotalCnt(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectDriverTotalCnt(param);
	}
	
	@Override
	public List<AccountVO> selectDriverList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectDriverList(param);
	}

	@Override
	public int selectCarTotalCnt(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectCarTotalCnt(param);
	}


	@Override
	public List<AccountVO> selectCarList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectCarList(param);
	}


}
