package com.douzone.devblog.board.community.service;

import java.util.List;
import java.util.Map;

public interface CommunityService {
	
	/**
	 * 커뮤니티 게시판 리스트  
	 * @param Map
	 * @return List
	 */
	public List<Map<String, Object>> retrieveCommunityDataList(Map<String, Object> param) throws Exception;
	
	
	
	
	/**
	 * 커뮤니티 게시판 입력
	 * @param Map
	 * @return Map
	 */
	public Map<String, Object> insertCommunityData(Map<String, Object> param) throws Exception;
	

}
