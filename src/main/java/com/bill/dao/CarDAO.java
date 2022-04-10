package com.bill.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bill.vo.CarMainVO;

@Repository("carDAO")
public interface CarDAO {

	public List<CarMainVO> selectCar() throws Exception;
	  
	public List<CarMainVO> selectTrip() throws Exception;

}
