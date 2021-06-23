package com.douzone.devblog.common.contoller;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.devblog.common.service.FileUploaderService;
import com.douzone.devblog.common.utils.DzEditorUtils;
import com.google.common.io.CharStreams;

/**
 * 헬프데스크 첨부파일 업로드&다운로드 Controller 클래스
 * 
 * @author joeyw
 * @version 2019-07-22
 */
@RestController
public class FileUploaderController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUploaderService.class);
	
	@Resource(name="FileUploaderService")
	private FileUploaderService fileUploaderService;
		
	@Autowired
	private Properties config;
	
	/**
	 * 더존에디터  서버 로직(업로드 등) 처리
	 * @param param
	 * @return
	 */
	@RequestMapping("/common/DzEditorImageUpload.do")
    public void DzEditorImageUpload(@RequestParam Map<String,Object> paramMap, HttpServletRequest request, HttpServletResponse res) throws Exception{
		
		String uploadPath = "";
		String fileName = "";
		String sReturn = "";
		String type = (String)paramMap.get("type");
		logger.debug("## DzEditorImageUpload.do [type] == "+type);
		
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
						
		if(type.equals("save_contents")){
			request.setCharacterEncoding("UTF-8");
			
			String strCR = "\r\n";
			
			String curUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
			
			String contents = request.getParameter("content");
			contents = new String(contents.getBytes("iso-8859-1"), "UTF-8"); //한글깨짐 방지 
			contents = contents.replaceAll("&nbsp;", " ");
			contents = contents.replaceAll("&lt;", "<");
			contents = contents.replaceAll("&gt;", ">");
			contents = contents.replaceAll("&amp;", "&");
			contents = contents.replaceAll("&quot;", "\"");
			contents = contents.replaceAll("&apos;", "'");
			
			if ("windows".equals(osName)) { //로컬테스트 용
//				contents = contents.replaceAll("src=\"/upload/editorImg/", "src=\"" + "d:/upload/editorImg/");
				contents = contents.replaceAll("src=\"/upload/editorImg/", "src=\"" + "c:/upload/editorImg/");
			} else {
				contents = contents.replaceAll("src=\"/upload/editorImg/", "src=\"" + curUrl + "/upload/editorImg/");	
			}
			
			String strHTML = "";
			strHTML += "<html>";
			strHTML += strCR;
			strHTML += "<head>";
			strHTML += strCR;
			strHTML += "<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />";
			strHTML += strCR;
			strHTML += "<title></title>";
			strHTML += strCR;
			strHTML += "</head>";
			strHTML += strCR;
			strHTML += "<body>";
			strHTML += strCR;
			strHTML += contents;
			strHTML += strCR;
			strHTML += "</body>";
			strHTML += strCR;
			strHTML += "</html>";
			strHTML += strCR;

			String strFileName = "duzon_content.html";
			
			res.setHeader("Pragma","public");
			res.setHeader("Expires","0");
			res.setHeader("Content-Type","application/octet-stream");
			res.setHeader("Content-disposition","attachment; filename=" + strFileName);
			res.setHeader("Content-Transfer-Encoding","binary");
			
//			out.print(strHTML);
			res.setCharacterEncoding("UTF-8");
			res.setContentType("text/html; charset=UTF-8");
			logger.debug("DzEditorImageUpload.do result == > " + strHTML);
	        res.getWriter().println(strHTML);
	        res.getWriter().close();
	        return;
	        
		}
		else if(type.equals("form_upload_image") || type.equals("dnd_upload_image")){
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
			MultipartFile uploadFile = multipartRequest.getFile("dze_upimage_file");

			if(!uploadFile.equals(null) && uploadFile.getSize() > 0){
				String editorParam = (String)paramMap.get("tosavepathurl");
				fileName = uploadFile.getOriginalFilename();
				fileName = new String(fileName.getBytes("iso-8859-1"), "UTF-8"); //한글깨짐 방지 
				String saveFileName  = java.util.UUID.randomUUID().toString() + "." + fileName.substring(fileName.lastIndexOf( "." ) + 1);
				DzEditorUtils.saveFile(uploadFile.getInputStream(), new File(editorParam.split("\\$")[1] + "/editorImg/" + saveFileName));
				//uploadPath = editorParam.split("\\$")[0] + "/editorImg/" + saveFileName;
				uploadPath = editorParam.split("\\$")[0] + "/editorImg/" + saveFileName;
				
				JSONObject json = new JSONObject();
				
				json.put("result", "success");
				json.put("type", type);
				json.put("filename", fileName);
				json.put("url", uploadPath);
				
				sReturn = json.toString();
			}
		}
		else if(type.equals("form_upload_extfile")){
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
			MultipartFile uploadFile = multipartRequest.getFile("dze_up_extfile");

			if(!uploadFile.equals(null) && uploadFile.getSize() > 0){
				
				String editorParam = (String)paramMap.get("tosavepathurl");
				fileName = uploadFile.getOriginalFilename();
				fileName = new String(fileName.getBytes("iso-8859-1"), "UTF-8"); //한글깨짐 방지 
				String saveFileName  = java.util.UUID.randomUUID().toString() + "." + fileName.substring(fileName.lastIndexOf( "." ) + 1);
				
				//paramMap.put("groupSeq", loginVO.getGroupSeq());
				paramMap.put("pathSeq", "0");
				//paramMap.put("osType", osName);
				
				String relativePath = File.separator + "dzeditor_ext";

				String path = absolPath + relativePath + File.separator + saveFileName;
				
				//File Id 생성(성공시 return)
				paramMap.put("value", "atchfileid");
				int attchNo = fileUploaderService.getAttachSeq(paramMap);
				
				long size = DzEditorUtils.saveFile(uploadFile.getInputStream(), new File(path));
				
				List<Map<String,Object>> saveFileList  = new ArrayList<Map<String,Object>>();		// 파일 저장 리스트
				HashMap<String,Object> newFileInfo = new HashMap<String,Object>();
				newFileInfo.put("attchNo", attchNo);
				newFileInfo.put("fileSn", "0");
				newFileInfo.put("pathSeq", "0");
				newFileInfo.put("fileStreCours", relativePath);
				newFileInfo.put("streFileName", saveFileName.substring(0,saveFileName.lastIndexOf( "." )));
				newFileInfo.put("orignlFileName", fileName.substring(0,fileName.lastIndexOf( "." )));
				newFileInfo.put("fileExtsn", fileName.substring(fileName.lastIndexOf( "." ) + 1));
				newFileInfo.put("fileSize", size);
				//newFileInfo.put("createSeq", loginVO.getUniqId());
				newFileInfo.put("inpName", uploadFile.getName());
				saveFileList.add(newFileInfo);
				
				//DB Insert
				List<Map<String,Object>> resultFileIdList = fileUploaderService.insertEditorAttachFileProc(saveFileList);
				
				//uploadPath = editorParam + "/common/fileDownloadProc.do?attachNo=" + attachNo;
				//TODO 헬프데스크) 다운 로직 개발해야 함
				uploadPath = editorParam + "/common/down.do?attchNo=" + attchNo;
				
				JSONObject json = new JSONObject();
				json.put("result", "success");
				json.put("type", type);
				json.put("filename", fileName);
				json.put("url", uploadPath);
				
				sReturn = json.toString();
			}
			
		}
		else if(type.equals("paste_image")){
			
			String dze_upimage_data = (String)paramMap.get("dze_upimage_data");
			
			if(!dze_upimage_data.equals(null) && !dze_upimage_data.equals("")){
				Base64 decoder = new Base64(); 
				dze_upimage_data = dze_upimage_data.substring(dze_upimage_data.indexOf(",")+1);
				byte[] dArray = decoder.decode(dze_upimage_data.getBytes());
				InputStream inputStream = new ByteArrayInputStream(dArray);
				String editorParam = (String)paramMap.get("tosavepathurl");
				fileName = java.util.UUID.randomUUID().toString() + ".png";
				DzEditorUtils.saveFile(inputStream, new File(editorParam.split("\\$")[1] + "/editorImg/" + fileName));
				uploadPath = editorParam.split("\\$")[0] + "/editorImg/" + fileName;				
				
				JSONObject json = new JSONObject();
				json.put("result", "success");
				json.put("type", type);
				json.put("filename", fileName);
				json.put("url", uploadPath);
				sReturn = json.toString();					
			}
		}
		else if(type.equals("openfile")){
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
			MultipartFile uploadFile = multipartRequest.getFile("openfile");
			
			byte[] byteArray = uploadFile.getBytes();
			sReturn = CharStreams.toString(new InputStreamReader(uploadFile.getInputStream(), DzEditorUtils.charLength(byteArray) ? StandardCharsets.UTF_8 : Charset.forName("EUC-KR")));
			
		}
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		logger.debug("DzEditorImageUpload.do result == > " + sReturn);
        res.getWriter().println(sReturn);
        res.getWriter().close();
    }
	
	
	/**
	 * 첨부파일 파일업로드 서버 로직 처리 (개발중..)
	 * @param param
	 * @return
	 */
	/*@RequestMapping("/common/fileUploadProc.do")
    public ModelAndView fileUploadProc(MultipartHttpServletRequest multiRequest, @RequestParam Map<String,Object> paramMap) throws Exception {
		logger.debug("## fileUploadProc.do [paramMap] == "+paramMap);
		
		ModelAndView mv = new ModelAndView();
		
		*//** return 메세지 설정 *//*
		Map<String,Object> messageMap = new HashMap<String,Object>();
		messageMap.put("mKey", "resultMessage");
		messageMap.put("cKey", "resultCode");
		messageMap.put("codeHead", "systemx.attach.");
		
		String empSeq = paramMap.get("empSeq") + "";
		
		*//** 파일 체크  *//*
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		if(paramMap.containsKey("file0") && files.isEmpty()){
			int cnt = Integer.parseInt(paramMap.get("attFileCnt").toString()); 
			
			for(int i=0;i<cnt;i++){
				String fileInfo = paramMap.get("file" + i).toString();
				String filePath = fileInfo.split("\\|")[0];
				String fileNm = fileInfo.split("\\|")[1];
				
				File file = new File(filePath + "/" + fileNm);
			    FileInputStream input = new FileInputStream(file);
			    MultipartFile multipartFile = new MockMultipartFile("file" + i,file.getName(), "text/plain", IOUtils.toByteArray(input));
			    files.put("file" + i, multipartFile);
			}
		}		
		
		if (files.isEmpty()) {
			mv.addObject("resultCode", "FAIL");
			mv.addObject("resultMessage", "파일이 없습니다.");
			
			return mv;
		}

		*//** 파일 ROOT 경로 체크 *//*
		String pathSeq = paramMap.get("pathSeq")+"";
		if (DzEditorUtils.isEmpty(pathSeq)) {
			messageMap.put("code", "AF0040");
			mv.addObject("result", "");
			return mv;
		}
		*//** 경로설정 조회 *//*
		String osName = System.getProperty("os.name");
		String absolPath = "";
		boolean osBoolean = Pattern.matches("Windows.*",osName);
		if(osBoolean == true){
			osName = "windows";
			absolPath = "d:/upload";
		}else{
			osName = "linux";
			absolPath = "/home/upload";
		}		
		paramMap.put("osType", osName);
		
		*//** 파일 절대경로  *//*
		String rootPath = absolPath;
		
		*//** 상대경로 *//*
		String relativePath = paramMap.get("relativePath")+"";
		*//** 상대경로가 없다면 기본경로 + 현재날짜 *//*
		if(DzEditorUtils.isEmpty(relativePath)) {
			relativePath = File.separator + "base"+ File.separator + DzEditorUtils.today("yyyy")+File.separator+DzEditorUtils.today("MM")+File.separator+DzEditorUtils.today("dd");
		} else {
			 경로 구분자 추가 
			if(!relativePath.startsWith("/")) {
				relativePath = File.separator + relativePath;
			}
		}
		
		*//** File Id 생성(성공시 return) *//*
		paramMap.put("value", "atchfileid");
		int fileId = commonService.getAttachNo(paramMap);
		
		
		*//** 입사처리 페이지에서 등록한 사인 이미지인 경우 t_co_emp file_id 업데이트 *//*
		String empFlag = paramMap.get("empSeq") + "";
		if(!DzEditorUtils.isEmpty(empFlag)){
			if((paramMap.get("imgSeq")+"").equals("sign")){
				Map<String, Object> empMap = new HashMap<String, Object>();
				empMap.put("empSeq", empFlag);
				empMap.put("imgSeq", paramMap.get("imgSeq"));
				empMap.put("fileId", fileId);
				
				//empManageService.updateEmpPicFileId(empMap);
			}				
		}
		
		*//** save file *//*
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		int fileSn = 0; 																	// 파일 순번
		List<Map<String,Object>> saveFileList  = new ArrayList<Map<String,Object>>();		// 파일 저장 리스트
		Map<String,Object> newFileInfo = null;
		String path = rootPath + File.separator + relativePath;								// 저장 경로
		long size = 0L;																		// 파일 사이즈
		MultipartFile file = null;
		
		// 파일마다 새로운 file id로 생성할것인가..
		boolean isNewId = paramMap.get("isNewId") != null && paramMap.get("isNewId").equals("true") ? true : false;

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			String orginFileName = file.getOriginalFilename();								// 원본 파일명

			 확장자 
			int index = orginFileName.lastIndexOf(".");
			if (index == -1) {
				continue;
			}
			
			String fileExt = orginFileName.substring(index + 1);
			orginFileName = orginFileName.substring(0, index);

			String newName =  DzEditorUtils.today("yyyyMMdd_HHmmss") +"_"+fileId+"_"+fileSn;	// 저장할 파일명
			String saveFilePath = path+File.separator+newName+"."+fileExt;
			
			
			*//** 회사로고 저장경로 다시 설정. *//*
			if(entry.getKey().toString().equals("IMG_COMP_LOGO") || entry.getKey().toString().equals("IMG_COMP_FOOTER") || entry.getKey().toString().equals("IMG_COMP_LOGIN_LOGO_A") || entry.getKey().toString().equals("IMG_COMP_LOGIN_LOGO_B") || entry.getKey().toString().equals("IMG_COMP_LOGIN_BANNER_A") || entry.getKey().toString().equals("IMG_COMP_LOGIN_BANNER_B")){
				newName = entry.getKey().toString() + "_" + "helpDesk";
				path = rootPath + File.separator + "logo" + File.separator + "helpDesk";
				saveFilePath = path + File.separator + newName + "." + fileExt;				
				relativePath = File.separator + "logo" + File.separator + "helpDesk";
			}
			
			size = DzEditorUtils.saveFile(file.getInputStream(), new File(saveFilePath));
			
			//DRM 체크
			//drmService.drmConvert("U", loginVO.getGroupSeq(), pathSeq, path, newName, fileExt);
			
			if (size > 0) {
				newFileInfo = new HashMap<String,Object>();
				newFileInfo.put("fileId", fileId);
				newFileInfo.put("fileSn", fileSn);
				newFileInfo.put("pathSeq", pathSeq);
				newFileInfo.put("fileStreCours", relativePath);
				newFileInfo.put("streFileName", newName);
				newFileInfo.put("orignlFileName", orginFileName);
				newFileInfo.put("fileExtsn", fileExt);
				newFileInfo.put("fileSize", size);
				newFileInfo.put("createSeq", "");
				newFileInfo.put("inpName", file.getName());
				saveFileList.add(newFileInfo);
				fileSn++;
			}
			
			*//** field id를 파일별로 다른경우 *//*
			if(isNewId) {
				paramMap.put("value", "atchfileid");
				fileId = commonService.getAttachNo(paramMap);
				fileSn = 0;
			}
			
		}
		
		*//** 파일 저장 리스트 확인 *//*
		if (saveFileList.size() < 1) {
			messageMap.put("code", "AF0090");
			return mv;
		}
		
		*//** DB Insert *//*
		List<Map<String,Object>> resultFileIdList = commonService.insertAttachFile(saveFileList);
		
		*//** insert 결과 체크 *//*
		if(resultFileIdList == null || resultFileIdList.size() == 0) {
			messageMap.put("code", "AF0090");
			return mv;
		} else {
			messageMap.put("code", "SUCCESS");
		}
		
		*//** field id를 파일별로 다른경우 *//*
		if (isNewId) {
			StringBuffer sb = new StringBuffer();
			for(int i = 0; i < resultFileIdList.size(); i++) {
				Map<String,Object> m = resultFileIdList.get(i);
				sb.append(m.get("inpName")+"");
				sb.append("|");
				sb.append(m.get("fileId")+"");
				if (i < resultFileIdList.size()-1) {
					sb.append(";");
				}
			}
			
			mv.addObject("fileList", sb.toString());
		} 
		*//** 일반적인 경우 fileId만 리턴 *//*
		else {
			if (resultFileIdList != null && resultFileIdList.size() > 0) {
				mv.addObject("fileId", resultFileIdList.get(0).get("fileId"));
			} else {
				mv.addObject("fileId", null);
			}
		}
		
		String datatype = paramMap.get("dataType")+"";
		if (DzEditorUtils.isEmpty(datatype)||datatype.equals("json")) {
			mv.setViewName("jsonView");
		} 
		else if (datatype.equals("page")) {			
			if(!DzEditorUtils.isEmpty(paramMap.get("displayText")+"")){
				String displayText = URLEncoder.encode(paramMap.get("displayText")+"", "UTF-8");
				paramMap.put("displayText", displayText);
			}
			mv.setViewName("redirect:"+paramMap.get("page")+"?"+DzEditorUtils.getUrlParameter(paramMap));
		}
		//페이지명
		else {
			mv.setViewName(datatype);
		}
		
		return mv;
	}*/
	
	/**
	 * 파일업로드 뷰
	 * @param param
	 * @return
	 */
	@RequestMapping("/common/fileUploadView.do")
	public ModelAndView fileUploadView(@RequestParam Map<String,Object> params, HttpServletRequest request) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("uploadMode",params.get("uploadMode"));
		
		//업로드용량제한 파라미터 체크
		if(params.get("allowFileSize") != null && !params.get("allowFileSize").toString().equals("")){
			String allowFileSize = params.get("allowFileSize") + "";
			try{
				int checkSize = Integer.parseInt(allowFileSize);
				mv.addObject("allowFileSize", checkSize);
			}catch(Exception E){
				mv.addObject("allowFileSize", "");
			}
		}
		
		if(params.get("allowFileCnt") != null && !params.get("allowFileCnt").toString().equals("")){
			try{
				mv.addObject("allowFileCnt", Integer.parseInt(params.get("allowFileCnt").toString()));
			}catch(Exception e){
				mv.addObject("allowFileCnt", "");
			}			
		}
		
		params.put("pathSeq", "0");
		
		// 경로설정 조회
		String osName = System.getProperty("os.name");
		String absolPath = "";
		boolean osBoolean = Pattern.matches("Windows.*",osName);
		
		if (osBoolean == true) {
			osName = "windows";
			absolPath = config.getProperty("Upload_Path_Win"); // TODO : upload path
		} else {
			osName = "linux";
			absolPath = config.getProperty("Upload_Path_Linux"); 
		}
		
		params.put("osType", osName);
		params.put("absolPath", absolPath);		
		
		mv.addObject("params", params);
		mv.addObject("pathSeq", params.get("pathSeq"));
		
		//첨부파일 타입 기본값 설정
		String viewType = "Thumbnail";
		
		if (params.get("displayMode") != null && params.get("displayMode").toString().equals("L")) {
			viewType = "List";
		} else if(params.get("viewType") != null) {
			viewType = params.get("viewType").toString();
		}
		
		mv.addObject("viewType", viewType);
		
		if (params.get("uploadMode").equals("U")) {
			
			//확장자 제한 파라미터 체크
			String allowExtention = "";
			String blockExtention = "";
			
			if (params.get("allowExtention") != null && !params.get("allowExtention").toString().equals("")) {
				allowExtention = params.get("allowExtention").toString();
			} else {
				
			}
			
			mv.addObject("allowExtention", "");
			mv.addObject("blockExtention", "");
			
			//자동첨부 파일리스트 조회
			if (params.get("fileKey") != null && ! params.get("fileKey").toString().equals("")) {
				
				Map<String, Object> mp = new HashMap<String, Object>();
				
				//Map<String, Object> pathMp = (Map<String, Object>) commonSql.select("GroupManage.selectPathInfo", mp);				
				
				String saveFilePath = absolPath + File.separator + "uploadTemp" + File.separator + params.get("fileKey").toString();
				String fileNms = "";
				File folder = new File(saveFilePath);
				File[] listOfFiles = folder.listFiles();
				
				if (listOfFiles != null) {
					
					for (int i=0; i < listOfFiles.length; i++) {
						fileNms = fileNms + listOfFiles[i].getName() + "|";
					}
	
					mv.addObject("deleteYN",params.get("fileKey").toString().substring(0,1));
					mv.addObject("fileNms",fileNms);
					mv.addObject("fileKey",params.get("fileKey"));					
				}
				
				mv.addObject("pathMp", "");
			}
			
		} else {
			//activeX 사용유무 설정값 가져오기
			mv.addObject("activxYn", "N");		
		}
		
		//로컬 파일경로 저장옵션
		mv.addObject("showPath", "0");
		
		//모듈별 첨부파일 보기 설정 옵션 가져오기(문서뷰어 or 파일다운)
		//downloadType : -1 -> 미선택
		//downloadType : 0 -> 문서뷰어+파일다운
		//downloadType : 1 -> 파일다운
		//downloadType : 2 -> 문서뷰어
		String downloadType = "1";
		
		mv.addObject("downloadType", downloadType);
		mv.addObject("loginVO", "");
		
		mv.setViewName("/common/editor/dzuploader");
		return mv;
	}
	
	/**
	 * 파일업로드 서버 업로드 처리 dzuploader
	 * @param param
	 * @return
	 */
	@RequestMapping("/ajaxFileUploadProc.do")
	public ModelAndView ajaxFileUploadProc(MultipartHttpServletRequest multiRequest, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		ModelAndView mv = new ModelAndView();

		/** 파일 체크 */
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (files.isEmpty()) {
			mv.addObject("result", "Empty");
			mv.setViewName("jsonView");
			return mv;
		}

		Long fileTotalSize = 0L;
		
		/** save file */
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator(); // 파일
																					// 순번
		MultipartFile file = null;
		String attachFileNm = "";
		String tempFolder = paramMap.get("tempFolder").toString();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();			
			file = entry.getValue();
			fileTotalSize += file.getSize();
			String orginFileName = file.getOriginalFilename(); // 저장할 파일명
			orginFileName = new String(orginFileName.getBytes("iso-8859-1"), "UTF-8"); //한글깨짐 방지 
			
			/* 확장자 */
			int index = orginFileName.lastIndexOf(".");
			if (index == -1) {
				continue;
			}

			String saveFilePath = tempFolder + File.separator + orginFileName;
			
			File saveFile = new File(saveFilePath);
			
			DzEditorUtils.saveFile(file.getInputStream(), saveFile);
			
			String fileExt = orginFileName.substring(index + 1);
			String newName = orginFileName.substring(0, index);
			String targetPathSeq = paramMap.get("targetPathSeq") + "";
						
			attachFileNm += "|" + orginFileName;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (attachFileNm.length() > 0){
			resultMap.put("attachFileNm", attachFileNm.substring(1));
		}else{
			resultMap.put("attachFileNm", attachFileNm);
		}
		
		mv.addObject("fileTotalSize", fileTotalSize);
		mv.addAllObjects(resultMap);
		mv.setViewName("jsonView");
		return mv;
	}
	
	/**
	 * 첨부파일 업로드 뷰 생성 YW
	 * @param param
	 * @return
	 */
	@RequestMapping("/uploaderView.do")
	public ModelAndView uploaderView(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView();
		
		String osName = System.getProperty("os.name");
		boolean osBoolean = Pattern.matches("Windows.*",osName);

		// TODO: upload path
		if (osBoolean == true) {
			params.put("osType", "windows");
			params.put("absolPath", config.get("Upload_Path_Win"));
		} else {
			params.put("osType", "linux");
			params.put("absolPath", config.get("Upload_Path_Linux"));
		}
		
		params.put("webPath", config.get("Upload_Web"));
		params.put("maxSize", config.get("File_MaxSize")); //개별파일 최대용량 5M
		params.put("maxAllSize", config.get("File_MaxAllSize")); //전체파일 최대용량 10M (10*1024*1024)

		mv.addObject("params", params);
		mv.setViewName("/common/editor/ywuploader");

		return mv;
	}
	
	/**
	 * 파일업로드 서버 업로드 처리 YW
	 * @param param
	 * @return
	 */
	@RequestMapping("/fileUploadProcYW.do")
	public ModelAndView fileUploadProcYW(MultipartHttpServletRequest multiRequest, 
			@RequestParam Map<String, Object> paramMap) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		logger.info("### fileUploadProcYW ###");
		logger.info("paramMap : " + paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		/** 파일 체크 */
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (files.isEmpty()) {
			mv.addObject("result", "Empty");
			mv.setViewName("jsonView");
			return mv;
		}
		
		if("".equals(paramMap.get("boardSeq"))){
			paramMap.put("boardSeq", "");
		}
		resultMap = fileUploaderService.insertAttachFileProc(multiRequest, paramMap);
		mv.addAllObjects(resultMap);
		mv.setViewName("jsonView");
		return mv;
	}
	
	/**
	 * 업로드 된 파일 삭제 함수 
	 *  1. DB
	 *  2. 실제파일 
	 * @param params
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteAttachFile.do", method = RequestMethod.POST)
	public Object deleteAttachFile(@RequestBody Map<String, List<String>> params) {
		// mType=board,  boardType=boardType, attachSeq=attachSeq
		// attachSeq를 통해 deleteYn을 Y로 변경한다.
		// boardType과 savePath에 있는 파일을 삭제한다.
		// 저장 경로 > c:/Upload/Notice/2019/08/21/uuid => 저장하는 패스 컬럼 추가
		int resultCode = 0;
		String returnValue = "ok";
		
		try {
			logger.debug("filesSeq=" + params);
			resultCode = fileUploaderService.deleteAttachSeqArray(params);
			
			if (resultCode < 1) {
				returnValue = "fail";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultCode", resultCode);
		resultMap.put("returnValue", returnValue);
		logger.debug("resultMap=" + resultMap.toString());
		
		return resultMap;
	}
	
	/**
	 * 파일 다운로드 로직(WEB)
	 * @param paramMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/fileDownloadProc.do")
    public void fileDownloadProc(HttpServletRequest request, @RequestParam Map<String, Object> paramMap, 
    		HttpServletResponse response) throws Exception{

		//TODO 추후 login 세션 체크 필요 
		String attachSeq = paramMap.get("attachSeq") != null ? (String) paramMap.get("attachSeq") : "";
		Map<String, Object> fileMap = new HashMap<String, Object>();
		
		//모듈별 공통 필수 변수
		File file = null;
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream out = null;
		
		String path = "";
		String fileName = "";
		String originFileName = "";
		String fileExt = "";
		String imgExt = "jpeg|bmp|gif|jpg|png";
		String absolPath = "";
		
		String osName = System.getProperty("os.name");
		boolean osBoolean = Pattern.matches("Windows.*",osName);
		
		if (osBoolean == true) {
			absolPath = config.getProperty("Upload_Path_Win");
		} else {
			absolPath = config.getProperty("Upload_Path_Linux");
		}
		
		// TODO 추후 게시판 및 각 다운로드 타입 파라미터 정의로 로직 구분 필요. ex) 게시판, 공통 등
		if (paramMap.get("mType") != null && "board".equals(paramMap.get("mType"))) {
			String deleteYn = paramMap.get("deleteYn") != null ?  (String) paramMap.get("deleteYn") : ""; 
			//첨부파일정보 조회
			paramMap.put("attachSeq", attachSeq);
			paramMap.put("deleteYn", deleteYn);
			
			fileMap = fileUploaderService.getAttachFileDetail(paramMap);
			
			if (fileMap == null) {
				return;
			}
			
			String boardType = (String) paramMap.get("boardType");
			path = absolPath + config.getProperty("Upload_Temp");

			if (boardType != null && !boardType.equals("")) {
				path = absolPath + config.getProperty("Upload_" + boardType); 
				logger.debug("get file download path=" + path);
			}
			
			fileExt = fileMap.get("fileExt") + "";	
			fileExt = fileExt.toLowerCase();
			fileName = fileMap.get("saveFileName") + "." + fileExt;
			originFileName = fileMap.get("originFileName") + "." + fileExt;
			
		} else {
			return;
		}
		
		try {
			String filePath = path;
			file = new File(filePath + File.separator + fileName);
		    fis = new FileInputStream(file);

		    in = new BufferedInputStream(fis);
		    out = new ByteArrayOutputStream();

		    int imgByte;
		    byte buffer[] = new byte[2048];
		    
		    while ((imgByte = in.read(buffer)) != -1) {
		    	out.write(buffer, 0, imgByte);
		    }

		    String browser = request.getHeader("User-Agent");
		    
		    //파일 인코딩
		    if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Edge")) {
		    	originFileName = URLEncoder.encode(originFileName,"UTF-8").replaceAll("\\+", "%20"); 
		    } else {
		    	originFileName = new String(originFileName.getBytes("UTF-8"), "ISO-8859-1"); 
		    }
		    
		    String type = "";
			if (fileExt != null && !fileExt.equals("")) {

				if (imgExt.indexOf(fileExt.toLowerCase()) != -1) {
					//이미지 컨텐츠타입 설정
					if (fileExt.toLowerCase().equals("jpg")) {
						type = "image/jpeg";
					} else {
						type = "image/" + fileExt.toLowerCase();
					}
				}		
			}
		    
			if(!type.equals("")) {
				response.setHeader("Content-Type", type);
			} else {
				response.setContentType(fileUploaderService.getContentType(file));
				response.setHeader("Content-Transfer-Encoding", "binary;");
			}

			response.setHeader("Content-Disposition","attachment;filename=\"" + originFileName+"\"");	
		    response.setContentLength(out.size());
		    
		    out.writeTo(response.getOutputStream());
			
		    response.getOutputStream().flush();
			response.getOutputStream().close();
			
		} catch (FileNotFoundException e) {
			logger.error(e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
		} finally {
			if (out != null) {
				out.close();
			}
			if (in != null) {
				in.close();
			}
			if (fis != null) {
				fis.close();
			}
		}
		
    }
	
}
