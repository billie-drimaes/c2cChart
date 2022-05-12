package com.bill.controller;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bill.service.CarsService;

@Controller
public class CarsController {
    
	@Autowired
	public CarsService service; 
    
    @RequestMapping("/cars")
    public String home(Locale locale, ModelMap modelMap, @RequestParam Map<String, Object> param, String searchId) throws Exception{
    	
    	InetAddress ip = InetAddress.getLocalHost(); 
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

    	System.out.println("list1..." + searchId);
    	System.out.println("list1..." + param.get("searchId"));
    	modelMap.addAttribute("list", service.selectCars(param));
    	System.out.println("list2..." + searchId);
    	System.out.println("list2..." + param.get("searchId"));
    	System.out.println("list..." + modelMap.get("list"));
    	
       return "cars/main";
    }
    
    //전체차량 - 통계페이지 호출
    @RequestMapping("/carsStat")
    public String carsStat(Locale locale, Model model) throws Exception{

       return "cars/carsStat";
    }
}
