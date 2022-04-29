package com.bill.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bill.vo.AccountVO;

// 계정 페이지 DAO
@Repository("accountDAO")
public interface AccountDAO {
	
	// 관리자 리스트, count 
	public int selectAdminTotalCnt(Map<String, Object> param) throws Exception;
	public List<AccountVO> selectAdminList(Map<String, Object> param) throws Exception;

	// 운전자 리스트, count	
	public int selectDriverTotalCnt(Map<String, Object> param) throws Exception;
	public List<AccountVO> selectDriverList(Map<String, Object> param) throws Exception;

	// 차량 리스트, count
	public int selectCarTotalCnt(Map<String, Object> param) throws Exception;
	public List<AccountVO> selectCarList(Map<String, Object> param) throws Exception;
}
