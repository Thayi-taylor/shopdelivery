package com.project.shopdelivery.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NaviController {

    @GetMapping("/navi")
    public String showNaviPage() {
        return "navi"; // /WEB-INF/views/navi.jsp로 매핑됨
    }

    @GetMapping("/naviResult")
    public String showNaviResultPage() {
        return "naviResult"; // /WEB-INF/views/naviResult.jsp로 매핑됨
    }
}
