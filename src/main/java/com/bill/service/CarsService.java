package com.bill.service;

import java.util.List;
import java.util.Map;
import com.bill.vo.CarsMainVO;

public interface CarsService {
	
	public List<CarsMainVO> selectCars(Map<String, Object> param) throws Exception;
	
}
