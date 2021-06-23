package com.douzone.devblog.main.login.service;

import java.util.Map;

import com.douzone.devblog.main.login.vo.LoginVO;

/**
 * 로그인 관련 인터페이스 
 */
public interface LoginService {
	
    /**
     * 로그인 유저 정보 조회 
     */
	public LoginVO retrieveUserInfo(Map<String, Object> params) throws Exception;
	
	/**
     * 로그인 유저 정보 조회 
     */
	public LoginVO selectUserNoInfo(String userNo) throws Exception;
	
	/**
	 * 로그인 비밀번호 조회 
	 */
	
	/**
	 * 로그인 아이디 조회
	 */
	
	/**
	 * 유저 탈퇴 (삭제) 처리 
	 */
	
	public LoginVO selectUserInfo(String username) throws Exception;

	/**
	 * 유저 정보 수정
	 */
	public String updateUserInfo(Map<String, Object> param);
	
}
