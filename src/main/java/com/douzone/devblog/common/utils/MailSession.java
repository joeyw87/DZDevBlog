package com.douzone.devblog.common.utils;

import org.springframework.context.annotation.Bean;
import org.springframework.jndi.JndiObjectFactoryBean;

public class MailSession {

    @Bean
    public JndiObjectFactoryBean mailSession() {
        JndiObjectFactoryBean jndi = new JndiObjectFactoryBean();
        jndi.setJndiName("mail/Session");
        jndi.setProxyInterface(MailSession.class);
        
        return jndi;
    }
    
}
