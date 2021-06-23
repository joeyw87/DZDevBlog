package com.douzone.devblog.common.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.douzone.devblog.common.dao.FileUploaderDAO;
import com.douzone.devblog.common.service.FileUploaderService;
import com.douzone.devblog.common.utils.DzEditorUtils;
import com.douzone.devblog.common.vo.AttachFileVO;

@Service("FileUploaderService")
public class FileUploaderServiceImpl implements FileUploaderService {
	private static final Logger logger = LoggerFactory.getLogger(FileUploaderServiceImpl.class);
	
	@Resource(name = "FileUploaderDAO")
	private FileUploaderDAO fileUploaderDAO;
	
	@Resource(name = "FileUploaderService")
	private FileUploaderService fileUploaderService;
	
	@Autowired
	private Properties config;
	
	/**
	 * getAttachNo 첨부파일 시퀀스 조회
	 * @param Map<String, Object> param
	 * @return int
	 */
	@Override
	public int getAttachSeq(Map<String, Object> paramMap) throws Exception {
		return (Integer)fileUploaderDAO.getAttachSeq(paramMap);
	}
	
	/**
	 * getAttachNo 첨부파일 DB등록
	 * @param Map<String, Object> param
	 * @return int
	 */
	@Override
	public void insertAttachFile(Map<String, Object> paramMap) throws Exception {
		fileUploaderDAO.insertAttachFile(paramMap);
	}
	
	/**
	 * 에디터 첨부파일 DB저장 프로세스
	 * @param List<Map<String, Object>> paramMap
	 * @return List<Map<String,Object>>
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String,Object>> insertEditorAttachFileProc(List<Map<String, Object>> paramMap) throws Exception{
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String,Object> param = (Map<String,Object>) paramMap.get(0);
		
		try {
			Iterator<?> iter = paramMap.iterator();

			while (iter.hasNext()) {
				param = (Map<String,Object>) iter.next();
				fileUploaderDAO.insertAttachFile(param);
				resultList.add(param);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
		
		return resultList;
	}
	
	/**
	 * insertAttachFileProc 첨부파일 DB저장 프로세스
	 * @param MultipartHttpServletRequest multiRequest, Map<String, Object> paramMap
	 * @return Map<String, Object>
	 */
	@Override
	public Map<String, Object> insertAttachFileProc(final MultipartHttpServletRequest multiRequest, 
			Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "";
		String resultMessage = "";
		
		try {
			Map<String, MultipartFile> files = multiRequest.getFileMap();
			Long fileTotalSize = 0L;
			
			// save file
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file = null;
			String attachFileNm = "";
			String attachFileSeq = "";
			String tempPath = "";
			String osName = System.getProperty("os.name");
			String absolPath = "";
			boolean osBoolean = Pattern.matches("Windows.*",osName);
			
			//TODO 파일절대경로 서버세팅시 맞게 수정해줘야 함. upload path
			if (osBoolean == true) {
				osName = "windows";
				absolPath = config.getProperty("Upload_Path_Win");
			} else {
				osName = "linux";
				absolPath = config.getProperty("Upload_Path_Linux");
			}
			
			if (paramMap.get("boardType") != null && !paramMap.get("boardType").equals("")) {
				tempPath = absolPath + (String) config.get("Upload_" + paramMap.get("boardType"));
			} else {
				tempPath = absolPath + config.getProperty("Upload_Temp"); // TODO: upload path
			}
			
			logger.debug("tempPath=" + tempPath);
			
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();			
				file = entry.getValue();
				fileTotalSize += file.getSize();
				String originFileName = file.getOriginalFilename(); // 저장할 파일명
				originFileName = new String(originFileName.getBytes("iso-8859-1"), "UTF-8"); //한글깨짐 방지 
				int index = originFileName.lastIndexOf("."); // 확장자 체크

				if (index == -1) {
					continue;
				}
				
				String saveFileName  = java.util.UUID.randomUUID().toString() + "." + originFileName.substring(originFileName.lastIndexOf( "." ) + 1);
				String fileExt = originFileName.substring(index + 1); //파일확장자
				String saveFilePath = tempPath + File.separator + saveFileName;
				
				File saveFile = new File(saveFilePath);
				
				DzEditorUtils.saveFile(file.getInputStream(), saveFile);
				
				// DB저장 파라미터 정의
				paramMap.put("originFileName", originFileName.substring(0,originFileName.lastIndexOf( "." )));
				paramMap.put("saveFileName", saveFileName.substring(0,saveFileName.lastIndexOf( "." )));
				paramMap.put("fileExt", fileExt);
				paramMap.put("fileSize", file.getSize());
				paramMap.put("createSeq", "9999"); // TODO: create seq 확인 
				paramMap.put("savePath", tempPath);
				
				// DB저장
				int attachSeq = fileUploaderService.getAttachSeq(paramMap);
				paramMap.put("attachSeq", attachSeq);
				fileUploaderService.insertAttachFile(paramMap);
				
				attachFileNm += "|" + originFileName;
				attachFileSeq += "|" + attachSeq;
			}
			
			if (attachFileNm.length() > 0) {
				resultMap.put("attachFileNm", attachFileNm.substring(1));
				resultMap.put("attachFileSeq", attachFileSeq.substring(1));
			} else {
				resultMap.put("attachFileNm", attachFileNm);
				resultMap.put("attachFileSeq", attachFileSeq);
			}
			
			resultMap.put("fileTotalSize", fileTotalSize);
			resultCode = "SUCCESS";
		} catch(Exception e) {
			resultCode = "FAIL";
			e.printStackTrace();
		} finally {
			resultMap.put("resultCode", resultCode);
			resultMap.put("resultMessage", resultMessage);
		}
		
