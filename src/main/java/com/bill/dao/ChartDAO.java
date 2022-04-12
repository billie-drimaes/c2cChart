package com.bill.dao;

import java.util.List;

import com.bill.vo.ChartVO;

public interface ChartDAO {
	
    public List<ChartVO> getRpm() throws Exception;
    public List<ChartVO> getSpeedWithPeriod() throws Exception;

}
