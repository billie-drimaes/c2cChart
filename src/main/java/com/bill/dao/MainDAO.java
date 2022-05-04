package com.bill.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bill.vo.MainVO;

// 계정 페이지 DAO
@Repository("accountDAO")
public interface MainDAO {
	
	// 관리자 리스트, count 
	public int selectTotalCnt(Map<String, Object> param) throws Exception;
	public List<MainVO> selectList(Map<String, Object> param) throws Exception;

}
