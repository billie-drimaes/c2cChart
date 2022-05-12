package com.bill.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bill.dao.CarsDAO;
import com.bill.vo.CarLogVO;
import com.bill.vo.CarMainVO;
import com.bill.vo.CarsMainVO;

@Service
public class CarsServiceImpl implements CarsService {

	@Inject
	private CarsDAO dao;

	@Override
	public List<CarsMainVO> selectCars(Map<String, Object> param) throws Exception {

		return dao.selectCars(param);
	}
	


	
}
