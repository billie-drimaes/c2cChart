package com.bill.service;

import java.util.List;
import java.util.Map;

import com.bill.vo.MainVO;


public interface MainService {
	
	
	// 메인 페이지 - 리스트 총 count 
	public int selectTotalCnt(Map<String, Object> param) throws Exception;
	// 메인 페이지 - 리스트
	public List<MainVO> selectList(Map<String, Object> param) throws Exception;
	
	
}
