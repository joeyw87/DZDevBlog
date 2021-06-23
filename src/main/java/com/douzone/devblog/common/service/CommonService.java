package com.douzone.devblog.common.service;

import java.util.List;
import java.util.Map;

import com.douzone.devblog.common.vo.PageOfListVO;

/**
 * retrieveCommonCodeList 공통코드 조회
 * @param param
 * @return
 * @throws Exception
 */
public interface CommonService {

	public PageOfListVO<Map<String, Object>> retrieveCommonCodeList(Map<String, Object> param);
	public Map<String, Object> getCodeDetailInfoById(String cd_m_nm, String cd_id);
	public Map<String, Object> getCodeDetailInfoBySeq(String cd_m_nm, String cd_no);
	public String getUserSeq();
	public String getCompSeq();
	public String getProdSeq();
	public int updateUserSeq(String newSeq, String currSeq);
	public int updateCompSeq(String newSeq, String currSeq);
	public int updateProdSeq(String newSeq, String currSeq);

}
