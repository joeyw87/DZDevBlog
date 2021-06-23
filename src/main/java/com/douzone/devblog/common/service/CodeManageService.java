package com.douzone.devblog.common.service;

import java.util.List;
import java.util.Map;

public interface CodeManageService {
	/**
	 * CodeManageService 코드관리 서비스 인터페이스 정의
	 * @param param
	 * @return
	 * @throws Exception
	 */	
	public List<Map<String,Object>> getProdCodeTreeList(Map<String, Object> paramMap) throws Exception;
	public Map<String,Object> insertCnsltCode(Map<String, Object> paramMap) throws Exception;
	public Map<String,Object> deleteCnsltCode(Map<String, Object> paramMap) throws Exception;
	public Map<String,Object> selectCnsltCode(Map<String, Object> paramMap) throws Exception;
}
