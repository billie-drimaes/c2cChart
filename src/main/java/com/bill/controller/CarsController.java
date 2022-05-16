package com.bill.controller;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bill.service.CarsService;

@Controller
public class CarsController {
    
	@Autowired
	public CarsService service; 
    
    @RequestMapping("/cars")
    public String home(Locale locale, ModelMap modelMap, @RequestParam Map<String, Object> param) throws Exception{
    	
    	InetAddress ip = InetAddress.getLocalHost(); 
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

    	modelMap.addAttribute("list", service.selectCars(param));
    	String i = "ca";
    	String j = "ba"; 
    	System.out.println("i=>" + (int)i.charAt(1));
    	System.out.println("j=>" + (int)j.charAt(0));
       return "cars/main";
    }
    
    @ResponseBody
    @RequestMapping(value = "/cars/json", method = RequestMethod.POST)
    public Map<String, Object> searchList(Locale locale, ModelMap modelMap, @RequestParam Map<String, Object> param) throws Exception{
    	
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	map.put("searchList", service.selectCars(param));
    	System.out.println("map.." + map);
    	return map;
    }
    //전체차량 - 통계페이지 호출
    @RequestMapping("/carsStat")
    public String carsStat(Locale locale, Model model) throws Exception{

       return "cars/carsStat";
    }
}
