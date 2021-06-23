package com.douzone.devblog.main.login.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.douzone.devblog.common.dao.AbstractDAO;
import com.douzone.devblog.main.login.vo.LoginVO;

@Repository("LoginDAO")
public class LoginDAO extends AbstractDAO {

    /**
     * 로그인 사용자 정보 조회 
     * @param params
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public LoginVO retrieveUserInfo(Map<String, Object> params) throws Exception {
        return (LoginVO) selectOne("LoginDAO.selectUserInfo", params);
    }

	public LoginVO selectUserInfo(String username) {
		 return (LoginVO) selectOne("LoginDAO.selectUser", username);
	}
	
	public LoginVO selectUserNoInfo(String userNo) {
		return (LoginVO) selectOne("LoginDAO.selectUserNoInfo", userNo);
	}

	public int updateUserInfo(Map<String, Object> param) {
		return (int) update("LoginDAO.updateUserInfo", param);
	}
	
}
