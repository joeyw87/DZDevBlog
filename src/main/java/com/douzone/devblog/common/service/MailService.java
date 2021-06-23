package com.douzone.devblog.common.service;

/**
 * 메일 인터페이스(테스트)
 *  
 * @author 김윤진
 */
public interface MailService {
	
	public boolean send(String subject, String content, String from, String to) throws Exception;

}
