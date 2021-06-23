package com.douzone.devblog.common.service.impl;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.douzone.devblog.common.service.MailService;

@Service("MailService")
public class MailServiceImpl implements MailService {
	
	private final static Logger logger = LoggerFactory.getLogger(MailServiceImpl.class);
    
    @Autowired
    private Properties config;

    @Bean
    public MailSender mailSender() {
    	
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.ssl.enable", "false");
        properties.setProperty("mail.smtp.starttls.enable", "false");
        properties.setProperty("mail.smtp.auth", "false");
        properties.setProperty("mail.debug", "true");
        
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(config.getProperty("config.mail.host"));
        mailSender.setPort(25);
        mailSender.setDefaultEncoding("utf-8");
        mailSender.setUsername(config.getProperty("config.mail.username"));
        mailSender.setPassword(config.getProperty("config.mail.password"));
        mailSender.setJavaMailProperties(properties);
        
        return mailSender;
    }

	@Override
	@Async
	public boolean send(String subject, String content, String from, String to) {
		logger.debug("send start.");
		
		from = config.getProperty("config.mail.username");
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(from);
		message.setTo(to);
		message.setSubject(subject);
		message.setText(content);
		logger.debug("from="+from + ", to=" + to);
		
		MailSender mailSender = mailSender();
		mailSender.send(message);

		logger.debug("send ended.");
		return true;
	}

	
	
}
