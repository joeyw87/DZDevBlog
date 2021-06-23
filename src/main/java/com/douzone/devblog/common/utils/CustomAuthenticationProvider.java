package com.douzone.devblog.common.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.douzone.devblog.main.login.vo.LoginVO;

public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String user_Id = (String) authentication.getPrincipal();
		String user_pw = (String) authentication.getCredentials();
		
		//userService.loadUserByUsername(user_Id);
		
//		if (!passwordEncoder.matches(user_pw, loginVO.getPasswordNow())) {
//			throw new BadCredentialsException("Bad Credentials");
//		}
		
		return new UsernamePasswordAuthenticationToken(user_Id, user_pw);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
	

}
