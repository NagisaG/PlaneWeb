package com.gzl.CustomerInterceptor;

/**

 /**
 * 名称:CustomerInterceptor
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-06-27 18:35
 */
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

public class CustomerInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session=request.getSession();
        System.out.println("拦截器取得session:"+session.getAttribute("username"));
        Object username=session.getAttribute("username");

        if (username != null) {
            //response.resetBuffer();
            return true;
        } else {
            response.sendRedirect(request.getContextPath() + "/checkLogin/tologin");
            //response.resetBuffer();
            return false;
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        System.out.println("Constomer afterCompletion");
        String logdir = request.getServletContext().getRealPath("log");//获取服务器记录日志log文件所存放的目录位置 -- tomcat下的真实路径+log目录
        //路径不存在就创建
        System.out.println(logdir);
        Path logdirPath = Paths.get(logdir);
        if(Files.notExists(logdirPath)){
            Files.createDirectories(logdirPath);
            System.out.println("创建目录:"+logdirPath);
        }
        //目录存在就将数据[字符]写入
        Path logfile = Paths.get(logdir,"userlog.log");//存放日志的路径+文件名
        BufferedWriter writer = new BufferedWriter(new FileWriter(logfile.toFile(),true));//logfile.toFile() paths转换为File类型 true以追加的方式写入
        String isLoggedIn=(String) request.getSession().getAttribute("username");
        System.out.println(isLoggedIn);
        if(isLoggedIn!=null&&isLoggedIn.length()>0) {
            //获取登录用户信息
            //Users user = (Users)request.getSession().getAttribute("user");
            String username = (String) request.getSession().getAttribute("username");
            // String username = user.getUsername();
            //记录user登录时间，存入日志
            String ipAddress = request.getRemoteAddr();
            // 其他相关信息，如浏览器、操作系统等
            String userAgent = request.getHeader("User-Agent");
            String message = username + " 登录时间：" + new Date() + "IP地址：" + ipAddress + "用户代理：" + userAgent;
            writer.write(message + "\r\n");
            writer.flush();
            writer.close();
        }
    }
}
