package com.gzl.config;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * 名称:PointcutConfig
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-11-25 18:35
 */
@Aspect
@Component
public class PointcutConfig {
    @Pointcut("execution(* com.gzl.controller.AdminController.*(..))")
    public void inSvcLayer() {}
}
