package com.bill.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bill.vo.CarMainVO;

public interface CarService {
	
	public List<CarMainVO> selectCar() throws Exception;
	
	public List<CarMainVO> selectTrip() throws Exception;
}
