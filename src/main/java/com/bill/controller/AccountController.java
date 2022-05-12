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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bill.service.AccountService;
import com.bill.util.PagingUtil;
import com.bill.vo.AccountVO;
import com.bill.vo.CarMainVO;

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
    	
    	//adminList(request, modelMap, param);
    	/*
    	Map<String, Object> adminParam = new HashMap<String, Object>();
    	Map<String, Object> driverParam = new HashMap<String, Object>();
    	Map<String, Object> carParam = new HashMap<String, Object>();
    	
    	if(param.isEmpty()) {
    		modelMap.addAllAttributes(adminList(request, modelMap, param));
    		modelMap.addAllAttributes(driverList(request, modelMap, param));
    		modelMap.addAllAttributes(carList(request, modelMap, param));
    	} else {
    		
    		if(param.get("type").equals("admin")) {
    			driverParam.remove("page");
    			carParam.remove("page");
    		} else if(param.get("type").equals("driver")) {
    			adminParam.remove("page");
    			carParam.remove("page");
    		} else if(param.get("type").equals("car")) {
    			adminParam.remove("page");
    			driverParam.remove("page");
    		} 
    		modelMap.addAllAttributes(adminList(request, modelMap, adminParam));
    		modelMap.addAllAttributes(driverList(request, modelMap, driverParam));
    		modelMap.addAllAttributes(carList(request, modelMap, carParam));
    	}
    	
    	System.out.println("request = " + request.toString());
    	System.out.println("modelMap = " + modelMap.toString());
    	System.out.println("param = " + param);
    	*/
    	
       return "account/main";
    }
	
	@GetMapping(value = "/managerRegister")
    public String managerRegister(Locale locale, Model model) throws Exception{

        return "account/managerRegister";
    }
	
	@ResponseBody
	@GetMapping(value="/admin")
	public Map<String, Object> adminList(HttpServletRequest request, ModelMap modelMap, @RequestParam Map<String, Object> param ) throws Exception {
		
		System.out.println("account/admin.. ");
		
		int totalCnt= accountService.selectAdminTotalCnt(param);
    	int curPage = MapUtils.getIntValue(param, "page", 1);
    	param.put("page", curPage);
    	/* 페이징 계산 */
		int offset = (curPage - 1) * 5;
		param.put("offset", offset);
		
		System.out.println("curPage==>" + curPage);
		System.out.println("offset==>" + offset);
		
		List<AccountVO> list = accountService.selectAdminList(param);
		PagingUtil pagingUtil = new PagingUtil(totalCnt, curPage);
		
    	Map<String, Object> map = new HashMap<String, Object>(); 
    	map.put("totalCnt", totalCnt);
    	map.put("list", list);
    	map.put("pagingUtil", pagingUtil);
    	
    	System.out.println(map);
    	
    	return map;
	}
	
	@ResponseBody
	@GetMapping(value="/driver")
	public  Map<String, Object> driverList(HttpServletRequest request, ModelMap modelMap, @RequestParam Map<String, Object> param ) throws Exception {
		
		System.out.println("account/driver.. ");
		
		int totalCnt= accountService.selectDriverTotalCnt(param);
    	int curPage = MapUtils.getIntValue(param, "page", 1);
    	param.put("page", curPage);
    	/* 페이징 계산 */
		int offset = (curPage - 1) * 5;
		param.put("offset", offset);
		
		System.out.println("curPage==>" + curPage);
		System.out.println("offset==>" + offset);
		
		List<AccountVO> list = accountService.selectDriverList(param);
		PagingUtil pagingUtil = new PagingUtil(totalCnt, curPage);
		
    	Map<String, Object> map = new HashMap<String, Object>(); 
    	map.put("totalCnt", totalCnt);
    	map.put("list", list);
    	map.put("pagingUtil", pagingUtil);
    	
    	System.out.println(map);
    	
    	return map;
	}
	
	@ResponseBody
	@GetMapping(value="/car")
	public Map<String, Object> carList(HttpServletRequest request, ModelMap modelMap, @RequestParam Map<String, Object> param ) throws Exception {
		
		System.out.println("account/car.. ");
		
		int totalCnt= accountService.selectCarTotalCnt(param);
    	int curPage = MapUtils.getIntValue(param, "page", 1);
    	param.put("page", curPage);
    	/* 페이징 계산 */
		int offset = (curPage - 1) * 5;
		param.put("offset", offset);
		
		System.out.println("curPage==>" + curPage);
		System.out.println("offset==>" + offset);
		
		List<AccountVO> list = accountService.selectCarList(param);
		PagingUtil pagingUtil = new PagingUtil(totalCnt, curPage);
		
    	Map<String, Object> map = new HashMap<String, Object>(); 
    	map.put("totalCnt", totalCnt);
    	map.put("list", list);
    	map.put("pagingUtil", pagingUtil);
    	
    	System.out.println(map);
    	
    	return map;
	}
}
