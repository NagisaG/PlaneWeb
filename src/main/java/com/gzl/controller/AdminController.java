//package com.gzl.controller;
//
//import com.gzl.service.AdminService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import javax.servlet.http.HttpSession;
//
///**
// * 名称:AdminController
// * 描述:
// *
// * @version 1.0
// * @author:Nagisa
// * @datetime:2023-11-21 16:56
// */
//@Controller
//@RequestMapping("/admin")
//public class AdminController {
//    @Autowired(required = false)
//    private AdminService adminService;
//    @RequestMapping("/index")
//    public String toIndex(HttpSession session){
//        return "index";
//    }
//    @RequestMapping("/toAdminIndex")
//    public String toAdminIndex(HttpSession session){
//        return "adminIndex";
//    }
//}
package com.gzl.controller;

import com.gzl.domain.Admin;
import com.gzl.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired(required = false)
    private AdminService adminService;


    @RequestMapping("/index")
    public String toIndex(HttpServletResponse response, HttpServletRequest request) {
        return "/admin/index";
    }

    @RequestMapping("/toAdminIndex")
    public String toAdminIndex(HttpServletResponse response,HttpServletRequest request) {
        // 方法逻辑
        return "/admin/adminsindex";
    }
    @RequestMapping(value = "/getadminsList", produces = "application/json")
    @ResponseBody
    public List<Admin> getadminsList(HttpServletResponse response,HttpServletRequest request){
        List<Admin> adminsList=adminService.findAllAdmins();
        for(Admin admin:adminsList)
            System.out.println(admin);
        return adminsList;
    }

    @RequestMapping(value = "/insertAdmin", method = RequestMethod.POST, consumes = "application/json")
    public ResponseEntity<String> insertAdmin(@RequestBody Admin admin, HttpServletResponse response, HttpServletRequest request) {
        String username = admin.getUsername();
        List<Admin> adminList = adminService.findAdminByUsername(username);

        if (adminList.isEmpty()) {
            int rowsAffected = adminService.insertAdmin(admin);

            if (rowsAffected > 0) {
                // 插入成功，返回成功的JSON响应
                return new ResponseEntity<>("{\"message\": \"插入成功\"}", HttpStatus.OK);
            } else {
                // 插入失败，返回失败的JSON响应
                return new ResponseEntity<>("{\"message\": \"插入失败\"}", HttpStatus.BAD_REQUEST);
            }
        } else {
            // 用户名已存在，返回相应的JSON响应
            return new ResponseEntity<>("{\"message\": \"用户名已存在，请重新输入\"}", HttpStatus.CONFLICT);
        }
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity updateAdmin(@RequestBody Admin admin,HttpServletResponse response,HttpServletRequest request) {
            int rowsAffected = adminService.updateAdmin(admin);
            if (rowsAffected > 0) {
                return new ResponseEntity<>("{\"message\": \"更新成功\"}", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("{\"message\": \"跟新失败\"}", HttpStatus.BAD_REQUEST);
            }
        }

    @GetMapping("/getAdminById")
    public ResponseEntity<Admin> getAdminById(@RequestParam int id,HttpServletResponse response,HttpServletRequest request) {
        try {
            Admin admin = adminService.getAdminById(id).get(0);
            return ResponseEntity.ok(admin);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity deletrAdmin(@RequestBody Admin admin,HttpServletResponse response,HttpServletRequest request) {
        int rowsAffected = adminService.deleteAdmin(admin);
        if (rowsAffected > 0) {
            return new ResponseEntity<>("{\"message\": \"删除成功\"}", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("{\"message\": \"删除失败\"}", HttpStatus.BAD_REQUEST);
        }
    }
}

