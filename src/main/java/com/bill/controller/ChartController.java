package com.bill.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import com.bill.dao.ChartDAO;
import com.bill.service.fuelService;
import com.bill.vo.fuelVO;
import com.bill.dao.speed.speedDAO;
import com.bill.vo.speed.speedVO;
import com.bill.vo.ChartVO;

@Controller
public class ChartController {

	@Inject
	private SqlSession sqlSession;
    
	private static final String Namespace = "com.bill.mapper.ChartMapper";


/*
 * 	@Autowired
	ChartDAO chartDao;
	@Autowired
	speedDAO speedDao;
    @Inject
    private fuelService service;
    
	@RequestMapping(value = "fuelList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")

	public @ResponseBody String fuelList(Locale locale, Model model) throws Exception {

		Gson gson_fuel = new Gson();

		List<fuelVO> list = service.selectFuel();

		return gson_fuel.toJson(list);
	}
	
	@RequestMapping(value = "speedList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String speedList(Locale locale, Model model) throws Exception {

		Gson gson_speed = new Gson();

		List<speedVO> list = speedDao.getSpeed();
		return gson_speed.toJson(list);
	}
	*/
	
    //statMain.jsp에서 그래프 시간단위를 받아와 그에따른 데이터 값을 불러온다.
	@ResponseBody
	@RequestMapping(value="/stat/carStat", method = RequestMethod.POST)
	public List<ChartVO> getChartList( HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception {
				
		
		HashMap<String, String> carStatMap = new HashMap<String, String>();
		carStatMap.put("dateUnit", request.getParameter("dateUnit"));
		carStatMap.put("column", request.getParameter("column"));
		carStatMap.put("carNum", request.getParameter("carNum"));
		carStatMap.put("startDate", request.getParameter("startDate"));
		carStatMap.put("endDate", request.getParameter("endDate"));
		System.out.println("carStat condition:"+carStatMap);

		
		List<ChartVO> chartList = sqlSession.selectList(Namespace + ".getGraphWithCondition", carStatMap);
		System.out.println(chartList);
		
		return chartList;
	}
	
    //carsStat.jsp에서 그래프 시간단위,항목 받아와 그에따른 데이터 값을 불러온다.
	@ResponseBody
	@RequestMapping(value="/stat/carsStat", method = RequestMethod.POST)
	public List<ChartVO> getTotalChart( HttpServletRequest request, @RequestParam Map<String, Object> param ) throws Exception {
				
		
		HashMap<String, String> carsStatMap = new HashMap<String, String>();
		carsStatMap.put("dateUnit", request.getParameter("dateUnit"));
		carsStatMap.put("column", request.getParameter("column"));
		carsStatMap.put("startDate", request.getParameter("startDate"));
		carsStatMap.put("endDate", request.getParameter("endDate"));
		System.out.println("carStat condition:"+carsStatMap);

		
		List<ChartVO> totalChartList = sqlSession.selectList(Namespace + ".getTotalChart", carsStatMap);
		System.out.println(totalChartList);
		
		return totalChartList;
	}
	

	

}
