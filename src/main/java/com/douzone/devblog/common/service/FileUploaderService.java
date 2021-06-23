package com.douzone.devblog.common.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.douzone.devblog.common.vo.AttachFileVO;


public interface FileUploaderService {
	/**
	 * getAttachNo 첨부파일 시퀀스 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */	
	public int getAttachSeq(Map<String, Object> paramMap) throws Exception;
	public void insertAttachFile(Map<String, Object> paramMap) throws Exception;
	public List<Map<String,Object>> insertEditorAttachFileProc(List<Map<String,Object>> paramMap) throws Exception;
	public Map<String,Object> insertAttachFileProc(final MultipartHttpServletRequest multiRequest, Map<String,Object> paramMap) throws Exception;
	public void updateAttachBoardSeq(String attachSeq, int boardSeq) throws Exception;
	public void deleteAttachBoardSeq(Map<String, Object> paramMap) throws Exception;
	public int deleteAttachSeqArray(Map<String, List<String>> params) throws Exception;
	public String getContentType(File file) throws Exception;
	public Map<String,Object> getAttachFileDetail(Map<String, Object> paramMap) throws Exception;
	public List<AttachFileVO> retrieveAttachFileList(Map<String, Object> paramMap) throws Exception;
}
