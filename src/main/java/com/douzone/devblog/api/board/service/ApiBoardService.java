package com.douzone.devblog.api.board.service;

import java.util.List;
import java.util.Map;

public interface ApiBoardService {
	
	/**
	 * 커뮤니티 게시판 리스트  
	 * @param Map
	 * @return List
	 */
	public List<Map<String, Object>> retrieveApiProfitList(Map<String, Object> param) throws Exception;
	
	
	
	
	/**
	 * 커뮤니티 게시판 입력
	 * @param Map
	 * @return Map
	 */
	public Map<String, Object> insertApiProfit(Map<String, Object> param) throws Exception;
	

}
