package com.douzone.devblog.api.test.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.douzone.devblog.common.utils.CommonUtils;
import com.douzone.devblog.common.utils.HttpUtils;
import com.douzone.devblog.common.utils.Utils;
import com.douzone.devblog.main.login.vo.LoginVO;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Controller
public class ApiTestController {
	
	// 로그
	private static final Logger logger = LoggerFactory.getLogger(ApiTestController.class);
	
	/**
	 * API CALL 테스트 페이지 호출
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/test/apiTest.do", method=RequestMethod.GET)
	public ModelAndView apicall(HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		// 디폴트 검색일자 설정
		SimpleDateFormat DateType = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        String nowDate = DateType.format(calendar.getTime());
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        String beforeDate = DateType.format(calendar.getTime()); 
		
		mv.addObject("beforeDate", beforeDate);
        mv.addObject("nowDate", nowDate);
        mv.setViewName("/api/test/apiTest");
		return mv;
	}
	
	
	/**
	 * 전자결재연동 SSO 로그인키 암호화 가져오기
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/test/getLoginIdEnc.do", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getLoginIdEnc(@RequestBody Map<String, Object> param, HttpServletRequest servletRequest) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		Map<String, Object> result = new HashMap();
		
		try {
			String gwLoginId = (String)param.get("gwLoginId");
			String nowTime = CommonUtils.date(new Date(), "yyyyMMddHHmmss"); //현재시간
			String preStr = nowTime+"▦"+gwLoginId; //사용자 id 암호화
			String encStr = CommonUtils.AES128_Encode(preStr); //암호화된 사용자 id
			mv.addObject("loginIdEnc", encStr);
			mv.addObject("resultCode", "SUCCESS");
			
		}catch(Exception e) {
			logger.error(CommonUtils.makeStackTrace(e));
			mv.addObject("resultCode", "FAIL");
			mv.addObject("resultMsg", "처리 실패.");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	/**
	 * 전자결재연동 SSO 로그인키 암호화 디코딩값 가져오기
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/test/getLoginIdEncRollBack.do", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getLoginIdEncRollBack(@RequestBody Map<String, Object> param, HttpServletRequest servletRequest) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		Map<String, Object> result = new HashMap();
		
		try {
			String gwLoginId = (String)param.get("gwLoginIdEnc");
			String aesKey = "";
			String loginIdDec = Utils.AESEX_ExpirDecode(gwLoginId, aesKey, 60);
			mv.addObject("loginIdDec", loginIdDec);
			mv.addObject("resultCode", "SUCCESS");
			
		}catch(Exception e) {
			logger.error(CommonUtils.makeStackTrace(e));
			mv.addObject("resultCode", "FAIL");
			mv.addObject("resultMsg", "처리 실패.");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	/**
	 * SSO연동 ssoKey 암호화 가져오기
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/test/getSsoKeyEnc.do", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getSsoKeyEnc(@RequestBody Map<String, Object> param, HttpServletRequest servletRequest) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		Map<String, Object> result = new HashMap();
		
		try {
			String ssoKeyStr = (String)param.get("ssoKeyStr");
			String nowTime = CommonUtils.date(new Date(), "yyyyMMddHHmmss"); //현재시간
			String preStr = nowTime+"▦"+ssoKeyStr; //사용자 id 암호화
			String encStr = CommonUtils.AES128EX_Encode(preStr,"1023497555960596"); //암호화된 사용자 id
			mv.addObject("ssoKeyEnc", encStr);
			mv.addObject("resultCode", "SUCCESS");
			
		}catch(Exception e) {
			logger.error(CommonUtils.makeStackTrace(e));
			mv.addObject("resultCode", "FAIL");
			mv.addObject("resultMsg", "처리 실패.");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	/**
	 * 전자결재연동 SSO 문서삭제처리 API 테스트 JSON응답
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/test/deleteApiCall.do", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView deleteApiCall(@RequestBody Map<String, Object> param, HttpServletRequest servletRequest) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		Map<String, Object> result = new HashMap();
		
		HttpSession session = servletRequest.getSession( true );
		
		try {
			String loginId = (String)param.get("gwLoginId");
			String approKey = (String)param.get("approKey");
			String outProcessCode = (String)param.get("outProcessCode");
			String mod = (String)param.get("mod");
			String gwUrl = (String)param.get("gwUrl");
			
			
			String resultHttp = "";
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("approKey", approKey);
			jsonObject.put("outProcessCode", outProcessCode);
			jsonObject.put("loginId", loginId);
			jsonObject.put("mod", mod);
			//resultHttp = HttpUtils.execute( "GET", gwUrl, jsonObject );
			String urlParam = HttpUtils.formEncode(jsonObject);
			String tUrl = gwUrl +"?"+ urlParam;
			
			/* GET 호출 1 */
			param.put("sessionId", servletRequest.getRequestedSessionId());
			HttpUtils httpUtils = null;
			httpUtils = HttpUtils.getInstance();
			String resultStr = httpUtils.SendGetMethodSession( tUrl, (String)param.get("sessionId") );
			logger.debug("####resultStr ======= " + resultStr);
			
			
			/* GET 호출 2 */
			URL u = null;
			HttpURLConnection request = null;
			String json = "";
			try {	
				u = new URL(tUrl);
				request = (HttpURLConnection)u.openConnection();

				request.setRequestProperty("Content-Type", "text/json");
				request.setRequestMethod("GET");

				InputStream is = request.getInputStream();
				Writer writer = new StringWriter();

				char[] buffer = new char[1024];
				try{
					Reader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
					int n;
					while ((n = reader.read(buffer)) != -1) 
					{
						writer.write(buffer, 0, n);
					}

					logger.debug(" writer.toString() : " + writer.toString());
					json = writer.toString();
				}finally{
					is.close();
					writer.close();
				}
			}
			catch(Exception e) {
				StringWriter sw = new StringWriter();
				e.printStackTrace(new PrintWriter(sw));
				String exceptionAsStrting = sw.toString();
				//param.put("errorMsg", exceptionAsStrting);  // 				, #{errorMsg}
				//param.put("errorCode", e.getMessage());  //   				, #{errorCode}
			}
			JSONObject jsonObject2 = JSONObject.fromObject(JSONSerializer.toJSON(json));
			
