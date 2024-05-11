package com.gzl.controller;

import com.gzl.domain.Admin;
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
import java.io.PrintWriter;
import java.util.List;

/**
 * 名称:LoginController
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-11-18 22:13
 */
@Controller
@RequestMapping("/checkLogin")
public class LoginController extends HttpServlet {
    @Autowired(required = false)
    private AdminService adminService;
    @RequestMapping("/tologin")
    public String tologin(){
        return "/admin/login";
    }
    @RequestMapping("/doget")
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        System.out.println(username);
        System.out.println(password);
        List<Admin> adminList = adminService.logInSearch(username, password);
        System.out.println(adminList);
        if (adminList.size() != 0) {
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(60 * 60 * 24);
            session.setAttribute("username", username);
            System.out.println("Session是"+session.getAttribute("username"));
            response.sendRedirect(request.getContextPath() + "/admin/index");
            //return "index";
        } else {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter writer = response.getWriter();
            writer.write("<h1>账号或密码错误<h1>");
            writer.write("<h3><a href='" + request.getContextPath() + "/checkLogin/tologin'>点击重新登录</a></h3>");
            //return "login";
        }
    }
    @RequestMapping("/dopost")
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
        request.getSession().setAttribute("isLogged", true);
        System.out.println("这是dopost");
        //response.reset();
    }
}
//@Controller
//@RequestMapping("/checkLogin")
//public class LoginController extends HttpServlet {
//    @Autowired(required = false)
//    private AdminService adminService;
//
//    @RequestMapping("/tologin")
//    public String toLogin() {
//        return "login";
//    }
//
//    @RequestMapping("/doget")
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        // 使用SHA-256对密码进行散列
//        String hashedPassword = hashPassword(password);
//
//        System.out.println(username);
//        System.out.println(hashedPassword);
//        List<Admin> adminList = adminService.logInSearch(username, hashedPassword);
//        System.out.println(adminList);
//        if (adminList.size() != 0) {
//            HttpSession session = request.getSession();
//            session.setMaxInactiveInterval(60 * 60 * 24);
//            session.setAttribute("username", username);
//            System.out.println("Session是" + session.getAttribute("username"));
//            response.sendRedirect(request.getContextPath() + "/index");
//        } else {
//            response.setContentType("text/html;charset=utf-8");
//            PrintWriter writer = response.getWriter();
//            writer.write("<h1>账号或密码错误<h1>");
//            writer.write("<h3><a href='" + request.getContextPath() + "/checkLogin/tologin'>点击重新登录</a></h3>");
//        }
//    }
//
//    @RequestMapping("/dopost")
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        this.doGet(request, response);
//        request.getSession().setAttribute("isLogged", true);
//        System.out.println("这是dopost");
//    }
//
//    private String hashPassword(String password) {
//        try {
//            MessageDigest digest = MessageDigest.getInstance("SHA-256");
//            byte[] hash = digest.digest(password.getBytes());
//            return Hex.encodeHexString(hash);
//        } catch (NoSuchAlgorithmException e) {
//            e.printStackTrace();
//            // Handle the exception appropriately (throw it or log it)
//            return null;
//        }
//    }
//}