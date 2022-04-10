package com.bill.controller;

import java.util.Locale;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bill.dao.CarDAO;
import com.bill.service.CarService;

@Controller
public class CarController {

	// 자동 DI 적용시키는 어노테이션 2가지 Inject, Autowired
	@Inject
    private CarService service;
	@Autowired
	CarDAO carDao;
		
	/*
	 * @RequestMapping("/car") public String home(Locale locale, Model model) throws
	 * Exception {
	 * 
	 * InetAddress ip = InetAddress.getLocalHost();
	 * System.out.println("Host Name = [" + ip.getHostName() + "]");
	 * System.out.println("Host Address = [" + ip.getHostAddress() + "]");
	 * 
	 * return "car/main"; }
	 */
	@RequestMapping("/mqtt")
	public String mqtt(Locale locale, Model model) throws Exception {

		return "mqtt/mqtt";
	}
	
	@GetMapping("/car")
    // model 안에 request가 있다. model에 데이터를 저장하면 request에 저장된다. 
    public String list(Model model) throws Exception {
    	
		System.out.println("CarController.selectCar() ");
    	model.addAttribute("selectCar", service.selectCar());
    	
    	System.out.println("CarController.selectTrip() ");
    	model.addAttribute("selectTrip", service.selectTrip());
    	
    	return "car/main";
    }
}
