package com.douzone.devblog.common.contoller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
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

import com.douzone.devblog.common.service.CommonService;
import com.douzone.devblog.common.utils.DzEditorUtils;
import com.google.common.io.CharStreams;

@RestController
public class CommonController {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonService.class);
	
	@Resource(name="CommonService")
	private CommonService commonService;
	
	@Autowired
	private Properties config;
	
	/**
	 * 공통코드 조회
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/common/retrieveCommonCodeList.do", method= {RequestMethod.POST, RequestMethod.GET})
	public List<Map<String, Object>> retrieveCommonCodeList(
			@RequestBody Map<String, Object> param, 
			HttpServletRequest request) {
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();

		try{
			/*LoginVO loginVo = (LoginVO)servletRequest.getSession().getAttribute("loginVO");
			if(loginVo == null) {
				throw new Exception("Session Login 정보 NULL");
			}*/
		
			returnList = commonService.retrieveCommonCodeList(param).getList();

		}catch(Exception e){
		}
		return returnList;
	}
	
	/**
	 * 더존에디터  v1.1.5.3 생성
	 * @param param
	 * @return
	 */
	@RequestMapping("/editorView.do")
	public ModelAndView editorView(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView();

		params.put("pathSeq", "0");
		String osName = System.getProperty("os.name");
		boolean osBoolean = Pattern.matches("Windows.*",osName);
		
		if (osBoolean == true) {
			params.put("osType", "windows");
			params.put("absolPath", config.getProperty("Upload_Path_Win"));
		} else {
			params.put("osType", "linux");
			params.put("absolPath", config.getProperty("Upload_Path_Linux"));
		}
		
		params.put("webPath", config.getProperty("Upload_Web"));		

		// 기본 옵션 설정값 가져오기
		String op_font = "돋움";
		String op_size = "10pt";
		String op_line = "120";

		params.put("op_font", op_font);
		params.put("op_size", op_size);
		params.put("op_line", op_line);

		mv.addObject("params", params);
		mv.setViewName("/common/editor/dzeditor");

		return mv;
	}
	
	
}
