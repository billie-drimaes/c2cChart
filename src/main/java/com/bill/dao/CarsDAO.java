package com.bill.dao;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.bill.vo.CarsMainVO;

@Repository("carsDAO")
public interface CarsDAO {

	public List<CarsMainVO> selectCars(Map<String, Object> param) throws Exception;
	  
}
