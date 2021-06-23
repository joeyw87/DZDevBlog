package com.douzone.devblog.common.contoller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.devblog.common.service.CodeManageService;
import com.douzone.devblog.common.service.CommonService;

import net.sf.json.JSONArray;

@RestController
public class CodeManageController {
	
	private static final Logger logger = LoggerFactory.getLogger(CodeManageService.class);
	
	@Resource(name="CodeManageService")
	private CodeManageService codeManageService;
	
	@Resource(name="CommonService")
	private CommonService commonService;
	
	/**
	 * 코드관리 조회페이지
	 * @param param
	 * @return
	 */
	@RequestMapping("/common/codeManageView.do")
	public ModelAndView codeManageView(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		params.put("div", "prod"); //제품구분
		mv.addObject("productList", commonService.retrieveCommonCodeList(params).getList()); //제품구분 리스트

		mv.addObject("params", params);
		mv.setViewName("/common/code/codeManageView");
		return mv;
	}
	
	@RequestMapping("/common/codeManageTreeData.do")
	public ModelAndView codeManageTreeData(@RequestParam Map<String, Object> paramMap) throws Exception{
		ModelAndView mv = new ModelAndView();
		logger.info("## codeManageTreeData.do == " + paramMap);
		//paramMap.get("");

		/* 코드정보 조회 */
		List<Map<String,Object>> list = codeManageService.getProdCodeTreeList(paramMap);
		JSONArray json = JSONArray.fromObject(list);

		mv.addObject("treeList", json);
		mv.setViewName("jsonView");
		return mv;
	}
	
	/* 분류코드 저장 */
	@RequestMapping("/common/insertCnsltCode.do")
	public ModelAndView insertCnsltCode(@RequestBody Map<String, Object> paramMap) throws Exception{
		ModelAndView mv = new ModelAndView();
		logger.info("## insertCnsltCode.do == " + paramMap);
		
		//TODO 사용자 정보 어떻게?
		paramMap.put("empSeq", "9999");
		/* 코드정보 저장 */
		Map<String,Object> result = codeManageService.insertCnsltCode(paramMap);
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}
	
	/* 분류코드 삭제 */
	@RequestMapping("/common/deleteCnsltCode.do")
	public ModelAndView deleteCnsltCode(@RequestBody Map<String, Object> paramMap) throws Exception{
		ModelAndView mv = new ModelAndView();
		logger.info("## deleteCnsltCode.do == " + paramMap);
		
		//TODO 사용자 정보  어떻게?
		paramMap.put("empSeq", "9999");
		/* 코드정보 삭제 */
		Map<String,Object> result = codeManageService.deleteCnsltCode(paramMap);
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}
	
	/* 분류코드 조회 */
	@RequestMapping("/common/selectCnsltCode.do")
	public ModelAndView selectCnsltCode(@RequestBody Map<String, Object> paramMap) throws Exception{
		ModelAndView mv = new ModelAndView();
		logger.info("## selectCnsltCode.do == " + paramMap);
		
		//TODO 사용자 정보  어떻게?
		paramMap.put("empSeq", "9999");
		/* 코드정보 조회 */
		Map<String,Object> result = codeManageService.selectCnsltCode(paramMap);
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}
	
}
