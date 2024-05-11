package com.gzl.controller;
import com.gzl.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
//
///**
// * 名称:LoggedController
// * 描述:
// *
// * @version 1.0
// * @author:Nagisa
// * @datetime:2023-11-18 22:24
// */
@Controller
@RequestMapping("/user")
public class LoggedController extends HttpServlet {
    @Autowired(required = false)
    private AdminService adminService;
    @RequestMapping("/adminindex")
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        HttpSession session = request.getSession();
        System.out.println("Logged页面：" + session.getAttribute("username"));
        Object username = session.getAttribute("username");
        System.out.println(username);

        if (username != null) {
            // 用户已登录，可以直接重定向到首页或其他受保护的资源
            response.sendRedirect(request.getContextPath() + "/index");
        } else {
            // 用户未登录，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/checkLogin/tologin");
        }
    }

    @RequestMapping("/dopost")
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("这是logged的dopost"+username);

        // 假设验证通过
        if (adminService.logInSearch(username, password).size()!=0) {
            // 设置用户信息到会话中，例如用户名
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setMaxInactiveInterval(60 * 60 * 24); // 设置会话有效时间为一天

            // 重定向到管理员首页
            response.sendRedirect(request.getContextPath() + "/admin/index");
        } else {
            // 用户验证失败，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/checkLogin/tologin");
        }
    }
}
//import com.gzl.service.AdminService;
//import org.apache.commons.codec.digest.DigestUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//
//@Controller
//@RequestMapping("/user")
//public class LoggedController extends HttpServlet {
//    @Autowired(required = false)
//    private AdminService adminService;
//
//    @RequestMapping("/adminindex")
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=utf-8");
//        HttpSession session = request.getSession();
//        System.out.println("Logged页面：" + session.getAttribute("username"));
//        Object username = session.getAttribute("username");
//        System.out.println(username);
//
//        if (username != null) {
//            // 用户已登录，可以直接重定向到首页或其他受保护的资源
//            response.sendRedirect(request.getContextPath() + "/admin/index");
//        } else {
//            // 用户未登录，重定向到登录页面
//            response.sendRedirect(request.getContextPath() + "/checkLogin/tologin");
//        }
//    }
//
//    @RequestMapping("/dopost")
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//        System.out.println("这是logged的dopost" + username);
//
//        // 加密密码
//        String hashedPassword = hashPassword(password);
//
//        // 假设验证通过
//        if (adminService.logInSearch(username, hashedPassword).size() != 0) {
//            // 设置用户信息到会话中，例如用户名
//            HttpSession session = request.getSession();
//            session.setAttribute("username", username);
//            session.setMaxInactiveInterval(60 * 60 * 24); // 设置会话有效时间为一天
//
//            // 重定向到管理员首页
//            response.sendRedirect(request.getContextPath() + "/admin/index");
//        } else {
//            // 用户验证失败，重定向到登录页面
//            response.sendRedirect(request.getContextPath() + "/checkLogin/tologin");
//        }
//    }
//
//    // 加密密码的方法
//    private String hashPassword(String password) {
//        return DigestUtils.sha256Hex(password);
//    }
//}

