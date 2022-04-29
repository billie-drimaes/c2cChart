package com.bill.controller;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bill.service.AccountService;
import com.bill.util.PagingUtil;
import com.bill.vo.AccountVO;

@Controller
@RequestMapping( value = "/account" )
public class AccountController {

	@Autowired
	public AccountService accountService;
	
	@GetMapping(value="")
    public String home(HttpServletRequest request, ModelMap modelMap, @RequestParam Map<String, Object> param ) throws Exception{
    	
    	InetAddress ip = InetAddress.getLocalHost(); 
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

    	int adminTotalCnt= accountService.selectAdminTotalCnt(param);
    	int driverTotalCnt = accountService.selectDriverTotalCnt(param);
    	int carTotalCnt = accountService.selectCarTotalCnt(param);
    	
    	int curPage = MapUtils.getIntValue(param, "page", 1);
    	param.put("page", curPage);
    	/* 페이징 계산 */
		int offset = (curPage - 1) * 5;
		param.put("offset", offset);
		
		System.out.println("curPage==>" + curPage);
		System.out.println("offset==>" + offset);
		
		List<AccountVO> adminList = accountService.selectAdminList(param);
		PagingUtil adminPagingUtil = new PagingUtil(adminTotalCnt, curPage);
		
		List<AccountVO> driverList = accountService.selectDriverList(param);
    	PagingUtil driverPagingUtil = new PagingUtil(driverTotalCnt, curPage);
    	
		List<AccountVO> carList = accountService.selectCarList(param);
    	PagingUtil carPagingUtil = new PagingUtil(carTotalCnt, curPage);
    	    	
		modelMap.addAttribute("adminTotalCnt", adminTotalCnt);
    	modelMap.addAttribute("adminList", adminList);
    	modelMap.addAttribute("adminPagingUtil", adminPagingUtil);
    	
    	modelMap.addAttribute("driverTotalCnt", driverTotalCnt);
    	modelMap.addAttribute("driverList", driverList);
    	modelMap.addAttribute("driverPagingUtil", driverPagingUtil);

    	modelMap.addAttribute("carTotalCnt", carTotalCnt);
    	modelMap.addAttribute("carList", carList);
    	modelMap.addAttribute("carPagingUtil", carPagingUtil);
    	
    	System.out.println("adminTotalCnt===>" + adminTotalCnt);
    	System.out.println("adminList===>" + adminList);
    	System.out.println("adminPagingUtil===>" + adminPagingUtil);
    	
    	System.out.println("driverTotalCnt===>" + driverTotalCnt);
    	System.out.println("driverList===>" + driverList);
    	System.out.println("driverPagingUtil===>" + driverPagingUtil);
    	
    	System.out.println("carTotalCnt===>" + carTotalCnt);
    	System.out.println("carList===>" + carList);
    	System.out.println("carPagingUtil===>" + carPagingUtil);
    	
       return "account/main";
    }
}
