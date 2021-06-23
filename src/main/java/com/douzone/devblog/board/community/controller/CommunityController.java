package com.douzone.devblog.board.community.controller;

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

import com.douzone.devblog.board.community.service.CommunityService;
import com.douzone.devblog.common.utils.Utils;

/**
 * 커뮤니티 게시판 컨트롤러
 * @author 조영욱
 * @version 1.0
 */
@Controller
public class CommunityController {
	
	// 로그
	private static final Logger logger = LoggerFactory.getLogger(CommunityController.class);
	
	
	@Resource(name="CommunityService")
	private CommunityService communityService;
	
	
	/**
	 * 커뮤니티 게시판 페이지화면
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/board/community/communityListView.do", method=RequestMethod.GET)
	public ModelAndView communityListView(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		try {
			// 디폴트 검색일자 설정
			SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
	        Calendar calendar = Calendar.getInstance();
	        String nowDate = DateType.format(calendar.getTime());
	        calendar.set(Calendar.DAY_OF_MONTH, 1);
	        String beforeDate = DateType.format(calendar.getTime()); 
	        mv.addObject("beforeDate", beforeDate);
	        mv.addObject("nowDate", nowDate);
	        
		} catch (Exception e) {
			logger.error(Utils.makeStackTrace(e));
		}
		
        mv.setViewName("/board/community/communityListView");
		return mv;
	}
	
	
	/**
	 * 커뮤니티 게시판 리스트 호출 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/board/community/getCommunityDataList.do")
	public ModelAndView getCommunityDataList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		try {
			
			logger.info("### getCommunityDataList params == " + params.toString());
			
			List<Map<String, Object>> result = communityService.retrieveCommunityDataList(params);
			
			//params.remove("start");
			//params.remove("length");
			params.put("is_count", "Y");
			
			int count = Integer.parseInt(communityService.retrieveCommunityDataList(params).get(0).get("totalCnt").toString());
			mv.addObject("resultCode", "SUCCESS");
			mv.addObject("result", result);
			mv.addObject("recordsTotal", count);
			mv.addObject("recordsFiltered", count);
		} catch (Exception e) {
			logger.error(Utils.makeStackTrace(e));
			mv.addObject("resultCode", "FAIL");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	/**
	 * 커뮤니티 게시판 글쓰기 페이지화면
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/board/community/boardWrite.do", method=RequestMethod.GET)
	public ModelAndView boardWrite(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
        mv.setViewName("/board/community/boardWrite");
		return mv;
	}
	
	
	/**
	 * 커뮤니티 게시판 상세 뷰 페이지화면 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/board/community/detailView.do", method=RequestMethod.GET)
	public ModelAndView detailView(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
        mv.setViewName("/board/community/detailView");
		return mv;
	}
	
	
	/**
	 * 커뮤니티 게시판 데이터 등록 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/board/community/insertCommunityData.do", method=RequestMethod.POST)
	public ModelAndView insertCommunityData(@RequestBody Map<String, Object> params, HttpServletRequest servletRequest) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		try {
			
			Map<String, Object> result = communityService.insertCommunityData(params);
			mv.addAllObjects(result);
			
		} catch (Exception e) {
			logger.error(Utils.makeStackTrace(e));
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
}
