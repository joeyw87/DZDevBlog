package com.douzone.devblog.board.community.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.douzone.devblog.common.dao.AbstractDAO;

/**
 * @version 1.0
 */
@Repository("CommunityDAO")
public class CommunityDAO extends AbstractDAO {
	
	/**
	 * 로그
	 */
	private static final Logger logger = LoggerFactory.getLogger(CommunityDAO.class);
	

	/**
     * retrieveApiProfitList 커뮤니티 게시판 리스트  
     * @param param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> retrieveCommunityDataList(Map<String, Object> param) throws Exception{
    	List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
    	
    	if (logger.isDebugEnabled()) {
    		logger.debug("invoked 'retrieveCommunityDataList' method...");
    	}
    	
    	returnList = (List<Map<String, Object>>)selectList("CommunityDAO.retrieveCommunityDataList", param);
    	
    	return returnList;
    }
	
    
    
    /**
     * 게시판 데이터 등록 
     * @param param
     * @return int
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int insertCommunityData(Map<String, Object> param) throws Exception{
    	
    	int returnInt = 0;
    	
    	if (logger.isDebugEnabled()) {
    		logger.debug("invoked 'insertCommunityData' method...");
    	}
    	
    	returnInt = (int) insert("CommunityDAO.insertCommunityData", param);
    			
    	return returnInt;
    }
    
    
    /**
     * 게시판 조회수 증가
     * @param param
     * @return int
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void updateViewCnt(Map<String, Object> param) throws Exception{
    	update("CommunityDAO.updateViewCnt", param);
    }
    
}
