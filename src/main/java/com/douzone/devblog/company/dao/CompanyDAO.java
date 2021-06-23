package com.douzone.devblog.company.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.douzone.devblog.common.dao.AbstractDAO;
import com.douzone.devblog.company.vo.CompanyVO;

@Repository("CompanyDAO")
public class CompanyDAO extends AbstractDAO{

	
	public CompanyVO retrieveCompanyInfo(Map<String, Object> param) {
		return (CompanyVO) selectOne("CompanyDAO.retrieveCompanyInfo", param);
	}

}
