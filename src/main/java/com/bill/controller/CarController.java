package com.bill.controller;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CarController {
    
    
    @RequestMapping("/car")
    public String home(Locale locale, Model model) throws Exception{
    	
    	InetAddress ip = InetAddress.getLocalHost(); 
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

        return "car/main";
    }
	/*
	 * public HashMap<String, String> getCarInfo() {
	 * 
	 * return ; }
	 */
    
    @RequestMapping("/mqtt")
    public String mqtt(Locale locale, Model model) throws Exception{
    	
    	InetAddress ip = InetAddress.getLocalHost(); 
    	System.out.println("Host Name = [" + ip.getHostName() + "]"); 
    	System.out.println("Host Address = [" + ip.getHostAddress() + "]");

        return "mqtt/mqtt";
    }
}