			mv.addObject("resultHttp", resultHttp);
			mv.addObject("resultCode", "SUCCESS");
			
		}catch(Exception e) {
			logger.error(CommonUtils.makeStackTrace(e));
			mv.addObject("resultCode", "FAIL");
			mv.addObject("resultMsg", "처리 실패.");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	/**
	 * 패키지 전자결재 가져오기 API
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/test/getEapLineList.do", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getEapLineList(@RequestBody Map<String, Object> param, HttpServletRequest servletRequest) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		Map<String, Object> result = new HashMap();
		
		try {
						
			String url = "http://58.224.117.51/eap/restful/ea/GetEaAppLineList";
			String resultHttp = "";
						
			JSONObject jsonBodyContent = new JSONObject();
		    jsonBodyContent.put("companyInfo", "");
		    jsonBodyContent.put("formId", "");
		    jsonBodyContent.put("erpEmpSeq", "5555");
		    jsonBodyContent.put("erpCompSeq", "10000");
		    
		    /* 전자결재 연동 파리미터 조합 */
		    JSONObject jsonBody = new JSONObject();
		    jsonBody.put("body", jsonBodyContent);

		    HttpUtils httpUtils = HttpUtils.getInstance();
		    resultHttp = httpUtils.SendPostMethodByJson(url, jsonBody);

			mv.addObject("result", result);
			mv.setViewName("jsonView");

		}catch(Exception e) {
			logger.error(CommonUtils.makeStackTrace(e));
			mv.addObject("result", "FAIL");
		}

		return mv;
	}
	
	
	/**
	 * 패키지 전자결재 문서 삭제 API - SSO X
	 * 문서일괄 삭제 interlock
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/api/test/eaDocDeleteApi.do", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView eaDocDeleteApi(@RequestBody Map<String, Object> param, HttpServletRequest servletRequest) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		Map<String, Object> result = new HashMap();
		
		try {
			
			String url = "http://58.224.117.51/eap/interlock/ea/SetEaDocMultiDel.do";
			String resultHttp = "";
			
			JSONObject jsonHeader = new JSONObject();
			jsonHeader.put("groupSeq", "SITestServerP");
			jsonHeader.put("empSeq", "1246");
			jsonHeader.put("tId", "CUST_TEST_1111");
			
			/* 삭제문서 리스트 세팅 */
			List<Map<String, Object>> docList = new ArrayList<Map<String,Object>>();
			Map<String, Object> docItem = new HashMap<String,Object>();
			docItem.put("docId", "691");
			docList.add(docItem);
			
			Map<String, Object> companyInfo = new HashMap<String,Object>();
			companyInfo.put("compSeq", "3583");
			companyInfo.put("bizSeq", "3583");
			companyInfo.put("deptSeq", "3585");
			
			JSONObject jsonBodyContent = new JSONObject();
		    jsonBodyContent.put("companyInfo", companyInfo);
		    jsonBodyContent.put("docList", docList);
		    
		    /* 전자결재 연동 파리미터 조합 */
		    JSONObject jsonBody = new JSONObject();
		    jsonBody.put("header", jsonHeader);
		    jsonBody.put("body", jsonBodyContent);

		    HttpUtils httpUtils = HttpUtils.getInstance();
		    resultHttp = httpUtils.SendPostMethodByJson(url, jsonBody);
		    
		    JSONObject jResult = new JSONObject(); // response body
		    jResult = JSONObject.fromObject(resultHttp);

			mv.addAllObjects(Utils.convertStringToMap(jResult.toString()));
			mv.setViewName("jsonView");

		}catch(Exception e) {
			logger.error(CommonUtils.makeStackTrace(e));
			mv.addObject("result", "FAIL");
		}

		return mv;
	}
	
}
