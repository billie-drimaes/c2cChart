package com.bill.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bill.vo.CarLogVO;
import com.bill.vo.CarMainVO;

@Repository("carDAO")
public interface CarDAO {

	public List<CarMainVO> selectCar() throws Exception;
	  
	public List<CarMainVO> selectTrip() throws Exception;
	
	public List<CarMainVO> selectTrip(Map<String, Object> param) throws Exception;
	
	public List<CarLogVO> selectLog() throws Exception;
	
}
