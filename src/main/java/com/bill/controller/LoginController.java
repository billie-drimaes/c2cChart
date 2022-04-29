package com.bill.controller;

import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bill.vo.UserVO;
import com.bill.service.UserService;

@Controller
@RequestMapping("/")
public class LoginController {
	
	@Inject
	UserService userService;
	
    @RequestMapping(value = "/")
    public String home(Locale locale, Model model) throws Exception{

        return "login/login";
    }
    
    @RequestMapping("login")
    public ModelAndView login_check(@ModelAttribute UserVO vo, HttpSession session) {
    	
    	String name = userService.loginCheck(vo, session);  
    	System.out.println("session=>"+session);
    	ModelAndView mav = new ModelAndView();
    	if (name != null) { // 로그인 성공 시
    		mav.setViewName("main/main"); // 뷰의 이름
    	} else { // 로그인 실패 시
    		mav.setViewName("login/login"); 		
    		mav.addObject("message", "error");
         }
        return mav;
       }
    
    @RequestMapping("logout.do")
    public ModelAndView logout(HttpSession session, ModelAndView mav) {
    	
    	System.out.println("logout");
    	userService.logout(session); 
    	mav.setViewName("login/login"); 
    	mav.addObject("message", "logout"); 
    	
    	return mav;
      }
}

