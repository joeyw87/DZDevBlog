package com.douzone.devblog.main.login.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.douzone.devblog.common.dao.CommonDAO;
import com.douzone.devblog.main.login.dao.LoginDAO;
import com.douzone.devblog.main.login.service.LoginService;
import com.douzone.devblog.main.login.vo.LoginVO;


@Service("LoginService")
public class LoginServiceImpl implements LoginService, UserDetailsService {

	private final static Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);
	
    @Resource(name="LoginDAO")
    private LoginDAO loginDAO;
    
    @Autowired
    private CommonDAO commonDAO;
    
    /**
     * 로그인 유저 정보 조회
     */
    @Override
    public LoginVO retrieveUserInfo(Map<String, Object> params) throws Exception {
        return (LoginVO) loginDAO.retrieveUserInfo(params);
    }

	@Override
	public LoginVO selectUserInfo(String username) throws Exception {
		return null;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		LoginVO loginVO = loginDAO.selectUserInfo(username);
		
		if (loginVO == null) {
			throw new UsernameNotFoundException(username);
		}
		
		Collection<SimpleGrantedAuthority> roles = new ArrayList<>();
		roles.add(new SimpleGrantedAuthority("ROLE_USER"));
		
		UserDetails user = new User(username, loginVO.getLoginPsswd(), roles);
		
		return user; 
	}

	@Override
	public LoginVO selectUserNoInfo(String userNo) throws Exception {
		return (LoginVO) loginDAO.selectUserNoInfo(userNo);
	}

	@Override
	public String updateUserInfo(Map<String, Object> param) {
		int resultCode = loginDAO.updateUserInfo(param);
		
		if (resultCode < 1) {
			return "fail";
		}
		
		return "ok";
	}
    
}
