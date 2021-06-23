package com.douzone.devblog.common.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class SampleCommonExceptionAdvice {

	private static final Logger logger = LoggerFactory.getLogger(SampleCommonExceptionAdvice.class);
	
	@ExceptionHandler(Exception.class)
	public ModelAndView common(Exception e) {
		e.printStackTrace();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/common/error/error");
		mv.addObject("Exception", e);

		return mv;
	}
	
	
}
