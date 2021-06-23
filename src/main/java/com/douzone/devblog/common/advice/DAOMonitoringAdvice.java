package com.douzone.devblog.common.advice;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StopWatch;

public class DAOMonitoringAdvice {

	private static Logger logger = LoggerFactory.getLogger(DAOMonitoringAdvice.class);
	
	public Object doDAOMonitoring(ProceedingJoinPoint pjp) throws Throwable {
		StopWatch clock = new StopWatch("Profiling...");
		
		Object returnValue;
		
		try {
			clock.start(pjp.toShortString());
			returnValue = pjp.proceed();
		} finally {
			clock.stop();
		}
		
		
		if (clock.getTotalTimeMillis() > 500) {
			if (logger.isWarnEnabled()) {
				logger.warn("Execution Location: " + pjp.getTarget().getClass().getName());
				logger.warn("Execution Method: " + pjp.toShortString());
				logger.warn("Execution Time: " + clock.prettyPrint());
			}
		}
		
		return returnValue;
		
	}
	
}
