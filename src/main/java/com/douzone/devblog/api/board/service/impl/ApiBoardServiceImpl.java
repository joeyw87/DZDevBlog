package com.douzone.devblog.api.board.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.douzone.devblog.api.board.dao.ApiBoardDAO;
import com.douzone.devblog.api.board.service.ApiBoardService;

/**
 * ApiBoardServiceImpl
 * @version 1.0
 */
@Service("ApiBoardService")
public class ApiBoardServiceImpl implements ApiBoardService {

	@Resource(name = "ApiBoardDAO")
	private ApiBoardDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(ApiBoardServiceImpl.class);

	
	/**
	 * 커뮤니티 게시판 리스트  
	 * @param param
	 * @return
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> retrieveApiProfitList(Map<String, Object> param) {
		
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		try 
		{
			returnList = dao.retrieveApiProfitList(param);
		}
		catch(Exception e) {
			logger.error(e.getMessage());
		}
		return returnList;
	}
	
	
	
	/**
	 * 커뮤니티 게시판 등록
	 * @param param
	 * @return
	 */
	@Override
	@SuppressWarnings("unchecked")
	public Map<String, Object> insertApiProfit(Map<String, Object> param) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int rslt = 0;
		try 
		{
			rslt = dao.insertApiProfit(param);
			if(rslt > 0 ){
				returnMap.put("resultCode", "SUCCESS");
			}
		}
		catch(Exception e) {
			logger.error(e.getMessage());
		}
		return returnMap;
	}
	
}

