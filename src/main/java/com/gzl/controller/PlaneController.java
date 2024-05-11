package com.gzl.controller;

import com.gzl.domain.Plane;
import com.gzl.service.PlaneService;
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
 * 名称:PlaneController
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-12-06 00:31
 */
@Controller
@RequestMapping("/admin/plane")
public class PlaneController {
    @Autowired(required = false)
    PlaneService planeService;
    @RequestMapping("/toPlaneIndex")
    public String toAdminIndex(HttpServletResponse response, HttpServletRequest request) {
        // 方法逻辑
        return "/plane/planesindex";
    }
    @GetMapping("/toplanePage")
    public String getPlanePage(@RequestParam("plane_id")  int planeId, Model model, HttpServletResponse response, HttpServletRequest request) {
        model.addAttribute("plane_id", planeId);

        // 返回要显示的视图的名称（视图文件的名称）
        return "/plane/planePage";
    }
    @RequestMapping(value = "/getplanesList", produces = "application/json")
    @ResponseBody
    public List<Plane> getplanesList(HttpServletResponse response, HttpServletRequest request){
        List<Plane> planesList=planeService.findAllPlanes();
        for(Plane plane:planesList)
            System.out.println(plane);
        return planesList;
    }
    @RequestMapping(value = "/insertPlane", method = RequestMethod.POST, consumes = "application/json")
    public ResponseEntity<String> insertPlane(@RequestBody Plane plane, HttpServletResponse response, HttpServletRequest request) {

            int rowsAffected = planeService.insertPlane(plane);

            if (rowsAffected > 0) {
                // 插入成功，返回成功的JSON响应
                return new ResponseEntity<>("{\"message\": \"插入成功\"}", HttpStatus.OK);
            } else {
                // 插入失败，返回失败的JSON响应
                return new ResponseEntity<>("{\"message\": \"插入失败\"}", HttpStatus.BAD_REQUEST);
            }
    }
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity updatePlane(@RequestBody Plane plane,HttpServletResponse response,HttpServletRequest request) {
        int rowsAffected = planeService.updatePlane(plane);
        if (rowsAffected > 0) {
            return new ResponseEntity<>("{\"message\": \"更新成功\"}", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("{\"message\": \"跟新失败\"}", HttpStatus.BAD_REQUEST);
        }
    }
    @GetMapping("/getPlaneById")
    public ResponseEntity<Plane> getPlaneById(@RequestParam int id,HttpServletResponse response,HttpServletRequest request) {
        try {
            Plane plane = planeService.getPlaneById(id).get(0);
            return ResponseEntity.ok(plane);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @RequestMapping(value = "/deletePlane", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity deletePlane(@RequestBody Plane plane,HttpServletResponse response,HttpServletRequest request) {
        int rowsAffected = planeService.deletePlane(plane);
        if (rowsAffected > 0) {
            return new ResponseEntity<>("{\"message\": \"删除成功\"}", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("{\"message\": \"删除失败\"}", HttpStatus.BAD_REQUEST);
        }
    }

}
