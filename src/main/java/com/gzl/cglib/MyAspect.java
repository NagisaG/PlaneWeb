package com.gzl.cglib;

import com.gzl.service.AdminService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
@Aspect
public class MyAspect {

    @Autowired
    private AdminService adminMapper; // 使用@Autowired注解进行注入

    @Before("com.gzl.config.PointcutConfig.inSvcLayer()")
    public void logBefore(JoinPoint joinPoint) throws IOException {
        Object[] args = joinPoint.getArgs();
        int count=0;
        HttpServletRequest request = (HttpServletRequest) args[args.length - 1];
        HttpServletResponse response = (HttpServletResponse) args[args.length - 2];
        System.out.println(joinPoint.getSignature().getName());
        if (joinPoint.getSignature().getName().equals("toAdminIndex")) {
            if (args != null && args.length > 0) {
                HttpSession session = request.getSession();
                String username = (String) session.getAttribute("username");
                String permit = adminMapper.permissionCheck(username);
                if (permit == null || !permit.equals("一级")) {
                    System.out.println("权限不足");
                    if (!response.isCommitted()&&count==0) {
                        response.sendRedirect("/admin/index");
                    }
                    return;
                }
            }
        }
    }
}

