package com.bill.controller;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bill.dao.info.infoDAO;
import com.bill.vo.info.infoVO;

@Controller
public class CarController {
    @Autowired
    infoDAO infoDao;
    
    
    @RequestMapping("/car")
    public String home(Locale locale, Model model) throws Exception{
    	
    	InetAddress ip = InetAddress.getLocalHost(); 
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

        return "car/main";
    }
    
    //개별차량 - 통계페이지 호출
    @RequestMapping("/car/stat")
    public String stat(Locale locale, Model model) throws Exception{
        
    	List<infoVO> infoList = infoDao.getInfo();
    	
       model.addAttribute("infoList", infoList);

        return "car/stat/statMain";
    }

	/*
	 * public HashMap<String, String> getCarInfo() {
	 * 
	 * 
	 * }
	 */
	 
    
    @RequestMapping("/mqtt")
    public String mqtt(Locale locale, Model model) throws Exception{
    	
        return "mqtt/mqtt";
    }
}
