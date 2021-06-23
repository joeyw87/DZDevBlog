package com.douzone.devblog.api.board.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.devblog.api.board.service.ApiBoardService;


@Controller
public class ApiBoardController {
	
	// 로그
	private static final Logger logger = LoggerFactory.getLogger(ApiBoardController.class);
	
	
	@Resource(name="ApiBoardService")
	private ApiBoardService apiBoardService;
	
	
	/**
	 * API 영리 커뮤니티 페이지화면
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/board/apiProfitList.do", method=RequestMethod.GET)
	public ModelAndView apiProfit(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/api/board/apiProfitList");
		return mv;
	}
	
	
	/**
	 * API 영리 커뮤니티 리스트 호출 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/api/board/retrieveApiProfitList.do")
	public ModelAndView retrieveApiProfitList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception 
	{
			ModelAndView mv = new ModelAndView();
			List<Map<String, Object>> result = apiBoardService.retrieveApiProfitList(params);
			
			params.remove("start");
			params.remove("length");
			params.put("is_count", 1);
			
			int count = Integer.parseInt(apiBoardService.retrieveApiProfitList(params).get(0).get("total_cnt").toString());
			mv.addObject("result", result);
			mv.addObject("recordsTotal", count);
			mv.addObject("recordsFiltered", count);
			mv.setViewName("jsonView");
			return mv;
	}
	
	
	/**
	 * API 영리 커뮤니티 글쓰기 페이지화면
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/board/apiProfitWrite.do", method=RequestMethod.GET)
	public ModelAndView apiProfitWrite(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/api/board/apiProfitWrite");
		return mv;
	}
	
	
	
	/**
	 * API 영리 커뮤니티 상세 페이지화면 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/board/apiProfitView.do", method=RequestMethod.GET)
	public ModelAndView apiProfitView(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/api/board/apiProfitView");
		return mv;
	}
	
	
	
	/**
	 * API 영리 커뮤니티 등록 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/api/board/insertApiProfit.do", method=RequestMethod.POST)
	public ModelAndView insertApiProfit(@RequestBody Map<String, Object> params, HttpServletRequest servletRequest) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		Map<String, Object> result = apiBoardService.insertApiProfit(params);
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	
	
	

	/**
	 * API 비영리 커뮤니티 페이지화면 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/board/apiNonProfitList.do", method=RequestMethod.GET)
	public ModelAndView apiNonProfit(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/api/board/apiNonProfitList");
		return mv;
	}
	
}