		return resultMap;
	}
	
	/**
	 * 첨부파일테이블 게시물시퀀스 업데이트 처리
	 * @param Map<String, Object> param
	 * @return int
	 */
	public void updateAttachBoardSeq(String attachSeq, int boardSeq) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		List<String> attachList = new ArrayList<String>();
		
		param.put("boardSeq", boardSeq);	//게시물 시퀀스
		
		String[] attachSeqList = attachSeq.split("\\|");
		
		if(attachSeqList.length > 0){
			for(int i=0; i<attachSeqList.length; i++){
				attachList.add(attachSeqList[i]);
			}
			param.put("attachList", attachList);
			fileUploaderDAO.updateAttachBoardSeq(param);
		}
		
	}
	
	/**
	 * 첨부파일테이블 게시물시퀀스 삭제처리
	 * @param Map<String, Object> param
	 * @return int
	 */
	public void deleteAttachBoardSeq(Map<String, Object> paramMap) throws Exception {
		List<Map<String, Object>> paramList  = new ArrayList<Map<String, Object>>();
		paramList = (List<Map<String, Object>>) paramMap.get("deleteArray");
		
		int boardSeq;
		
		for(Map<String, Object> tmpMap : paramList){
			boardSeq = (int)(tmpMap.get("BOARD_SEQ"));
			fileUploaderDAO.deleteAttachBoardSeq(boardSeq);
		}
	}
	
	public String getContentType(File file){
		String fileName = file.getName();		
		int idx = fileName.lastIndexOf(".");
		
		String fileExtsn = fileName.substring(idx + 1);		
		String contentType = "application/octet-stream";
		
		if(fileExtsn.toLowerCase().equals("aac")){
			contentType = "audio/aac";
		}else if(fileExtsn.toLowerCase().equals("abw")){
			contentType = "application/x-abiword";
		}else if(fileExtsn.toLowerCase().equals("arc")){
			contentType = "application/octet-stream";
		} else if(fileExtsn.toLowerCase().equals("avi")){
			contentType = "video/x-msvideo";
		} else if(fileExtsn.toLowerCase().equals("azw")){
			contentType = "application/vnd.amazon.ebook";
		} else if(fileExtsn.toLowerCase().equals("bin")){
			contentType = "application/octet-stream";
		} else if(fileExtsn.toLowerCase().equals("bz")){
			contentType = "application/x-bzip";
		} else if(fileExtsn.toLowerCase().equals("bz2")){
			contentType = "application/x-bzip2";
		} else if(fileExtsn.toLowerCase().equals("csh")){
			contentType = "application/x-csh";
		} else if(fileExtsn.toLowerCase().equals("css")){
			contentType = "text/css";
		} else if(fileExtsn.toLowerCase().equals("csv")){
			contentType = "text/csv";
		} else if(fileExtsn.toLowerCase().equals("doc")){
			contentType = "application/msword";
		} else if(fileExtsn.toLowerCase().equals("epub")){
			contentType = "application/epub+zip";
		} else if(fileExtsn.toLowerCase().equals("gif")){
			contentType = "image/gif";
		} else if(fileExtsn.toLowerCase().equals("htm")){
			contentType = "text/html";
		} else if(fileExtsn.toLowerCase().equals("html")){
			contentType = "text/html";
		} else if(fileExtsn.toLowerCase().equals("ico")){
			contentType = "image/x-icon";
		} else if(fileExtsn.toLowerCase().equals("ics")){
			contentType = "text/calendar";
		} else if(fileExtsn.toLowerCase().equals("jar")){
			contentType = "application/java-archive";
		} else if(fileExtsn.toLowerCase().equals("jpeg")){
			contentType = "image/jpeg";
		} else if(fileExtsn.toLowerCase().equals("jpg")){
			contentType = "image/jpeg";
		} else if(fileExtsn.toLowerCase().equals("js")){
			contentType = "application/js";
		} else if(fileExtsn.toLowerCase().equals("json")){
			contentType = "application/json";
		} else if(fileExtsn.toLowerCase().equals("mid")){
			contentType = "audio/midi";
		} else if(fileExtsn.toLowerCase().equals("midi")){
			contentType = "audio/midi";
		} else if(fileExtsn.toLowerCase().equals("mpeg")){
			contentType = "video/mpeg";
		} else if(fileExtsn.toLowerCase().equals("mpkg")){
			contentType = "application/vnd.apple.installer+xml";
		} else if(fileExtsn.toLowerCase().equals("odp")){
			contentType = "application/vnd.oasis.opendocument.presentation";
		} else if(fileExtsn.toLowerCase().equals("ods")){
			contentType = "application/vnd.oasis.opendocument.spreadsheet";
		} else if(fileExtsn.toLowerCase().equals("odt")){
			contentType = "application/vnd.oasis.opendocument.text";
		} else if(fileExtsn.toLowerCase().equals("oga")){
			contentType = "audio/ogg";
		} else if(fileExtsn.toLowerCase().equals("ogv")){
			contentType = "video/ogg";
		} else if(fileExtsn.toLowerCase().equals("ogx")){
			contentType = "application/ogg";
		} else if(fileExtsn.toLowerCase().equals("pdf")){
			contentType = "application/pdf";
		} else if(fileExtsn.toLowerCase().equals("ppt")){
			contentType = "application/vnd.ms-powerpoint";
		} else if(fileExtsn.toLowerCase().equals("rar")){
			contentType = "application/x-rar-compressed";
		} else if(fileExtsn.toLowerCase().equals("rtf")){
			contentType = "application/rtf";
		} else if(fileExtsn.toLowerCase().equals("sh")){
			contentType = "application/x-sh";
		} else if(fileExtsn.toLowerCase().equals("svg")){
			contentType = "image/svg+xml";
		} else if(fileExtsn.toLowerCase().equals("swf")){
			contentType = "application/x-shockwave-flash";
		} else if(fileExtsn.toLowerCase().equals("tar")){
			contentType = "application/x-tar";
		} else if(fileExtsn.toLowerCase().equals("tif")){
			contentType = "image/tiff";
		} else if(fileExtsn.toLowerCase().equals("tiff")){
			contentType = "image/tiff";
		} else if(fileExtsn.toLowerCase().equals("ttf")){
			contentType = "application/x-font-ttf";
		} else if(fileExtsn.toLowerCase().equals("vsd")){
			contentType = "application/vnd.visio";
		} else if(fileExtsn.toLowerCase().equals("wav")){
			contentType = "audio/x-wav";
		} else if(fileExtsn.toLowerCase().equals("weba")){
			contentType = "audio/webm";
		} else if(fileExtsn.toLowerCase().equals("webm")){
			contentType = "video/webm";
		} else if(fileExtsn.toLowerCase().equals("webp")){
			contentType = "image/webp";
		} else if(fileExtsn.toLowerCase().equals("woff")){
			contentType = "application/x-font-woff";
		} else if(fileExtsn.toLowerCase().equals("xhtml")){
			contentType = "application/xhtml+xml";
		} else if(fileExtsn.toLowerCase().equals("xls") || fileExtsn.toLowerCase().equals("xlsx")){
			contentType = "application/vnd.ms-excel";
		} else if(fileExtsn.toLowerCase().equals("xml")){
			contentType = "application/xml";
		} else if(fileExtsn.toLowerCase().equals("xul")){
			contentType = "application/vnd.mozilla.xul+xml";
		} else if(fileExtsn.toLowerCase().equals("zip")){
			contentType = "application/zip";
		} else if(fileExtsn.toLowerCase().equals("7z")){
			contentType = "application/x-7z-compressed";
		} else if(fileExtsn.toLowerCase().equals("mp4")){
			contentType = "video/mp4";
		}
		
		return contentType;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getAttachFileDetail(Map<String, Object> paramMap) throws Exception{
		return (Map<String, Object>) fileUploaderDAO.getAttachFileDetail(paramMap);
	}

	/**
	 * 첨부파일 리스트 취득 서비스 
	 */
	@Override
	public List<AttachFileVO> retrieveAttachFileList(Map<String, Object> paramMap) throws Exception {
		return fileUploaderDAO.retrieveAttachFileList(paramMap);
	}

	@Override
	public int deleteAttachSeqArray(Map<String, List<String>> params) throws Exception {
		return fileUploaderDAO.deleteAttachSeqArray(params);
	}
}
