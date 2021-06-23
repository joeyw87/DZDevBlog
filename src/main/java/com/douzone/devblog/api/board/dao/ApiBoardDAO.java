package com.douzone.devblog.api.board.dao;

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
@Repository("ApiBoardDAO")
public class ApiBoardDAO extends AbstractDAO {
	
	/**
	 * 로그
	 */
	private static final Logger logger = LoggerFactory.getLogger(ApiBoardDAO.class);
	

	/**
     * retrieveApiProfitList 커뮤니티 게시판 리스트  
     * @param param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> retrieveApiProfitList(Map<String, Object> param) throws Exception{
    	List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
    	
    	if (logger.isDebugEnabled()) {
    		logger.debug("invoked 'retrieveApiProfitList' method...");
    	}
    	
    	returnList = (List<Map<String, Object>>)selectList("ApiBoardDAO.retrieveApiProfitList", param);
    	
    	return returnList;
    }
	
    
    
    /**
     * insertApiProfit api 등록 
     * @param param
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int insertApiProfit(Map<String, Object> param) throws Exception{
    	
    	int returnInt = 0;
    	
    	if (logger.isDebugEnabled()) {
    		logger.debug("invoked 'insertApiProfit' method...");
    	}
    	
    	returnInt = (int) insert("ApiBoardDAO.insertApiProfit", param);
    			
    	return returnInt;
    }
    
}
