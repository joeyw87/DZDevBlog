package com.douzone.devblog.common.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("CodeManageDAO")
public class CodeManageDAO extends AbstractDAO {

	/**
	 * getProdCodeList 코드관리 트리 데이터 조회
	 * @param param
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCnsltCodeList(Map<String, Object> param) throws Exception{
		return selectList("CodeManageDAO.getCnsltCodeList", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectChildTreeList(Map<String, Object> param) throws Exception{
		return selectList("CodeManageDAO.selectChildTreeList", param);
	}
	
	@SuppressWarnings("unchecked")
	public void insertCnsltCode(Map<String, Object> param) throws Exception{
		insert("CodeManageDAO.insertCnsltCode", param);
	}
	
	@SuppressWarnings("unchecked")
	public void deleteCnsltCode(Map<String, Object> param) throws Exception{
		delete("CodeManageDAO.deleteCnsltCode", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCnsltCode(Map<String, Object> param) throws Exception{
		return (Map<String, Object>) selectOne("CodeManageDAO.selectCnsltCode", param);
	}
	
}
