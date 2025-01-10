package com.myspring.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/")
@Controller
public class MainController {
	@GetMapping(value = "/")
	public String home() {
		// 즉시 index페이지로 이동
		return "redirect:/index.do";
	}
	
	@GetMapping(value = "/index.do")
	public String index() {
		//System.out.print("index()");
		return "index";
	}
	
}
