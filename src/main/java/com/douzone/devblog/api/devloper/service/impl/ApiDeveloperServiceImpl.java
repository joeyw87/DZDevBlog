package com.douzone.devblog.api.devloper.service.impl;

import java.util.ArrayList;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.douzone.devblog.api.devloper.dao.ApiDeveloperDAO;
import com.douzone.devblog.api.devloper.service.ApiDeveloperService;

/**
 * ApiDeveloperServiceImpl
 * @version 1.0
 */
@Service("ApiDeveloperService")
public class ApiDeveloperServiceImpl implements ApiDeveloperService {

	@Resource(name = "ApiDeveloperDAO")
	private ApiDeveloperDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(ApiDeveloperServiceImpl.class);

	
	
}

