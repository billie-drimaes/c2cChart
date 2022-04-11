package com.bill.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.bill.vo.CarLogVO;
import com.bill.vo.CarMainVO;

public interface CarService {
	
	public List<CarMainVO> selectCar() throws Exception;
	
	public List<CarMainVO> selectTrip() throws Exception;
	
	public List<CarMainVO> selectTrip(Map<String, Object> param) throws Exception;
	
	public List<CarLogVO> selectLog() throws Exception;
}
