package com.bill.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.xml.stream.events.Namespace;

import org.apache.ibatis.annotations.Param;
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
import com.bill.vo.CarLogVO;
import com.bill.vo.CarMainVO;
import com.bill.vo.ChartVO;
import com.google.gson.Gson;

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
    	
    	return "car/main";
    }
    //개별차량 - 통계페이지 호출
    @RequestMapping(value="/carStat", method = RequestMethod.GET)
    public String stat(Locale locale, Model model, String carId) throws Exception{

    	System.out.println("parameter..." + carId);
    	List<CarMainVO> carList = service.selectCar();

       model.addAttribute("carList", carList);
       model.addAttribute("carId", carId);

        return "car/statMain";
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
    	
    	return "car/log";
    }
	@GetMapping("/carReport")
    // model 안에 request가 있다. model에 데이터를 저장하면 request에 저장된다. 
    public String carReport(Model model) throws Exception {
    	List<CarMainVO> carList = service.selectCar();
    	model.addAttribute("carList", carList);
    	
    	return "car/report";
    }
	/*
	 * 차량번호의 트립아이디 리스트를 가져온다.
	*/
	@ResponseBody
	@RequestMapping(value="/car/post", method = RequestMethod.POST)
	public List<CarMainVO> getTripNumber( HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception {
		
		System.out.println("CarController.selectTrip() ");
		System.out.println("param=>"+param);
		
		List<CarMainVO> tripListAll = sqlSession.selectList(Namespace + ".selectTripAll", param);
		System.out.println("tripListAll=>"+tripListAll);
		
		List<CarMainVO> tripList = sqlSession.selectList(Namespace + ".selectTrip", param);
		System.out.println("tripList=>"+tripList);
		
		return tripList;
	}
	
	/*
	 * 차량번호의 트립아이디 리스트를 가져온다. 
	*/
	@ResponseBody
	@RequestMapping(value="/car/json", method = RequestMethod.POST)
	public List<CarLogVO> getTripData( HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception {
		
		System.out.println("CarController.selectTripData() ");
		
		System.out.println(request.getParameter("tripId"));
		System.out.println(request.getParameter("insDte"));
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("carNum", request.getParameter("carNum"));
		map.put("tripId", request.getParameter("tripId"));
		map.put("insDte", request.getParameter("insDte"));
		map.put("userId", "user1");
		
		System.out.println("map==>" + map);
		List<CarLogVO> tripList = sqlSession.selectList(Namespace + ".selectTripData", map);
		System.out.println("/car/json tripList=>"+ tripList);

		return tripList;
	}
	
    //rpm_chart.jsp에서 그래프 시간단위를 받아와 그에따른 데이터 값을 불러온다.
	@ResponseBody
	@RequestMapping(value="/car/rpmchart", method = RequestMethod.POST)
	public List<ChartVO> getRpmChartList( HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception {
				
		
		HashMap<String, String> rpmMap = new HashMap<String, String>();
		rpmMap.put("tripId", request.getParameter("tripId"));
		rpmMap.put("carNum", request.getParameter("carNum"));
//		System.out.println("/car/rpmchart rpm =>"+rpmMap);

		
		List<ChartVO> rpmChartList = sqlSession.selectList(Namespace + ".getRpm", rpmMap);
//		System.out.println(rpmChartList);
		
		return rpmChartList;
	}  
	
    //fuelchart.jsp에서 main.jsp로부터 받은 tripId,carNum값을 넘겨받아 mapper의 .getFuelLevel 호출
	@ResponseBody
	@RequestMapping(value="/car/fuelBar", method = RequestMethod.POST)
	public List<ChartVO> getFuelChartList( HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception {
				
		
		HashMap<String, String> fuelMap = new HashMap<String, String>();
		fuelMap.put("tripId", request.getParameter("tripId"));
		fuelMap.put("carNum", request.getParameter("carNum"));
//		System.out.println("/car/fuelchart FuelLevel =>"+fuelMap);

		
		List<ChartVO> fuelChartList = sqlSession.selectList(Namespace + ".getFuelLevel", fuelMap);
//		System.out.println("fuelChartList"+fuelChartList);
		
		return fuelChartList;
	}
	
    //fuelchart.jsp에서 main.jsp로부터 받은 tripId,carNum값을 넘겨받아 mapper의 .getMileage 호출
	@ResponseBody
	@RequestMapping(value="/car/milechart", method = RequestMethod.POST)
	public List<ChartVO> getMileChartList( HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception {
						
		HashMap<String, String> mileMap = new HashMap<String, String>();
		mileMap.put("tripId", request.getParameter("tripId"));
		mileMap.put("carNum", request.getParameter("carNum"));
		//System.out.println("/car/milechart Mileage =>"+mileMap);
		
		List<ChartVO> mileChartList = sqlSession.selectList(Namespace + ".getMileage", mileMap);
		//System.out.println(mileChartList);		
		return mileChartList;
	} 
}
