package com.bill.controller;
import java.net.InetAddress;
import java.util.List;
import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bill.vo.CarMainVO;

@Controller
public class CarsController {
    
    
    @RequestMapping("/cars")
    public String home(Locale locale, Model model) throws Exception{
    	
    	InetAddress ip = InetAddress.getLocalHost(); 
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

        return "cars/main";
    }
    
    //전체차량 - 통계페이지 호출
    @RequestMapping("/carsStat")
    public String carsStat(Locale locale, Model model) throws Exception{

        return "cars/carsStat";
    }
}
