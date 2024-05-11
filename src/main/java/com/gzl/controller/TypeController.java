package com.gzl.controller;

import com.gzl.domain.Type;
import com.gzl.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 名称:TypeController
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-12-06 10:17
 */
@Controller
@RequestMapping("/admin/type")
public class TypeController {
    @Autowired(required = false)
    private TypeService typeService;
    @RequestMapping("/toTypeIndex")
    public String toTypeIndex(HttpServletResponse response, HttpServletRequest request) {
        // 方法逻辑
        return "/type/typesindex";
    }
    @RequestMapping(value = "/getAllTypesAndPlanes",produces = "application/json")
    @ResponseBody
    public List<Type> getAllTypesAndPlanes(HttpServletResponse response, HttpServletRequest request){
        List<Type> typeList=typeService.findAllTypesAndPlanes();
        System.out.println(typeList);
        System.out.println(typeList.size());
        return typeList;
    }
    @RequestMapping(value = "/getALlTypes",produces = "application/json")
    @ResponseBody
    public List<Type> getAllTypes(HttpServletResponse response, HttpServletRequest request){
        List<Type> typeList=typeService.findAllType();
        System.out.println(typeList);
        System.out.println(typeList.size());
        return typeList;
    }
    @GetMapping("/getTypeById")
    public ResponseEntity<String> getTypeById(@RequestParam("ptype") int id, HttpServletResponse response, HttpServletRequest request) {
        try {
            String typename=typeService.findTypeById(id).get(0).getType_name();
            System.out.println(typename);
            return ResponseEntity.ok(typename);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/getTypeById2")
    public ResponseEntity<Type> getTypeById2(@RequestParam("ptype") int id, HttpServletResponse response, HttpServletRequest request) {
        try {
            String typename=typeService.getTypeById(id).get(0).getType_name();
            System.out.println(typename);
            System.out.println(typeService.getTypeById(id).get(0));
            return ResponseEntity.ok(typeService.getTypeById(id).get(0));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @RequestMapping(value = "/insertType", method = RequestMethod.POST, consumes = "application/json")
    public ResponseEntity<String> insertType(@RequestBody Type type, HttpServletResponse response, HttpServletRequest request) {

        int rowsAffected = typeService.insertType(type);

        if (rowsAffected > 0) {
            // 插入成功，返回成功的JSON响应
            return new ResponseEntity<>("{\"message\": \"插入成功\"}", HttpStatus.OK);
        } else {
            // 插入失败，返回失败的JSON响应
            return new ResponseEntity<>("{\"message\": \"插入失败\"}", HttpStatus.BAD_REQUEST);
        }
    }
    @RequestMapping(value = "/deleteType", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity deleteType(@RequestBody Type type,HttpServletResponse response,HttpServletRequest request) {
        System.out.println(type);
        int rowsAffected = typeService.deleteTypeAndPlanes(type.getType_id());
        System.out.println(rowsAffected);
        if (rowsAffected > 0) {
            return new ResponseEntity<>("{\"message\": \"删除成功\"}", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("{\"message\": \"删除失败\"}", HttpStatus.BAD_REQUEST);
        }
    }
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity updateType(@RequestBody Type type,HttpServletResponse response,HttpServletRequest request) {
        System.out.println(type);
        int rowsAffected = typeService.updateType(type);
        System.out.println(rowsAffected);
        if (rowsAffected > 0) {
            return new ResponseEntity<>("{\"message\": \"更新成功\"}", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("{\"message\": \"跟新失败\"}", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/totypePage")
    public String getTypePage(@RequestParam("type_id")  int typeId, Model model,HttpServletResponse response,HttpServletRequest request) {
        model.addAttribute("type_id", typeId);

        // 返回要显示的视图的名称（视图文件的名称）
        return "/type/typePage";
    }
}
