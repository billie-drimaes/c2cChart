package com.bill.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.xml.stream.events.Namespace;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bill.dao.CarDAO;
import com.bill.service.CarService;
import com.bill.vo.CarMainVO;

@Controller
public class CarController {

	// 자동 DI 적용시키는 어노테이션 2가지 Inject, Autowired
	@Inject
    private CarService service;
	
	@Autowired
	CarDAO carDao;
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace = "com.bill.mapper.CarMapper";
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
    public String carMain(Model model) throws Exception {
    	
		System.out.println("CarController.selectCar() ");
		System.out.println(service.selectCar());
		model.addAttribute("selectCar", service.selectCar());

		System.out.println("CarController.selectTrip() ");
		System.out.println(service.selectTrip());
    	model.addAttribute("selectTrip", service.selectTrip());
    	
    	System.out.println("CarController.selectLog() ");
		System.out.println(service.selectLog());
    	model.addAttribute("selectLog", service.selectLog());
    	
    	
    	return "car/main";
    }
	
	@ResponseBody
	@RequestMapping(value="/car/post", method = RequestMethod.POST)
	public String getTrimNumber( HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception {
		String carNumber = request.getParameter("carNo");
		System.out.println(carNumber);
		
		CarMainVO vo = new CarMainVO();
		vo.setCarNo(carNumber);
		//List<CarMainVO> tripList = sqlSession.selectList(Namespace + ".selectTrip");
		System.out.println(service.selectTrip(param));
		
		return null;
	}
	
	@GetMapping("/log")
    // model 안에 request가 있다. model에 데이터를 저장하면 request에 저장된다. 
    public String carLog(Model model) throws Exception {
    	
		System.out.println("CarController.selectCar() ");
		System.out.println(service.selectCar());
    	model.addAttribute("selectCar", service.selectCar());
    	
    	System.out.println("CarController.selectTrip() ");
		System.out.println(service.selectTrip());
    	model.addAttribute("selectTrip", service.selectTrip());
    	
    	System.out.println("CarController.selectLog() ");
		System.out.println(service.selectLog());
    	model.addAttribute("selectLog", service.selectLog());
    	
    	return "car/log";
    }
}
