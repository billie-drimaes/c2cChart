package com.bill.controller;

import java.util.Locale;
import java.util.Map;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bill.vo.UserVO;
import com.bill.service.UserService;

@Controller
@RequestMapping("/")
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	
	@Inject
	UserService userService;
	
    @RequestMapping(value = "/")
    public String home(Locale locale, Model model) throws Exception{

        return "login/login";
    }
    
    @RequestMapping("login")
    public String login_check(@ModelAttribute UserVO vo, HttpSession session, Model mav) {
    	
    	String name = userService.loginCheck(vo, session);  
    	System.out.println("session=>"+session);
//    	ModelAndView mav = new ModelAndView();
    	
    	if (name != null) { // 로그인 성공 시
    		//mav.setViewName("main/main"); // 뷰의 이름
    		return "redirect:main";
    	} else { // 로그인 실패 시
    		//mav.setViewName("login/login"); 		
    		//mav.addObject("message", "error");
    		mav.addAttribute("message", "error");
    		return "login/login";
         }
       }
    
    @RequestMapping("logout.do")
    public ModelAndView logout(HttpSession session, ModelAndView mav) {
    	
    	System.out.println("logout");
    	userService.logout(session); 
    	mav.setViewName("login/login"); 
    	mav.addObject("message", "logout"); 
    	
    	return mav;
      }
    
    //ID 중복확인
    @ResponseBody
    @RequestMapping(value="/user/idCheck",method=RequestMethod.POST)
    public int getIdCheck(HttpServletRequest request) throws Exception{
    	String userId = request.getParameter("userId");
    	int result = userService.idCheck(userId);//중복아이디 있으면 1, 없으면 0
    		
    	return result;
    		
    }
    
    //관리자 등록
    @RequestMapping(value="/user/register",method=RequestMethod.POST)
    public String register(UserVO uservo, RedirectAttributes rttr) throws Exception{
		logger.info("register");
		
		userService.register(uservo);
		
		rttr.addFlashAttribute("msg", "가입이 완료되었습니다.");
    		
    	return "redirect:/account";
    		
    }
}

