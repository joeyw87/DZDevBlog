package com.douzone.devblog.common.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.douzone.devblog.common.vo.AttachFileVO;

@Repository("FileUploaderDAO")
public class FileUploaderDAO extends AbstractDAO {

	/**
	 * retrieveCommonCodeList  공통 첨부파일 업로드 조회
	 * @param param
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> test(Map<String, Object> param) throws Exception{
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		
		returnList = (List<Map<String, Object>>)selectList("FileUploaderDAO.test", param);
		
		return returnList;
	}
	
	/**
	 * 공통 첨부파일 시퀀스 조회
	 * @param param
	 * @return int
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int getAttachSeq(Map<String, Object> param) throws Exception{
		return (Integer)selectOne("FileUploaderDAO.getAttachSeq", param);
	}
	
	/**
	 * 첨부파일 인서트
	 * @param param
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void insertAttachFile(Map<String, Object> param) throws Exception{
		insert("FileUploaderDAO.insertAttachFile", param);
	}
	
	/**
	 * 첨부파일 게시물 시퀀스 업데이트
	 * @param param
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateAttachBoardSeq(Map<String, Object> param) throws Exception{
		update("FileUploaderDAO.updateAttachBoardSeq", param);
	}
	
	/**
	 * 첨부파일 게시물 시퀀스 삭제처리
	 * @param param
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void deleteAttachBoardSeq(int boardSeq) throws Exception{
		update("FileUploaderDAO.deleteAttachBoardSeq", boardSeq);
	}
	
	/**
	 * 첨부파일 게시물 시퀀스 삭제처리
	 * @param param
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int deleteAttachSeqArray(Map<String, List<String>> params) throws Exception{
		return (int) update("FileUploaderDAO.deleteAttachSeqArray", params);
	}
	
	/**
	 * 공통 첨부파일 정보 조회
	 * @param param
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getAttachFileDetail(Map<String, Object> param) throws Exception{
		return (Map<String, Object>) selectOne("FileUploaderDAO.getAttachFileDetail", param);
	}
	
	/**
	 * 공통 첨부파일 리스트 조회
	 * @param param
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AttachFileVO> retrieveAttachFileList(Map<String, Object> param) throws Exception{
		return selectList("FileUploaderDAO.retrieveAttachFileList", param);
	}
	
	
}
