package com.gzl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 名称:GuestMain
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-12-07 03:59
 */
@Controller
public class GuestMain {
    @RequestMapping("/index")
    private String toIndex(){
        return "/guest/index";
    }
}
