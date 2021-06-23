package com.douzone.devblog.common.utils;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MessageUtils {

	private static MessageSource resource = new ClassPathXmlApplicationContext("config/spring/context-message.xml");
	
	public static String getMessage(String code) {
		return resource.getMessage(code, null, Locale.getDefault());
	}
	
	public static String getMessage(String code, String args[]) {
		return resource.getMessage(code, args, Locale.getDefault());
	}
}
