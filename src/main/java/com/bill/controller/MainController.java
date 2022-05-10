package com.bill.controller;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bill.service.MainService;

@Controller
public class MainController {
    
   @Autowired
	public MainService service;
	
    @RequestMapping(value="/main", method = RequestMethod.GET)
    public String home(HttpServletRequest request, ModelMap modelMap, @RequestParam Map<String, Object> param ) throws Exception{
    		
    	InetAddress ip = InetAddress.getLocalHost();
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

    	modelMap.addAttribute("list", service.selectList(param));
    	modelMap.addAttribute("searchType", param.get("searchType") != null ? param.get("searchType") : "");
    	modelMap.addAttribute("searchBox", param.get("searchBox") != null ? param.get("searchBox") : "");
    	
    	System.out.println("param..." + param);
    	System.out.println("searchType..." + modelMap.get("searchType"));
       return "main/main";
    }
    
    
}
