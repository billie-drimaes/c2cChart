package com.bill.controller;
import java.net.InetAddress;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bill.service.MainService;

@Controller
public class MainController {
    
   @Autowired
	public MainService service;
	
    @GetMapping(value="/main")
    public String home(HttpServletRequest request, ModelMap modelMap, @RequestParam Map<String, Object> param ) throws Exception{
    		
    	InetAddress ip = InetAddress.getLocalHost();
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

    	modelMap.addAttribute("list", service.selectList(param));
    	System.out.println("list.." + modelMap.get("list"));
    	
       return "main/main";
    }
}
