package com.douzone.devblog.company.service;

import java.util.Map;

import com.douzone.devblog.company.vo.CompanyVO;

public interface CompanyService {

	public CompanyVO retrieveCompanyInfo(Map<String, Object> param);
}
