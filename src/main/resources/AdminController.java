package com.museum.controller;

import com.museum.pojo.Admin;
import com.museum.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 名称:AdminController
 * 描述:管理员的控制器
 *
 * @version 1.0
 * &#064;author:Nagisa
 * &#064;datetime:2023-06-26  16:45
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired(required = false)
    private AdminService adminService;

    @RequestMapping(value = "/getAdminsList", produces = "application/json")//获取全部管理员
    @ResponseBody
    public List<Admin> getAdminsList(){
        List<Admin> adminsList=adminService.findAllAdmins();
        for(Admin admin:adminsList)
            System.out.println(admin);
        return adminsList;
    }

    @RequestMapping(value = "/checkLogIn", produces = "application/json")//获取全部管理员
    @ResponseBody
    public ResponseEntity<String> checkLogIn(@RequestBody Admin admin){
        List<Admin> adminList=adminService.logIn(admin.getUsername(),admin.getPassword());
        if(adminList.isEmpty()){
             return new ResponseEntity<>("{\"message\": \"登录失败\"}", HttpStatus.BAD_REQUEST);
        }
        else{
            return new ResponseEntity<>("{\"message\": \"登录成功\"}", HttpStatus.OK);
        }
    }

    @RequestMapping(value = "/insertAdmin", method = RequestMethod.POST, consumes = "application/json")//插入管理员
    public ResponseEntity<String> insertAdmin(@RequestBody Admin admin) {
        //String username = admin.getUsername();
        List<Admin> adminList = adminService.findAdminByUsername(admin);

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
    @RequestMapping(value = "/update", method = RequestMethod.POST)//更新管理员
    @ResponseBody
    public ResponseEntity updateAdmin(@RequestBody Admin admin) {
            int rowsAffected = adminService.updateAdmin(admin);
            if (rowsAffected > 0) {
                return new ResponseEntity<>("{\"message\": \"更新成功\"}", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("{\"message\": \"跟新失败\"}", HttpStatus.BAD_REQUEST);
            }
    }
    @GetMapping("/getAdminById")//根据id查找
    public ResponseEntity<Admin> getAdminById(@RequestParam Integer id) {
        try {
            Admin admin = adminService.findAdminById(id).get(0);
            return ResponseEntity.ok(admin);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @GetMapping("/findAdminByStr")//模糊查询
    public ResponseEntity<List<Admin>> findAdminByStr(@RequestParam String Str) {
        try {
            List<Admin> adminList=adminService.findAdminByStr(Str);
            return ResponseEntity.ok(adminList);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)//删除管理员
    @ResponseBody
    public ResponseEntity deleteAdmin(@RequestBody Admin admin) {
        int rowsAffected = adminService.deleteAdminById(admin);
        if (rowsAffected > 0) {
            return new ResponseEntity<>("{\"message\": \"删除成功\"}", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("{\"message\": \"删除失败\"}", HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value ="/deleteAdmins",method = RequestMethod.POST)//批量删除
    @ResponseBody
    public ResponseEntity deleteAdmins(@RequestBody Admin[] admins){
        int rowsAffected=adminService.deleteAdmins(admins);
        if (rowsAffected > 0) {
            return new ResponseEntity<>("{\"message\": \"删除成功\"}", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("{\"message\": \"删除失败\"}", HttpStatus.BAD_REQUEST);
        }
    }
}
