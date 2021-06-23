package com.douzone.devblog.common.advice;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class LoggingAdvice {

	private static Logger logger = LoggerFactory.getLogger(LoggingAdvice.class);
	
	@Around("execution(* com..controller.*Controller.*(..)) "
			+ "|| execution(* com..service.*Impl.*(..)) ")
	public Object logAspect(ProceedingJoinPoint joinPoint) throws Throwable {
		
		String targetClassName = joinPoint.getTarget().getClass().getName();
		String targetmethodName = joinPoint.getSignature().getName();
		
		if (logger.isDebugEnabled()) {
			logger.debug(targetClassName + "." + targetmethodName + " started.");
			
			Object[] args = joinPoint.getArgs();
			
			for (int i = 0; i < args.length; i++) {
				Pattern pattern = Pattern.compile("\\{.+\\}");
				Matcher matcher = pattern.matcher(String.valueOf(args[i]));
				
				if (matcher.find()) {
					logger.debug(i + " : " + args[i]);
				}
			}
		}

		Object returnValue = joinPoint.proceed();

		if (logger.isDebugEnabled()) {
			logger.debug(targetClassName + "." + targetmethodName + " ended.");
		}
	
		return returnValue;
	}

}
