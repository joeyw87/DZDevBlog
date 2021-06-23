package com.douzone.devblog.common.advice;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.douzone.devblog.main.login.service.LoginService;
import com.douzone.devblog.main.login.vo.LoginVO;

/**
 * 시스템 메인, 서브메뉴 View 요청시 User Action을 기록하는 모듈
 * @version 2019.07.11 yjks 
 */
@Aspect
public class UserActionMonitoringAdvice {

	private static final Logger logger = LoggerFactory.getLogger(UserActionMonitoringAdvice.class);
	
	@Autowired
	LoginService loginService;
	
	/**
	 * execution 메서드 종료 이후에 호출되는 함수
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	//@After("execution(* com..controller.*Controller.view*(..))")
	public Object logAspect(JoinPoint joinPoint) throws Throwable {
				
		// 세션을 확인하기 위해 request를 얻는다.
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
										.currentRequestAttributes())
										.getRequest();
		HttpSession session = request.getSession();
		LoginVO loginVO = (LoginVO) session.getAttribute("loginSession");
		String mainMenu = (String) session.getAttribute("mainMenu") == null 
				? "" : (String) session.getAttribute("mainMenu");
		String subMenu = (String) session.getAttribute("subMenu") == null 
				? "" : (String) session.getAttribute("subMenu");

		if (loginVO != null && !subMenu.equals("")) {
			Map<String, Object> params = new HashMap<>();
			
			params.put("userSeq", loginVO.getUserSeq());
			params.put("mainMenu", mainMenu);
			params.put("subMenu", subMenu);

			logger.debug("create user action history.");
			logger.debug("Main Menu : " + mainMenu);
			logger.debug("Sub  Menu : " + subMenu);

			//personalService.createUserActionInfo(params);
		} else {
			logger.debug("LoginVO is null OR subMenu is empty. user action create fail.");
		}
		
		return joinPoint;
	}
	
}
