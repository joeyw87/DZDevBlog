package com.douzone.devblog.common.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("CommonDAO")
public class CommonDAO extends AbstractDAO {

	/**
	 * retrieveCommonCodeList  공통코드 조회
	 * @param param
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> retrieveCommonCodeList(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		
		returnList = (List<Map<String, Object>>)selectList("CommonDAO.retrieveCommonCodeList", param);
		
		return returnList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> retrieveCommonCodeListId(Map<String, Object> param) throws Exception{
		return selectList("CommonDAO.retrieveCommonCodeListId", param);
	}
	
	/**
	 * retrieveProductCodeList 제품 조회
	 * @param param
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> retrieveProductCodeList(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		
		returnList = (List<Map<String, Object>>)selectList("CommonDAO.retrieveProductCodeList", param);
		
		return returnList;
	}
	
	/**
	 * 공통코드 부모자식 계층코드 조회 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> retrieveHierarchyCodeList(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		
		returnList = (List<Map<String, Object>>)selectList("CommonDAO.retrieveHierarchyCodeList", param);
		
		return returnList;
	}

	public Map<String, Object> getCodeDetailInfoById(Map<String, Object> param) {
		return (Map<String, Object>) selectOne("CommonDAO.getCodeDetailId", param);
	}
	
	public Map<String, Object> getCodeDetailInfoBySeq(Map<String, Object> param) {
		return (Map<String, Object>) selectOne("CommonDAO.getCodeDetailSeq", param);
	}

	public Object getUserSeq() {
		return selectOne("CommonDAO.getUserSeq");
	}
	
	public String getCompSeq() {
		return (String) selectOne("CommonDAO.getCompSeq");
	}
	
	public String getProdSeq() {
		return (String) selectOne("CommonDAO.getProdSeq");
	}
	
	public int updateUserSeq(Map<String, Object> params) {
		return (int) update("CommonDAO.updateUserSeq", params);
	}
	
	public int updateProdSeq(Map<String, Object> params) {
		return (int) update("CommonDAO.updateProdSeq", params);
	}
	
	public int updateCompSeq(Map<String, Object> params) {
		return (int) update("CommonDAO.updateCompSeq", params);
	}
	
}
