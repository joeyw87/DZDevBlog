package com.douzone.devblog.common.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.douzone.devblog.common.dao.CommonDAO;
import com.douzone.devblog.common.service.CommonService;
import com.douzone.devblog.common.vo.PageOfListVO;

@Service("CommonService")
public class CommonServiceImpl implements CommonService {
	
    private final static Logger logger = LoggerFactory.getLogger(CommonServiceImpl.class);
    
	@Resource(name = "CommonDAO")
	private CommonDAO commonDAO;
	
	/**
	 * retrieveCommonCodeList 공통 코드 조회
	 * @param Map<String, Object> param
	 * @return List<ExpFormVO>
	 */
	public PageOfListVO<Map<String, Object>> retrieveCommonCodeList(Map<String, Object> param)  {
		PageOfListVO<Map<String, Object>> returnList = new PageOfListVO<Map<String, Object>>();

		try {
		    
			if (param.get("search") == null) {
				param.put("search", "");
			}
			
			if (String.valueOf(param.get("div")).equals("common")) {
				returnList.setList((List<Map<String, Object>>) commonDAO.retrieveCommonCodeList(param));
			} else if (String.valueOf(param.get("div")).equals("p")) { // TODO: p -> depth 이거 수정 
				returnList.setList((List<Map<String, Object>>) commonDAO.retrieveHierarchyCodeList(param));
			} else if (String.valueOf(param.get("div")).equals("prod")) {
				returnList.setList((List<Map<String, Object>>) commonDAO.retrieveProductCodeList(param));
			} else if (String.valueOf(param.get("div")).equals("etc")) {
                returnList.setList((List<Map<String, Object>>) commonDAO.retrieveCommonCodeList(param));
            } else {
			    logger.debug("div is empty");
			}
		} catch(Exception e) {
			//logger.error(Utils.makeStackTrace(e));
			e.printStackTrace();
		}

		return returnList;
	}
	
	@Override
	public Map<String, Object> getCodeDetailInfoById(String cd_m_nm, String cd_id) {
		Map<String, Object> param = new HashMap<>();
		param.put("codeMasterName", cd_m_nm);
		param.put("codeDetailId", cd_id);
		
		return commonDAO.getCodeDetailInfoById(param);
	}

	@Override
	public Map<String, Object> getCodeDetailInfoBySeq(String cd_m_nm, String cd_no) {
		Map<String, Object> param = new HashMap<>();
		param.put("CD_M_NM", cd_m_nm);
		param.put("CD_NO", cd_no);
		
		return commonDAO.getCodeDetailInfoBySeq(param);
	}

	@Override
	public String getUserSeq() {
		return (String) commonDAO.getUserSeq();
	}

	@Override
	public String getCompSeq() {
		return commonDAO.getCompSeq();
	}

	@Override
	public String getProdSeq() {
		return commonDAO.getProdSeq();
	}

	@Override
	public int updateUserSeq(String newSeq, String currSeq) {
		Map<String, Object> params = new HashMap<>();
		params.put("userSeq", newSeq);
		params.put("currSeq", currSeq);
		
		return commonDAO.updateUserSeq(params);
	}

	@Override
	public int updateCompSeq(String newSeq, String currSeq) {
		Map<String, Object> params = new HashMap<>();
		params.put("userSeq", newSeq);
		params.put("currSeq", currSeq);
		
		return commonDAO.updateCompSeq(params);
	}

	@Override
	public int updateProdSeq(String newSeq, String currSeq) {
		Map<String, Object> params = new HashMap<>();
		params.put("userSeq", newSeq);
		params.put("currSeq", currSeq);
		
		return commonDAO.updateProdSeq(params);
	}

}
