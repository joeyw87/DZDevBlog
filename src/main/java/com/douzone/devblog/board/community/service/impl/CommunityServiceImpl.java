package com.douzone.devblog.board.community.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.douzone.devblog.board.community.dao.CommunityDAO;
import com.douzone.devblog.board.community.service.CommunityService;
import com.douzone.devblog.common.utils.Utils;

/**
 * CommunityServiceImpl
 * @version 1.0
 */
@Service("CommunityService")
public class CommunityServiceImpl implements CommunityService {

	@Resource(name = "CommunityDAO")
	private CommunityDAO communityDAO;

	private static final Logger logger = LoggerFactory.getLogger(CommunityServiceImpl.class);

	
	/**
	 * 커뮤니티 게시판 리스트  
	 * @param param
	 * @return
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> retrieveCommunityDataList(Map<String, Object> param) throws Exception {
		
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		try 
		{
			logger.info("### retrieveCommunityDataList params == " + param.toString());
			returnList = communityDAO.retrieveCommunityDataList(param);
		}
		catch(Exception e) {
			logger.error(Utils.makeStackTrace(e));
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
	public Map<String, Object> insertCommunityData(Map<String, Object> param) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int rslt = 0;
		try 
		{
			rslt = communityDAO.insertCommunityData(param);
			if(rslt > 0 ){
				returnMap.put("resultCode", "SUCCESS");
			}else{
				returnMap.put("resultCode", "FAIL");
			}
		}
		catch(Exception e) {
			logger.error(Utils.makeStackTrace(e));
			returnMap.put("resultCode", "FAIL");
		}
		return returnMap;
	}
	
}

