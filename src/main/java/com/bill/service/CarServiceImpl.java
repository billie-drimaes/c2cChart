package com.bill.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bill.dao.CarDAO;
import com.bill.vo.CarLogVO;
import com.bill.vo.CarMainVO;

@Service
public class CarServiceImpl implements CarService {

	@Inject
	private CarDAO dao;
	
	@Override
	public List<CarMainVO> selectCar() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectCar();
	}

	@Override
	public List<CarMainVO> selectTrip() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectTrip();
	}
	
	@Override
	public List<CarMainVO> selectTrip(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("param==> " + param);
		return dao.selectTrip(param);
	}

	@Override
	public List<CarLogVO> selectLog() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectLog();
	}



	
}
