package com.douzone.devblog.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.douzone.devblog.main.login.service.LoginService;


/**
 * 매핑된 URL로 연결하기 전 Interceptor 로직 검증
 * 
 * @author Yoonjin
 * @version 2019.07.02
 */
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthenticationInterceptor.class);
	
	@Autowired
	LoginService loginService;
	
	@Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		    throws Exception {

		// session check
		HttpSession session = request.getSession();
		Object loginSessionObj = session.getAttribute("loginSession");

		// 로그인 세션이 없으면 login 페이지로 이동한다. 
		if (loginSessionObj == null || loginSessionObj.equals("")) {
			logger.debug("login session is null. redirect login page.");
			response.sendRedirect("/user/login.do");

			return true;
		}

		
		// 그렇지 않으면 통과
		// 이후 구현 로직 작성
		
		return true;
	}

	@Override
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {
		
		super.postHandle(request, response, handler, modelAndView);
	}
}
