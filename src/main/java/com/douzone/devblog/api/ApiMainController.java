package com.douzone.devblog.api;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ApiMainController {
	
	// 로그
	private static final Logger logger = LoggerFactory.getLogger(ApiMainController.class);
	
	
	/*@RequestMapping(value="api/main.do", method=RequestMethod.GET)
	public ModelAndView apimain(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("api/main/apimain");
		return mv;
	}*/
}
