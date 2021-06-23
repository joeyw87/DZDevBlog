package com.douzone.devblog.company.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.devblog.company.dao.CompanyDAO;
import com.douzone.devblog.company.service.CompanyService;
import com.douzone.devblog.company.vo.CompanyVO;

@Service("CompanyService")
public class CompanyServiceImpl implements CompanyService {

	@Autowired
	CompanyDAO companyDAO;
	
	@Override
	public CompanyVO retrieveCompanyInfo(Map<String, Object> param) {
		return companyDAO.retrieveCompanyInfo(param);
	}

}
