package com.bill.service;

import java.util.List;
import java.util.Map;

import com.bill.vo.AccountVO;

public interface AccountService {
	
	
	// 계정 페이지 - 관리자 리스트 총 count 
	public int selectAdminTotalCnt(Map<String, Object> param) throws Exception;
	// 계정 페이지 - 관리자 리스트
	public List<AccountVO> selectAdminList(Map<String, Object> param) throws Exception;
	
	// 계정 페이지 - 운전자 리스트 총 count
	public int selectDriverTotalCnt(Map<String, Object> param) throws Exception;
	// 계정 페이지 - 운전자리스트
	public List<AccountVO> selectDriverList(Map<String, Object> param) throws Exception;
		
	// 계정 페이지 - 차량 리스트 총 count
	public int selectCarTotalCnt(Map<String, Object> param) throws Exception;
	// 계정 페이지 - 차량 리스트
	public List<AccountVO> selectCarList(Map<String, Object> param) throws Exception;
	
}
