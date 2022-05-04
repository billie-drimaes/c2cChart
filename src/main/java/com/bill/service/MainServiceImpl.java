package com.bill.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bill.dao.MainDAO;
import com.bill.vo.MainVO;


@Service
public class MainServiceImpl implements MainService {

	@Inject
	private MainDAO dao;

	@Override
	public int selectTotalCnt(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectTotalCnt(param);
	}

	@Override
	public List<MainVO> selectList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectList(param);
	}


}
