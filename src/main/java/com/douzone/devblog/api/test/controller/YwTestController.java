package com.douzone.devblog.api.test.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.devblog.common.utils.CommonUtils;
import com.douzone.devblog.common.utils.HttpUtils;
import com.douzone.devblog.main.login.vo.LoginVO;

import net.sf.json.JSONObject;

@Controller
public class YwTestController {
	
	// 로그
	private static final Logger logger = LoggerFactory.getLogger(YwTestController.class);
	
	/**
	 * API 테스트 페이지 호출
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/yw/test/ywCalView.do", method=RequestMethod.GET)
	public ModelAndView ywCalView(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/yw/test/ywCalView");
		return mv;
	}
	
	/**
	 * 풀캘린더 테스트 페이지 호출2 (keea)
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/yw/test/ywCalView2.do", method=RequestMethod.GET)
	public ModelAndView ywCalView2(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/yw/test/ywCalView2");
		return mv;
	}
	
	/**
	 * 풀캘린더 테스트 페이지 호출3 (타임라인 라이센스)
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/yw/test/ywCalView3.do", method=RequestMethod.GET)
	public ModelAndView ywCalView3(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/yw/test/ywCalView3");
		return mv;
	}
	
	/**
	 * 일정표 html 테스트 페이지 호출4
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/yw/test/ywCalView4.do", method=RequestMethod.GET)
	public ModelAndView ywCalView4(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/yw/test/ywCalView4");
		return mv;
	}
	
	
	
}
